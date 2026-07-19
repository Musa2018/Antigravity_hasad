namespace Hasad.Domain.Entities;

public class Directorate
{
    public Guid Id { get; set; }
    public string NameAr { get; set; } = string.Empty;
    public string NameEn { get; set; } = string.Empty;
    public bool IsActive { get; set; } = true;
    public DateTime CreatedAt { get; set; }

    public Guid GovernorateId { get; set; }
    public Governorate? Governorate { get; set; }
}
