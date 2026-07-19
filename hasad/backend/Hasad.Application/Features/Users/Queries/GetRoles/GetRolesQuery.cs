using Hasad.Application.Common.Models;
using Hasad.Application.Features.Users.Models;
using Hasad.Domain.Constants;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Users.Queries.GetRoles;

public record GetRolesQuery : IRequest<Result<List<RoleDto>>>;

public class GetRolesQueryHandler : IRequestHandler<GetRolesQuery, Result<List<RoleDto>>>
{
    private readonly RoleManager<IdentityRole> _roleManager;

    public GetRolesQueryHandler(RoleManager<IdentityRole> roleManager)
    {
        _roleManager = roleManager;
    }

    public async Task<Result<List<RoleDto>>> Handle(GetRolesQuery request, CancellationToken cancellationToken)
    {
        var roles = await _roleManager.Roles
            .AsNoTracking()
            .OrderBy(r => r.Name)
            .ToListAsync(cancellationToken);

        var dtos = roles.Select(r => new RoleDto(
            r.Id,
            r.Name ?? string.Empty,
            AppRoles.GetScopeType(r.Name ?? string.Empty).ToString()
        )).ToList();

        return Result<List<RoleDto>>.Success(dtos);
    }
}
