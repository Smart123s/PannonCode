using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public interface ITradeService
    {
        // Returns Transaction ID on success, or error details
        Task<(int? TransactionId, string? ErrorMessage, int StatusCode)> BuyCryptoAsync(TradeRequestDto request);

        // Returns Transaction ID on success, or error details
        Task<(int? TransactionId, string? ErrorMessage, int StatusCode)> SellCryptoAsync(TradeRequestDto request);
    }
}
