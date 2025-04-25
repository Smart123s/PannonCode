namespace halado_prog2.Entities
{
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    // Represents the quantity of a specific cryptocurrency held in a specific wallet
    // This is the join entity for the many-to-many relationship between Wallet and Cryptocurrency
    public class WalletCrypto
    {
        // Composite Primary Key defined in DbContext OnModelCreating
        public int WalletId { get; set; }
        public int CryptoId { get; set; }

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal Quantity { get; set; }

        // Navigation properties
        public Wallet Wallet { get; set; } // Foreign Key relationship to Wallet
        public Cryptocurrency Cryptocurrency { get; set; } // Foreign Key relationship to Cryptocurrency
    }
}

