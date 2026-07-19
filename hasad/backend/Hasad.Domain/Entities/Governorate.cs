namespace Hasad.Domain.Entities;

public class Governorate
{
    public Guid Id { get; set; }
    public string NameAr { get; set; } = string.Empty;
    public string NameEn { get; set; } = string.Empty;
    public string Code { get; set; } = string.Empty;
    public bool IsActive { get; set; } = true;
    public DateTime CreatedAt { get; set; }

    public ICollection<Directorate> Directorates { get; set; } = new List<Directorate>();
    public ICollection<Locality> Localities { get; set; } = new List<Locality>();
}
