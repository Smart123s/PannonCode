// File: Entities/GiftTransaction.cs
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace halado_prog2.Entities
{
    public enum GiftStatus
    {
        Pending = 0,
        Accepted = 1,
        Rejected = 2,
        Cancelled = 3 // Optional: If sender can cancel before acceptance
    }

    public class GiftTransaction
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int SenderUserId { get; set; }
        public User SenderUser { get; set; } // Navigation property

        [Required]
        public int ReceiverUserId { get; set; }
        public User ReceiverUser { get; set; } // Navigation property

        [Required]
        public int CryptoId { get; set; }
        public Cryptocurrency Cryptocurrency { get; set; } // Navigation property

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal Quantity { get; set; }

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal PriceAtGifting { get; set; } // Market price when the gift was initiated

        [Required]
        public GiftStatus Status { get; set; } = GiftStatus.Pending;

        [Required]
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public DateTime? ResolvedAt { get; set; } // Timestamp when accepted/rejected
    }
}