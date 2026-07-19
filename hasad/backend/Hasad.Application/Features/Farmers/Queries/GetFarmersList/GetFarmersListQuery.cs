using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using Hasad.Application.Features.Farmers.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Farmers.Queries.GetFarmersList;

public record GetFarmersListQuery(
    int PageNumber = 1,
    int PageSize = 10,
    string? Name = null,
    string? IdNumber = null,
    string? DirectorateId = null) : IRequest<Result<PaginatedList<FarmerDto>>>;

public class GetFarmersListQueryHandler : IRequestHandler<GetFarmersListQuery, Result<PaginatedList<FarmerDto>>>
{
    private readonly IApplicationDbContext _context;

    public GetFarmersListQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<PaginatedList<FarmerDto>>> Handle(GetFarmersListQuery request, CancellationToken cancellationToken)
    {
        var query = _context.Farmers.AsNoTracking();

        // Directorate-based filtering for farmers with damaged farms/reports
        if (!string.IsNullOrWhiteSpace(request.DirectorateId) && Guid.TryParse(request.DirectorateId, out var dirGuid))
        {
            var dirGovId = await _context.Directorates
                .Where(d => d.Id == dirGuid)
                .Select(d => d.GovernorateId)
                .FirstOrDefaultAsync(cancellationToken);

            if (dirGovId != Guid.Empty)
            {
                var govIdStr = dirGovId.ToString();
                var farmerIdsWithDamage = _context.DamageReports
                    .Where(dr => dr.GovernorateId == govIdStr)
                    .Select(dr => dr.FarmerId);

                query = query.Where(f => farmerIdsWithDamage.Contains(f.Id) || f.GovernorateId == govIdStr);
            }
        }

        // Filtering
        if (!string.IsNullOrWhiteSpace(request.IdNumber))
        {
            query = query.Where(f => f.IdNumber.Contains(request.IdNumber));
        }

        if (!string.IsNullOrWhiteSpace(request.Name))
        {
            var searchName = request.Name.ToLower();
            query = query.Where(f =>
                f.FirstNameAr.ToLower().Contains(searchName) ||
                f.FatherNameAr.ToLower().Contains(searchName) ||
                f.GrandfatherNameAr.ToLower().Contains(searchName) ||
                f.FamilyNameAr.ToLower().Contains(searchName) ||
                f.FirstNameEn.ToLower().Contains(searchName) ||
                f.FatherNameEn.ToLower().Contains(searchName) ||
                f.GrandfatherNameEn.ToLower().Contains(searchName) ||
                f.FamilyNameEn.ToLower().Contains(searchName));
        }

        var count = await query.CountAsync(cancellationToken);

        // 1. جلب البيانات الأساسية من SQL Server
        var dbItems = await query
            .OrderBy(f => f.FirstNameAr)
            .Skip((request.PageNumber - 1) * request.PageSize)
            .Take(request.PageSize)
            .ToListAsync(cancellationToken);

        // 2. التحويل (Mapping) في الذاكرة لتفادي أخطاء الـ EF Core Translation
        var items = dbItems.Select(f => new FarmerDto
        {
            Id = f.Id,
            ClientId = f.ClientId,
            IdTypeId = f.IdTypeId,
            IdNumber = f.IdNumber,
            PhoneNumber = f.PhoneNumber,
            Address = f.Address,
            GovernorateId = f.GovernorateId,
            LocalityId = f.LocalityId,
            BirthDate = f.BirthDate,
            Gender = f.Gender,
            FamilySize = f.FamilySize,
            FirstNameAr = f.FirstNameAr,
            FatherNameAr = f.FatherNameAr,
            GrandfatherNameAr = f.GrandfatherNameAr,
            FamilyNameAr = f.FamilyNameAr,
            FirstNameEn = f.FirstNameEn,
            FatherNameEn = f.FatherNameEn,
            GrandfatherNameEn = f.GrandfatherNameEn,
            FamilyNameEn = f.FamilyNameEn,
            RowVersion = Convert.ToBase64String(f.RowVersion),
            CreatedAt = f.CreatedAt,
            UpdatedAt = f.UpdatedAt
        }).ToList();

        var paginatedList = new PaginatedList<FarmerDto>
        {
            Items = items,
            TotalCount = count,
            PageNumber = request.PageNumber,
            TotalPages = (int)Math.Ceiling(count / (double)request.PageSize)
        };

        return Result<PaginatedList<FarmerDto>>.Success(paginatedList);
    }
}
