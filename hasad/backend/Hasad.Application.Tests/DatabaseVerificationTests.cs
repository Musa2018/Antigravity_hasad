using Hasad.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;
using Xunit;
using System.Linq;
using Hasad.Domain.Identity;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Collections.Generic;

namespace Hasad.Application.Tests;

public class DatabaseVerificationTests
{
    private static ServiceProvider CreateServices()
    {
        var services = new ServiceCollection();
        services.AddDbContext<ApplicationDbContext>(o =>
            o.UseSqlServer("Data Source=MUSA_PC;Initial Catalog=hasad;Persist Security Info=True;User ID=sa;Password=Pass@word2023m;Pooling=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;Application Name=\"HASAD API\";Command Timeout=30"));
        services.AddLogging();
        services
            .AddIdentityCore<ApplicationUser>(o =>
            {
                o.Password.RequiredLength = 12;
                o.Password.RequireDigit = true;
                o.Password.RequireUppercase = true;
                o.Password.RequireLowercase = true;
                o.Password.RequireNonAlphanumeric = true;
            })
            .AddRoles<IdentityRole>()
            .AddEntityFrameworkStores<ApplicationDbContext>();
        return services.BuildServiceProvider();
    }

    [Fact(Skip = "Requires local SQL Server instance. Ignored in CI.")]
    public async Task VerifyAndSeedAdminManually()
    {
        using var provider = CreateServices();
        var userManager = provider.GetRequiredService<UserManager<ApplicationUser>>();
        var roleManager = provider.GetRequiredService<RoleManager<IdentityRole>>();

        // Ensure role exists
        if (!await roleManager.RoleExistsAsync("SuperAdmin"))
        {
            await roleManager.CreateAsync(new IdentityRole("SuperAdmin"));
        }

        var email = "admin@hasad.ps";
        var user = await userManager.FindByEmailAsync(email);

        if (user == null)
        {
            user = new ApplicationUser
            {
                UserName = email,
                Email = email,
                FullName = "Super Admin",
                EmailConfirmed = true
            };
            var result = await userManager.CreateAsync(user, "Str0ng!Passw0rd");
            Assert.True(result.Succeeded, string.Join(", ", result.Errors.Select(e => e.Description)));
            await userManager.AddToRoleAsync(user, "SuperAdmin");
        }

        var roles = await userManager.GetRolesAsync(user);
        Assert.Contains("SuperAdmin", roles);
    }
}
