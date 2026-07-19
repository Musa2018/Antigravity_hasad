using Hasad.Application.Common.Interfaces;
using Hasad.Application.Features.Accounts.Commands.Login;
using Hasad.Domain.Identity;
using Microsoft.AspNetCore.Identity;
using NSubstitute;

namespace Hasad.Application.Tests;

public class LoginCommandHandlerTests
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly ITokenService _tokenService;
    private readonly IRefreshTokenStore _refreshTokenStore;
    private readonly LoginCommandHandler _handler;

    private static readonly Guid GzId = Guid.NewGuid();
    private static readonly Guid DirId = Guid.NewGuid();

    private static readonly ApplicationUser User = new()
    {
        Id = "user-1",
        Email = "user@hasad.ps",
        UserName = "user@hasad.ps",
        FullName = "Test User",
        GovernorateId = GzId,
        DirectorateId = DirId
    };

    public LoginCommandHandlerTests()
    {
        _userManager = Substitute.For<UserManager<ApplicationUser>>(
            Substitute.For<IUserStore<ApplicationUser>>(),
            null, null, null, null, null, null, null, null);
        _tokenService = Substitute.For<ITokenService>();
        _refreshTokenStore = Substitute.For<IRefreshTokenStore>();
        _handler = new LoginCommandHandler(_userManager, _tokenService, _refreshTokenStore);
    }

    [Fact]
    public async Task UnknownEmail_ReturnsFailure()
    {
        _userManager.FindByEmailAsync("nobody@hasad.ps").Returns((ApplicationUser?)null);

        var result = await _handler.Handle(new LoginCommand("nobody@hasad.ps", "x"), CancellationToken.None);

        Assert.False(result.Succeeded);
    }

    [Fact]
    public async Task WrongPassword_ReturnsFailure_AndRecordsFailedAttempt()
    {
        _userManager.FindByEmailAsync(User.Email!).Returns(User);
        _userManager.IsLockedOutAsync(User).Returns(false);
        _userManager.CheckPasswordAsync(User, "wrong").Returns(false);

        var result = await _handler.Handle(new LoginCommand(User.Email!, "wrong"), CancellationToken.None);

        Assert.False(result.Succeeded);
        await _userManager.Received(1).AccessFailedAsync(User);
    }

    [Fact]
    public async Task LockedOutUser_ReturnsFailure_WithoutCheckingPassword()
    {
        _userManager.FindByEmailAsync(User.Email!).Returns(User);
        _userManager.IsLockedOutAsync(User).Returns(true);

        var result = await _handler.Handle(new LoginCommand(User.Email!, "correct"), CancellationToken.None);

        Assert.False(result.Succeeded);
        await _userManager.DidNotReceive().CheckPasswordAsync(Arg.Any<ApplicationUser>(), Arg.Any<string>());
    }

    [Fact]
    public async Task ValidCredentials_ReturnsAccessAndRefreshTokens()
    {
        _userManager.FindByEmailAsync(User.Email!).Returns(User);
        _userManager.IsLockedOutAsync(User).Returns(false);
        _userManager.CheckPasswordAsync(User, "correct").Returns(true);
        _userManager.GetRolesAsync(User).Returns(new List<string> { "FieldSurveyor" });
        _tokenService.CreateAccessToken(User, Arg.Any<IEnumerable<string>>()).Returns("access-token");
        _refreshTokenStore.IssueAsync(User.Id, Arg.Any<CancellationToken>()).Returns("refresh-token");

        var result = await _handler.Handle(new LoginCommand(User.Email!, "correct"), CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Equal("access-token", result.Data!.Token);
        Assert.Equal("refresh-token", result.Data.RefreshToken);
        Assert.Equal(User.Id, result.Data.UserId);
        Assert.Equal(User.Email, result.Data.Email);
        Assert.Equal(GzId, result.Data.GovernorateId);
        Assert.Equal(DirId, result.Data.DirectorateId);
        await _userManager.Received(1).ResetAccessFailedCountAsync(User);
    }
}
