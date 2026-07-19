using Hasad.Domain.Entities;

namespace Hasad.Application.Common.Interfaces;

public interface ICompensationService
{
    decimal Calculate(DamageReport report, CompensationRule rule);
}
