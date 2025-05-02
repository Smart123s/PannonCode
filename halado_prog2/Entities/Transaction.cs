using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace halado_prog2.Entities
{
    public class Transaction
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int UserId { get; set; }

        [Required]
        public int CryptoId { get; set; }

        [Required]
        [MaxLength(10)]
        public string TransactionType { get; set; }

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal Quantity { get; set; }

        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal PriceAtTrade { get; set; }

        [Required]
        public DateTime Timestamp { get; set; }
        public User User { get; set; }
        public Cryptocurrency Cryptocurrency { get; set; }
    }
}