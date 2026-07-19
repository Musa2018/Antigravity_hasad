using Hasad.Application.Features.Farmers.Commands.CreateFarmer;
using Hasad.Application.Features.Farmers.Commands.DeleteFarmer;
using Hasad.Application.Features.Farmers.Commands.UpdateFarmer;
using Hasad.Application.Features.Farmers.Queries.GetFarmerById;
using Hasad.Application.Features.Farmers.Queries.GetFarmersList;
using Hasad.Domain.Entities;
using Hasad.Domain.Enums;
using Hasad.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;
using Xunit;

namespace Hasad.Application.Tests;

public class FarmerCommandHandlerTests
{
    private ApplicationDbContext CreateContext()
    {
        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options;
        return new ApplicationDbContext(options);
    }

    [Fact]
    public async Task CreateFarmer_Succeeds_WhenDataIsValid()
    {
        var context = CreateContext();
        var handler = new CreateFarmerCommandHandler(context);
        var command = new CreateFarmerCommand(
            Guid.NewGuid(),
            1,
            "123456789",
            "أحمد", "محمد", "علي", "محمود",
            "Ahmed", "Mohammed", "Ali", "Mahmoud",
            new DateOnly(1985, 5, 10),
            Gender.Male,
            "0599123456",
            5,
            "GOV-1",
            "LOC-1",
            "Gaza");

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.NotNull(result.Data);
        Assert.Equal("أحمد", result.Data.FirstNameAr);
        Assert.Equal("محمود", result.Data.FamilyNameAr);
        Assert.Equal(command.ClientId, result.Data.ClientId);
        Assert.Equal(Gender.Male, result.Data.Gender);
        Assert.Equal(5, result.Data.FamilySize);
        Assert.Single(context.Farmers);
    }

    [Fact]
    public async Task CreateFarmer_IsIdempotent_WhenClientIdExists()
    {
        var context = CreateContext();
        var clientId = Guid.NewGuid();
        context.Farmers.Add(new Farmer
        {
            Id = Guid.NewGuid(),
            ClientId = clientId,
            IdTypeId = 1,
            IdNumber = "123",
            FirstNameAr = "مزارع",
            FatherNameAr = "موجود",
            GrandfatherNameAr = "سابقا",
            FamilyNameAr = "هنا",
            FirstNameEn = "",
            FatherNameEn = "",
            GrandfatherNameEn = "",
            FamilyNameEn = "",
            GovernorateId = "G",
            LocalityId = "L",
            Gender = Gender.Male,
            FamilySize = 1,
            RowVersion = new byte[] { 1 }
        });
        await context.SaveChangesAsync();

        var handler = new CreateFarmerCommandHandler(context);
        var command = new CreateFarmerCommand(clientId, 1, "123", "اسم", "مختلف", "جدا", "هنا", "", "", "", "", new DateOnly(1990, 1, 1), Gender.Female, "059", 4, "G", "L", "Address");

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
        // يجب أن يرجع الاسم القديم لأنه Idempotent (يمنع التكرار لنفس العميل)
        Assert.Equal("مزارع", result.Data!.FirstNameAr);
        Assert.Equal(Gender.Male, result.Data!.Gender);
        Assert.Single(context.Farmers);
    }

    [Fact]
    public async Task UpdateFarmer_Succeeds_WhenDataAndVersionMatch()
    {
        var context = CreateContext();
        var version = new byte[] { 1, 2, 3, 4 };
        var farmer = new Farmer
        {
            Id = Guid.NewGuid(),
            ClientId = Guid.NewGuid(),
            IdTypeId = 1,
            IdNumber = "123",
            FirstNameAr = "الاسم",
            FatherNameAr = "القديم",
            GrandfatherNameAr = "للمزارع",
            FamilyNameAr = "الحالي",
            FirstNameEn = "",
            FatherNameEn = "",
            GrandfatherNameEn = "",
            FamilyNameEn = "",
            GovernorateId = "G",
            LocalityId = "L",
            Gender = Gender.Male,
            FamilySize = 2,
            RowVersion = version
        };
        context.Farmers.Add(farmer);
        await context.SaveChangesAsync();

        var handler = new UpdateFarmerCommandHandler(context);
        var command = new UpdateFarmerCommand(
            farmer.Id, farmer.ClientId, 1, "123",
            "الاسم", "الجديد", "تم", "تحديثه",
            "", "", "", "",
            new DateOnly(1980, 1, 1), Gender.Male, "059", 3, "G", "L", "New Address", Convert.ToBase64String(version));

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Equal("الاسم", result.Data!.FirstNameAr);
        Assert.Equal("تحديثه", result.Data!.FamilyNameAr);
        Assert.Equal(3, result.Data!.FamilySize);
    }

