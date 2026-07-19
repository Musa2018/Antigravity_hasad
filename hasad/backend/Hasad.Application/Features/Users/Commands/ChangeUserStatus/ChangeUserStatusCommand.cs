using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Domain.Identity;
using MediatR;
using Microsoft.AspNetCore.Identity;

namespace Hasad.Application.Features.Users.Commands.ChangeUserStatus;

public record ChangeUserStatusCommand(string UserId, bool IsActive) : IRequest<Result<bool>>;

public class ChangeUserStatusCommandHandler : IRequestHandler<ChangeUserStatusCommand, Result<bool>>
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly ICurrentUserService _currentUserService;

    public ChangeUserStatusCommandHandler(UserManager<ApplicationUser> userManager, ICurrentUserService currentUserService)
    {
        _userManager = userManager;
        _currentUserService = currentUserService;
    }

    public async Task<Result<bool>> Handle(ChangeUserStatusCommand request, CancellationToken cancellationToken)
    {
        var user = await _userManager.FindByIdAsync(request.UserId);
        if (user == null)
        {
            return Result<bool>.Failure(new[] { "User not found." });
        }

        // Prevent self-deactivation if SuperAdmin
        if (!request.IsActive && user.UserName == _currentUserService.UserName)
        {
            return Result<bool>.Failure(new[] { "You cannot deactivate your own account." });
        }

        user.IsActive = request.IsActive;
        var result = await _userManager.UpdateAsync(user);

        return result.Succeeded
            ? Result<bool>.Success(true)
            : Result<bool>.Failure(result.Errors.Select(e => e.Description).ToArray());
    }
}
