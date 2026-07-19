using System;

namespace Hasad.Application.Features.Location.Models
{
    public class LocalityDto
    {
        public Guid Id { get; set; }
        public string NameAr { get; set; } = string.Empty;
        public string NameEn { get; set; } = string.Empty;
        public Guid GovernorateId { get; set; }
    }
}
