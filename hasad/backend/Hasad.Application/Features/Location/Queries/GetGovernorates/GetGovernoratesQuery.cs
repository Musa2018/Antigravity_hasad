using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Users.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Location.Queries.GetGovernorates;

public record GetGovernoratesQuery : IRequest<Result<List<GovernorateDto>>>;

public class GetGovernoratesQueryHandler : IRequestHandler<GetGovernoratesQuery, Result<List<GovernorateDto>>>
{
    private readonly IApplicationDbContext _context;

    public GetGovernoratesQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<List<GovernorateDto>>> Handle(GetGovernoratesQuery request, CancellationToken cancellationToken)
    {
        var governorates = await _context.Governorates
            .AsNoTracking()
            .Where(g => g.IsActive)
            .OrderBy(g => g.NameEn)
            .Select(g => new GovernorateDto
            {
                Id = g.Id,
                NameAr = g.NameAr,
                NameEn = g.NameEn
            })
            .ToListAsync(cancellationToken);

        return Result<List<GovernorateDto>>.Success(governorates);
    }
}
