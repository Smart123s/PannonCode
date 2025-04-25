namespace halado_prog2.Entities
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;


    // Represents a user in the system
    public class User
    {
        [Key] // Data Annotation for Primary Key
        public int Id { get; set; }

        [Required] // Data Annotation for NOT NULL
        [MaxLength(255)] // Limit string length
        public string Username { get; set; }

        [Required]
        [MaxLength(255)]
        // Using Fluent API for unique index on Email in DbContext
        public string Email { get; set; }

        [Required]
        // Store hashed password, not plain text!
        public string PasswordHash { get; set; }

        // Navigation properties
        public Wallet Wallet { get; set; } // One-to-one relationship with Wallet
        public ICollection<Transaction> Transactions { get; set; } // One-to-many relationship with Transactions
    }

}
