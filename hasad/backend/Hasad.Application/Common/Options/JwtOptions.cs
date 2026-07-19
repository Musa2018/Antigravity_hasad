namespace Hasad.Application.Common.Options;

/// <summary>
/// Strongly-typed JWT configuration bound from the "JwtSettings" section.
/// The signing key must be supplied via environment variables or user secrets;
/// it is never committed to the repository.
/// </summary>
public class JwtOptions
{
    /// <summary>Configuration section name.</summary>
    public const string SectionName = "JwtSettings";

    /// <summary>Minimum accepted signing-key length in characters.</summary>
    public const int MinimumKeyLength = 32;

    /// <summary>Symmetric signing key. Required; minimum 32 characters.</summary>
    public string Key { get; set; } = string.Empty;

    /// <summary>Expected token issuer.</summary>
    public string Issuer { get; set; } = string.Empty;

    /// <summary>Expected token audience.</summary>
    public string Audience { get; set; } = string.Empty;

    /// <summary>Access-token lifetime in minutes.</summary>
    public int AccessTokenMinutes { get; set; } = 60;

    /// <summary>Refresh-token lifetime in days.</summary>
    public int RefreshTokenDays { get; set; } = 14;
}
