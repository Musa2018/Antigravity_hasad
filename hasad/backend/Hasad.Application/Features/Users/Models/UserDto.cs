namespace Hasad.Application.Features.Users.Models;

public class UserDto
{
    public string Id { get; set; } = string.Empty;
    public string FullName { get; set; } = string.Empty;
    public string UserName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string PhoneNumber { get; set; } = string.Empty;
    public string Role { get; set; } = string.Empty;
    public Guid? GovernorateId { get; set; }
    public string? GovernorateName { get; set; }
    public Guid? DirectorateId { get; set; }
    public string? DirectorateName { get; set; }
    public bool IsActive { get; set; }
    public DateTime CreatedAt { get; set; }
}
