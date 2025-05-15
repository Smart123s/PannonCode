// File: DTOs/AcceptGiftResponseDto.cs
using halado_prog2.Entities;

namespace halado_prog2.DTOs
{
    public class AcceptGiftResponseDto
    {
        public int GiftId { get; set; }
        public GiftStatus NewStatus { get; set; }
        public string Message { get; set; }
    }
}