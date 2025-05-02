using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using halado_prog2.Entities;
using halado_prog2.DTOs;
namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/[controller]")] // Base route /api/trade
    public class TradeController : ControllerBase
    {
        private readonly CryptoDbContext _context;

        public TradeController(CryptoDbContext context)
        {
            _context = context;
        }

        // POST /api/trade/buy
        // Kriptovaluta vásárlása.
        [HttpPost("buy")]
        [ProducesResponseType(StatusCodes.Status200OK)] // Indicate success response
        [ProducesResponseType(StatusCodes.Status404NotFound)] // User or Crypto not found
        [ProducesResponseType(StatusCodes.Status409Conflict)] // Insufficient funds
        [ProducesResponseType(StatusCodes.Status400BadRequest)] // Validation errors
        public async Task<ActionResult<TradeResponseDto>> BuyCrypto([FromBody] TradeRequestDto request)
        {
            // 1. Input Validation (handled by [ApiController] and DTO attributes)
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // 2. Fetch Required Entities
            // Load User (needs balance)
            var user = await _context.Users.FindAsync(request.UserId);
            if (user == null)
            {
                return NotFound($"User with ID {request.UserId} not found.");
            }

            // Load Cryptocurrency and its PriceHistory (needs CurrentPrice)
            var crypto = await _context.Cryptocurrencies
                .FirstOrDefaultAsync(c => c.Id == request.CryptoId);
            if (crypto == null)
            {
                return NotFound($"Cryptocurrency with ID {request.CryptoId} not found.");
            }

            // Check if crypto has any price history (edge case, should be seeded/added)
            if (crypto.CurrentPrice <= 0)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, $"Cryptocurrency {crypto.Name} has no valid current price.");
            }

            // 3. Calculate Cost and Check Funds
            var tradeCost = request.Quantity * crypto.CurrentPrice;

            if (user.Balance < tradeCost)
            {
                return Conflict(new ProblemDetails
                {
                    Title = "Insufficient Funds",
                    Detail = $"User {user.Username} has {user.Balance:N8} fiat, but trade requires {tradeCost:N8}.",
                    Status = StatusCodes.Status409Conflict,
                    Instance = HttpContext.Request.Path
                });
            }

            // 4. Perform Trade Logic
            user.Balance -= tradeCost; // Debit user's fiat balance

            // Find or create the user's CryptoWallet entry for this crypto
            var cryptoWallet = await _context.CryptoWallets
                .FirstOrDefaultAsync(cw => cw.UserId == user.Id && cw.CryptoId == crypto.Id);

            if (cryptoWallet == null)
            {
                // User doesn't hold this crypto yet, create a new entry
                cryptoWallet = new CryptoWallet
                {
                    UserId = user.Id,
                    CryptoId = crypto.Id,
                    Quantity = request.Quantity
                };
                _context.CryptoWallets.Add(cryptoWallet);
            }
            else
            {
                // User already holds this crypto, update quantity
                cryptoWallet.Quantity += request.Quantity;
            }

            // 5. Record Transaction
            var transaction = new Transaction
            {
                UserId = user.Id,
                CryptoId = crypto.Id,
                TransactionType = "Buy",
                Quantity = request.Quantity,
                PriceAtTrade = crypto.CurrentPrice,
                Timestamp = DateTime.UtcNow
            };
            _context.Transactions.Add(transaction);

            // 6. Save Changes
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException dbEx)
            {
                Console.Error.WriteLine($"Database error during BUY trade: {dbEx}");
                return StatusCode(StatusCodes.Status500InternalServerError, "An error occurred while saving the trade.");
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"Unexpected error during BUY trade: {ex}");
                return StatusCode(StatusCodes.Status500InternalServerError, "An unexpected error occurred.");
            }


            // 7. Return Response
            return Ok(new TradeResponseDto
            {
                TransactionId = transaction.Id,
                Message = $"Successfully bought {request.Quantity:N8} {crypto.Name} for {tradeCost:N8} fiat."
            });
        }

        // POST /api/trade/sell
        // Kriptovaluta eladása.
        [HttpPost("sell")]
        [ProducesResponseType(StatusCodes.Status200OK)] // Indicate success response
        [ProducesResponseType(StatusCodes.Status404NotFound)] // User or Crypto not found, or user doesn't hold the crypto
        [ProducesResponseType(StatusCodes.Status409Conflict)] // Insufficient holdings
        [ProducesResponseType(StatusCodes.Status400BadRequest)] // Validation errors
        public async Task<ActionResult<TradeResponseDto>> SellCrypto([FromBody] TradeRequestDto request)
        {
            // 1. Input Validation (handled by [ApiController] and DTO attributes)
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // 2. Fetch Required Entities
            // Load User (needs balance update)
            var user = await _context.Users.FindAsync(request.UserId);
            if (user == null)
            {
                return NotFound($"User with ID {request.UserId} not found.");
            }

            var crypto = await _context.Cryptocurrencies
                .FirstOrDefaultAsync(c => c.Id == request.CryptoId);
            if (crypto == null)
            {
                return NotFound($"Cryptocurrency with ID {request.CryptoId} not found.");
            }


            // Find the user's CryptoWallet entry for this crypto
            var cryptoWallet = await _context.CryptoWallets
                .FirstOrDefaultAsync(cw => cw.UserId == user.Id && cw.CryptoId == crypto.Id);

            // 3. Check Holdings
            if (cryptoWallet == null || cryptoWallet.Quantity < request.Quantity)
            {
                // Detail message can be more specific if cryptoWallet is not null
                var detail = cryptoWallet == null
                    ? $"User {user.Username} does not hold {crypto.Name}."
                    : $"User {user.Username} holds {cryptoWallet.Quantity:N8} {crypto.Name}, which is less than the requested sell quantity {request.Quantity:N8}.";

                return Conflict(new ProblemDetails
                {
                    Title = "Insufficient Holdings",
                    Detail = detail,
                    Status = StatusCodes.Status409Conflict,
                    Instance = HttpContext.Request.Path
                });
            }

            // 4. Perform Trade Logic
            var tradeRevenue = request.Quantity * crypto.CurrentPrice;

            user.Balance += tradeRevenue; // Credit user's fiat balance
            cryptoWallet.Quantity -= request.Quantity; // Debit user's crypto quantity

            // Remove CryptoWallet entry if quantity drops to zero or less
            if (cryptoWallet.Quantity <= 0)
            {
                _context.CryptoWallets.Remove(cryptoWallet);
            }

            // 5. Record Transaction
            var transaction = new Transaction
            {
                UserId = user.Id,
                CryptoId = crypto.Id,
                TransactionType = "Sell",
                Quantity = request.Quantity,
                PriceAtTrade = crypto.CurrentPrice,
                Timestamp = DateTime.UtcNow
            };
            _context.Transactions.Add(transaction);


            // 6. Save Changes
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException dbEx)
            {
                Console.Error.WriteLine($"Database error during SELL trade: {dbEx}");
                return StatusCode(StatusCodes.Status500InternalServerError, "An error occurred while saving the trade.");
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"Unexpected error during SELL trade: {ex}");
                return StatusCode(StatusCodes.Status500InternalServerError, "An unexpected error occurred.");
            }


            // 7. Return Response
            return Ok(new TradeResponseDto
            {
                TransactionId = transaction.Id,
                Message = $"Successfully sold {request.Quantity:N8} {crypto.Name} for {tradeRevenue:N8} fiat."
            });
        }
    }
}