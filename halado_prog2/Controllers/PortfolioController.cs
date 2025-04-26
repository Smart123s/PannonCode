using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using halado_prog2.Entities; // Your Entity models namespace
using halado_prog2.DTOs; // Your DTOs namespace
using System.Linq; // Required for LINQ methods

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/[controller]")] // Base route /api/portfolio
    public class PortfolioController : ControllerBase
    {
        private readonly CryptoDbContext _context;

        public PortfolioController(CryptoDbContext context)
        {
            _context = context;
        }

        // GET /api/portfolio/{userId}
        // Felhasználó portfóliójának lekérdezése.
        // This endpoint is very similar to GET /api/wallet/{userId},
        // returning the user's fiat balance and crypto holdings.
        [HttpGet("{userId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<WalletDto>> GetPortfolio(int userId)
        {
            // Find the user, INCLUDING their CryptoWallets and the related Cryptocurrency and its PriceHistory
            // Including PriceHistory is crucial for the [NotMapped] CurrentPrice property on Cryptocurrency to work.
            var user = await _context.Users
                .Include(u => u.CryptoWallets) // Include the join table entries
                    .ThenInclude(cw => cw.Cryptocurrency) // Include the related Cryptocurrency for each holding
                        .ThenInclude(c => c.PriceHistory) // *** MUST INCLUDE THIS for CurrentPrice Getter! ***
                .FirstOrDefaultAsync(u => u.Id == userId);

            if (user == null)
            {
                return NotFound($"User with ID {userId} not found.");
            }

            // Map the data to the WalletDto (or a dedicated PortfolioDto if needed later)
            // Reusing WalletDto as it contains the required info: balance and crypto holdings with current prices
            var portfolioDto = new WalletDto
            {
                UserId = user.Id,
                FiatBalance = user.Balance, // Get balance directly from User entity
                CryptoHoldings = user.CryptoWallets.Select(cw => new CryptoHoldingDto
                {
                    CryptoId = cw.CryptoId,
                    CryptoName = cw.Cryptocurrency.Name, // Get name from the included Cryptocurrency
                    Quantity = cw.Quantity, // Get quantity from the CryptoWallet entry
                    CurrentPrice = cw.Cryptocurrency.CurrentPrice // Use the [NotMapped] getter (which works because PriceHistory was included)
                    // ValueInFiat can be calculated in the DTO or client-side
                }).ToList()
            };

            return Ok(portfolioDto); // Return 200 OK with the portfolio data
        }
    }
}