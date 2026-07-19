using Hasad.Application.Common.Interfaces;
using Hasad.Domain.Entities;

namespace Hasad.Infrastructure.Services;

public class CompensationService : ICompensationService
{
    public decimal Calculate(DamageReport report, CompensationRule rule)
    {
        if (report.Items == null || !report.Items.Any())
            return 0;

        // Use the configurable multiplier from the rule
        decimal totalEstimatedLoss = report.Items.Sum(i => i.EstimatedLoss);
        return totalEstimatedLoss * rule.Multiplier;
    }
}
