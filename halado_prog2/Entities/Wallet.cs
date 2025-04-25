namespace halado_prog2.Entities
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    // Represents a user's virtual wallet
    public class Wallet
    {
        // Primary Key and Foreign Key to User (for 1-to-1 relationship)
        [Key]
        // [ForeignKey("User")] // Fluent API is often clearer for 1-to-1 foreign key config
        public int Id { get; set; }

        [Required]
        [Column(TypeName = "decimal(18, 8)")] // Use decimal for currency precision
        public decimal Balance { get; set; }

        // Navigation properties
        public User User { get; set; } // One-to-one relationship with User
        public ICollection<WalletCrypto> WalletCryptos { get; set; } // Many-to-many relationship via WalletCrypto
    }
}

