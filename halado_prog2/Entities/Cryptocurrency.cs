using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace halado_prog2.Entities
{
    public class Cryptocurrency
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; }
        [Required]
        [Column(TypeName = "decimal(18, 8)")]
        public decimal CurrentPrice { get; set; }
        public ICollection<CryptoWallet> CryptoWallets { get; set; }
        public ICollection<Transaction> Transactions { get; set; }
        public ICollection<PriceHistory> PriceHistory { get; set; }
    }
}