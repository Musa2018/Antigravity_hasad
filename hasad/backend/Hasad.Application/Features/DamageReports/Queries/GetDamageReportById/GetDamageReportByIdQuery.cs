using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.DamageReports.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.DamageReports.Queries.GetDamageReportById;

public record GetDamageReportByIdQuery(Guid Id) : IRequest<Result<DamageReportDto>>;

public class GetDamageReportByIdQueryHandler : IRequestHandler<GetDamageReportByIdQuery, Result<DamageReportDto>>
{
    private readonly IApplicationDbContext _context;

    public GetDamageReportByIdQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<DamageReportDto>> Handle(GetDamageReportByIdQuery request, CancellationToken cancellationToken)
    {
        var report = await _context.DamageReports
            .AsNoTracking()
            .Include(r => r.Items)
            .FirstOrDefaultAsync(r => r.Id == request.Id, cancellationToken);

        if (report == null)
        {
            return Result<DamageReportDto>.Failure(new[] { "Damage report not found." });
        }

        return Result<DamageReportDto>.Success(new DamageReportDto
        {
            Id = report.Id,
            ClientId = report.ClientId,
            FarmId = report.FarmId,
            FarmerId = report.FarmerId,
            DamageDate = report.DamageDate,
            DocumentationDate = report.DocumentationDate,
            GovernorateId = report.GovernorateId,
            LocalityId = report.LocalityId,
            Latitude = report.Latitude,
            Longitude = report.Longitude,
            StatusId = report.StatusId,
            Notes = report.Notes,
            RowVersion = Convert.ToBase64String(report.RowVersion),
            Items = report.Items.Select(i => new DamageItemDto
            {
                Id = i.Id,
                ClientId = i.ClientId,
                AgriculturalSectorId = i.AgriculturalSectorId,
                SubSectorId = i.SubSectorId,
                CropId = i.CropId,
                DamageTypeId = i.DamageTypeId,
                AffectedArea = i.AffectedArea,
                DamagePercentage = i.DamagePercentage,
                Quantity = i.Quantity,
                EstimatedLoss = i.EstimatedLoss,
                RowVersion = Convert.ToBase64String(i.RowVersion)
            }).ToList()
        });
    }
}
