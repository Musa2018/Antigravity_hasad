using FluentValidation;
using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.DamageReports.Models;
using Hasad.Domain.Entities;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.DamageReports.Commands.UploadAttachment;

public record UploadAttachmentCommand(
    Guid DamageReportId,
    Guid ClientId,
    Stream FileStream,
    string FileName,
    string ContentType,
    long FileSize,
    double? Latitude,
    double? Longitude,
    DateTime? CapturedAt) : IRequest<Result<AttachmentDto>>;

public class UploadAttachmentCommandHandler : IRequestHandler<UploadAttachmentCommand, Result<AttachmentDto>>
{
    private readonly IApplicationDbContext _context;
    private readonly IFileStorageService _storageService;

    public UploadAttachmentCommandHandler(IApplicationDbContext context, IFileStorageService storageService)
    {
        _context = context;
        _storageService = storageService;
    }

    public async Task<Result<AttachmentDto>> Handle(UploadAttachmentCommand request, CancellationToken cancellationToken)
    {
        // Idempotency
        var existing = await _context.DamageReportAttachments
            .AsNoTracking()
            .FirstOrDefaultAsync(a => a.ClientId == request.ClientId, cancellationToken);

        if (existing != null)
        {
            return Result<AttachmentDto>.Success(MapToDto(existing));
        }

        if (!await _context.DamageReports.AnyAsync(r => r.Id == request.DamageReportId, cancellationToken))
        {
            return Result<AttachmentDto>.Failure(new[] { "Damage report not found." });
        }

        // Save physical file
        var remotePath = await _storageService.SaveAsync(request.FileStream, $"{request.ClientId}_{request.FileName}", request.ContentType, cancellationToken);

        var attachment = new DamageReportAttachment
        {
            Id = Guid.NewGuid(),
            ClientId = request.ClientId,
            DamageReportId = request.DamageReportId,
            FileName = request.FileName,
            OriginalFileName = request.FileName,
            FileType = request.ContentType,
            FileSize = request.FileSize,
            RemotePath = remotePath,
            Latitude = request.Latitude,
            Longitude = request.Longitude,
            CapturedAt = request.CapturedAt,
            UploadStatus = "Completed",
            CreatedAt = DateTime.UtcNow
        };

        _context.DamageReportAttachments.Add(attachment);
        await _context.SaveChangesAsync(cancellationToken);

        return Result<AttachmentDto>.Success(MapToDto(attachment));
    }

    private AttachmentDto MapToDto(DamageReportAttachment a) => new()
    {
        Id = a.Id,
        ClientId = a.ClientId,
        FileName = a.FileName,
        FileType = a.FileType,
        FileSize = a.FileSize,
        RemoteUrl = _storageService.GetUrl(a.RemotePath),
        UploadStatus = a.UploadStatus
    };
}

public class UploadAttachmentCommandValidator : AbstractValidator<UploadAttachmentCommand>
{
    public UploadAttachmentCommandValidator()
    {
        RuleFor(v => v.DamageReportId).NotEmpty();
        RuleFor(v => v.ClientId).NotEmpty();
        RuleFor(v => v.FileStream).NotNull();
        RuleFor(v => v.FileSize).LessThanOrEqualTo(10 * 1024 * 1024).WithMessage("File size must be less than 10MB.");

        var allowedTypes = new[] { "image/jpeg", "image/png", "application/pdf" };
        RuleFor(v => v.ContentType).Must(x => allowedTypes.Contains(x)).WithMessage("Invalid file type.");
    }
}
