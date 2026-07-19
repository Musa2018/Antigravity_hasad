using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Compensations.Models;
using Hasad.Domain.Constants;
using Hasad.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Compensations.Commands.RecalculateCompensation;

public record RecalculateCompensationCommand(Guid Id, string RowVersion) : IRequest<Result<CompensationDto>>;

public class RecalculateCompensationCommandHandler : IRequestHandler<RecalculateCompensationCommand, Result<CompensationDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly ICompensationService _compensationService;
    private readonly ICurrentUserService _currentUserService;

    public RecalculateCompensationCommandHandler(IApplicationDbContext context, ICompensationService compensationService, ICurrentUserService currentUserService)
    {
        _context = context;
        _compensationService = compensationService;
        _currentUserService = currentUserService;
    }

    public async Task<Result<CompensationDto>> Handle(RecalculateCompensationCommand request, CancellationToken cancellationToken)
    {
        var compensation = await _context.Compensations
            .Include(c => c.DamageReport)
                .ThenInclude(r => r!.Items)
            .FirstOrDefaultAsync(c => c.Id == request.Id, cancellationToken);

        if (compensation == null) return Result<CompensationDto>.Failure(new[] { "Compensation not found." });

        byte[] expectedVersion = Convert.FromBase64String(request.RowVersion);
        if (!compensation.RowVersion.SequenceEqual(expectedVersion))
            return Result<CompensationDto>.Failure(new[] { "CONFLICT: The record has been modified by another user." });

        // Only allow recalculation if in certain states (Draft, Calculated, Rejected)
        if (compensation.Status == CompensationStatus.Approved || compensation.Status == CompensationStatus.Paid || compensation.Status == CompensationStatus.Submitted)
        {
            return Result<CompensationDto>.Failure(new[] { $"Recalculation not allowed in {compensation.Status} status." });
        }

        var rule = await _context.CompensationRules.FirstOrDefaultAsync(r => r.IsActive, cancellationToken);
        if (rule == null) return Result<CompensationDto>.Failure(new[] { "No active compensation rule found." });

        var newCalculatedAmount = _compensationService.Calculate(compensation.DamageReport!, rule);

        var previousStatus = compensation.Status;
        compensation.CalculatedAmount = newCalculatedAmount;
        compensation.ApprovedAmount = newCalculatedAmount; // Reset approved to calculated
        compensation.Status = CompensationStatus.Calculated;
        compensation.RuleId = rule.Id;
        compensation.UpdatedAt = DateTime.UtcNow;

        _context.CompensationAuditLogs.Add(new CompensationAuditLog
        {
            Id = Guid.NewGuid(),
            CompensationId = compensation.Id,
            PreviousStatus = previousStatus,
            NewStatus = CompensationStatus.Calculated,
            ChangedBy = _currentUserService.UserName ?? "System",
            ChangedAt = DateTime.UtcNow,
            Reason = "Recalculation triggered"
        });

        await _context.SaveChangesAsync(cancellationToken);

        return Result<CompensationDto>.Success(new CompensationDto
        {
            Id = compensation.Id,
            ClientId = compensation.ClientId,
            DamageReportId = compensation.DamageReportId,
            CalculatedAmount = compensation.CalculatedAmount,
            ApprovedAmount = compensation.ApprovedAmount,
            Status = compensation.Status,
            Remarks = compensation.Remarks,
            RowVersion = Convert.ToBase64String(compensation.RowVersion)
        });
    }
}
