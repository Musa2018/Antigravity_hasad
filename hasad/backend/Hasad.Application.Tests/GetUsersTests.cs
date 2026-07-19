using Hasad.Application.Features.Users.Queries.GetUsers;
using Hasad.Domain.Identity;
using Hasad.Infrastructure.Persistence;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Moq;
using Xunit;

namespace Hasad.Application.Tests;

public class GetUsersTests
{
    private ApplicationDbContext CreateContext()
    {
        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options;
        return new ApplicationDbContext(options);
    }

    private Mock<UserManager<ApplicationUser>> CreateUserManagerMock()
    {
        var store = new Mock<IUserStore<ApplicationUser>>();
        return new Mock<UserManager<ApplicationUser>>(store.Object, null!, null!, null!, null!, null!, null!, null!, null!);
    }

    [Fact]
    public async Task GetUsers_ReturnsPaginatedList()
    {
        var context = CreateContext();
        context.Users.AddRange(new[]
        {
            new ApplicationUser { Id = "1", FullName = "User A", UserName = "usera", Email = "a@test.com" },
            new ApplicationUser { Id = "2", FullName = "User B", UserName = "userb", Email = "b@test.com" },
            new ApplicationUser { Id = "3", FullName = "User C", UserName = "userc", Email = "c@test.com" }
        });
        await context.SaveChangesAsync();

        var userManagerMock = CreateUserManagerMock();
        userManagerMock.Setup(m => m.GetRolesAsync(It.IsAny<ApplicationUser>()))
            .ReturnsAsync(new List<string> { "FieldSurveyor" });

        var handler = new GetUsersQueryHandler(context, userManagerMock.Object);
        var query = new GetUsersQuery(PageNumber: 1, PageSize: 2);

        var result = await handler.Handle(query, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Equal(2, result.Data!.Items.Count);
        Assert.Equal(3, result.Data.TotalCount);
        Assert.Equal(2, result.Data.TotalPages);
    }

    [Fact]
    public async Task GetUsers_AppliesSearchFilter()
    {
        var context = CreateContext();
        context.Users.AddRange(new[]
        {
            new ApplicationUser { Id = "1", FullName = "John Doe", UserName = "johnd", Email = "john@test.com" },
            new ApplicationUser { Id = "2", FullName = "Jane Smith", UserName = "janes", Email = "jane@test.com" }
        });
        await context.SaveChangesAsync();

        var userManagerMock = CreateUserManagerMock();
        userManagerMock.Setup(m => m.GetRolesAsync(It.IsAny<ApplicationUser>()))
            .ReturnsAsync(new List<string>());

        var handler = new GetUsersQueryHandler(context, userManagerMock.Object);

        // Search by name
        var result = await handler.Handle(new GetUsersQuery(Search: "Jane"), CancellationToken.None);
        Assert.Single(result.Data!.Items);
        Assert.Equal("Jane Smith", result.Data.Items[0].FullName);

        // Search by email
        var resultEmail = await handler.Handle(new GetUsersQuery(Search: "john@"), CancellationToken.None);
        Assert.Single(resultEmail.Data!.Items);
        Assert.Equal("John Doe", resultEmail.Data.Items[0].FullName);
    }
}
