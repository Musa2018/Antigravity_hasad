using System;

using Hasad.Domain.Enums;

namespace Hasad.Domain.Entities
{
    public class Farmer
    {
        public Guid Id { get; set; }

        /// <summary>
        /// Client-generated synchronization identifier.
        /// </summary>
        public Guid ClientId { get; set; }

        // Identification
        public int IdTypeId { get; set; }
        public IdType IdType { get; set; } = null!;
        public string IdNumber { get; set; } = string.Empty;

        // Arabic Name (4 parts)
        public string FirstNameAr { get; set; } = string.Empty;
        public string FatherNameAr { get; set; } = string.Empty;
        public string GrandfatherNameAr { get; set; } = string.Empty;
        public string FamilyNameAr { get; set; } = string.Empty;

        // English Name (4 parts)
        public string FirstNameEn { get; set; } = string.Empty;
        public string FatherNameEn { get; set; } = string.Empty;
        public string GrandfatherNameEn { get; set; } = string.Empty;
        public string FamilyNameEn { get; set; } = string.Empty;

        // Demographics & Geography
        public DateOnly BirthDate { get; set; }
        public Gender Gender { get; set; }
        public string PhoneNumber { get; set; } = string.Empty;
        public int FamilySize { get; set; }

        // --- التحديث الجغرافي ليتوافق مع جداول النظام (المحافظة والمديرية/التجمع) ---
        public string GovernorateId { get; set; } = string.Empty; // من نوع String كما في Farm
        public string LocalityId { get; set; } = string.Empty;    // بدلاً من CityId، و من نوع String كما في Farm

        // إذا كان هناك حاجة للعنوان التفصيلي كحقل نصي، نستعيده لأنك ذكرته في النسخة القديمة
        public string Address { get; set; } = string.Empty;

        // Metadata
        public int SyncStatus { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }

        /// <summary>
        /// Concurrency token for optimistic synchronization.
        /// </summary>
        public byte[] RowVersion { get; set; } = Array.Empty<byte>();

        public bool IsDeleted { get; set; } = false;
    }
}
