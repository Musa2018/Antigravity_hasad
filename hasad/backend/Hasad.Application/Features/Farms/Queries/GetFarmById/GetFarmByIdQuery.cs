using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Farms.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Farms.Queries.GetFarmById;

public record GetFarmByIdQuery(Guid Id) : IRequest<Result<FarmDto>>;

public class GetFarmByIdQueryHandler : IRequestHandler<GetFarmByIdQuery, Result<FarmDto>>
{
    private readonly IApplicationDbContext _context;

    public GetFarmByIdQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<FarmDto>> Handle(GetFarmByIdQuery request, CancellationToken cancellationToken)
    {
        var farm = await _context.Farms
            .AsNoTracking()
            .FirstOrDefaultAsync(f => f.Id == request.Id, cancellationToken);

        if (farm == null)
        {
            return Result<FarmDto>.Failure(new[] { "Farm not found." });
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
