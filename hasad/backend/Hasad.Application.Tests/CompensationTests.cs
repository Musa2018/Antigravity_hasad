using Hasad.Application.Common.Interfaces;
using Hasad.Application.Features.Compensations.Commands.CreateCompensation;
using Hasad.Application.Features.Compensations.Commands.ApproveCompensation;
using Hasad.Application.Features.Compensations.Commands.RecalculateCompensation;
using Hasad.Application.Features.Compensations.Queries.GetCompensationByReportId;
using Hasad.Domain.Constants;
using Hasad.Domain.Entities;
using Hasad.Infrastructure.Persistence;
using Hasad.Infrastructure.Services;
using Microsoft.EntityFrameworkCore;
using Moq;
using Xunit;

namespace Hasad.Application.Tests;

public class CompensationTests
{
    private ApplicationDbContext CreateContext()
    {
        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options;
        return new ApplicationDbContext(options);
    }

    [Fact]
    public async Task CreateCompensation_UsesActiveRule_AndCalculatesAmount()
    {
        var context = CreateContext();
        var reportId = Guid.NewGuid();
        var ruleId = Guid.NewGuid();

        context.CompensationRules.Add(new CompensationRule
        {
            Id = ruleId,
            Multiplier = 0.5m,
            IsActive = true,
            Name = "50% Rule"
        });

        context.DamageReports.Add(new DamageReport
        {
            Id = reportId,
            Items = new List<DamageItem>
            {
                new DamageItem { EstimatedLoss = 1000 }
            }
        });
        await context.SaveChangesAsync();

        var service = new CompensationService();
        var currentUserServiceMock = new Mock<ICurrentUserService>();
        currentUserServiceMock.Setup(x => x.UserName).Returns("testuser");

        var handler = new CreateCompensationCommandHandler(context, service, currentUserServiceMock.Object);
        var command = new CreateCompensationCommand(Guid.NewGuid(), reportId, "Test remarks");

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Equal(500, result.Data!.CalculatedAmount); // 1000 * 0.5
        Assert.Equal(CompensationStatus.Calculated, result.Data.Status);

        var auditLog = await context.CompensationAuditLogs.FirstOrDefaultAsync(l => l.CompensationId == result.Data.Id);
        Assert.NotNull(auditLog);
        Assert.Equal("testuser", auditLog.ChangedBy);
    }

    [Fact]
    public async Task ApproveCompensation_Succeeds_WhenInSubmittedStatus()
    {
        var context = CreateContext();
        var compId = Guid.NewGuid();
        var compensation = new Compensation
        {
            Id = compId,
            Status = CompensationStatus.Submitted,
            RowVersion = new byte[] { 1, 2, 3, 4 },
            CalculatedAmount = 500
        };
        context.Compensations.Add(compensation);
        await context.SaveChangesAsync();

        var currentUserServiceMock = new Mock<ICurrentUserService>();
        currentUserServiceMock.Setup(x => x.UserName).Returns("admin");

        var handler = new ApproveCompensationCommandHandler(context, currentUserServiceMock.Object);
        var command = new ApproveCompensationCommand(compId, 600, "Approved with adjustment", Convert.ToBase64String(compensation.RowVersion));

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.True(result.Succeeded);
        Assert.Equal(CompensationStatus.Approved, result.Data!.Status);
        Assert.Equal(600, result.Data.ApprovedAmount);
    }

    [Fact]
    public async Task ApproveCompensation_Fails_WhenInDraftStatus()
    {
        var context = CreateContext();
        var compId = Guid.NewGuid();
        var compensation = new Compensation
        {
            Id = compId,
            Status = CompensationStatus.Draft,
            RowVersion = new byte[] { 1, 2, 3, 4 }
        };
        context.Compensations.Add(compensation);
        await context.SaveChangesAsync();

        var currentUserServiceMock = new Mock<ICurrentUserService>();
        var handler = new ApproveCompensationCommandHandler(context, currentUserServiceMock.Object);
        var command = new ApproveCompensationCommand(compId, 600, "Should fail", Convert.ToBase64String(compensation.RowVersion));

        var result = await handler.Handle(command, CancellationToken.None);

        Assert.False(result.Succeeded);
        Assert.Contains("Invalid status transition", result.Errors[0]);
    }

    [Theory]
    [InlineData(CompensationStatus.Calculated, CompensationStatus.Approved)]
    [InlineData(CompensationStatus.Submitted, CompensationStatus.Draft)]
    [InlineData(CompensationStatus.Approved, CompensationStatus.Draft)]
    public void CompensationStatus_InvalidTransitions_ShouldReturnFalse(string current, string next)
    {
        Assert.False(CompensationStatus.CanTransition(current, next));
    }

    [Theory]
    [InlineData(CompensationStatus.Draft, CompensationStatus.Calculated)]
    [InlineData(CompensationStatus.Calculated, CompensationStatus.Submitted)]
    [InlineData(CompensationStatus.Submitted, CompensationStatus.Approved)]
    [InlineData(CompensationStatus.Approved, CompensationStatus.Paid)]
    public void CompensationStatus_ValidTransitions_ShouldReturnTrue(string current, string next)
    {
        Assert.True(CompensationStatus.CanTransition(current, next));
    }
}
