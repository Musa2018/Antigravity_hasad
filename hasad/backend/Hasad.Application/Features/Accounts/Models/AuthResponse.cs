namespace Hasad.Application.Features.Accounts.Models;

public class AuthResponse
{
    public string Token { get; set; } = string.Empty;
    public string RefreshToken { get; set; } = string.Empty;
    public string UserId { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string FullName { get; set; } = string.Empty;
    public Guid? GovernorateId { get; set; }
    public Guid? DirectorateId { get; set; }
    public IEnumerable<string> Roles { get; set; } = Array.Empty<string>();
}
