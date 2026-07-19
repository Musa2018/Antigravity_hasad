using FluentValidation;
using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Farms.Models;
using Hasad.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Farms.Commands.CreateFarm;

public record CreateFarmCommand(
    Guid ClientId,
    Guid FarmerId,
    string Name,
    string GovernorateId,
    string LocalityId,
    decimal LandArea,
    string LandAreaUnit,
    double? Latitude,
    double? Longitude,
    string OwnershipTypeId) : IRequest<Result<FarmDto>>;

public class CreateFarmCommandHandler : IRequestHandler<CreateFarmCommand, Result<FarmDto>>
{
    private readonly IApplicationDbContext _context;

    public CreateFarmCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<FarmDto>> Handle(CreateFarmCommand request, CancellationToken cancellationToken)
    {
        // Idempotency check
        var existingByClientId = await _context.Farms
            .AsNoTracking()
            .FirstOrDefaultAsync(f => f.ClientId == request.ClientId, cancellationToken);

        if (existingByClientId != null)
        {
            return Result<FarmDto>.Success(MapToDto(existingByClientId));
        }

        // Verify farmer exists
        if (!await _context.Farmers.AnyAsync(f => f.Id == request.FarmerId, cancellationToken))
        {
            return Result<FarmDto>.Failure(new[] { "Farmer not found." });
        }

        var farm = new Farm
        {
            Id = Guid.NewGuid(),
            ClientId = request.ClientId,
            FarmerId = request.FarmerId,
            Name = request.Name,
            GovernorateId = request.GovernorateId,
            LocalityId = request.LocalityId,
            LandArea = request.LandArea,
            LandAreaUnit = request.LandAreaUnit,
            Latitude = request.Latitude,
            Longitude = request.Longitude,
            OwnershipTypeId = request.OwnershipTypeId,
            CreatedAt = DateTime.UtcNow
        };

        _context.Farms.Add(farm);
        await _context.SaveChangesAsync(cancellationToken);

        return Result<FarmDto>.Success(MapToDto(farm));
    }

    private static FarmDto MapToDto(Farm farm) => new()
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
        RowVersion = farm.RowVersion != null ? Convert.ToBase64String(farm.RowVersion) : string.Empty
    };
}

public class CreateFarmCommandValidator : AbstractValidator<CreateFarmCommand>
{
    public CreateFarmCommandValidator()
    {
        RuleFor(v => v.ClientId).NotEmpty();
        RuleFor(v => v.FarmerId).NotEmpty();
        RuleFor(v => v.Name).NotEmpty().MaximumLength(200);
        RuleFor(v => v.GovernorateId).NotEmpty().MaximumLength(50);
        RuleFor(v => v.LocalityId).NotEmpty().MaximumLength(50);
        RuleFor(v => v.LandArea).GreaterThan(0);
        RuleFor(v => v.LandAreaUnit).NotEmpty().MaximumLength(20);
        RuleFor(v => v.OwnershipTypeId).NotEmpty().MaximumLength(50);

        RuleFor(v => v.Latitude)
            .InclusiveBetween(-90, 90).When(v => v.Latitude.HasValue);
        RuleFor(v => v.Longitude)
            .InclusiveBetween(-180, 180).When(v => v.Longitude.HasValue);
    }
}