    [Fact]
    public async Task UpdateFarmer_Fails_WhenVersionMismatches()
    {
        var context = CreateContext();
        var farmer = new Farmer
        {
            Id = Guid.NewGuid(),
            ClientId = Guid.NewGuid(),
            IdTypeId = 1,
            IdNumber = "123",
            FirstNameAr = "قديم",
            FatherNameAr = "قديم",
            GrandfatherNameAr = "قديم",
            FamilyNameAr = "قديم",
            FirstNameEn = "",
            FatherNameEn = "",
            GrandfatherNameEn = "",
            FamilyNameEn = "",
            GovernorateId = "G",
            LocalityId = "L",
            RowVersion = new byte[] { 1 }
        };
        context.Farmers.Add(farmer);
        await context.SaveChangesAsync();

        var handler = new UpdateFarmerCommandHandler(context);
        var command = new UpdateFarmerCommand(
            farmer.Id, farmer.ClientId, 1, "123",
            "جديد", "جديد", "جديد", "جديد",
            "", "", "", "",
            new DateOnly(1990, 1, 1), Gender.Male, "059", 5, "G", "L", "Add", Convert.ToBase64String(new byte[] { 2 }));

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.False(result.Succeeded);
        Assert.Contains("CONFLICT", result.Errors[0]);
    }

    [Fact]
    public async Task DeleteFarmer_Succeeds_WhenFarmerExists()
    {
        var context = CreateContext();
        var farmer = new Farmer
        {
            Id = Guid.NewGuid(),
            ClientId = Guid.NewGuid(),
            IdTypeId = 1,
            IdNumber = "123",
            FirstNameAr = "مزارع",
            FatherNameAr = "للحذف",
            GrandfatherNameAr = "",
            FamilyNameAr = "",
            FirstNameEn = "",
            FatherNameEn = "",
            GrandfatherNameEn = "",
            FamilyNameEn = "",
            GovernorateId = "G",
            LocalityId = "L",
            RowVersion = new byte[] { 1 }
        };
        context.Farmers.Add(farmer);
        await context.SaveChangesAsync();

        var handler = new DeleteFarmerCommandHandler(context);
        var command = new DeleteFarmerCommand(farmer.Id);

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.True(context.Farmers.First().IsDeleted);
    }

    [Fact]
    public async Task GetFarmerById_ReturnsFarmer_WhenExists()
    {
        var context = CreateContext();
        var farmer = new Farmer
        {
            Id = Guid.NewGuid(),
            ClientId = Guid.NewGuid(),
            IdTypeId = 1,
            IdNumber = "123",
            FirstNameAr = "الهدف",
            FatherNameAr = "المطلوب",
            GrandfatherNameAr = "هنا",
            FamilyNameAr = "صحيح",
            FirstNameEn = "",
            FatherNameEn = "",
            GrandfatherNameEn = "",
            FamilyNameEn = "",
            GovernorateId = "G",
            LocalityId = "L",
            RowVersion = new byte[] { 1 }
        };
        context.Farmers.Add(farmer);
        await context.SaveChangesAsync();

        var handler = new GetFarmerByIdQueryHandler(context);
        var query = new GetFarmerByIdQuery(farmer.Id);

        var result = await handler.Handle(query, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Equal("الهدف", result.Data!.FirstNameAr);
        Assert.Equal("صحيح", result.Data!.FamilyNameAr);
        Assert.NotEmpty(result.Data!.RowVersion);
    }

    [Fact]
    public async Task GetFarmersList_ReturnsPaginatedItems()
    {
        var context = CreateContext();
        for (int i = 0; i < 15; i++)
        {
            context.Farmers.Add(new Farmer
            {
                Id = Guid.NewGuid(),
                ClientId = Guid.NewGuid(),
                IdTypeId = 1,
                IdNumber = i.ToString(),
                FirstNameAr = $"مزارع {i:D2}",
                FatherNameAr = "تجربة",
                GrandfatherNameAr = "رقم",
                FamilyNameAr = $"{i}",
                FirstNameEn = "",
                FatherNameEn = "",
                GrandfatherNameEn = "",
                FamilyNameEn = "",
                GovernorateId = "G",
                LocalityId = "L",
                RowVersion = new byte[] { (byte)i }
            });
        }
        await context.SaveChangesAsync();

        var handler = new GetFarmersListQueryHandler(context);
        var query = new GetFarmersListQuery(PageNumber: 1, PageSize: 10);

        var result = await handler.Handle(query, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Equal(10, result.Data!.Items.Count);
        Assert.Equal(15, result.Data!.TotalCount);
        Assert.Equal(2, result.Data!.TotalPages);
        Assert.NotEmpty(result.Data!.Items[0].RowVersion);
    }
}
