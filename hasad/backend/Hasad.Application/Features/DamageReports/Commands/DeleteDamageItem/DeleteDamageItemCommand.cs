using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.DamageReports.Commands.DeleteDamageItem;

public record DeleteDamageItemCommand(Guid Id) : IRequest<Result<Unit>>;

public class DeleteDamageItemCommandHandler : IRequestHandler<DeleteDamageItemCommand, Result<Unit>>
{
    private readonly IApplicationDbContext _context;

    public DeleteDamageItemCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<Unit>> Handle(DeleteDamageItemCommand request, CancellationToken cancellationToken)
    {
        var item = await _context.DamageItems
            .FirstOrDefaultAsync(i => i.Id == request.Id, cancellationToken);

        if (item == null)
        {
            return Result<Unit>.Failure(new[] { "Damage item not found." });
        }

        _context.DamageItems.Remove(item);
        await _context.SaveChangesAsync(cancellationToken);

        return Result<Unit>.Success(Unit.Value);
    }
}
