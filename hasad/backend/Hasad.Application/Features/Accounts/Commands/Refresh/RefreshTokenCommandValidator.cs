using FluentValidation;

namespace Hasad.Application.Features.Accounts.Commands.Refresh;

/// <summary>
/// Validates <see cref="RefreshTokenCommand"/> input shape.
/// </summary>
public class RefreshTokenCommandValidator : AbstractValidator<RefreshTokenCommand>
{
    /// <summary>Defines the validation rules.</summary>
    public RefreshTokenCommandValidator()
    {
        RuleFor(x => x.RefreshToken)
            .NotEmpty().WithMessage("Refresh token is required.")
            .MaximumLength(512).WithMessage("Refresh token must not exceed 512 characters.");
    }
}
