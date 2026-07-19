using FluentValidation;
using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Compensations.Models;
using Hasad.Domain.Constants;
using Hasad.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Compensations.Commands.CreateCompensation;

public record CreateCompensationCommand(
    Guid ClientId,
    Guid DamageReportId,
    string Remarks) : IRequest<Result<CompensationDto>>;

public class CreateCompensationCommandHandler : IRequestHandler<CreateCompensationCommand, Result<CompensationDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly ICompensationService _compensationService;
    private readonly ICurrentUserService _currentUserService;

    public CreateCompensationCommandHandler(IApplicationDbContext context, ICompensationService compensationService, ICurrentUserService currentUserService)
    {
        _context = context;
        _compensationService = compensationService;
        _currentUserService = currentUserService;
    }

    public async Task<Result<CompensationDto>> Handle(CreateCompensationCommand request, CancellationToken cancellationToken)
    {
        // Idempotency check
        var existing = await _context.Compensations
            .AsNoTracking()
            .FirstOrDefaultAsync(c => c.ClientId == request.ClientId, cancellationToken);

        if (existing != null)
        {
            return Result<CompensationDto>.Success(MapToDto(existing));
        }

        // Check if report exists and load items for calculation
        var report = await _context.DamageReports
            .Include(r => r.Items)
            .FirstOrDefaultAsync(r => r.Id == request.DamageReportId, cancellationToken);

        if (report == null)
        {
            return Result<CompensationDto>.Failure(new[] { "Damage report not found." });
        }

        // Check if compensation already exists for this report
        if (await _context.Compensations.AnyAsync(c => c.DamageReportId == request.DamageReportId, cancellationToken))
        {
            return Result<CompensationDto>.Failure(new[] { "Compensation already exists for this damage report." });
        }

        // Get active rule
        var rule = await _context.CompensationRules
            .FirstOrDefaultAsync(r => r.IsActive, cancellationToken);

        if (rule == null)
        {
            return Result<CompensationDto>.Failure(new[] { "No active compensation rule found." });
        }

        var calculatedAmount = _compensationService.Calculate(report, rule);

        var compensation = new Compensation
        {
            Id = Guid.NewGuid(),
            ClientId = request.ClientId,
            DamageReportId = request.DamageReportId,
            RuleId = rule.Id,
            CalculatedAmount = calculatedAmount,
            ApprovedAmount = calculatedAmount,
            Status = CompensationStatus.Calculated,
            Remarks = request.Remarks,
            CreatedAt = DateTime.UtcNow
        };

        compensation.AuditLogs.Add(new CompensationAuditLog
        {
            Id = Guid.NewGuid(),
            PreviousStatus = "None",
            NewStatus = CompensationStatus.Calculated,
            ChangedBy = _currentUserService.UserName ?? "System",
            ChangedAt = DateTime.UtcNow,
            Reason = "Initial calculation"
        });

        _context.Compensations.Add(compensation);
        await _context.SaveChangesAsync(cancellationToken);

        return Result<CompensationDto>.Success(MapToDto(compensation));
    }

    private static CompensationDto MapToDto(Compensation compensation) => new()
    {
        Id = compensation.Id,
        ClientId = compensation.ClientId,
        DamageReportId = compensation.DamageReportId,
        CalculatedAmount = compensation.CalculatedAmount,
        ApprovedAmount = compensation.ApprovedAmount,
        Status = compensation.Status,
        Remarks = compensation.Remarks,
        RowVersion = Convert.ToBase64String(compensation.RowVersion)
    };
}

public class CreateCompensationCommandValidator : AbstractValidator<CreateCompensationCommand>
{
    public CreateCompensationCommandValidator()
    {
        RuleFor(v => v.ClientId).NotEmpty();
        RuleFor(v => v.DamageReportId).NotEmpty();
    }
}
