// File: DTOs/TransactionDto.cs
using System;

namespace halado_prog2.DTOs
{
    // DTO to represent a transaction in API responses (for list and details)
    public class TransactionDto
    {
        public int Id { get; set; }
        // UserId might be useful for the list view, but not strictly required by spec output
        // public int UserId { get; set; }
        public int CryptoId { get; set; }
        public string CryptoName { get; set; } // Include crypto name for context
        public string TransactionType { get; set; } // "Buy" or "Sell"
        public decimal Quantity { get; set; } // Quantity of crypto traded
        public decimal PriceAtTrade { get; set; } // Price at the time of trade
        public DateTime Timestamp { get; set; }
        // Optionally calculate the total value of the trade at the time
        // public decimal TradeValue => Quantity * PriceAtTrade;
    }
}