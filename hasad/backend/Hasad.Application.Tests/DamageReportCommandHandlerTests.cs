using Hasad.Application.Features.DamageReports.Commands.CreateDamageReport;
using Hasad.Application.Features.DamageReports.Queries.GetDamageReportsByFarm;
using Hasad.Domain.Entities;
using Hasad.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace Hasad.Application.Tests;

public class DamageReportCommandHandlerTests
{
    private ApplicationDbContext CreateContext()
    {
        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options;
        return new ApplicationDbContext(options);
    }

    [Fact]
    public async Task CreateDamageReport_Succeeds_WithItems()
    {
        var context = CreateContext();
        // تم استبدال Name بالحقول الجديدة
        var farmer = new Farmer
        {
            Id = Guid.NewGuid(),
            FirstNameAr = "مزارع",
            FatherNameAr = "اختبار",
            GrandfatherNameAr = "في",
            FamilyNameAr = "النظام",
            IdTypeId = 1,
            IdNumber = "123456789"
        };
        var farm = new Farm { Id = Guid.NewGuid(), FarmerId = farmer.Id, Name = "Farm" };
        context.Farmers.Add(farmer);
        context.Farms.Add(farm);
        await context.SaveChangesAsync();

        var handler = new CreateDamageReportCommandHandler(context);
        var command = new CreateDamageReportCommand(
            Guid.NewGuid(),
            farm.Id,
            farmer.Id,
            DateTime.UtcNow,
            "G1",
            "L1",
            null,
            null,
            "Test Notes",
            new List<CreateDamageItemInput>
            {
                new(Guid.NewGuid(), "Plant", "Fruit", "Olive", "Fire", 10, 50, 100, 1000)
            });

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Single(result.Data!.Items);
        Assert.Equal("Submitted", result.Data.StatusId);
        Assert.Single(context.DamageReports);
        Assert.Single(context.DamageItems);
    }

    [Fact]
    public async Task GetDamageReportsByFarm_ReturnsReports()
    {
        var context = CreateContext();
        var farmId = Guid.NewGuid();
        context.DamageReports.Add(new DamageReport
        {
            Id = Guid.NewGuid(),
            FarmId = farmId,
            FarmerId = Guid.NewGuid(),
            DamageDate = DateTime.UtcNow,
            GovernorateId = "G",
            LocalityId = "L",
            StatusId = "Draft",
            RowVersion = new byte[] { 1 }
        });
        await context.SaveChangesAsync();

        var handler = new GetDamageReportsByFarmQueryHandler(context);
        var query = new GetDamageReportsByFarmQuery(farmId);

        var result = await handler.Handle(query, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Single(result.Data!);
    }
}