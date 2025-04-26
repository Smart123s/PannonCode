namespace halado_prog2.DTOs
{
    // DTO for the response of GET /api/profit/{userId}
    public class TotalProfitLossDto
    {
        public int UserId { get; set; }
        public decimal TotalProfitLoss { get; set; }
        public string Currency { get; set; } = "Fiat"; // Or your base currency name
    }
}
