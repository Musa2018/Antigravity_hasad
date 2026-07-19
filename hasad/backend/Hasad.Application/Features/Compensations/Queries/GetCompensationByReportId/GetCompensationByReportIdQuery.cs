using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Compensations.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Compensations.Queries.GetCompensationByReportId;

public record GetCompensationByReportIdQuery(Guid DamageReportId) : IRequest<Result<CompensationDto?>>;

public class GetCompensationByReportIdQueryHandler : IRequestHandler<GetCompensationByReportIdQuery, Result<CompensationDto?>>
{
    private readonly IApplicationDbContext _context;

    public GetCompensationByReportIdQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<CompensationDto?>> Handle(GetCompensationByReportIdQuery request, CancellationToken cancellationToken)
    {
        var compensation = await _context.Compensations
            .AsNoTracking()
            .FirstOrDefaultAsync(c => c.DamageReportId == request.DamageReportId, cancellationToken);

        if (compensation == null)
        {
            return Result<CompensationDto?>.Success(null);
        }

        return Result<CompensationDto?>.Success(new CompensationDto
        {
            Id = compensation.Id,
            ClientId = compensation.ClientId,
            DamageReportId = compensation.DamageReportId,
            CalculatedAmount = compensation.CalculatedAmount,
            ApprovedAmount = compensation.ApprovedAmount,
            Status = compensation.Status,
            Remarks = compensation.Remarks,
            RowVersion = Convert.ToBase64String(compensation.RowVersion)
        });
    }
}
