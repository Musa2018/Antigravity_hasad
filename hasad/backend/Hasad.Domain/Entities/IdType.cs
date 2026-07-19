using System.Collections.Generic;

namespace Hasad.Domain.Entities
{
    public class IdType
    {
        public int Id { get; set; }
        public string NameAr { get; set; } = string.Empty;
        public string NameEn { get; set; } = string.Empty;

        // Navigation property
        public ICollection<Farmer> Farmers { get; set; } = new List<Farmer>();
    }
}