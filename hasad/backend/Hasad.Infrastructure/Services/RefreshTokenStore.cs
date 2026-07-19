using System.Security.Cryptography;
using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Options;
using Hasad.Domain.Entities;
using Hasad.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;

namespace Hasad.Infrastructure.Services;

/// <summary>
/// EF Core-backed refresh-token store implementing rotation and family revocation.
/// Raw tokens are 64 bytes of cryptographic randomness; only SHA-256 hashes are persisted.
/// </summary>
public class RefreshTokenStore : IRefreshTokenStore
{
    private const int RawTokenSizeBytes = 64;

    private readonly ApplicationDbContext _context;
    private readonly JwtOptions _options;
    private readonly TimeProvider _timeProvider;

    /// <summary>Initializes the store.</summary>
    public RefreshTokenStore(ApplicationDbContext context, IOptions<JwtOptions> options, TimeProvider timeProvider)
    {
        _context = context;
        _options = options.Value;
        _timeProvider = timeProvider;
    }

    /// <inheritdoc />
    public async Task<string> IssueAsync(string userId, CancellationToken cancellationToken)
    {
        var (rawToken, entity) = CreateToken(userId, Guid.NewGuid());
        _context.RefreshTokens.Add(entity);
        await _context.SaveChangesAsync(cancellationToken);
        return rawToken;
    }

    /// <inheritdoc />
    public async Task<RefreshTokenRotationResult> ValidateAndRotateAsync(string rawToken, CancellationToken cancellationToken)
    {
        var utcNow = _timeProvider.GetUtcNow().UtcDateTime;
        var hash = Hash(rawToken);
        var token = await _context.RefreshTokens
            .SingleOrDefaultAsync(t => t.TokenHash == hash, cancellationToken);

        if (token is null)
        {
            return new RefreshTokenRotationResult(false, null, null);
        }

        if (!token.IsActive(utcNow))
        {
            // Reuse of a rotated/revoked token indicates possible theft: kill the family.
            await RevokeFamilyInternalAsync(token.UserId, token.FamilyId, utcNow, cancellationToken);
            return new RefreshTokenRotationResult(false, null, null);
        }

        var (newRawToken, replacement) = CreateToken(token.UserId, token.FamilyId);
        token.RevokedAtUtc = utcNow;
        token.ReplacedByTokenHash = replacement.TokenHash;
        _context.RefreshTokens.Add(replacement);
        await _context.SaveChangesAsync(cancellationToken);

        return new RefreshTokenRotationResult(true, token.UserId, newRawToken);
    }

    /// <inheritdoc />
    public async Task<bool> RevokeFamilyAsync(string rawToken, CancellationToken cancellationToken)
    {
        var utcNow = _timeProvider.GetUtcNow().UtcDateTime;
        var hash = Hash(rawToken);
        var token = await _context.RefreshTokens
            .SingleOrDefaultAsync(t => t.TokenHash == hash, cancellationToken);

        if (token is null)
        {
            return false;
        }

        await RevokeFamilyInternalAsync(token.UserId, token.FamilyId, utcNow, cancellationToken);
        return true;
    }

    private async Task RevokeFamilyInternalAsync(string userId, Guid familyId, DateTime utcNow, CancellationToken cancellationToken)
    {
        var familyTokens = await _context.RefreshTokens
            .Where(t => t.UserId == userId && t.FamilyId == familyId && t.RevokedAtUtc == null)
            .ToListAsync(cancellationToken);

        foreach (var familyToken in familyTokens)
        {
            familyToken.RevokedAtUtc = utcNow;
        }

        await _context.SaveChangesAsync(cancellationToken);
    }

    private (string RawToken, RefreshToken Entity) CreateToken(string userId, Guid familyId)
    {
        var rawToken = Convert.ToBase64String(RandomNumberGenerator.GetBytes(RawTokenSizeBytes));
        var utcNow = _timeProvider.GetUtcNow().UtcDateTime;

        var entity = new RefreshToken
        {
            Id = Guid.NewGuid(),
            TokenHash = Hash(rawToken),
            UserId = userId,
            FamilyId = familyId,
            CreatedAtUtc = utcNow,
            ExpiresAtUtc = utcNow.AddDays(_options.RefreshTokenDays)
        };

        return (rawToken, entity);
    }

    private static string Hash(string rawToken)
    {
        var bytes = SHA256.HashData(System.Text.Encoding.UTF8.GetBytes(rawToken));
        return Convert.ToBase64String(bytes);
    }
}
