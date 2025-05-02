using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace halado_prog2.Entities // Namespace remains the same
{

    // Removed Wallet entity previously

    // Represents a type of cryptocurrency traded in the simulator (Remains the same)
    public class Cryptocurrency
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        // --- Re-added as a mapped database column ---
        [Required] // Price is required
        [Column(TypeName = "decimal(18, 8)")] // Define SQL Server data type
        public decimal CurrentPrice { get; set; } // Now stored directly
        // --- Removed [NotMapped] and custom getter ---

        // Navigation properties (remain the same)
        public ICollection<CryptoWallet> CryptoWallets { get; set; }
        public ICollection<Transaction> Transactions { get; set; }
        public ICollection<PriceHistory> PriceHistory { get; set; }
    }
}