namespace Hasad.Domain.Entities;

public class DamageItem
{
    public Guid Id { get; set; }
    public Guid ClientId { get; set; }

    public Guid DamageReportId { get; set; }
    public DamageReport? DamageReport { get; set; }

    public string AgriculturalSectorId { get; set; } = string.Empty;
    public string SubSectorId { get; set; } = string.Empty;
    public string CropId { get; set; } = string.Empty;

    public string DamageTypeId { get; set; } = string.Empty;

    public decimal AffectedArea { get; set; }
    public decimal DamagePercentage { get; set; }

    public decimal Quantity { get; set; }
    public decimal EstimatedLoss { get; set; }

    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }

    public byte[] RowVersion { get; set; } = Array.Empty<byte>();
}
