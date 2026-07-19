namespace Hasad.Application.Features.Farms.Models;

public class FarmDto
{
    public Guid Id { get; set; }
    public Guid ClientId { get; set; }
    public Guid FarmerId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string GovernorateId { get; set; } = string.Empty;
    public string LocalityId { get; set; } = string.Empty;
    public decimal LandArea { get; set; }
    public string LandAreaUnit { get; set; } = string.Empty;
    public double? Latitude { get; set; }
    public double? Longitude { get; set; }
    public string OwnershipTypeId { get; set; } = string.Empty;
    public string RowVersion { get; set; } = string.Empty;
}
