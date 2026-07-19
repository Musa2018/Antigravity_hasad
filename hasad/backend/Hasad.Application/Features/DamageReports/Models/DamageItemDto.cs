namespace Hasad.Application.Features.DamageReports.Models;

public class DamageItemDto
{
    public Guid Id { get; set; }
    public Guid ClientId { get; set; }
    public string AgriculturalSectorId { get; set; } = string.Empty;
    public string SubSectorId { get; set; } = string.Empty;
    public string CropId { get; set; } = string.Empty;
    public string DamageTypeId { get; set; } = string.Empty;
    public decimal AffectedArea { get; set; }
    public decimal DamagePercentage { get; set; }
    public decimal Quantity { get; set; }
    public decimal EstimatedLoss { get; set; }
    public string RowVersion { get; set; } = string.Empty;
}
