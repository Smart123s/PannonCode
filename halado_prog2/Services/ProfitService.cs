using Microsoft.EntityFrameworkCore;
using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public class ProfitService : IProfitService
    {
        private readonly CryptoDbContext _context;
        private readonly ILogger<ProfitService> _logger;

        public ProfitService(CryptoDbContext context, ILogger<ProfitService> logger)
        {
            _context = context;
            _logger = logger;
        }

        // Public method matching the interface for detailed P/L
        public async Task<DetailedProfitLossDto?> GetDetailedProfitLossAsync(int userId)
        {
            // Call the private calculation method
            return await CalculateProfitLossDetails(userId);
        }

        // Public method matching the interface for total P/L
        public async Task<TotalProfitLossDto?> GetTotalProfitLossAsync(int userId)
        {
            // Calculate detailed profit/loss first
            var details = await CalculateProfitLossDetails(userId);

            if (details == null)
            {
                return null; // User not found
            }

            // Sum the profit/loss from the details
            decimal totalProfitLoss = details.HoldingsProfitLoss?.Sum(h => h.ProfitLoss) ?? 0M; // Handle potential null list

            var totalResult = new TotalProfitLossDto
            {
                UserId = userId,
                TotalProfitLoss = totalProfitLoss
            };

            return totalResult;
        }


        // --- Private Helper Method for Calculation Logic (moved from controller) ---
        private async Task<DetailedProfitLossDto?> CalculateProfitLossDetails(int userId)
        {
            // 1. Check if user exists
            // We fetch the user directly to get their ID confirmed. AsNoTracking for read-only.
            var user = await _context.Users.AsNoTracking().FirstOrDefaultAsync(u => u.Id == userId);
            if (user == null)
            {
                _logger.LogWarning("Profit/Loss details requested for non-existent User ID {UserId}", userId);
                return null; // Indicate user not found
            }

            // 2. Get User's Current Holdings (CryptoWallet entries)
            //    Include Cryptocurrency for current price and name. AsNoTracking for optimization.
            var userHoldings = await _context.CryptoWallets
                .Include(cw => cw.Cryptocurrency) // Include Cryptocurrency (reads stored CurrentPrice)
                .Where(cw => cw.UserId == userId && cw.Quantity > 0) // Only include cryptos currently held
                .AsNoTracking()
                .ToListAsync();

            // 3. Get all BUY transactions for this user. AsNoTracking for optimization.
            var userBuyTransactions = await _context.Transactions
                .Where(t => t.UserId == userId && t.TransactionType == "Buy")
                .AsNoTracking()
                .ToListAsync();

            var profitLossDetailsList = new List<CryptoProfitLossDetailDto>();
            _logger.LogDebug("Calculating profit/loss for User ID {UserId} with {HoldingCount} holdings.", userId, userHoldings.Count);

            // 4. Calculate profit/loss for each holding
            foreach (var holding in userHoldings)
            {
                decimal currentQuantityHeld = holding.Quantity;
                decimal currentPrice = holding.Cryptocurrency.CurrentPrice; // Read stored price

                // Filter transactions for this specific crypto
                var cryptoBuyTransactions = userBuyTransactions
                    .Where(t => t.CryptoId == holding.CryptoId)
                    .ToList(); // Materialize for calculation

                decimal totalCostOfBuys = 0;
                decimal totalQuantityBought = 0;
                decimal averagePurchasePrice = 0;

                if (cryptoBuyTransactions.Any())
                {
                    totalCostOfBuys = cryptoBuyTransactions.Sum(t => t.Quantity * t.PriceAtTrade);
                    totalQuantityBought = cryptoBuyTransactions.Sum(t => t.Quantity);

                    if (totalQuantityBought > 0)
                    {
                        // Calculate average price based on ALL historical buys
                        averagePurchasePrice = totalCostOfBuys / totalQuantityBought;
                    }
                    _logger.LogDebug("CryptoId {CryptoId}: Total Cost={TotalCost}, Total Qty Bought={TotalQty}, Avg Price={AvgPrice}",
                                    holding.CryptoId, totalCostOfBuys, totalQuantityBought, averagePurchasePrice);
                }
                else
                {
                    _logger.LogDebug("CryptoId {CryptoId}: No buy transactions found.", holding.CryptoId);
                    // averagePurchasePrice remains 0 if never bought (shouldn't happen if they hold quantity?)
                    // Or handle this case if a user could somehow acquire crypto without a 'Buy' transaction
                }

                decimal totalCostBasis = averagePurchasePrice * currentQuantityHeld;
                decimal currentMarketValue = currentPrice * currentQuantityHeld;
                decimal profitLoss = currentMarketValue - totalCostBasis;

                profitLossDetailsList.Add(new CryptoProfitLossDetailDto
                {
                    CryptoId = holding.CryptoId,
                    CryptoName = holding.Cryptocurrency.Name,
                    QuantityHeld = currentQuantityHeld,
                    AveragePurchasePrice = averagePurchasePrice,
                    CurrentPrice = currentPrice,
                    TotalCostBasis = totalCostBasis,
                    CurrentMarketValue = currentMarketValue,
                    ProfitLoss = profitLoss
                });
            }

            var resultDto = new DetailedProfitLossDto
            {
                UserId = userId,
                HoldingsProfitLoss = profitLossDetailsList
            };
            _logger.LogInformation("Successfully calculated detailed profit/loss for User ID {UserId}", userId);

            return resultDto;
        }
    }
}