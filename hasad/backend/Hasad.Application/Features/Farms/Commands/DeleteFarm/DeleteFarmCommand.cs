using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.Farms.Commands.DeleteFarm;

public record DeleteFarmCommand(Guid Id) : IRequest<Result<Unit>>;

public class DeleteFarmCommandHandler : IRequestHandler<DeleteFarmCommand, Result<Unit>>
{
    private readonly IApplicationDbContext _context;

    public DeleteFarmCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<Unit>> Handle(DeleteFarmCommand request, CancellationToken cancellationToken)
    {
        var farm = await _context.Farms
            .FirstOrDefaultAsync(f => f.Id == request.Id, cancellationToken);

        if (farm == null)
        {
            return Result<Unit>.Failure(new[] { "Farm not found." });
        }

        _context.Farms.Remove(farm);
        await _context.SaveChangesAsync(cancellationToken);

        return Result<Unit>.Success(Unit.Value);
    }
}
