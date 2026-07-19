using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Users.Models;
using Hasad.Domain.Identity;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Users.Queries.GetUsers;

public class GetUsersQueryHandler : IRequestHandler<GetUsersQuery, Result<PaginatedList<UserDto>>>
{
    private readonly IApplicationDbContext _context;
    private readonly UserManager<ApplicationUser> _userManager;

    public GetUsersQueryHandler(IApplicationDbContext context, UserManager<ApplicationUser> userManager)
    {
        _context = context;
        _userManager = userManager;
    }

    public async Task<Result<PaginatedList<UserDto>>> Handle(GetUsersQuery request, CancellationToken cancellationToken)
    {
        var query = _context.Users
            .Include(u => u.Governorate)
            .Include(u => u.Directorate)
            .AsNoTracking();

        // Apply filters
        if (!string.IsNullOrWhiteSpace(request.Search))
        {
            var search = request.Search.ToLower();
            query = query.Where(u =>
                u.FullName.ToLower().Contains(search) ||
                u.UserName!.ToLower().Contains(search) ||
                u.Email!.ToLower().Contains(search));
        }

        if (request.GovernorateId.HasValue)
        {
            query = query.Where(u => u.GovernorateId == request.GovernorateId);
        }

        if (request.DirectorateId.HasValue)
        {
            query = query.Where(u => u.DirectorateId == request.DirectorateId);
        }

        if (request.IsActive.HasValue)
        {
            query = query.Where(u => u.IsActive == request.IsActive.Value);
        }

        if (!string.IsNullOrWhiteSpace(request.Role))
        {
            var usersInRole = await _userManager.GetUsersInRoleAsync(request.Role);
            var userIdsInRole = usersInRole.Select(u => u.Id).ToList();
            query = query.Where(u => userIdsInRole.Contains(u.Id));
        }

        var count = await query.CountAsync(cancellationToken);

        var users = await query
            .OrderBy(u => u.FullName)
            .Skip((request.PageNumber - 1) * request.PageSize)
            .Take(request.PageSize)
            .ToListAsync(cancellationToken);

        var dtos = new List<UserDto>();
        foreach (var user in users)
        {
            var roles = await _userManager.GetRolesAsync(user);
            dtos.Add(new UserDto
            {
                Id = user.Id,
                FullName = user.FullName,
                UserName = user.UserName ?? string.Empty,
                Email = user.Email ?? string.Empty,
                PhoneNumber = user.PhoneNumber ?? string.Empty,
                Role = roles.FirstOrDefault() ?? "None",
                GovernorateId = user.GovernorateId,
                GovernorateName = user.Governorate?.NameEn,
                DirectorateId = user.DirectorateId,
                DirectorateName = user.Directorate?.NameEn,
                IsActive = user.IsActive,
                CreatedAt = user.CreatedAt
            });
        }

        var paginatedList = new PaginatedList<UserDto>
        {
            Items = dtos,
            TotalCount = count,
            PageNumber = request.PageNumber,
            TotalPages = (int)Math.Ceiling(count / (double)request.PageSize)
        };

        return Result<PaginatedList<UserDto>>.Success(paginatedList);
    }
}
