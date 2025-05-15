// File: Services/ITradeService.cs
using System.Threading.Tasks;
using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public interface ITradeService
    {
        // Returns the detailed TradeResponseDto or error details
        Task<(TradeResponseDto? TradeConfirmation, string? ErrorMessage, int StatusCode)> BuyCryptoAsync(TradeRequestDto request);
        Task<(TradeResponseDto? TradeConfirmation, string? ErrorMessage, int StatusCode)> SellCryptoAsync(TradeRequestDto request);
    }
}