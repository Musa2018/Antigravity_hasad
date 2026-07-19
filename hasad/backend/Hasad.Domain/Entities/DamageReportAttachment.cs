namespace Hasad.Domain.Entities;

public class DamageReportAttachment
{
    public Guid Id { get; set; }
    public Guid ClientId { get; set; }
    public Guid DamageReportId { get; set; }
    public DamageReport? DamageReport { get; set; }

    public string FileName { get; set; } = string.Empty;
    public string OriginalFileName { get; set; } = string.Empty;
    public string FileType { get; set; } = string.Empty;
    public long FileSize { get; set; }

    public string LocalPath { get; set; } = string.Empty;
    public string RemotePath { get; set; } = string.Empty;
    public string? ThumbnailPath { get; set; }

    public double? Latitude { get; set; }
    public double? Longitude { get; set; }
    public DateTime? CapturedAt { get; set; }

    public string UploadStatus { get; set; } = "Pending"; // Pending, Completed, Failed

    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }

    public byte[] RowVersion { get; set; } = Array.Empty<byte>();
}
