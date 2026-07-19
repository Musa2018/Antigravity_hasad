using Hasad.Application.Common.Options;
using Hasad.Infrastructure.Persistence;
using Hasad.Infrastructure.Services;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Tests;

public class RefreshTokenStoreTests
{
    private sealed class MutableTimeProvider : TimeProvider
    {
        public DateTimeOffset UtcNow { get; set; } = new(2026, 7, 6, 12, 0, 0, TimeSpan.Zero);
        public override DateTimeOffset GetUtcNow() => UtcNow;
    }

    private static ApplicationDbContext CreateContext() =>
        new(new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options);

    private static RefreshTokenStore CreateStore(ApplicationDbContext context, TimeProvider timeProvider) =>
        new(context,
            Microsoft.Extensions.Options.Options.Create(new JwtOptions { RefreshTokenDays = 14 }),
            timeProvider);

    [Fact]
    public async Task IssueAndRotate_Succeeds_AndRevokesPresentedToken()
    {
        using var context = CreateContext();
        var store = CreateStore(context, new MutableTimeProvider());

        var raw = await store.IssueAsync("user-1", CancellationToken.None);
        var rotation = await store.ValidateAndRotateAsync(raw, CancellationToken.None);

        Assert.True(rotation.Succeeded);
        Assert.Equal("user-1", rotation.UserId);
        Assert.NotNull(rotation.NewRefreshToken);
        Assert.NotEqual(raw, rotation.NewRefreshToken);
        Assert.Single(await context.RefreshTokens.Where(t => t.RevokedAtUtc != null).ToListAsync());
    }

    [Fact]
    public async Task ReusingRotatedToken_Fails_AndRevokesWholeFamily()
    {
        using var context = CreateContext();
        var store = CreateStore(context, new MutableTimeProvider());

        var raw = await store.IssueAsync("user-1", CancellationToken.None);
        var rotation = await store.ValidateAndRotateAsync(raw, CancellationToken.None);

        var reuse = await store.ValidateAndRotateAsync(raw, CancellationToken.None);
        Assert.False(reuse.Succeeded);

        // The replacement issued during the legitimate rotation must now be dead too.
        var replacementAttempt = await store.ValidateAndRotateAsync(rotation.NewRefreshToken!, CancellationToken.None);
        Assert.False(replacementAttempt.Succeeded);
        Assert.Empty(await context.RefreshTokens.Where(t => t.RevokedAtUtc == null).ToListAsync());
    }

    [Fact]
    public async Task ExpiredToken_CannotBeRotated()
    {
        using var context = CreateContext();
        var time = new MutableTimeProvider();
        var store = CreateStore(context, time);

        var raw = await store.IssueAsync("user-1", CancellationToken.None);
        time.UtcNow = time.UtcNow.AddDays(15);

        var rotation = await store.ValidateAndRotateAsync(raw, CancellationToken.None);
        Assert.False(rotation.Succeeded);
    }

    [Fact]
    public async Task RevokeFamily_InvalidatesToken()
    {
        using var context = CreateContext();
        var store = CreateStore(context, new MutableTimeProvider());

        var raw = await store.IssueAsync("user-1", CancellationToken.None);
        var revoked = await store.RevokeFamilyAsync(raw, CancellationToken.None);

        Assert.True(revoked);
        var rotation = await store.ValidateAndRotateAsync(raw, CancellationToken.None);
        Assert.False(rotation.Succeeded);
    }

    [Fact]
    public async Task UnknownToken_IsRejected()
    {
        using var context = CreateContext();
        var store = CreateStore(context, new MutableTimeProvider());

        var rotation = await store.ValidateAndRotateAsync("not-a-real-token", CancellationToken.None);
        Assert.False(rotation.Succeeded);
        Assert.False(await store.RevokeFamilyAsync("not-a-real-token", CancellationToken.None));
    }
}
