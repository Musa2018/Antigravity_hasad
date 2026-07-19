using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Hasad.Application.Common.Options;
using Hasad.Domain.Identity;
using Hasad.Infrastructure.Services;
using Microsoft.Extensions.Options;

namespace Hasad.Application.Tests;

public class TokenServiceTests
{
    private static readonly JwtOptions Options = new()
    {
        Key = new string('k', 48),
        Issuer = "HasadApi",
        Audience = "HasadClients",
        AccessTokenMinutes = 60
    };

    private static ApplicationUser CreateUser() => new()
    {
        Id = "user-1",
        Email = "user@hasad.ps",
        UserName = "user@hasad.ps",
        FullName = "Test User"
    };

    [Fact]
    public void CreateAccessToken_EmbedsIssuerAudienceAndClaims()
    {
        var service = new TokenService(Microsoft.Extensions.Options.Options.Create(Options));

        var jwt = service.CreateAccessToken(CreateUser(), new[] { "FieldSurveyor" });
        var token = new JwtSecurityTokenHandler().ReadJwtToken(jwt);

        Assert.Equal("HasadApi", token.Issuer);
        Assert.Contains("HasadClients", token.Audiences);
        Assert.Equal("user-1", token.Claims.Single(c => c.Type == "nameid").Value);
        Assert.Equal("Test User", token.Claims.Single(c => c.Type == "FullName").Value);
        Assert.Equal("FieldSurveyor", token.Claims.Single(c => c.Type == "role").Value);
    }

    [Fact]
    public void CreateAccessToken_ExpiresAfterConfiguredLifetime()
    {
        var service = new TokenService(Microsoft.Extensions.Options.Options.Create(Options));

        var jwt = service.CreateAccessToken(CreateUser(), Array.Empty<string>());
        var token = new JwtSecurityTokenHandler().ReadJwtToken(jwt);

        var expectedExpiry = DateTime.UtcNow.AddMinutes(Options.AccessTokenMinutes);
        Assert.InRange(token.ValidTo, expectedExpiry.AddMinutes(-2), expectedExpiry.AddMinutes(2));
    }
}
