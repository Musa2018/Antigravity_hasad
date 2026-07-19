using Hasad.Application.Common.Interfaces;
using Hasad.Application.Features.Accounts.Commands.Refresh;
using Hasad.Domain.Identity;
using Microsoft.AspNetCore.Identity;
using NSubstitute;

namespace Hasad.Application.Tests;

public class RefreshTokenCommandHandlerTests
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly ITokenService _tokenService;
    private readonly IRefreshTokenStore _refreshTokenStore;
    private readonly RefreshTokenCommandHandler _handler;

    private static readonly ApplicationUser User = new()
    {
        Id = "user-1",
        Email = "user@hasad.ps",
        UserName = "user@hasad.ps",
        FullName = "Test User"
    };

    public RefreshTokenCommandHandlerTests()
    {
        _userManager = Substitute.For<UserManager<ApplicationUser>>(
            Substitute.For<IUserStore<ApplicationUser>>(),
            null, null, null, null, null, null, null, null);
        _tokenService = Substitute.For<ITokenService>();
        _refreshTokenStore = Substitute.For<IRefreshTokenStore>();
        _handler = new RefreshTokenCommandHandler(_userManager, _tokenService, _refreshTokenStore);
    }

    [Fact]
    public async Task InvalidToken_ReturnsFailure()
    {
        _refreshTokenStore.ValidateAndRotateAsync("bad", Arg.Any<CancellationToken>())
            .Returns(new RefreshTokenRotationResult(false, null, null));

        var result = await _handler.Handle(new RefreshTokenCommand("bad"), CancellationToken.None);

        Assert.False(result.Succeeded);
    }

    [Fact]
    public async Task ValidToken_ReturnsNewTokenPair()
    {
        _refreshTokenStore.ValidateAndRotateAsync("good", Arg.Any<CancellationToken>())
            .Returns(new RefreshTokenRotationResult(true, User.Id, "new-refresh"));
        _userManager.FindByIdAsync(User.Id).Returns(User);
        _userManager.IsLockedOutAsync(User).Returns(false);
        _userManager.GetRolesAsync(User).Returns(new List<string>());
        _tokenService.CreateAccessToken(User, Arg.Any<IEnumerable<string>>()).Returns("new-access");

        var result = await _handler.Handle(new RefreshTokenCommand("good"), CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Equal("new-access", result.Data!.Token);
        Assert.Equal("new-refresh", result.Data.RefreshToken);
    }

    [Fact]
    public async Task LockedOutUser_ReturnsFailure()
    {
        _refreshTokenStore.ValidateAndRotateAsync("good", Arg.Any<CancellationToken>())
            .Returns(new RefreshTokenRotationResult(true, User.Id, "new-refresh"));
        _userManager.FindByIdAsync(User.Id).Returns(User);
        _userManager.IsLockedOutAsync(User).Returns(true);

        var result = await _handler.Handle(new RefreshTokenCommand("good"), CancellationToken.None);

        Assert.False(result.Succeeded);
    }
}
