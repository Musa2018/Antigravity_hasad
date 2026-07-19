using FluentValidation;

namespace Hasad.Application.Features.Accounts.Commands.Login;

/// <summary>
/// Validates <see cref="LoginCommand"/> input shape. Credential correctness is
/// the handler's responsibility; this only rejects malformed requests early.
/// </summary>
public class LoginCommandValidator : AbstractValidator<LoginCommand>
{
    /// <summary>Defines the validation rules.</summary>
    public LoginCommandValidator()
    {
        RuleFor(x => x.Email)
            .NotEmpty().WithMessage("Email is required.")
            .EmailAddress().WithMessage("Email must be a valid email address.")
            .MaximumLength(256).WithMessage("Email must not exceed 256 characters.");

        RuleFor(x => x.Password)
            .NotEmpty().WithMessage("Password is required.")
            .MaximumLength(128).WithMessage("Password must not exceed 128 characters.");
    }
}
