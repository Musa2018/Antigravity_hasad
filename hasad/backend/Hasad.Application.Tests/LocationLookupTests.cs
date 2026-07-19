using Hasad.Application.Features.Location.Queries.GetGovernorates;
using Hasad.Application.Features.Location.Queries.GetLocalities;
using Hasad.Domain.Entities;
using Hasad.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Tests;

public class LocationLookupTests
{
    private readonly ApplicationDbContext _context;

    public LocationLookupTests()
    {
        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
            .Options;

        _context = new ApplicationDbContext(options);
    }

    [Fact]
    public async Task GetGovernorates_ReturnsActiveGovernorates()
    {
        // Arrange
        _context.Governorates.Add(new Governorate { Id = Guid.NewGuid(), NameAr = "أ", NameEn = "A", Code = "A", IsActive = true });
        _context.Governorates.Add(new Governorate { Id = Guid.NewGuid(), NameAr = "ب", NameEn = "B", Code = "B", IsActive = false });
        await _context.SaveChangesAsync();

        var handler = new GetGovernoratesQueryHandler(_context);

        // Act
        var result = await handler.Handle(new GetGovernoratesQuery(), CancellationToken.None);

        // Assert
        Assert.True(result.Succeeded);
        Assert.Single(result.Data);
        Assert.Equal("A", result.Data[0].NameEn);
    }

    [Fact]
    public async Task GetLocalities_ReturnsActiveLocalitiesForGovernorate()
    {
        // Arrange
        var govId = Guid.NewGuid();
        _context.Governorates.Add(new Governorate { Id = govId, NameAr = "أ", NameEn = "A", Code = "A", IsActive = true });

        _context.Localities.Add(new Locality { Id = Guid.NewGuid(), NameAr = "ل1", NameEn = "L1", GovernorateId = govId, IsActive = true });
        _context.Localities.Add(new Locality { Id = Guid.NewGuid(), NameAr = "ل2", NameEn = "L2", GovernorateId = govId, IsActive = false });
        _context.Localities.Add(new Locality { Id = Guid.NewGuid(), NameAr = "ل3", NameEn = "L3", GovernorateId = Guid.NewGuid(), IsActive = true });
        await _context.SaveChangesAsync();

        var handler = new GetLocalitiesQueryHandler(_context);

        // Act
        var result = await handler.Handle(new GetLocalitiesQuery(govId), CancellationToken.None);

        // Assert
        Assert.True(result.Succeeded);
        Assert.Single(result.Data);
        Assert.Equal("L1", result.Data[0].NameEn);
    }
}
