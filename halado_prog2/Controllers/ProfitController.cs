using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using halado_prog2.DTOs;

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/[controller]")] // Base route /api/profit
    public class ProfitController : ControllerBase
    {
        private readonly CryptoDbContext _context;
        private readonly ILogger<ProfitController> _logger; // Optional: for logging

        public ProfitController(CryptoDbContext context, ILogger<ProfitController> logger)
        {
            _context = context;
            _logger = logger;
        }

        // GET /api/profit/{userId}
        // Profit/Veszteség kiszámítása egy adott pillanatban (összesített).
        [HttpGet("{userId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<TotalProfitLossDto>> GetTotalProfitLoss(int userId)
        {
            // Calculate detailed profit/loss first
            var detailedResult = await CalculateProfitLossDetails(userId);

            // Check if the underlying calculation returned a 404 (user not found)
            if (detailedResult.Result is NotFoundObjectResult)
            {
                return NotFound($"User with ID {userId} not found.");
            }
            // Handle other potential errors if CalculateProfitLossDetails returns them
            if (!(detailedResult.Result is OkObjectResult okResult && okResult.Value is DetailedProfitLossDto details))
            {
                // If it's not OK or not the expected type, something went wrong internally
                _logger.LogError("Unexpected result from CalculateProfitLossDetails for total calculation.");
                return StatusCode(StatusCodes.Status500InternalServerError, "An internal error occurred calculating profit/loss.");
            }


            // Sum the profit/loss from the details
            decimal totalProfitLoss = details.HoldingsProfitLoss.Sum(h => h.ProfitLoss);

            var totalResult = new TotalProfitLossDto
            {
                UserId = userId,
                TotalProfitLoss = totalProfitLoss
                // Currency is set by default in DTO
            };

            return Ok(totalResult);
        }


        // GET /api/profit/details/{userId}
        // Profit/Veszteség részletes lebontásban.
        [HttpGet("details/{userId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<DetailedProfitLossDto>> GetDetailedProfitLoss(int userId)
        {
            return await CalculateProfitLossDetails(userId);
        }


        private async Task<ActionResult<DetailedProfitLossDto>> CalculateProfitLossDetails(int userId)
        {
            // 1. Check if user exists
            var userExists = await _context.Users.AnyAsync(u => u.Id == userId);
            if (!userExists)
            {
                // Use ActionResult to return specific status codes from helper
                return NotFound($"User with ID {userId} not found.");
            }

            // 2. Get User's Current Holdings (CryptoWallet entries)
            //    Include Cryptocurrency and its PriceHistory for current price
            var userHoldings = await _context.CryptoWallets
                .Include(cw => cw.Cryptocurrency)
                .Where(cw => cw.UserId == userId && cw.Quantity > 0) // Only include cryptos currently held
                .ToListAsync();

            // 3. Get all BUY transactions for this user
            var userBuyTransactions = await _context.Transactions
                .Where(t => t.UserId == userId && t.TransactionType == "Buy")
                .ToListAsync();

            var profitLossDetailsList = new List<CryptoProfitLossDetailDto>();

            // 4. Calculate profit/loss for each holding
            foreach (var holding in userHoldings)
            {
                decimal currentQuantityHeld = holding.Quantity;
                decimal currentPrice = holding.Cryptocurrency.CurrentPrice;

                // Filter transactions for this specific crypto
                var cryptoBuyTransactions = userBuyTransactions
                    .Where(t => t.CryptoId == holding.CryptoId)
                    .ToList();

                decimal totalCostOfBuys = 0;
                decimal totalQuantityBought = 0;
                decimal averagePurchasePrice = 0;

                if (cryptoBuyTransactions.Any())
                {
                    totalCostOfBuys = cryptoBuyTransactions.Sum(t => t.Quantity * t.PriceAtTrade);
                    totalQuantityBought = cryptoBuyTransactions.Sum(t => t.Quantity);

                    if (totalQuantityBought > 0)
                    {
                        averagePurchasePrice = totalCostOfBuys / totalQuantityBought;
                    }
                }
                // If no buy transactions, averagePurchasePrice remains 0

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

            return Ok(resultDto);
        }

    }
}
