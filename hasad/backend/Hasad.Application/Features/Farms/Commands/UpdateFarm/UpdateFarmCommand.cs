using FluentValidation;
using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Farms.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Farms.Commands.UpdateFarm;

public record UpdateFarmCommand(
    Guid Id,
    Guid ClientId,
    Guid FarmerId,
    string Name,
    string GovernorateId,
    string LocalityId,
    decimal LandArea,
    string LandAreaUnit,
    double? Latitude,
    double? Longitude,
    string OwnershipTypeId,
    string RowVersion) : IRequest<Result<FarmDto>>;

public class UpdateFarmCommandHandler : IRequestHandler<UpdateFarmCommand, Result<FarmDto>>
{
    private readonly IApplicationDbContext _context;

    public UpdateFarmCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<FarmDto>> Handle(UpdateFarmCommand request, CancellationToken cancellationToken)
    {
        var farm = await _context.Farms
            .FirstOrDefaultAsync(f => f.Id == request.Id, cancellationToken);

        if (farm == null)
        {
            return Result<FarmDto>.Failure(new[] { "Farm not found." });
        }

        // Optimistic concurrency check
        byte[] expectedVersion = Convert.FromBase64String(request.RowVersion);
        if (!farm.RowVersion.SequenceEqual(expectedVersion))
        {
            return Result<FarmDto>.Failure(new[] { "CONFLICT: The record has been modified by another user." });
        }

        farm.Name = request.Name;
        farm.GovernorateId = request.GovernorateId;
        farm.LocalityId = request.LocalityId;
        farm.LandArea = request.LandArea;
        farm.LandAreaUnit = request.LandAreaUnit;
        farm.Latitude = request.Latitude;
        farm.Longitude = request.Longitude;
        farm.OwnershipTypeId = request.OwnershipTypeId;
        farm.UpdatedAt = DateTime.UtcNow;

        try
        {
            await _context.SaveChangesAsync(cancellationToken);
        }
        catch (DbUpdateConcurrencyException)
        {
            return Result<FarmDto>.Failure(new[] { "CONFLICT: The record has been modified by another user." });
        }

        return Result<FarmDto>.Success(new FarmDto
        {
            Id = farm.Id,
            ClientId = farm.ClientId,
            FarmerId = farm.FarmerId,
            Name = farm.Name,
            GovernorateId = farm.GovernorateId,
            LocalityId = farm.LocalityId,
            LandArea = farm.LandArea,
            LandAreaUnit = farm.LandAreaUnit,
            Latitude = farm.Latitude,
            Longitude = farm.Longitude,
            OwnershipTypeId = farm.OwnershipTypeId,
            RowVersion = Convert.ToBase64String(farm.RowVersion)
        });
    }
}

public class UpdateFarmCommandValidator : AbstractValidator<UpdateFarmCommand>
{
    public UpdateFarmCommandValidator()
    {
        RuleFor(v => v.Id).NotEmpty();
        RuleFor(v => v.ClientId).NotEmpty();
        RuleFor(v => v.FarmerId).NotEmpty();
        RuleFor(v => v.Name).NotEmpty().MaximumLength(200);
        RuleFor(v => v.GovernorateId).NotEmpty().MaximumLength(50);
        RuleFor(v => v.LocalityId).NotEmpty().MaximumLength(50);
        RuleFor(v => v.LandArea).GreaterThan(0);
        RuleFor(v => v.LandAreaUnit).NotEmpty().MaximumLength(20);
        RuleFor(v => v.OwnershipTypeId).NotEmpty().MaximumLength(50);
        RuleFor(v => v.RowVersion).NotEmpty();
    }
}
