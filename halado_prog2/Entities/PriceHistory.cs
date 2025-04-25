namespace halado_prog2.Entities
{
    using System;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    // Logs the price changes for cryptocurrencies
    public class PriceHistory
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int CryptoId { get; set; } // Foreign Key

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal Price { get; set; }

        [Required]
        public DateTime Timestamp { get; set; }

        // Navigation property
        public Cryptocurrency Cryptocurrency { get; set; } // Foreign Key relationship to Cryptocurrency
    }
}

