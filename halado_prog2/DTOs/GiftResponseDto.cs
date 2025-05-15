// File: DTOs/GiftResponseDto.cs
// For confirming gift creation
using halado_prog2.Entities;

namespace halado_prog2.DTOs
{
    public class GiftCreationResponseDto
    {
        public int GiftId { get; set; }
        public string Message { get; set; }
        public GiftStatus Status { get; set; }
    }
}