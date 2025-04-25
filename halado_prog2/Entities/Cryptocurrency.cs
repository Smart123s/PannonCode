namespace halado_prog2.Entities
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    // Represents a type of cryptocurrency traded in the simulator
    public class Cryptocurrency
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(50)]
        // Using Fluent API for unique index on Name in DbContext
        public string Name { get; set; } // e.g., "BTC", "ETH"

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal CurrentPrice { get; set; }

        // Starting price/quantity mentioned in the spec could be stored if needed for history or setup,
        // but CurrentPrice is the crucial dynamic value.
        // Optional:
        // [Column(TypeName = "decimal(18, 8)")]
        // public decimal StartingPrice { get; set; }

        // Navigation properties
        public ICollection<Transaction> Transactions { get; set; } // One-to-many relationship with Transactions (trades involving this crypto)
        public ICollection<PriceHistory> PriceHistory { get; set; } // One-to-many relationship with PriceHistory
        public ICollection<WalletCrypto> WalletCryptos { get; set; } // Many-to-many relationship via WalletCrypto (wallets holding this crypto)
    }
}

