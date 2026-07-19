using Asp.Versioning;
using Hasad.Application.Features.Accounts.Commands.ForgotPassword;
using Hasad.Application.Features.Accounts.Commands.ResetPassword;
using Hasad.Application.Features.Accounts.Commands.Login;
using Hasad.Application.Features.Accounts.Commands.Logout;
using Hasad.Application.Features.Accounts.Commands.Refresh;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.RateLimiting;

namespace Hasad.Api.Controllers;

/// <summary>
/// Authentication endpoints: login, token refresh, and logout.
/// </summary>
[ApiController]
[Route("api/v{version:apiVersion}/[controller]")]
[ApiVersion("1.0")]
[EnableRateLimiting("auth")]
public class AccountsController : ControllerBase
{
    private readonly IMediator _mediator;

    /// <summary>Initializes the controller.</summary>
    public AccountsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Authenticates a user and returns an access/refresh token pair.
    /// </summary>
    /// <param name="command">Email and password.</param>
    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginCommand command)
    {
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : Unauthorized(result);
    }

    /// <summary>
    /// Exchanges a valid refresh token for a new access/refresh token pair.
    /// </summary>
    /// <param name="command">The refresh token to rotate.</param>
    [HttpPost("refresh")]
    public async Task<IActionResult> Refresh([FromBody] RefreshTokenCommand command)
    {
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : Unauthorized(result);
    }

    /// <summary>
    /// Revokes the presented refresh token and its family, ending the session.
    /// </summary>
    /// <param name="command">The refresh token to revoke.</param>
    [HttpPost("logout")]
    public async Task<IActionResult> Logout([FromBody] LogoutCommand command)
    {
        var result = await _mediator.Send(command);
        return Ok(result);
    }

    /// <summary>
    /// Sends a password reset token to the user's email.
    /// </summary>
    [HttpPost("forgot-password")]
    public async Task<IActionResult> ForgotPassword([FromBody] ForgotPasswordCommand command)
    {
        var result = await _mediator.Send(command);
        return Ok(result);
    }

    /// <summary>
    /// Resets the user's password using the provided token.
    /// </summary>
    [HttpPost("reset-password")]
    public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordCommand command)
    {
        var result = await _mediator.Send(command);
        return result.Succeeded ? Ok(result) : BadRequest(result);
    }
}
