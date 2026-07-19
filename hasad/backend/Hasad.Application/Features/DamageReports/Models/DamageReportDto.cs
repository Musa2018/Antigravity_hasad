namespace Hasad.Application.Features.DamageReports.Models;

public class DamageReportDto
{
    public Guid Id { get; set; }
    public Guid ClientId { get; set; }
    public Guid FarmId { get; set; }
    public Guid FarmerId { get; set; }
    public DateTime DamageDate { get; set; }
    public DateTime DocumentationDate { get; set; }
    public string GovernorateId { get; set; } = string.Empty;
    public string LocalityId { get; set; } = string.Empty;
    public double? Latitude { get; set; }
    public double? Longitude { get; set; }
    public string StatusId { get; set; } = string.Empty;
    public string Notes { get; set; } = string.Empty;
    public string RowVersion { get; set; } = string.Empty;
    public List<DamageItemDto> Items { get; set; } = new();
}
