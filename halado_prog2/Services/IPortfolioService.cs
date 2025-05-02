// File: Services/IPortfolioService.cs

using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public interface IPortfolioService
    {
        // Returns WalletDto (which represents the portfolio) or null if user not found
        Task<WalletDto?> GetPortfolioAsync(int userId);
    }
}
