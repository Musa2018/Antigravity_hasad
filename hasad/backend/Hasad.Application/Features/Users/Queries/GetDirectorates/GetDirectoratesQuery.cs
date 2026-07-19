using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Users.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Users.Queries.GetDirectorates;

public record GetDirectoratesQuery(Guid? GovernorateId = null) : IRequest<Result<List<DirectorateDto>>>;

public class GetDirectoratesQueryHandler : IRequestHandler<GetDirectoratesQuery, Result<List<DirectorateDto>>>
{
    private readonly IApplicationDbContext _context;

    public GetDirectoratesQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<List<DirectorateDto>>> Handle(GetDirectoratesQuery request, CancellationToken cancellationToken)
    {
        var query = _context.Directorates.AsNoTracking().Where(d => d.IsActive);

        if (request.GovernorateId.HasValue)
        {
            query = query.Where(d => d.GovernorateId == request.GovernorateId.Value);
        }

        var directorates = await query
            .OrderBy(d => d.NameEn)
            .Select(d => new DirectorateDto
            {
                Id = d.Id,
                NameAr = d.NameAr,
                NameEn = d.NameEn,
                GovernorateId = d.GovernorateId
            })
            .ToListAsync(cancellationToken);

        return Result<List<DirectorateDto>>.Success(directorates);
    }
}
