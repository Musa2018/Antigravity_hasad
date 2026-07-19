namespace Hasad.Domain.Enums;

public enum RoleScopeType
{
    Global,      // No geographic assignment required
    Governorate, // GovernorateId required, DirectorateId optional
    Directorate  // Both GovernorateId and DirectorateId required
}
