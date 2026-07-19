using Hasad.Domain.Constants;
using Hasad.Domain.Identity;
using Hasad.Infrastructure.Persistence;
using Hasad.Infrastructure.Persistence.Seed;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Xunit;

namespace Hasad.Application.Tests;

public class DbInitializerTests
{
    private static ServiceProvider CreateServices()
    {
        var services = new ServiceCollection();
        services.AddDbContext<ApplicationDbContext>(o =>
            o.UseInMemoryDatabase(Guid.NewGuid().ToString()));
        services.AddLogging();
        services
            .AddIdentityCore<ApplicationUser>()
            .AddRoles<IdentityRole>()
            .AddEntityFrameworkStores<ApplicationDbContext>();
        return services.BuildServiceProvider();
    }

    [Fact]
    public async Task SeedRolesAsync_CreatesAllApplicationRoles_AndIsIdempotent()
    {
        using var provider = CreateServices();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();

        await DbInitializer.SeedRolesAsync(roleManager);
        await DbInitializer.SeedRolesAsync(roleManager);

        foreach (var role in AppRoles.All())
        {
            Assert.True(await roleManager.RoleExistsAsync(role));
        }
        Assert.Equal(AppRoles.All().Length, await roleManager.Roles.CountAsync());
    }

    [Fact]
    public async Task SeedSuperAdminAsync_CreatesUserWithSuperAdminRole()
    {
        using var provider = CreateServices();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();
        await DbInitializer.SeedRolesAsync(roleManager);

        var result = await DbInitializer.SeedSuperAdminAsync(userManager, "admin@hasad.ps", "Str0ng!Passw0rd");

        Assert.NotNull(result);
        Assert.True(result!.Succeeded);
        var user = await userManager.FindByEmailAsync("admin@hasad.ps");
        Assert.NotNull(user);
        Assert.True(await userManager.IsInRoleAsync(user!, "SuperAdmin"));
    }

    [Fact]
    public async Task SeedSuperAdminAsync_ReturnsNull_WhenUserAlreadyExists()
    {
        using var provider = CreateServices();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();
        await DbInitializer.SeedRolesAsync(roleManager);
        await DbInitializer.SeedSuperAdminAsync(userManager, "admin@hasad.ps", "Str0ng!Passw0rd");

        var second = await DbInitializer.SeedSuperAdminAsync(userManager, "admin@hasad.ps", "Str0ng!Passw0rd");

        Assert.Null(second);
        Assert.Single(userManager.Users.Where(u => u.Email == "admin@hasad.ps"));
    }

    [Fact]
    public async Task SeedSuperAdminAsync_ReportsFailure_ForPasswordPolicyViolation()
    {
        using var provider = CreateServices();
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();

        var result = await DbInitializer.SeedSuperAdminAsync(userManager, "admin@hasad.ps", "weak");

        Assert.NotNull(result);
        Assert.False(result!.Succeeded);
        Assert.Null(await userManager.FindByEmailAsync("admin@hasad.ps"));
    }
}
