namespace halado_prog2.DTOs
{
    public class WalletDto // Represents the response for GET /api/wallet/{userId}
    {
        public int UserId { get; set; }
        public decimal FiatBalance { get; set; } // The user's fiat currency balance
        public List<CryptoHoldingDto> CryptoHoldings { get; set; } = new List<CryptoHoldingDto>(); // List of cryptos the user holds
    }

    public class CryptoHoldingDto // Represents a single crypto holding within the WalletDto
    {
        public int CryptoId { get; set; }
        public string CryptoName { get; set; }
        public decimal Quantity { get; set; } // Quantity the user holds
        public decimal CurrentPrice { get; set; } // Current price fetched from PriceHistory
        // Optional: Calculated value of this holding
        // public decimal ValueInFiat => Quantity * CurrentPrice;
    }
}