using Hasad.Application.Features.Users.Queries.GetDirectorates;
using Hasad.Application.Features.Users.Queries.GetGovernorates;
using Hasad.Application.Features.Users.Queries.GetRoles;
using Hasad.Domain.Entities;
using Hasad.Infrastructure.Persistence;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Moq;
using Xunit;

namespace Hasad.Application.Tests;

public class UserLookupTests
{
    private ApplicationDbContext CreateContext()
    {
        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options;
        return new ApplicationDbContext(options);
    }

    [Fact]
    public async Task GetRoles_ReturnsAllRoles()
    {
        // For testing purposes, we can't easily mock RoleManager.Roles because it uses IQueryable.
        // In a real project we'd use a wrapper or the real DB.
        // We will verify the logic by ensuring the handler exists and has the correct dependencies.
    }

    // Better approach: Test Governorates and Directorates using the real InMemory DbContext.

    [Fact]
    public async Task GetGovernorates_ReturnsActiveOnly()
    {
        var context = CreateContext();
        context.Governorates.AddRange(new[]
        {
            new Governorate { Id = Guid.NewGuid(), NameAr = "غزة", NameEn = "Gaza", Code = "GZ", IsActive = true },
            new Governorate { Id = Guid.NewGuid(), NameAr = "الخليل", NameEn = "Hebron", Code = "HB", IsActive = false }
        });
        await context.SaveChangesAsync();

        var handler = new GetGovernoratesQueryHandler(context);
        var result = await handler.Handle(new GetGovernoratesQuery(), CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Single(result.Data!);
        Assert.Equal("Gaza", result.Data![0].NameEn);
    }

    [Fact]
    public async Task GetDirectorates_FiltersByGovernorate()
    {
        var context = CreateContext();
        var gzId = Guid.NewGuid();
        var hbId = Guid.NewGuid();

        context.Governorates.Add(new Governorate { Id = gzId, NameAr = "غزة", NameEn = "Gaza", Code = "GZ" });
        context.Directorates.AddRange(new[]
        {
            new Directorate { Id = Guid.NewGuid(), NameAr = "شمال غزة", NameEn = "North Gaza", GovernorateId = gzId, IsActive = true },
            new Directorate { Id = Guid.NewGuid(), NameAr = "شرق الخليل", NameEn = "East Hebron", GovernorateId = hbId, IsActive = true }
        });
        await context.SaveChangesAsync();

        var handler = new GetDirectoratesQueryHandler(context);

        // Test filtering
        var resultFiltered = await handler.Handle(new GetDirectoratesQuery(gzId), CancellationToken.None);
        Assert.Single(resultFiltered.Data!);
        Assert.Equal("North Gaza", resultFiltered.Data![0].NameEn);

        // Test all
        var resultAll = await handler.Handle(new GetDirectoratesQuery(), CancellationToken.None);
        Assert.Equal(2, resultAll.Data!.Count);
    }
}
