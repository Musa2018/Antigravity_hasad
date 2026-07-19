using Hasad.Domain.Identity;

namespace Hasad.Application.Common.Interfaces;

/// <summary>
/// Issues signed JWT access tokens for authenticated users.
/// </summary>
public interface ITokenService
{
    /// <summary>
    /// Creates a signed access token containing the user's identity claims and roles.
    /// </summary>
    /// <param name="user">The authenticated user.</param>
    /// <param name="roles">Role names to embed as role claims.</param>
    /// <returns>The serialized JWT.</returns>
    string CreateAccessToken(ApplicationUser user, IEnumerable<string> roles);
}
