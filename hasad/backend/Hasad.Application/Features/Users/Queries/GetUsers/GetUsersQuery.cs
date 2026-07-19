using Hasad.Application.Common.Models;
using Hasad.Application.Features.Users.Models;
using MediatR;

namespace Hasad.Application.Features.Users.Queries.GetUsers;

public record GetUsersQuery(
    int PageNumber = 1,
    int PageSize = 10,
    string? Search = null,
    string? Role = null,
    Guid? GovernorateId = null,
    Guid? DirectorateId = null,
    bool? IsActive = null) : IRequest<Result<PaginatedList<UserDto>>>;
