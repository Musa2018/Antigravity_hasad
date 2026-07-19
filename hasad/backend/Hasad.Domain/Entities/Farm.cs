namespace Hasad.Domain.Entities;

public class Farm
{
    public Guid Id { get; set; }

    /// <summary>
    /// Client-generated synchronization identifier.
    /// </summary>
    public Guid ClientId { get; set; }

    public Guid FarmerId { get; set; }
    public Farmer? Farmer { get; set; }

    public string Name { get; set; } = string.Empty;

    public string GovernorateId { get; set; } = string.Empty;
    public string LocalityId { get; set; } = string.Empty;

    public decimal LandArea { get; set; }
    public string LandAreaUnit { get; set; } = string.Empty;

    public double? Latitude { get; set; }
    public double? Longitude { get; set; }

    public string OwnershipTypeId { get; set; } = string.Empty;

    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }

    /// <summary>
    /// Concurrency token for optimistic synchronization.
    /// </summary>
    public byte[] RowVersion { get; set; } = Array.Empty<byte>();
}
