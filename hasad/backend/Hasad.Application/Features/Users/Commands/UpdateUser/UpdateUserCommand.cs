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

namespace Hasad.Application.Features.Users.Commands.UpdateUser;

public record UpdateUserCommand(
    string Id,
    string FullName,
    string Email,
    string PhoneNumber,
    string Role,
    Guid? GovernorateId,
    Guid? DirectorateId,
    bool IsActive) : IRequest<Result<UserDto>>;

public class UpdateUserCommandHandler : IRequestHandler<UpdateUserCommand, Result<UserDto>>
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly RoleManager<IdentityRole> _roleManager;
    private readonly IApplicationDbContext _context;

    public UpdateUserCommandHandler(
        UserManager<ApplicationUser> userManager,
        RoleManager<IdentityRole> roleManager,
        IApplicationDbContext context)
    {
        _userManager = userManager;
        _roleManager = roleManager;
        _context = context;
    }

    public async Task<Result<UserDto>> Handle(UpdateUserCommand request, CancellationToken cancellationToken)
    {
        var user = await _userManager.FindByIdAsync(request.Id);
        if (user == null)
        {
            return Result<UserDto>.Failure(new[] { "User not found." });
        }

        // 1. Validate Role existence
        if (!await _roleManager.RoleExistsAsync(request.Role))
        {
            return Result<UserDto>.Failure(new[] { $"Role \u0027{request.Role}\u0027 does not exist." });
        }

        // 2. Duplicate Checks (excluding current user)
        if (await _userManager.Users.AnyAsync(u => u.Id != request.Id && u.Email == request.Email, cancellationToken))
        {
            return Result<UserDto>.Failure(new[] { "Email is already registered by another user." });
        }

        if (!string.IsNullOrWhiteSpace(request.PhoneNumber) &&
            await _userManager.Users.AnyAsync(u => u.Id != request.Id && u.PhoneNumber == request.PhoneNumber, cancellationToken))
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

        // 4. Update User
        user.FullName = request.FullName;
        user.Email = request.Email;
        user.UserName = request.Email; // Keep username synced with email for consistency if that's the pattern
        user.PhoneNumber = request.PhoneNumber;
        user.GovernorateId = request.GovernorateId;
        user.DirectorateId = request.DirectorateId;
        user.IsActive = request.IsActive;

        var updateResult = await _userManager.UpdateAsync(user);
        if (!updateResult.Succeeded)
        {
            return Result<UserDto>.Failure(updateResult.Errors.Select(e => e.Description).ToArray());
        }

        // 5. Update Role
        var currentRoles = await _userManager.GetRolesAsync(user);
        if (!currentRoles.Contains(request.Role))
        {
            await _userManager.RemoveFromRolesAsync(user, currentRoles);
            await _userManager.AddToRoleAsync(user, request.Role);
        }

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
            IsActive = user.IsActive,
            CreatedAt = user.CreatedAt
        });
    }
}

public class UpdateUserCommandValidator : AbstractValidator<UpdateUserCommand>
{
    public UpdateUserCommandValidator()
    {
        RuleFor(x => x.Id).NotEmpty();
        RuleFor(x => x.FullName).NotEmpty().MaximumLength(100);
        RuleFor(x => x.Email).NotEmpty().EmailAddress();
        RuleFor(x => x.Role).NotEmpty();
    }
}
