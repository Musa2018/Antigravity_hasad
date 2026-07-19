using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Compensations.Models;
using Hasad.Domain.Constants;
using Hasad.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Compensations.Commands.RejectCompensation;

public record RejectCompensationCommand(Guid Id, string Remarks, string RowVersion) : IRequest<Result<CompensationDto>>;

public class RejectCompensationCommandHandler : IRequestHandler<RejectCompensationCommand, Result<CompensationDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserService _currentUserService;

    public RejectCompensationCommandHandler(IApplicationDbContext context, ICurrentUserService currentUserService)
    {
        _context = context;
        _currentUserService = currentUserService;
    }

    public async Task<Result<CompensationDto>> Handle(RejectCompensationCommand request, CancellationToken cancellationToken)
    {
        var compensation = await _context.Compensations
            .FirstOrDefaultAsync(c => c.Id == request.Id, cancellationToken);

        if (compensation == null) return Result<CompensationDto>.Failure(new[] { "Compensation not found." });

        byte[] expectedVersion = Convert.FromBase64String(request.RowVersion);
        if (!compensation.RowVersion.SequenceEqual(expectedVersion))
            return Result<CompensationDto>.Failure(new[] { "CONFLICT: The record has been modified by another user." });

        if (!CompensationStatus.CanTransition(compensation.Status, CompensationStatus.Rejected))
            return Result<CompensationDto>.Failure(new[] { $"Invalid status transition from {compensation.Status} to Rejected." });

        var previousStatus = compensation.Status;
        compensation.Status = CompensationStatus.Rejected;
        compensation.Remarks = request.Remarks;
        compensation.UpdatedAt = DateTime.UtcNow;

        _context.CompensationAuditLogs.Add(new CompensationAuditLog
        {
            Id = Guid.NewGuid(),
            CompensationId = compensation.Id,
            PreviousStatus = previousStatus,
            NewStatus = CompensationStatus.Rejected,
            ChangedBy = _currentUserService.UserName ?? "System",
            ChangedAt = DateTime.UtcNow,
            Reason = request.Remarks
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
