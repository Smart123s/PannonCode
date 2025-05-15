// File: Entities/Transaction.cs
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace halado_prog2.Entities
{
    public class Transaction
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int UserId { get; set; }

        [Required]
        public int CryptoId { get; set; }

        [Required]
        [MaxLength(10)]
        public string TransactionType { get; set; } // "Buy" or "Sell"

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal Quantity { get; set; } // Quantity of crypto traded

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal PriceAtTrade { get; set; } // Price per unit of crypto at trade

        // --- New Field for Transaction Fee ---
        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal FeeAmount { get; set; } // The actual fee amount paid for this transaction
        // ---

        [Required]
        public DateTime Timestamp { get; set; }

        // Navigation properties
        public User User { get; set; }
        public Cryptocurrency Cryptocurrency { get; set; }
    }
}