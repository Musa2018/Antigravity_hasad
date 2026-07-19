using Hasad.Application.Common.Interfaces;
using Hasad.Application.Common.Models;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Hasad.Application.Features.DamageReports.Commands.DeleteDamageReport;

public record DeleteDamageReportCommand(Guid Id) : IRequest<Result<Unit>>;

public class DeleteDamageReportCommandHandler : IRequestHandler<DeleteDamageReportCommand, Result<Unit>>
{
    private readonly IApplicationDbContext _context;

    public DeleteDamageReportCommandHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<Unit>> Handle(DeleteDamageReportCommand request, CancellationToken cancellationToken)
    {
        var report = await _context.DamageReports
            .FirstOrDefaultAsync(r => r.Id == request.Id, cancellationToken);

        if (report == null)
        {
            return Result<Unit>.Failure(new[] { "Damage report not found." });
        }

        _context.DamageReports.Remove(report);
        await _context.SaveChangesAsync(cancellationToken);

        return Result<Unit>.Success(Unit.Value);
    }
}
