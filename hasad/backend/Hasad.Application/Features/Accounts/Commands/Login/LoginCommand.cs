using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Accounts.Models;
using Hasad.Domain.Identity;
using MediatR;
using Microsoft.AspNetCore.Identity;

namespace Hasad.Application.Features.Accounts.Commands.Login;

/// <summary>
/// Authenticates a user by email and password and issues an access/refresh token pair.
/// </summary>
/// <param name="Email">The user's email address.</param>
/// <param name="Password">The user's password.</param>
public record LoginCommand(string Email, string Password) : IRequest<Result<AuthResponse>>;

/// <summary>
/// Handles <see cref="LoginCommand"/>: verifies credentials with lockout tracking,
/// then issues a JWT access token and a persisted refresh token.
/// </summary>
public class LoginCommandHandler : IRequestHandler<LoginCommand, Result<AuthResponse>>
{
    private static readonly string[] InvalidCredentialsError = { "Invalid email or password." };

    private readonly UserManager<ApplicationUser> _userManager;
    private readonly ITokenService _tokenService;
    private readonly IRefreshTokenStore _refreshTokenStore;

    /// <summary>Initializes the handler.</summary>
    public LoginCommandHandler(
        UserManager<ApplicationUser> userManager,
        ITokenService tokenService,
        IRefreshTokenStore refreshTokenStore)
    {
        _userManager = userManager;
        _tokenService = tokenService;
        _refreshTokenStore = refreshTokenStore;
    }

    /// <summary>Processes the login request.</summary>
    public async Task<Result<AuthResponse>> Handle(LoginCommand request, CancellationToken cancellationToken)
    {
        var user = await _userManager.FindByEmailAsync(request.Email);
        if (user is null)
        {
            return Result<AuthResponse>.Failure(InvalidCredentialsError);
        }

        if (await _userManager.IsLockedOutAsync(user))
        {
            return Result<AuthResponse>.Failure(InvalidCredentialsError);
        }

        if (!await _userManager.CheckPasswordAsync(user, request.Password))
        {
            await _userManager.AccessFailedAsync(user);
            return Result<AuthResponse>.Failure(InvalidCredentialsError);
        }

        await _userManager.ResetAccessFailedCountAsync(user);

        var roles = await _userManager.GetRolesAsync(user);
        var accessToken = _tokenService.CreateAccessToken(user, roles);
        var refreshToken = await _refreshTokenStore.IssueAsync(user.Id, cancellationToken);

        return Result<AuthResponse>.Success(new AuthResponse
        {
            Token = accessToken,
            RefreshToken = refreshToken,
            UserId = user.Id,
            Email = user.Email!,
            FullName = user.FullName,
            GovernorateId = user.GovernorateId,
            DirectorateId = user.DirectorateId,
            Roles = roles
        });
    }
}
