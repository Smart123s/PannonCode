// File: DTOs/GiftHistoryItemDto.cs
using System;
using halado_prog2.Entities; // For GiftStatus

namespace halado_prog2.DTOs
{
    public class GiftHistoryItemDto
    {
        public int GiftId { get; set; }
        public int? ActionUserId { get; set; } // Sender or Receiver, depending on context
        public string ActionUserUsername { get; set; } // Sender or Receiver username
        public string OtherPartyUsername { get; set; } // The other user in the gift
        public string Direction { get; set; } // "Sent" or "Received"
        public string CryptoName { get; set; }
        public decimal Quantity { get; set; }
        public decimal PriceAtGifting { get; set; }
        public decimal CurrentPriceOfCrypto { get; set; } // Current market price of the crypto
        public GiftStatus Status { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? ResolvedAt { get; set; }
    }
}