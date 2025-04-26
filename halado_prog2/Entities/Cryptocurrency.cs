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

        // --- REMOVED [Required] and [Column(TypeName = "decimal(18, 8)")] ---
        // --- Added [NotMapped] and implemented getter logic ---
        [NotMapped] // This property will NOT be mapped to a database column
        public decimal CurrentPrice
        {
            get
            {
                // Find the latest price entry in the PriceHistory collection
                // IMPORTANT: This relies on the PriceHistory navigation property being loaded!
                // If PriceHistory is not loaded, this will likely return 0 or throw an error.
                return PriceHistory?
                       .OrderByDescending(ph => ph.Timestamp) // Order by timestamp descending
                       .FirstOrDefault()?.Price ?? 0.0M; // Get the price of the latest, or 0 if no history
            }
            // You can keep a setter if you want to allow setting it in code, but it won't save to DB
            // or you can remove the setter if it's purely calculated. Let's remove the setter
            // to emphasize it's derived.
            // set { /* Maybe do nothing, or handle it if needed */ }
        }
        // ---

        // Navigation properties
        public ICollection<CryptoWallet> CryptoWallets { get; set; }
        public ICollection<Transaction> Transactions { get; set; }

        // One-to-many relationship with PriceHistory - Remains the source of truth for prices
        public ICollection<PriceHistory> PriceHistory { get; set; } // This collection MUST be loaded!
    }
}