using Hasad.Application.Common.Interfaces;
using Hasad.Application.Features.Accounts.Commands.Logout;
using NSubstitute;

namespace Hasad.Application.Tests;

public class LogoutCommandHandlerTests
{
    [Fact]
    public async Task Handle_RevokesPresentedTokenFamily()
    {
        var store = Substitute.For<IRefreshTokenStore>();
        var handler = new LogoutCommandHandler(store);

        await handler.Handle(new LogoutCommand("raw-refresh-token"), CancellationToken.None);

        await store.Received(1).RevokeFamilyAsync("raw-refresh-token", Arg.Any<CancellationToken>());
    }

    [Fact]
    public async Task Handle_AlwaysReportsSuccess()
    {
        var store = Substitute.For<IRefreshTokenStore>();
        var handler = new LogoutCommandHandler(store);

        var result = await handler.Handle(new LogoutCommand("unknown-token"), CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.True(result.Data);
    }
}
