namespace halado_prog2.Entities
{
    using System;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    // Represents a buy or sell transaction
    public class Transaction
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int UserId { get; set; } // Foreign Key

        [Required]
        public int CryptoId { get; set; } // Foreign Key

        [Required]
        [MaxLength(10)] // "Buy" or "Sell"
        public string TransactionType { get; set; } // e.g., "Buy", "Sell" - could also be an enum

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal Quantity { get; set; } // Quantity of crypto traded

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal PriceAtTrade { get; set; } // Price of the crypto at the time of the trade

        [Required]
        public DateTime Timestamp { get; set; }

        // Navigation properties
        public User User { get; set; } // Foreign Key relationship to User
        public Cryptocurrency Cryptocurrency { get; set; } // Foreign Key relationship to Cryptocurrency
    }
}

