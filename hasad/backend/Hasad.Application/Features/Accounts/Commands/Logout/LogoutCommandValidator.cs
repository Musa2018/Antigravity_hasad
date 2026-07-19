using FluentValidation;

namespace Hasad.Application.Features.Accounts.Commands.Logout;

/// <summary>
/// Validates <see cref="LogoutCommand"/> input shape.
/// </summary>
public class LogoutCommandValidator : AbstractValidator<LogoutCommand>
{
    /// <summary>Defines the validation rules.</summary>
    public LogoutCommandValidator()
    {
        RuleFor(x => x.RefreshToken)
            .NotEmpty().WithMessage("Refresh token is required.")
            .MaximumLength(512).WithMessage("Refresh token must not exceed 512 characters.");
    }
}
