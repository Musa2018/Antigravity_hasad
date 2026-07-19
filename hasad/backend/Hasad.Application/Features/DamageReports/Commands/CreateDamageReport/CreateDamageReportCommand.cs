using FluentValidation;
using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.DamageReports.Models;
using Hasad.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.DamageReports.Commands.CreateDamageReport;

public record CreateDamageItemInput(
    Guid ClientId,
    string AgriculturalSectorId,
    string SubSectorId,
    string CropId,
    string DamageTypeId,
    decimal AffectedArea,
    decimal DamagePercentage,
    decimal Quantity,
    decimal EstimatedLoss);

public record CreateDamageReportCommand(
    Guid ClientId,
    Guid FarmId,
    Guid FarmerId,
    DateTime DamageDate,
    string GovernorateId,
    string LocalityId,
    double? Latitude,
    double? Longitude,
    string Notes,
    List<CreateDamageItemInput> Items) : IRequest<Result<DamageReportDto>>;

public class CreateDamageReportCommandHandler : IRequestHandler<CreateDamageReportCommand, Result<DamageReportDto>>
{
    private readonly IApplicationDbContext _context;

    public CreateDamageReportCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<DamageReportDto>> Handle(CreateDamageReportCommand request, CancellationToken cancellationToken)
    {
        // Idempotency
        var existing = await _context.DamageReports
            .AsNoTracking()
            .Include(r => r.Items)
            .FirstOrDefaultAsync(r => r.ClientId == request.ClientId, cancellationToken);

        if (existing != null)
        {
            return Result<DamageReportDto>.Success(MapToDto(existing));
        }

        // Validation: Farm and Farmer must exist
        if (!await _context.Farms.AnyAsync(f => f.Id == request.FarmId, cancellationToken))
        {
            return Result<DamageReportDto>.Failure(new[] { "Farm not found." });
        }
        if (!await _context.Farmers.AnyAsync(f => f.Id == request.FarmerId, cancellationToken))
        {
            return Result<DamageReportDto>.Failure(new[] { "Farmer not found." });
        }

        var report = new DamageReport
        {
            Id = Guid.NewGuid(),
            ClientId = request.ClientId,
            FarmId = request.FarmId,
            FarmerId = request.FarmerId,
            DamageDate = request.DamageDate,
            DocumentationDate = DateTime.UtcNow,
            GovernorateId = request.GovernorateId,
            LocalityId = request.LocalityId,
            Latitude = request.Latitude,
            Longitude = request.Longitude,
            StatusId = "Submitted",
            Notes = request.Notes,
            CreatedAt = DateTime.UtcNow,
            Items = request.Items.Select(i => new DamageItem
            {
                Id = Guid.NewGuid(),
                ClientId = i.ClientId,
                AgriculturalSectorId = i.AgriculturalSectorId,
                SubSectorId = i.SubSectorId,
                CropId = i.CropId,
                DamageTypeId = i.DamageTypeId,
                AffectedArea = i.AffectedArea,
                DamagePercentage = i.DamagePercentage,
                Quantity = i.Quantity,
                EstimatedLoss = i.EstimatedLoss,
                CreatedAt = DateTime.UtcNow
            }).ToList()
        };

        _context.DamageReports.Add(report);
        await _context.SaveChangesAsync(cancellationToken);

        return Result<DamageReportDto>.Success(MapToDto(report));
    }

    private static DamageReportDto MapToDto(DamageReport report) => new()
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
    };
}

public class CreateDamageReportCommandValidator : AbstractValidator<CreateDamageReportCommand>
{
    public CreateDamageReportCommandValidator()
    {
        RuleFor(v => v.ClientId).NotEmpty();
        RuleFor(v => v.FarmId).NotEmpty();
        RuleFor(v => v.FarmerId).NotEmpty();
        RuleFor(v => v.DamageDate).NotEmpty().LessThanOrEqualTo(DateTime.UtcNow);
        RuleFor(v => v.GovernorateId).NotEmpty().MaximumLength(50);
        RuleFor(v => v.LocalityId).NotEmpty().MaximumLength(50);

        RuleForEach(v => v.Items).SetValidator(new CreateDamageItemInputValidator());
    }
}

public class CreateDamageItemInputValidator : AbstractValidator<CreateDamageItemInput>
{
    public CreateDamageItemInputValidator()
    {
        RuleFor(v => v.ClientId).NotEmpty();
        RuleFor(v => v.AgriculturalSectorId).NotEmpty();
        RuleFor(v => v.DamagePercentage).InclusiveBetween(0, 100);
        RuleFor(v => v.AffectedArea).GreaterThanOrEqualTo(0);
        RuleFor(v => v.EstimatedLoss).GreaterThanOrEqualTo(0);
    }
}
