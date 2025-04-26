// File: DTOs/PriceHistoryDto.cs
using System;

namespace halado_prog2.DTOs
{
    // DTO to represent a single price history entry in the response
    public class PriceHistoryDto
    {
        public int Id { get; set; }
        public decimal Price { get; set; }
        public DateTime Timestamp { get; set; }
        // Optionally include CryptoId or CryptoName if the endpoint wasn't crypto-specific
        // public int CryptoId { get; set; }
    }
}