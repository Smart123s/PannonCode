using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace halado_prog2.Entities // Namespace remains the same
{
    // --- Renamed Join Entity from UserCrypto to CryptoWallet ---
    // Represents the quantity of a specific cryptocurrency held by a specific user
    public class CryptoWallet // RENAMED from UserCrypto
    {
        // Composite Primary Key defined in DbContext OnModelCreating (remains the same structure)
        public int UserId { get; set; } // Foreign Key to User
        public int CryptoId { get; set; } // Foreign Key to Cryptocurrency

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal Quantity { get; set; } // Quantity of this crypto the user holds

        // Navigation properties (remain the same, pointing to the entities)
        public User User { get; set; } // Foreign Key relationship to User
        public Cryptocurrency Cryptocurrency { get; set; } // Foreign Key relationship to Cryptocurrency
    }
}