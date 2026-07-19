using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Farms.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Farms.Queries.GetFarmsByFarmer;

public record GetFarmsByFarmerQuery(Guid FarmerId) : IRequest<Result<List<FarmDto>>>;

public class GetFarmsByFarmerQueryHandler : IRequestHandler<GetFarmsByFarmerQuery, Result<List<FarmDto>>>
{
    private readonly IApplicationDbContext _context;

    public GetFarmsByFarmerQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<List<FarmDto>>> Handle(GetFarmsByFarmerQuery request, CancellationToken cancellationToken)
    {
        var farms = await _context.Farms
            .AsNoTracking()
            .Where(f => f.FarmerId == request.FarmerId)
            .Select(f => new FarmDto
            {
                Id = f.Id,
                ClientId = f.ClientId,
                FarmerId = f.FarmerId,
                Name = f.Name,
                GovernorateId = f.GovernorateId,
                LocalityId = f.LocalityId,
                LandArea = f.LandArea,
                LandAreaUnit = f.LandAreaUnit,
                Latitude = f.Latitude,
                Longitude = f.Longitude,
                OwnershipTypeId = f.OwnershipTypeId,
                RowVersion = Convert.ToBase64String(f.RowVersion)
            })
            .ToListAsync(cancellationToken);

        return Result<List<FarmDto>>.Success(farms);
    }
}
