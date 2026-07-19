namespace Hasad.Application.Features.Compensations.Models;

public class CompensationDto
{
    public Guid Id { get; set; }
    public Guid ClientId { get; set; }
    public Guid DamageReportId { get; set; }
    public decimal CalculatedAmount { get; set; }
    public decimal ApprovedAmount { get; set; }
    public string Status { get; set; } = string.Empty;
    public string Remarks { get; set; } = string.Empty;
    public string RowVersion { get; set; } = string.Empty;
}
