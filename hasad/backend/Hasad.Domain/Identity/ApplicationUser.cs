using Hasad.Domain.Entities;
using Microsoft.AspNetCore.Identity;

namespace Hasad.Domain.Identity;

public class ApplicationUser : IdentityUser
{
    public string FullName { get; set; } = string.Empty;
    public bool IsActive { get; set; } = true;
    public DateTime CreatedAt { get; set; }

    public Guid? GovernorateId { get; set; }
    public Governorate? Governorate { get; set; }

    public Guid? DirectorateId { get; set; }
    public Directorate? Directorate { get; set; }
}
