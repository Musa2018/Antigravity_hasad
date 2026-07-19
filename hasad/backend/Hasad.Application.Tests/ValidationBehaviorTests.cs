using FluentValidation;
using Hasad.Application.Common.Behaviors;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Accounts.Commands.Login;
using Hasad.Application.Features.Accounts.Commands.Logout;
using Hasad.Application.Features.Accounts.Commands.Refresh;
using Hasad.Application.Features.Accounts.Models;
using MediatR;

namespace Hasad.Application.Tests;

public class ValidationBehaviorTests
{
    private static ValidationBehavior<LoginCommand, Result<AuthResponse>> CreateBehavior() =>
        new(new IValidator<LoginCommand>[] { new LoginCommandValidator() });

    private static RequestHandlerDelegate<Result<AuthResponse>> NextReturning(Result<AuthResponse> result, Action? onInvoked = null) =>
        _ =>
        {
            onInvoked?.Invoke();
            return Task.FromResult(result);
        };

    [Fact]
    public async Task Handle_ValidRequest_InvokesNextAndReturnsItsResult()
    {
        var invoked = false;
        var expected = Result<AuthResponse>.Success(new AuthResponse { Token = "t", RefreshToken = "r", Email = "user@hasad.ps", FullName = "Test User" });

        var result = await CreateBehavior().Handle(
            new LoginCommand("user@hasad.ps", "Str0ng!Passw0rd"),
            NextReturning(expected, () => invoked = true),
            CancellationToken.None);

        Assert.True(invoked);
        Assert.Same(expected, result);
    }

    [Fact]
    public async Task Handle_InvalidRequest_ThrowsValidationExceptionWithoutInvokingNext()
    {
        var invoked = false;

        var exception = await Assert.ThrowsAsync<ValidationException>(() =>
            CreateBehavior().Handle(
                new LoginCommand("not-an-email", string.Empty),
                NextReturning(Result<AuthResponse>.Success(new AuthResponse()), () => invoked = true),
                CancellationToken.None));

        Assert.False(invoked);
        Assert.Contains(exception.Errors, e => e.PropertyName == nameof(LoginCommand.Email));
        Assert.Contains(exception.Errors, e => e.PropertyName == nameof(LoginCommand.Password));
    }

    [Fact]
    public async Task Handle_NoValidatorsRegistered_PassesThrough()
    {
        var behavior = new ValidationBehavior<LoginCommand, Result<AuthResponse>>(Array.Empty<IValidator<LoginCommand>>());
        var expected = Result<AuthResponse>.Success(new AuthResponse());

        var result = await behavior.Handle(
            new LoginCommand(string.Empty, string.Empty),
            NextReturning(expected),
            CancellationToken.None);

        Assert.Same(expected, result);
    }

    [Theory]
    [InlineData("", "password", false)]
    [InlineData("not-an-email", "password", false)]
    [InlineData("user@hasad.ps", "", false)]
    [InlineData("user@hasad.ps", "password", true)]
    public async Task LoginCommandValidator_ValidatesEmailAndPassword(string email, string password, bool expectedValid)
    {
        var result = await new LoginCommandValidator().ValidateAsync(new LoginCommand(email, password));

        Assert.Equal(expectedValid, result.IsValid);
    }

    [Theory]
    [InlineData("", false)]
    [InlineData("some-refresh-token", true)]
    public async Task RefreshTokenCommandValidator_RequiresToken(string token, bool expectedValid)
    {
        var result = await new RefreshTokenCommandValidator().ValidateAsync(new RefreshTokenCommand(token));

        Assert.Equal(expectedValid, result.IsValid);
    }

    [Theory]
    [InlineData("", false)]
    [InlineData("some-refresh-token", true)]
    public async Task LogoutCommandValidator_RequiresToken(string token, bool expectedValid)
    {
        var result = await new LogoutCommandValidator().ValidateAsync(new LogoutCommand(token));

        Assert.Equal(expectedValid, result.IsValid);
    }
}
