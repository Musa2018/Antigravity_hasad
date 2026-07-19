namespace Hasad.Domain.Entities;

public class CompensationRule
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public decimal Multiplier { get; set; } // e.g., 0.8 for 80%
    public bool IsActive { get; set; } = true;
    public DateTime CreatedAt { get; set; }
}
