namespace halado_prog2.DTOs
{
    // Represents the profit/loss details for a single crypto holding
    public class CryptoProfitLossDetailDto
    {
        public int CryptoId { get; set; }
        public string CryptoName { get; set; }
        public decimal QuantityHeld { get; set; }
        public decimal AveragePurchasePrice { get; set; } // Average cost per unit
        public decimal CurrentPrice { get; set; } // Current market price per unit
        public decimal TotalCostBasis { get; set; } // AveragePurchasePrice * QuantityHeld
        public decimal CurrentMarketValue { get; set; } // CurrentPrice * QuantityHeld
        public decimal ProfitLoss { get; set; } // CurrentMarketValue - TotalCostBasis
    }
}
