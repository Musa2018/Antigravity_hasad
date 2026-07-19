namespace Hasad.Application.Features.DamageReports.Models;

public class AttachmentDto
{
    public Guid Id { get; set; }
    public Guid ClientId { get; set; }
    public string FileName { get; set; } = string.Empty;
    public string FileType { get; set; } = string.Empty;
    public long FileSize { get; set; }
    public string RemoteUrl { get; set; } = string.Empty;
    public string UploadStatus { get; set; } = string.Empty;
}
