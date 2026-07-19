using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Location.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Location.Queries.GetLocalities;

public record GetLocalitiesQuery(Guid? GovernorateId = null) : IRequest<Result<List<LocalityDto>>>;

public class GetLocalitiesQueryHandler : IRequestHandler<GetLocalitiesQuery, Result<List<LocalityDto>>>
{
    private readonly IApplicationDbContext _context;

    public GetLocalitiesQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<List<LocalityDto>>> Handle(GetLocalitiesQuery request, CancellationToken cancellationToken)
    {
        var query = _context.Localities.AsNoTracking().Where(l => l.IsActive);

        if (request.GovernorateId.HasValue)
        {
            query = query.Where(l => l.GovernorateId == request.GovernorateId.Value);
        }

        var localities = await query
            .OrderBy(l => l.NameEn)
            .Select(l => new LocalityDto
            {
                Id = l.Id,
                NameAr = l.NameAr,
                NameEn = l.NameEn,
                GovernorateId = l.GovernorateId
            })
            .ToListAsync(cancellationToken);

        return Result<List<LocalityDto>>.Success(localities);
    }
}
