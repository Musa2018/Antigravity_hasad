using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Farmers.Commands.DeleteFarmer;

public record DeleteFarmerCommand(Guid Id) : IRequest<Result<Unit>>;

public class DeleteFarmerCommandHandler : IRequestHandler<DeleteFarmerCommand, Result<Unit>>
{
    private readonly IApplicationDbContext _context;

    public DeleteFarmerCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<Unit>> Handle(DeleteFarmerCommand request, CancellationToken cancellationToken)
    {
        // جلب المزارع من قاعدة البيانات
        var farmer = await _context.Farmers
            .FirstOrDefaultAsync(f => f.Id == request.Id, cancellationToken);

        // التحقق من وجود المزارع
        if (farmer == null)
        {
            return Result<Unit>.Failure(new[] { "Farmer not found." });
        }

        // تنفيذ الحذف المنطقي (Soft Delete)
        farmer.IsDeleted = true;

        // حفظ التغييرات (EF Core سيقوم بعمل UPDATE وليس DELETE)
        await _context.SaveChangesAsync(cancellationToken);

        return Result<Unit>.Success(Unit.Value);
    }
}