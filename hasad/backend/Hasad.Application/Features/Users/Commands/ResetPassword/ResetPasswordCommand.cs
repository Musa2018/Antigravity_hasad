using FluentValidation;
using Hasad.Application.Common.Models;
using Hasad.Domain.Identity;
using MediatR;
using Microsoft.AspNetCore.Identity;

namespace Hasad.Application.Features.Users.Commands.ResetPassword;

public record ResetPasswordCommand(string UserId, string NewPassword, string ConfirmPassword) : IRequest<Result<bool>>;

public class ResetPasswordCommandHandler : IRequestHandler<ResetPasswordCommand, Result<bool>>
{
    private readonly UserManager<ApplicationUser> _userManager;

    public ResetPasswordCommandHandler(UserManager<ApplicationUser> userManager)
    {
        _userManager = userManager;
    }

    public async Task<Result<bool>> Handle(ResetPasswordCommand request, CancellationToken cancellationToken)
    {
        var user = await _userManager.FindByIdAsync(request.UserId);
        if (user == null)
        {
            return Result<bool>.Failure(new[] { "User not found." });
        }

        // Remove existing password and set new one
        var removeResult = await _userManager.RemovePasswordAsync(user);
        if (!removeResult.Succeeded)
        {
            return Result<bool>.Failure(removeResult.Errors.Select(e => e.Description).ToArray());
        }

        var addResult = await _userManager.AddPasswordAsync(user, request.NewPassword);
        if (!addResult.Succeeded)
        {
            return Result<bool>.Failure(addResult.Errors.Select(e => e.Description).ToArray());
        }

        return Result<bool>.Success(true);
    }
}

public class ResetPasswordCommandValidator : AbstractValidator<ResetPasswordCommand>
{
    public ResetPasswordCommandValidator()
    {
        RuleFor(x => x.UserId).NotEmpty();
        RuleFor(x => x.NewPassword).NotEmpty().MinimumLength(6);
        RuleFor(x => x.ConfirmPassword).Equal(x => x.NewPassword).WithMessage("Passwords do not match.");
    }
}
