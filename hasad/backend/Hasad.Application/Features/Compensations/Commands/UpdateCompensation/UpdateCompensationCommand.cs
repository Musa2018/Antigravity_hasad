using FluentValidation;
using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Compensations.Models;
using Hasad.Domain.Constants;
using Hasad.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Compensations.Commands.UpdateCompensation;

public record UpdateCompensationCommand(
    Guid Id,
    decimal ApprovedAmount,
    string Status,
    string Remarks,
    string RowVersion) : IRequest<Result<CompensationDto>>;

public class UpdateCompensationCommandHandler : IRequestHandler<UpdateCompensationCommand, Result<CompensationDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserService _currentUserService;

    public UpdateCompensationCommandHandler(IApplicationDbContext context, ICurrentUserService currentUserService)
    {
        _context = context;
        _currentUserService = currentUserService;
    }

    public async Task<Result<CompensationDto>> Handle(UpdateCompensationCommand request, CancellationToken cancellationToken)
    {
        var compensation = await _context.Compensations
            .FirstOrDefaultAsync(c => c.Id == request.Id, cancellationToken);

        if (compensation == null)
        {
            return Result<CompensationDto>.Failure(new[] { "Compensation not found." });
        }

        // Optimistic concurrency check
        byte[] expectedVersion = Convert.FromBase64String(request.RowVersion);
        if (!compensation.RowVersion.SequenceEqual(expectedVersion))
        {
            return Result<CompensationDto>.Failure(new[] { "CONFLICT: The record has been modified by another user." });
        }

        // Validate state transition
        if (!CompensationStatus.CanTransition(compensation.Status, request.Status))
        {
            return Result<CompensationDto>.Failure(new[] { $"Invalid status transition from {compensation.Status} to {request.Status}." });
        }

        var previousStatus = compensation.Status;
        compensation.ApprovedAmount = request.ApprovedAmount;
        compensation.Status = request.Status;
        compensation.Remarks = request.Remarks;
        compensation.UpdatedAt = DateTime.UtcNow;

        _context.CompensationAuditLogs.Add(new CompensationAuditLog
        {
            Id = Guid.NewGuid(),
            CompensationId = compensation.Id,
            PreviousStatus = previousStatus,
            NewStatus = request.Status,
            ChangedBy = _currentUserService.UserName ?? "System",
            ChangedAt = DateTime.UtcNow,
            Reason = request.Remarks
        });

        try
        {
            await _context.SaveChangesAsync(cancellationToken);
        }
        catch (DbUpdateConcurrencyException)
        {
            return Result<CompensationDto>.Failure(new[] { "CONFLICT: The record has been modified by another user." });
        }

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

public class UpdateCompensationCommandValidator : AbstractValidator<UpdateCompensationCommand>
{
    public UpdateCompensationCommandValidator()
    {
        RuleFor(v => v.Id).NotEmpty();
        RuleFor(v => v.ApprovedAmount).GreaterThanOrEqualTo(0);
        RuleFor(v => v.Status).NotEmpty().MaximumLength(50);
        RuleFor(v => v.RowVersion).NotEmpty();
    }
}
