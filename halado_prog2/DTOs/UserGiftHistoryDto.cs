// File: DTOs/UserGiftHistoryDto.cs
using System.Collections.Generic;

namespace halado_prog2.DTOs
{
    public class UserGiftHistoryDto
    {
        public int UserId { get; set; }
        public List<GiftHistoryItemDto> Gifts { get; set; } = new List<GiftHistoryItemDto>();
    }
}