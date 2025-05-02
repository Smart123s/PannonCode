using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using halado_prog2.DTOs;

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/[controller]")] // Base route /api/transactions
    public class TransactionsController : ControllerBase
    {
        private readonly CryptoDbContext _context;

        public TransactionsController(CryptoDbContext context)
        {
            _context = context;
        }

        // GET /api/transactions/{userId}
        // Tranzakciók listázása egy adott felhasználóhoz.
        // Az adatok időrendi sorrendben tárolódnak.
        [HttpGet("{userId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<IEnumerable<TransactionDto>>> GetUserTransactions(int userId)
        {
            // Optional: Check if the user exists first (good practice)
            var userExists = await _context.Users.AnyAsync(u => u.Id == userId);
            if (!userExists)
            {
                return NotFound($"User with ID {userId} not found.");
            }

            // Fetch transactions for the specific user
            // Include the Cryptocurrency to get its name
            // Order by Timestamp (ascending for historical order)
            var transactions = await _context.Transactions
                .Include(t => t.Cryptocurrency)
                .Where(t => t.UserId == userId)
                .OrderBy(t => t.Timestamp)
                .Select(t => new TransactionDto // Project into DTO
                {
                    Id = t.Id,
                    CryptoId = t.CryptoId,
                    CryptoName = t.Cryptocurrency.Name,
                    TransactionType = t.TransactionType,
                    Quantity = t.Quantity,
                    PriceAtTrade = t.PriceAtTrade,
                    Timestamp = t.Timestamp
                })
                .ToListAsync();

            // If the user exists but has no transactions, return an empty list (200 OK)
            // Returning 404 only if the userId itself is invalid.

            return Ok(transactions);
        }

        // GET /api/transactions/details/{transactionId}
        // Egy adott tranzakció részletes megjelenítése.
        [HttpGet("details/{transactionId}")] // Sub-route details/{transactionId}
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<TransactionDto>> GetTransactionDetails(int transactionId)
        {
            // Find the transaction by ID
            // Include the Cryptocurrency to get its name
            var transaction = await _context.Transactions
                .Include(t => t.Cryptocurrency)
                .FirstOrDefaultAsync(t => t.Id == transactionId);

            if (transaction == null)
            {
                return NotFound($"Transaction with ID {transactionId} not found.");
            }

            // Map the entity to DTO
            var transactionDto = new TransactionDto
            {
                Id = transaction.Id,
                CryptoId = transaction.CryptoId,
                CryptoName = transaction.Cryptocurrency.Name,
                TransactionType = transaction.TransactionType,
                Quantity = transaction.Quantity,
                PriceAtTrade = transaction.PriceAtTrade,
                Timestamp = transaction.Timestamp
            };

            return Ok(transactionDto);
        }
    }
}