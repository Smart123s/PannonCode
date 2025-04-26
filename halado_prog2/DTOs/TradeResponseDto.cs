// File: DTOs/TradeResponseDto.cs
// Optional: DTO for returning confirmation after a trade
namespace halado_prog2.DTOs
{
    public class TradeResponseDto
    {
        public int TransactionId { get; set; }
        public string Message { get; set; } // e.g., "Buy successful", "Sell successful"
    }
}