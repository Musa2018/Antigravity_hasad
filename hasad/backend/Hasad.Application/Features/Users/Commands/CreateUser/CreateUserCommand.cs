using FluentValidation;
using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Users.Models;
using Hasad.Domain.Constants;
using Hasad.Domain.Enums;
using Hasad.Domain.Identity;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Users.Commands.CreateUser;

public record CreateUserCommand(
    string FullName,
    string UserName,
    string Email,
    string PhoneNumber,
    string Password,
    string ConfirmPassword,
    string Role,
    Guid? GovernorateId,
    Guid? DirectorateId,
    bool IsActive) : IRequest<Result<UserDto>>;

public class CreateUserCommandHandler : IRequestHandler<CreateUserCommand, Result<UserDto>>
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly RoleManager<IdentityRole> _roleManager;
    private readonly IApplicationDbContext _context;

    public CreateUserCommandHandler(
        UserManager<ApplicationUser> userManager,
        RoleManager<IdentityRole> roleManager,
        IApplicationDbContext context)
    {
        _userManager = userManager;
        _roleManager = roleManager;
        _context = context;
    }

    public async Task<Result<UserDto>> Handle(CreateUserCommand request, CancellationToken cancellationToken)
    {
        // 1. Validate Role existence
        if (!await _roleManager.RoleExistsAsync(request.Role))
        {
            return Result<UserDto>.Failure(new[] { $"Role \u0027{request.Role}\u0027 does not exist." });
        }

        // 2. Duplicate Checks
        if (await _userManager.FindByNameAsync(request.UserName) != null)
        {
            return Result<UserDto>.Failure(new[] { "Username is already taken." });
        }

        if (await _userManager.FindByEmailAsync(request.Email) != null)
        {
            return Result<UserDto>.Failure(new[] { "Email is already registered." });
        }

        if (!string.IsNullOrWhiteSpace(request.PhoneNumber) &&
            await _userManager.Users.AnyAsync(u => u.PhoneNumber == request.PhoneNumber, cancellationToken))
        {
            return Result<UserDto>.Failure(new[] { "Phone number is already in use." });
        }

        // 3. Geographic Validation
        var scopeType = AppRoles.GetScopeType(request.Role);

        if (scopeType == RoleScopeType.Governorate || scopeType == RoleScopeType.Directorate)
        {
            if (!request.GovernorateId.HasValue)
                return Result<UserDto>.Failure(new[] { "Governorate is required for this role." });
        }

        if (scopeType == RoleScopeType.Directorate)
        {
            if (!request.DirectorateId.HasValue)
                return Result<UserDto>.Failure(new[] { "Directorate is required for this role." });
        }

        if (request.DirectorateId.HasValue)
        {
            var directorate = await _context.Directorates
                .AsNoTracking()
                .FirstOrDefaultAsync(d => d.Id == request.DirectorateId.Value, cancellationToken);

            if (directorate == null)
                return Result<UserDto>.Failure(new[] { "Selected Directorate does not exist." });

            if (request.GovernorateId.HasValue && directorate.GovernorateId != request.GovernorateId.Value)
                return Result<UserDto>.Failure(new[] { "The selected Directorate does not belong to the selected Governorate." });
        }

        // 4. Create User
        var user = new ApplicationUser
        {
            FullName = request.FullName,
            UserName = request.UserName,
            Email = request.Email,
            PhoneNumber = request.PhoneNumber,
            GovernorateId = request.GovernorateId,
            DirectorateId = request.DirectorateId,
            IsActive = request.IsActive,
            CreatedAt = DateTime.UtcNow,
            EmailConfirmed = true // Default to confirmed for admin-created users
        };

        var createResult = await _userManager.CreateAsync(user, request.Password);
        if (!createResult.Succeeded)
        {
            return Result<UserDto>.Failure(createResult.Errors.Select(e => e.Description).ToArray());
        }

        // 5. Assign Role
        await _userManager.AddToRoleAsync(user, request.Role);

        return Result<UserDto>.Success(new UserDto
        {
            Id = user.Id,
            FullName = user.FullName,
            UserName = user.UserName!,
            Email = user.Email!,
            PhoneNumber = user.PhoneNumber ?? string.Empty,
            Role = request.Role,
            GovernorateId = user.GovernorateId,
            DirectorateId = user.DirectorateId,
            IsActive = request.IsActive
        });
    }
}

public class CreateUserCommandValidator : AbstractValidator<CreateUserCommand>
{
    public CreateUserCommandValidator()
    {
        RuleFor(x => x.FullName).NotEmpty().MaximumLength(100);
        RuleFor(x => x.UserName).NotEmpty().MaximumLength(50);
        RuleFor(x => x.Email).NotEmpty().EmailAddress();
        RuleFor(x => x.Password).NotEmpty().MinimumLength(6);
        RuleFor(x => x.ConfirmPassword).Equal(x => x.Password).WithMessage("Passwords do not match.");
        RuleFor(x => x.Role).NotEmpty();
    }
}
