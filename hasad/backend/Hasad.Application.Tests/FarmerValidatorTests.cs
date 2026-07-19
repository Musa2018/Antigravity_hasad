using System;
using Hasad.Application.Features.Farmers.Commands.CreateFarmer;
using Hasad.Application.Features.Farmers.Commands.UpdateFarmer;
using Hasad.Domain.Enums;
using Xunit;

namespace Hasad.Application.Tests;

public class FarmerValidatorTests
{
    private readonly CreateFarmerCommandValidator _createValidator = new();

    [Fact]
    public void CreateFarmerValidator_Fails_WhenClientIdIsEmpty()
    {
        var command = CreateValidCommand() with { ClientId = Guid.Empty };
        var result = _createValidator.Validate(command);
        Assert.False(result.IsValid);
        Assert.Contains(result.Errors, e => e.PropertyName == "ClientId");
    }

    [Theory]
    [InlineData("937717783", true)]  // Valid
    [InlineData("937717782", false)] // Invalid checksum
    [InlineData("12345678", false)]  // Too short
    [InlineData("1234567890", false)] // Too long
    [InlineData("ABCDEFGHI", false)] // Not numeric
    public void PalestinianId_Validation_Works(string idNumber, bool expected)
    {
        var command = CreateValidCommand() with { IdTypeId = 1, IdNumber = idNumber };
        var result = _createValidator.Validate(command);
        Assert.Equal(expected, result.IsValid);
    }

    [Theory]
    [InlineData("12345", true)]
    [InlineData("0012345", true)]
    [InlineData("123A5", false)]
    public void JerusalemId_Validation_Works(string idNumber, bool expected)
    {
        var command = CreateValidCommand() with { IdTypeId = 2, IdNumber = idNumber };
        var result = _createValidator.Validate(command);
        Assert.Equal(expected, result.IsValid);
    }

    [Theory]
    [InlineData("ABC12345", true)]
    [InlineData("A-B-C", false)]
    public void Passport_Validation_Works(string idNumber, bool expected)
    {
        var command = CreateValidCommand() with { IdTypeId = 3, IdNumber = idNumber };
        var result = _createValidator.Validate(command);
        Assert.Equal(expected, result.IsValid);
    }

    [Fact]
    public void Age_Validation_Fails_WhenUnder18()
    {
        var birthDate = DateOnly.FromDateTime(DateTime.UtcNow.AddYears(-17));
        var command = CreateValidCommand() with { BirthDate = birthDate };
        var result = _createValidator.Validate(command);
        Assert.False(result.IsValid);
        Assert.Contains(result.Errors, e => e.ErrorMessage.Contains("18 years old"));
    }

    [Fact]
    public void BirthDate_Fails_WhenInFuture()
    {
        var birthDate = DateOnly.FromDateTime(DateTime.UtcNow.AddDays(1));
        var command = CreateValidCommand() with { BirthDate = birthDate };
        var result = _createValidator.Validate(command);
        Assert.False(result.IsValid);
        Assert.Contains(result.Errors, e => e.ErrorMessage.Contains("future"));
    }

    private CreateFarmerCommand CreateValidCommand()
    {
        return new CreateFarmerCommand(
            Guid.NewGuid(),
            1,
            "937717783",
            "أحمد", "محمد", "علي", "محمود",
            "Ahmad", "Mohammad", "Ali", "Mahmoud",
            new DateOnly(1990, 1, 1),
            Gender.Male,
            "0599123456",
            5,
            "GOV-1",
            "LOC-1",
            "Main Street");
    }
}
