using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace halado_prog2.Entities // Namespace remains the same
{
    // Represents a user in the system
    public class User // Remains the same
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(255)]
        public string Username { get; set; }

        [Required]
        [MaxLength(255)]
        public string Email { get; set; }

        [Required]
        public string PasswordHash { get; set; }

        // Fiat Balance - remains here
        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal Balance { get; set; } // Fiat currency balance

        // Navigation properties
        // Link to the cryptocurrencies this user holds (Many-to-Many represented by CryptoWallet)
        // RENAMED navigation property
        public ICollection<CryptoWallet> CryptoWallets { get; set; } // Changed from UserCryptos

        // One-to-many relationship with Transactions (trades involving this user) - remains the same
        public ICollection<Transaction> Transactions { get; set; }
    }
}