using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Domain.Identity;
using MediatR;
using Microsoft.AspNetCore.Identity;

namespace Hasad.Application.Features.Accounts.Commands.ForgotPassword;

public record ForgotPasswordCommand(string Email) : IRequest<Result<Unit>>;

public class ForgotPasswordCommandHandler : IRequestHandler<ForgotPasswordCommand, Result<Unit>>
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly IEmailService _emailService;

    public ForgotPasswordCommandHandler(UserManager<ApplicationUser> userManager, IEmailService emailService)
    {
        _userManager = userManager;
        _emailService = emailService;
    }

    public async Task<Result<Unit>> Handle(ForgotPasswordCommand request, CancellationToken cancellationToken)
    {
        var user = await _userManager.FindByEmailAsync(request.Email);

        // For security reasons, don't reveal if user exists or not
        if (user == null) return Result<Unit>.Success(Unit.Value);

        var token = await _userManager.GeneratePasswordResetTokenAsync(user);

        // In a real app, this would be a link to your website/app
        var resetLink = $"HASAD Reset Token: {token}";

        await _emailService.SendEmailAsync(
            request.Email,
            "HASAD - Reset Password",
            $"<h3>Hello {user.FullName},</h3><p>Your password reset token is:</p><b>{token}</b><p>If you didn't request this, please ignore this email.</p>");

        return Result<Unit>.Success(Unit.Value);
    }
}
