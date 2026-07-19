using Hasad.Application.Features.Farms.Commands.CreateFarm;
using Hasad.Application.Features.Farms.Commands.UpdateFarm;
using Hasad.Application.Features.Farms.Queries.GetFarmById;
using Hasad.Application.Features.Farms.Queries.GetFarmsByFarmer;
using Hasad.Domain.Entities;
using Hasad.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace Hasad.Application.Tests;

public class FarmCommandHandlerTests
{
    private ApplicationDbContext CreateContext()
    {
        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options;
        return new ApplicationDbContext(options);
    }

    [Fact]
    public async Task CreateFarm_Succeeds_WhenDataIsValid()
    {
        var context = CreateContext();
        // تم استبدال Name بالحقول الجديدة
        var farmer = new Farmer
        {
            Id = Guid.NewGuid(),
            FirstNameAr = "مزارع",
            IdTypeId = 1,
            IdNumber = "123456789"
        };
        context.Farmers.Add(farmer);
        await context.SaveChangesAsync();

        var handler = new CreateFarmCommandHandler(context);
        var command = new CreateFarmCommand(
            Guid.NewGuid(),
            farmer.Id,
            "My Farm",
            "Gov1",
            "Loc1",
            100.5m,
            "Dunam",
            31.5,
            34.5,
            "Owned");

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.NotNull(result.Data);
        Assert.Equal("My Farm", result.Data.Name);
        Assert.Single(context.Farms);
    }

    [Fact]
    public async Task CreateFarm_IsIdempotent_WhenClientIdExists()
    {
        var context = CreateContext();
        var clientId = Guid.NewGuid();
        var farmer = new Farmer
        {
            Id = Guid.NewGuid(),
            FirstNameAr = "مزارع",
            IdTypeId = 1,
            IdNumber = "123456789"
        };
        context.Farmers.Add(farmer);
        context.Farms.Add(new Farm { Id = Guid.NewGuid(), ClientId = clientId, FarmerId = farmer.Id, Name = "Existing", RowVersion = new byte[] { 1 } });
        await context.SaveChangesAsync();

        var handler = new CreateFarmCommandHandler(context);
        var command = new CreateFarmCommand(clientId, farmer.Id, "New Name", "G1", "L1", 1, "U", null, null, "O");

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Equal("Existing", result.Data!.Name);
        Assert.Single(context.Farms);
    }

    [Fact]
    public async Task UpdateFarm_Fails_WhenVersionMismatches()
    {
        var context = CreateContext();
        var farmer = new Farmer
        {
            Id = Guid.NewGuid(),
            FirstNameAr = "مزارع",
            IdTypeId = 1,
            IdNumber = "123456789"
        };
        var farm = new Farm { Id = Guid.NewGuid(), ClientId = Guid.NewGuid(), FarmerId = farmer.Id, Name = "Old", RowVersion = new byte[] { 1 } };
        context.Farmers.Add(farmer);
        context.Farms.Add(farm);
        await context.SaveChangesAsync();

        var handler = new UpdateFarmCommandHandler(context);
        var command = new UpdateFarmCommand(farm.Id, farm.ClientId, farmer.Id, "New", "G", "L", 2, "U", null, null, "O", Convert.ToBase64String(new byte[] { 2 }));

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.False(result.Succeeded);
        Assert.Contains("CONFLICT", result.Errors[0]);
    }
}