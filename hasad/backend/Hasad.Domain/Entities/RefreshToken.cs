namespace Hasad.Domain.Entities;

/// <summary>
/// A persisted refresh token. Only a SHA-256 hash of the raw token is stored;
/// the raw value is returned to the client once and never persisted.
/// Tokens belong to a family so that reuse of a rotated token can revoke
/// every descendant token issued from the same login.
/// </summary>
public class RefreshToken
{
    /// <summary>Primary key.</summary>
    public Guid Id { get; set; }

    /// <summary>SHA-256 hash (Base64) of the raw refresh token.</summary>
    public string TokenHash { get; set; } = string.Empty;

    /// <summary>Identifier of the user the token was issued to.</summary>
    public string UserId { get; set; } = string.Empty;

    /// <summary>Family identifier shared by all tokens rotated from the same login.</summary>
    public Guid FamilyId { get; set; }

    /// <summary>UTC instant after which the token is no longer valid.</summary>
    public DateTime ExpiresAtUtc { get; set; }

    /// <summary>UTC instant the token was created.</summary>
    public DateTime CreatedAtUtc { get; set; }

    /// <summary>UTC instant the token was revoked, or null while it remains valid.</summary>
    public DateTime? RevokedAtUtc { get; set; }

    /// <summary>Hash of the token that replaced this one during rotation, if any.</summary>
    public string? ReplacedByTokenHash { get; set; }

    /// <summary>Whether the token can still be redeemed at the given UTC instant.</summary>
    public bool IsActive(DateTime utcNow) => RevokedAtUtc is null && utcNow < ExpiresAtUtc;
}
