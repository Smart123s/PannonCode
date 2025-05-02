using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using halado_prog2.DTOs;

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
            var user = await _context.Users
                .Include(u => u.CryptoWallets)
                    .ThenInclude(cw => cw.Cryptocurrency)
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
                FiatBalance = user.Balance,
                CryptoHoldings = user.CryptoWallets.Select(cw => new CryptoHoldingDto
                {
                    CryptoId = cw.CryptoId,
                    CryptoName = cw.Cryptocurrency.Name,
                    Quantity = cw.Quantity,
                    CurrentPrice = cw.Cryptocurrency.CurrentPrice
                }).ToList()
            };

            return Ok(portfolioDto);
        }
    }
}