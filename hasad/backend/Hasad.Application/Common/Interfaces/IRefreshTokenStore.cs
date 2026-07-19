namespace Hasad.Application.Common.Interfaces;

/// <summary>
/// Outcome of a refresh-token rotation attempt.
/// </summary>
/// <param name="Succeeded">Whether the presented token was valid and rotated.</param>
/// <param name="UserId">The owning user's identifier when rotation succeeds.</param>
/// <param name="NewRefreshToken">The newly issued raw refresh token when rotation succeeds.</param>
public record RefreshTokenRotationResult(bool Succeeded, string? UserId, string? NewRefreshToken);

/// <summary>
/// Persists and validates refresh tokens with rotation and family revocation.
/// Implementations store only token hashes.
/// </summary>
public interface IRefreshTokenStore
{
    /// <summary>
    /// Issues a new refresh token for the user, starting a new token family.
    /// </summary>
    /// <param name="userId">Identifier of the user receiving the token.</param>
    /// <param name="cancellationToken">Cancellation token.</param>
    /// <returns>The raw refresh token to return to the client.</returns>
    Task<string> IssueAsync(string userId, CancellationToken cancellationToken);

    /// <summary>
    /// Validates a presented refresh token and rotates it: the presented token is
    /// revoked and a replacement is issued within the same family. Presenting a
    /// token that was already rotated or revoked revokes the entire family.
    /// </summary>
    /// <param name="rawToken">The raw refresh token presented by the client.</param>
    /// <param name="cancellationToken">Cancellation token.</param>
    /// <returns>The rotation outcome.</returns>
    Task<RefreshTokenRotationResult> ValidateAndRotateAsync(string rawToken, CancellationToken cancellationToken);

    /// <summary>
    /// Revokes the presented refresh token and its entire family (logout).
    /// </summary>
    /// <param name="rawToken">The raw refresh token presented by the client.</param>
    /// <param name="cancellationToken">Cancellation token.</param>
    /// <returns>True when a matching token was found and revoked.</returns>
    Task<bool> RevokeFamilyAsync(string rawToken, CancellationToken cancellationToken);
}
