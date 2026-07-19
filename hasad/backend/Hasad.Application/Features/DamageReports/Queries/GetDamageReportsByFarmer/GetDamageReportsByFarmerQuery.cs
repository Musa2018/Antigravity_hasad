using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.DamageReports.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.DamageReports.Queries.GetDamageReportsByFarmer;

public record GetDamageReportsByFarmerQuery(Guid FarmerId) : IRequest<Result<List<DamageReportDto>>>;

public class GetDamageReportsByFarmerQueryHandler : IRequestHandler<GetDamageReportsByFarmerQuery, Result<List<DamageReportDto>>>
{
    private readonly IApplicationDbContext _context;

    public GetDamageReportsByFarmerQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<List<DamageReportDto>>> Handle(GetDamageReportsByFarmerQuery request, CancellationToken cancellationToken)
    {
        var reports = await _context.DamageReports
            .AsNoTracking()
            .Where(r => r.FarmerId == request.FarmerId)
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
