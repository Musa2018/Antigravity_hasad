using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.DamageReports.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.DamageReports.Queries.GetDamageReportsByFarm;

public record GetDamageReportsByFarmQuery(Guid FarmId) : IRequest<Result<List<DamageReportDto>>>;

public class GetDamageReportsByFarmQueryHandler : IRequestHandler<GetDamageReportsByFarmQuery, Result<List<DamageReportDto>>>
{
    private readonly IApplicationDbContext _context;

    public GetDamageReportsByFarmQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<List<DamageReportDto>>> Handle(GetDamageReportsByFarmQuery request, CancellationToken cancellationToken)
    {
        var reports = await _context.DamageReports
            .AsNoTracking()
            .Where(r => r.FarmId == request.FarmId)
            .OrderByDescending(r => r.DamageDate)
            .Select(r => new DamageReportDto
            {
                Id = r.Id,
                ClientId = r.ClientId,
                FarmId = r.FarmId,
                FarmerId = r.FarmerId,
                DamageDate = r.DamageDate,
                DocumentationDate = r.DocumentationDate,
                GovernorateId = r.GovernorateId,
                LocalityId = r.LocalityId,
                Latitude = r.Latitude,
                Longitude = r.Longitude,
                StatusId = r.StatusId,
                Notes = r.Notes,
                RowVersion = Convert.ToBase64String(r.RowVersion)
            })
            .ToListAsync(cancellationToken);

        return Result<List<DamageReportDto>>.Success(reports);
    }
}
