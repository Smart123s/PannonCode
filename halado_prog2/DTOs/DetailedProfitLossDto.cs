using System.Collections.Generic;

namespace halado_prog2.DTOs
{
    // DTO for the response of GET /api/profit/details/{userId}
    public class DetailedProfitLossDto
    {
        public int UserId { get; set; }
        public List<CryptoProfitLossDetailDto> HoldingsProfitLoss { get; set; } = new List<CryptoProfitLossDetailDto>();
    }
}