using FluentValidation;
using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.DamageReports.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.DamageReports.Commands.UpdateDamageReport;

public record UpdateDamageReportCommand(
    Guid Id,
    DateTime DamageDate,
    string GovernorateId,
    string LocalityId,
    double? Latitude,
    double? Longitude,
    string Notes,
    string RowVersion) : IRequest<Result<DamageReportDto>>;

public class UpdateDamageReportCommandHandler : IRequestHandler<UpdateDamageReportCommand, Result<DamageReportDto>>
{
    private readonly IApplicationDbContext _context;

    public UpdateDamageReportCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<DamageReportDto>> Handle(UpdateDamageReportCommand request, CancellationToken cancellationToken)
    {
        var report = await _context.DamageReports
            .Include(r => r.Items)
            .FirstOrDefaultAsync(r => r.Id == request.Id, cancellationToken);

        if (report == null)
        {
            return Result<DamageReportDto>.Failure(new[] { "Damage report not found." });
        }

        // Optimistic concurrency
        byte[] expectedVersion = Convert.FromBase64String(request.RowVersion);
        if (!report.RowVersion.SequenceEqual(expectedVersion))
        {
            return Result<DamageReportDto>.Failure(new[] { "CONFLICT: The record has been modified by another user." });
        }

        report.DamageDate = request.DamageDate;
        report.GovernorateId = request.GovernorateId;
        report.LocalityId = request.LocalityId;
        report.Latitude = request.Latitude;
        report.Longitude = request.Longitude;
        report.Notes = request.Notes;
        report.UpdatedAt = DateTime.UtcNow;

        try
        {
            await _context.SaveChangesAsync(cancellationToken);
        }
        catch (DbUpdateConcurrencyException)
        {
            return Result<DamageReportDto>.Failure(new[] { "CONFLICT: The record has been modified by another user." });
        }

        return Result<DamageReportDto>.Success(new DamageReportDto
        {
            Id = report.Id,
            ClientId = report.ClientId,
            FarmId = report.FarmId,
            FarmerId = report.FarmerId,
            DamageDate = report.DamageDate,
            DocumentationDate = report.DocumentationDate,
            GovernorateId = report.GovernorateId,
            LocalityId = report.LocalityId,
            Latitude = report.Latitude,
            Longitude = report.Longitude,
            StatusId = report.StatusId,
            Notes = report.Notes,
            RowVersion = Convert.ToBase64String(report.RowVersion),
            Items = report.Items.Select(i => new DamageItemDto
            {
                Id = i.Id,
                ClientId = i.ClientId,
                AgriculturalSectorId = i.AgriculturalSectorId,
                SubSectorId = i.SubSectorId,
                CropId = i.CropId,
                DamageTypeId = i.DamageTypeId,
                AffectedArea = i.AffectedArea,
                DamagePercentage = i.DamagePercentage,
                Quantity = i.Quantity,
                EstimatedLoss = i.EstimatedLoss,
                RowVersion = Convert.ToBase64String(i.RowVersion)
            }).ToList()
        });
    }
}

public class UpdateDamageReportCommandValidator : AbstractValidator<UpdateDamageReportCommand>
{
    public UpdateDamageReportCommandValidator()
    {
        RuleFor(v => v.Id).NotEmpty();
        RuleFor(v => v.DamageDate).NotEmpty().LessThanOrEqualTo(DateTime.UtcNow);
        RuleFor(v => v.GovernorateId).NotEmpty().MaximumLength(50);
        RuleFor(v => v.LocalityId).NotEmpty().MaximumLength(50);
        RuleFor(v => v.RowVersion).NotEmpty();
    }
}
