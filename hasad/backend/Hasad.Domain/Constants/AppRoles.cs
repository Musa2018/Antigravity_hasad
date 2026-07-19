using Hasad.Domain.Enums;

namespace Hasad.Domain.Constants;

public static class AppRoles
{
    public const string SuperAdmin = "SuperAdmin";
    public const string Administrator = "Administrator";
    public const string AgriculturalEngineer = "AgriculturalEngineer";
    public const string FieldSurveyor = "FieldSurveyor";
    public const string Farmer = "Farmer";
    public const string ReadOnly = "ReadOnly";
    public const string Director = "Director";
    public const string Finance = "Finance";

    public static RoleScopeType GetScopeType(string roleName) => roleName switch
    {
        Director => RoleScopeType.Governorate,
        AgriculturalEngineer or FieldSurveyor => RoleScopeType.Directorate,
        _ => RoleScopeType.Global
    };

    public static string[] All() => new[]
    {
        SuperAdmin, Administrator, AgriculturalEngineer,
        FieldSurveyor, Farmer, ReadOnly, Director, Finance
    };
}
