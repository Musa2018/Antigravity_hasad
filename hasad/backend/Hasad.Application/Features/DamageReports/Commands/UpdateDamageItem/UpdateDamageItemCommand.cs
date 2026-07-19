using FluentValidation;
using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.DamageReports.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.DamageReports.Commands.UpdateDamageItem;

public record UpdateDamageItemCommand(
    Guid Id,
    string AgriculturalSectorId,
    string SubSectorId,
    string CropId,
    string DamageTypeId,
    decimal AffectedArea,
    decimal DamagePercentage,
    decimal Quantity,
    decimal EstimatedLoss,
    string RowVersion) : IRequest<Result<DamageItemDto>>;

public class UpdateDamageItemCommandHandler : IRequestHandler<UpdateDamageItemCommand, Result<DamageItemDto>>
{
    private readonly IApplicationDbContext _context;

    public UpdateDamageItemCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<DamageItemDto>> Handle(UpdateDamageItemCommand request, CancellationToken cancellationToken)
    {
        var item = await _context.DamageItems
            .FirstOrDefaultAsync(i => i.Id == request.Id, cancellationToken);

        if (item == null)
        {
            return Result<DamageItemDto>.Failure(new[] { "Damage item not found." });
        }

        // Concurrency
        byte[] expectedVersion = Convert.FromBase64String(request.RowVersion);
        if (!item.RowVersion.SequenceEqual(expectedVersion))
        {
            return Result<DamageItemDto>.Failure(new[] { "CONFLICT: The record has been modified by another user." });
        }

        item.AgriculturalSectorId = request.AgriculturalSectorId;
        item.SubSectorId = request.SubSectorId;
        item.CropId = request.CropId;
        item.DamageTypeId = request.DamageTypeId;
        item.AffectedArea = request.AffectedArea;
        item.DamagePercentage = request.DamagePercentage;
        item.Quantity = request.Quantity;
        item.EstimatedLoss = request.EstimatedLoss;
        item.UpdatedAt = DateTime.UtcNow;

        try
        {
            await _context.SaveChangesAsync(cancellationToken);
        }
        catch (DbUpdateConcurrencyException)
        {
            return Result<DamageItemDto>.Failure(new[] { "CONFLICT: The record has been modified by another user." });
        }

        return Result<DamageItemDto>.Success(new DamageItemDto
        {
            Id = item.Id,
            ClientId = item.ClientId,
            AgriculturalSectorId = item.AgriculturalSectorId,
            SubSectorId = item.SubSectorId,
            CropId = item.CropId,
            DamageTypeId = item.DamageTypeId,
            AffectedArea = item.AffectedArea,
            DamagePercentage = item.DamagePercentage,
            Quantity = item.Quantity,
            EstimatedLoss = item.EstimatedLoss,
            RowVersion = Convert.ToBase64String(item.RowVersion)
        });
    }
}

public class UpdateDamageItemCommandValidator : AbstractValidator<UpdateDamageItemCommand>
{
    public UpdateDamageItemCommandValidator()
    {
        RuleFor(v => v.Id).NotEmpty();
        RuleFor(v => v.AgriculturalSectorId).NotEmpty();
        RuleFor(v => v.DamagePercentage).InclusiveBetween(0, 100);
        RuleFor(v => v.RowVersion).NotEmpty();
    }
}
