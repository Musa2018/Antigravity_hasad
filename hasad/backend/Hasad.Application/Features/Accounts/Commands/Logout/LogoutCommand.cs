using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using MediatR;

namespace Hasad.Application.Features.Accounts.Commands.Logout;

/// <summary>
/// Revokes the presented refresh token and its family, ending the session server-side.
/// </summary>
/// <param name="RefreshToken">The raw refresh token to revoke.</param>
public record LogoutCommand(string RefreshToken) : IRequest<Result<bool>>;

/// <summary>
/// Handles <see cref="LogoutCommand"/> by revoking the token family in the store.
/// Always reports success to the client so logout cannot be used to probe token validity.
/// </summary>
public class LogoutCommandHandler : IRequestHandler<LogoutCommand, Result<bool>>
{
    private readonly IRefreshTokenStore _refreshTokenStore;

    /// <summary>Initializes the handler.</summary>
    public LogoutCommandHandler(IRefreshTokenStore refreshTokenStore)
    {
        _refreshTokenStore = refreshTokenStore;
    }

    /// <summary>Processes the logout request.</summary>
    public async Task<Result<bool>> Handle(LogoutCommand request, CancellationToken cancellationToken)
    {
        await _refreshTokenStore.RevokeFamilyAsync(request.RefreshToken, cancellationToken);
        return Result<bool>.Success(true);
    }
}
