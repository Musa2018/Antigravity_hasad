using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Accounts.Models;
using Hasad.Domain.Identity;
using MediatR;
using Microsoft.AspNetCore.Identity;

namespace Hasad.Application.Features.Accounts.Commands.Refresh;

/// <summary>
/// Exchanges a valid refresh token for a new access/refresh token pair (rotation).
/// </summary>
/// <param name="RefreshToken">The raw refresh token previously issued to the client.</param>
public record RefreshTokenCommand(string RefreshToken) : IRequest<Result<AuthResponse>>;

/// <summary>
/// Handles <see cref="RefreshTokenCommand"/>: rotates the presented refresh token
/// and issues a new access token. Reuse of an already-rotated token revokes the
/// whole token family inside the store.
/// </summary>
public class RefreshTokenCommandHandler : IRequestHandler<RefreshTokenCommand, Result<AuthResponse>>
{
    private static readonly string[] InvalidTokenError = { "Invalid or expired refresh token." };

    private readonly UserManager<ApplicationUser> _userManager;
    private readonly ITokenService _tokenService;
    private readonly IRefreshTokenStore _refreshTokenStore;

    /// <summary>Initializes the handler.</summary>
    public RefreshTokenCommandHandler(
        UserManager<ApplicationUser> userManager,
        ITokenService tokenService,
        IRefreshTokenStore refreshTokenStore)
    {
        _userManager = userManager;
        _tokenService = tokenService;
        _refreshTokenStore = refreshTokenStore;
    }

    /// <summary>Processes the refresh request.</summary>
    public async Task<Result<AuthResponse>> Handle(RefreshTokenCommand request, CancellationToken cancellationToken)
    {
        var rotation = await _refreshTokenStore.ValidateAndRotateAsync(request.RefreshToken, cancellationToken);
        if (!rotation.Succeeded)
        {
            return Result<AuthResponse>.Failure(InvalidTokenError);
        }

        var user = await _userManager.FindByIdAsync(rotation.UserId!);
        if (user is null || await _userManager.IsLockedOutAsync(user))
        {
            return Result<AuthResponse>.Failure(InvalidTokenError);
        }

        var roles = await _userManager.GetRolesAsync(user);
        var accessToken = _tokenService.CreateAccessToken(user, roles);

        return Result<AuthResponse>.Success(new AuthResponse
        {
            Token = accessToken,
            RefreshToken = rotation.NewRefreshToken!,
            UserId = user.Id,
            Email = user.Email!,
            FullName = user.FullName,
            GovernorateId = user.GovernorateId,
            DirectorateId = user.DirectorateId,
            Roles = roles
        });
    }
}
