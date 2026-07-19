using Hasad.Domain.Enums;

namespace Hasad.Application.Features.Farmers.Models;

public class FarmerDto
{
    public Guid Id { get; set; }
    public Guid ClientId { get; set; }

    // الحقول الأساسية
    public int IdTypeId { get; set; }
    public string IdNumber { get; set; } = string.Empty;
    public string PhoneNumber { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public string RowVersion { get; set; } = string.Empty;

    public string GovernorateId { get; set; } = string.Empty;
    public string LocalityId { get; set; } = string.Empty;
    public DateOnly BirthDate { get; set; }
    public Gender Gender { get; set; }
    public int FamilySize { get; set; }

    // الأسماء المفصلة (عربي)
    public string FirstNameAr { get; set; } = string.Empty;
    public string FatherNameAr { get; set; } = string.Empty;
    public string GrandfatherNameAr { get; set; } = string.Empty;
    public string FamilyNameAr { get; set; } = string.Empty;

    // الأسماء المفصلة (إنجليزي)
    public string FirstNameEn { get; set; } = string.Empty;
    public string FatherNameEn { get; set; } = string.Empty;
    public string GrandfatherNameEn { get; set; } = string.Empty;
    public string FamilyNameEn { get; set; } = string.Empty;

    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
