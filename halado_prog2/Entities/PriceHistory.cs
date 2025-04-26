using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace halado_prog2.Entities // Namespace remains the same
{
    // Logs the price changes for cryptocurrencies (remains the same)
    public class PriceHistory
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int CryptoId { get; set; }

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal Price { get; set; }

        [Required]
        public DateTime Timestamp { get; set; }

        // Navigation property (remains the same)
        public Cryptocurrency Cryptocurrency { get; set; }
    }
}