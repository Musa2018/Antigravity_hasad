using Hasad.Application.Features.Users.Commands.CreateUser;
using Hasad.Application.Features.Users.Models;
using Hasad.Domain.Entities;
using Hasad.Domain.Identity;
using Hasad.Infrastructure.Persistence;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using Xunit;

namespace Hasad.Application.Tests;

public class CreateUserTests
{
    private ServiceProvider CreateServices(ApplicationDbContext context)
    {
        var services = new ServiceCollection();
        services.AddSingleton(context);
        services.AddLogging();
        services.AddIdentity<ApplicationUser, IdentityRole>()
            .AddEntityFrameworkStores<ApplicationDbContext>()
            .AddDefaultTokenProviders();

        return services.BuildServiceProvider();
    }

    private ApplicationDbContext CreateContext()
    {
        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options;
        return new ApplicationDbContext(options);
    }

    [Fact]
    public async Task CreateUser_Succeeds_WhenDataIsValid()
    {
        var context = CreateContext();
        using var provider = CreateServices(context);
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();

        await roleManager.CreateAsync(new IdentityRole("SuperAdmin"));

        var handler = new CreateUserCommandHandler(userManager, roleManager, context);
        var command = new CreateUserCommand("Full Name", "user1", "user1@test.com", "123", "Pass123!", "Pass123!", "SuperAdmin", null, null, true);

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Equal("Full Name", result.Data!.FullName);
    }

    [Fact]
    public async Task CreateUser_Fails_WhenRoleDoesNotExist()
    {
        var context = CreateContext();
        using var provider = CreateServices(context);
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();

        var handler = new CreateUserCommandHandler(userManager, roleManager, context);
        var command = new CreateUserCommand("Name", "user1", "e@e.com", "1", "P", "P", "GhostRole", null, null, true);

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.False(result.Succeeded);
        Assert.Contains("does not exist", result.Errors[0]);
    }

    [Fact]
    public async Task CreateUser_Fails_WhenGeoMissingForRegionalRole()
    {
        var context = CreateContext();
        using var provider = CreateServices(context);
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();

        await roleManager.CreateAsync(new IdentityRole("Director"));

        var handler = new CreateUserCommandHandler(userManager, roleManager, context);
        var command = new CreateUserCommand("Name", "u", "e@e.com", "1", "P", "P", "Director", null, null, true);

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.False(result.Succeeded);
        Assert.Contains("Governorate is required", result.Errors[0]);
    }

    [Fact]
    public async Task CreateUser_Fails_WhenDirectorateDoesNotBelongToGovernorate()
    {
        var context = CreateContext();
        var gzId = Guid.NewGuid();
        var otherId = Guid.NewGuid();
        var dirId = Guid.NewGuid();

        context.Governorates.Add(new Governorate { Id = gzId, NameAr = "Gaza", NameEn = "Gaza", Code = "GZ" });
        context.Directorates.Add(new Directorate { Id = dirId, NameAr = "D", NameEn = "D", GovernorateId = otherId });
        await context.SaveChangesAsync();

        using var provider = CreateServices(context);
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();
        await roleManager.CreateAsync(new IdentityRole("Director"));

        var handler = new CreateUserCommandHandler(userManager, roleManager, context);
        var command = new CreateUserCommand("Name", "u", "e@e.com", "1", "P", "P", "Director", gzId, dirId, true);

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.False(result.Succeeded);
        Assert.Contains("does not belong to the selected Governorate", result.Errors[0]);
    }

    [Fact]
    public async Task CreateUser_Fails_WhenUsernameExists()
    {
        var context = CreateContext();
        using var provider = CreateServices(context);
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();

        await roleManager.CreateAsync(new IdentityRole("SuperAdmin"));
        await userManager.CreateAsync(new ApplicationUser { UserName = "duplicate", FullName = "Existing", Email = "old@test.com" }, "Pass123!");

        var handler = new CreateUserCommandHandler(userManager, roleManager, context);
        var command = new CreateUserCommand("New Name", "duplicate", "new@test.com", "123", "Pass123!", "Pass123!", "SuperAdmin", null, null, true);

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.False(result.Succeeded);
        Assert.Contains("Username is already taken", result.Errors[0]);
    }

    [Fact]
    public async Task CreateUser_Succeeds_ForGlobalRole_WithoutGeo()
    {
        var context = CreateContext();
        using var provider = CreateServices(context);
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();

        await roleManager.CreateAsync(new IdentityRole("Finance"));

        var handler = new CreateUserCommandHandler(userManager, roleManager, context);
        var command = new CreateUserCommand("Finance User", "finance1", "f@test.com", "123", "Pass123!", "Pass123!", "Finance", null, null, true);

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
    }

    [Fact]
    public async Task CreateUser_Succeeds_ForGovernorateRole_WithOnlyGovernorate()
    {
        var context = CreateContext();
        var gzId = Guid.NewGuid();
        context.Governorates.Add(new Governorate { Id = gzId, NameAr = "Gaza", NameEn = "Gaza", Code = "GZ" });
        await context.SaveChangesAsync();

        using var provider = CreateServices(context);
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();
        await roleManager.CreateAsync(new IdentityRole("Director"));

        var handler = new CreateUserCommandHandler(userManager, roleManager, context);
        var command = new CreateUserCommand("Director Name", "dir1", "d@test.com", "123", "Pass123!", "Pass123!", "Director", gzId, null, true);

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
    }

    [Fact]
    public async Task CreateUser_Fails_ForDirectorateRole_WithoutDirectorate()
    {
        var context = CreateContext();
        var gzId = Guid.NewGuid();
        context.Governorates.Add(new Governorate { Id = gzId, NameAr = "Gaza", NameEn = "Gaza", Code = "GZ" });
        await context.SaveChangesAsync();

        using var provider = CreateServices(context);
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();
        await roleManager.CreateAsync(new IdentityRole("FieldSurveyor"));

        var handler = new CreateUserCommandHandler(userManager, roleManager, context);
        var command = new CreateUserCommand("Surveyor", "sur1", "s@test.com", "123", "Pass123!", "Pass123!", "FieldSurveyor", gzId, null, true);

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.False(result.Succeeded);
        Assert.Contains("Directorate is required", result.Errors[0]);
    }

    [Fact]
    public async Task CreateUser_Succeeds_ForDirectorateRole_WithBothIds()
    {
        var context = CreateContext();
        var gzId = Guid.NewGuid();
        var dirId = Guid.NewGuid();
        context.Governorates.Add(new Governorate { Id = gzId, NameAr = "Gaza", NameEn = "Gaza", Code = "GZ" });
        context.Directorates.Add(new Directorate { Id = dirId, NameAr = "D", NameEn = "D", GovernorateId = gzId });
        await context.SaveChangesAsync();

        using var provider = CreateServices(context);
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();
        await roleManager.CreateAsync(new IdentityRole("FieldSurveyor"));

        var handler = new CreateUserCommandHandler(userManager, roleManager, context);
        var command = new CreateUserCommand("Surveyor", "sur1", "s@test.com", "123", "Pass123!", "Pass123!", "FieldSurveyor", gzId, dirId, true);

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
    }
}
