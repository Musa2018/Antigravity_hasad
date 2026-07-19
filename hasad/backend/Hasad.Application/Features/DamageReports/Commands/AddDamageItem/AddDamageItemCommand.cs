using FluentValidation;
using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.DamageReports.Models;
using Hasad.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.DamageReports.Commands.AddDamageItem;

public record AddDamageItemCommand(
    Guid DamageReportId,
    Guid ClientId,
    string AgriculturalSectorId,
    string SubSectorId,
    string CropId,
    string DamageTypeId,
    decimal AffectedArea,
    decimal DamagePercentage,
    decimal Quantity,
    decimal EstimatedLoss) : IRequest<Result<DamageItemDto>>;

public class AddDamageItemCommandHandler : IRequestHandler<AddDamageItemCommand, Result<DamageItemDto>>
{
    private readonly IApplicationDbContext _context;

    public AddDamageItemCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<DamageItemDto>> Handle(AddDamageItemCommand request, CancellationToken cancellationToken)
    {
        // Idempotency
        var existing = await _context.DamageItems
            .AsNoTracking()
            .FirstOrDefaultAsync(i => i.ClientId == request.ClientId, cancellationToken);

        if (existing != null)
        {
            return Result<DamageItemDto>.Success(MapToDto(existing));
        }

        if (!await _context.DamageReports.AnyAsync(r => r.Id == request.DamageReportId, cancellationToken))
        {
            return Result<DamageItemDto>.Failure(new[] { "Damage report not found." });
        }

        var item = new DamageItem
        {
            Id = Guid.NewGuid(),
            ClientId = request.ClientId,
            DamageReportId = request.DamageReportId,
            AgriculturalSectorId = request.AgriculturalSectorId,
            SubSectorId = request.SubSectorId,
            CropId = request.CropId,
            DamageTypeId = request.DamageTypeId,
            AffectedArea = request.AffectedArea,
            DamagePercentage = request.DamagePercentage,
            Quantity = request.Quantity,
            EstimatedLoss = request.EstimatedLoss,
            CreatedAt = DateTime.UtcNow
        };

        _context.DamageItems.Add(item);
        await _context.SaveChangesAsync(cancellationToken);

        return Result<DamageItemDto>.Success(MapToDto(item));
    }

    private static DamageItemDto MapToDto(DamageItem i) => new()
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
    };
}

public class AddDamageItemCommandValidator : AbstractValidator<AddDamageItemCommand>
{
    public AddDamageItemCommandValidator()
    {
        RuleFor(v => v.DamageReportId).NotEmpty();
        RuleFor(v => v.ClientId).NotEmpty();
        RuleFor(v => v.AgriculturalSectorId).NotEmpty();
        RuleFor(v => v.DamagePercentage).InclusiveBetween(0, 100);
    }
}
