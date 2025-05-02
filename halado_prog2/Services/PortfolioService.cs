// File: Services/PortfolioService.cs
using Microsoft.EntityFrameworkCore;
using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public class PortfolioService : IPortfolioService
    {
        private readonly CryptoDbContext _context;
        private readonly ILogger<PortfolioService> _logger;

        public PortfolioService(CryptoDbContext context, ILogger<PortfolioService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task<WalletDto?> GetPortfolioAsync(int userId)
        {
            // Fetch the user, including their holdings and the related cryptocurrency details.
            // No need to include PriceHistory just for CurrentPrice anymore.
            var user = await _context.Users
                .Include(u => u.CryptoWallets) // Include the join table entries
                    .ThenInclude(cw => cw.Cryptocurrency) // Include the related Cryptocurrency (this loads its stored CurrentPrice)
                .AsNoTracking() // Use AsNoTracking for read-only query optimization
                .FirstOrDefaultAsync(u => u.Id == userId);

            if (user == null)
            {
                _logger.LogWarning("Portfolio requested for non-existent User ID {UserId}", userId);
                return null; // Indicate user not found
            }

            // Map the data to the WalletDto (representing the portfolio)
            var portfolioDto = new WalletDto
            {
                UserId = user.Id,
                FiatBalance = user.Balance,
                CryptoHoldings = user.CryptoWallets
                                     .Where(cw => cw.Quantity > 0) // Ensure only holdings with quantity are included
                                     .Select(cw => new CryptoHoldingDto
                                     {
                                         CryptoId = cw.CryptoId,
                                         CryptoName = cw.Cryptocurrency.Name,
                                         Quantity = cw.Quantity,
                                         CurrentPrice = cw.Cryptocurrency.CurrentPrice // Read stored price directly
                                     }).ToList()
            };

            _logger.LogInformation("Retrieved portfolio for User ID {UserId}", userId);
            return portfolioDto;
        }
    }
}