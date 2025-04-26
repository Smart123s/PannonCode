using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using halado_prog2.Entities; // Your Entity models namespace
using halado_prog2.DTOs; // Your DTOs namespace
using System.Linq; // Required for LINQ methods
using System; // Required for DateTime
using System.Collections.Generic; // Required for IEnumerable

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/[controller]")] // Base route /api/transactions
    public class TransactionsController : ControllerBase
    {
        // !!! NOTE: Accessing the database requires an instance of CryptoDbContext.
        // This instance is provided via Dependency Injection, and the CryptoDbContext class
        // is defined in the halado_prog2.DataAccess namespace.
        // Therefore, the 'using halado_prog2.DataAccess;' directive is necessary. !!!
        private readonly CryptoDbContext _context;

        public TransactionsController(CryptoDbContext context)
        {
            _context = context;
        }

        // GET /api/transactions/{userId}
        // Tranzakciók listázása egy adott felhasználóhoz.
        // Az adatok időrendi sorrendben tárolódnak.
        [HttpGet("{userId}")]
        [ProducesResponseType(StatusCodes.Status200OK)] // Corrected casing
        [ProducesResponseType(StatusCodes.Status404NotFound)] // Corrected casing
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
                .Include(t => t.Cryptocurrency) // Include related Cryptocurrency entity
                .Where(t => t.UserId == userId)
                .OrderBy(t => t.Timestamp) // Order by timestamp
                .Select(t => new TransactionDto // Project into DTO
                {
                    Id = t.Id,
                    // UserId = t.UserId, // Include if needed in DTO
                    CryptoId = t.CryptoId,
                    CryptoName = t.Cryptocurrency.Name, // Get name from included entity
                    TransactionType = t.TransactionType,
                    Quantity = t.Quantity,
                    PriceAtTrade = t.PriceAtTrade,
                    Timestamp = t.Timestamp
                })
                .ToListAsync();

            // If the user exists but has no transactions, return an empty list (200 OK)
            // Returning 404 only if the userId itself is invalid.

            return Ok(transactions); // Return 200 OK with the list of transactions
        }

        // GET /api/transactions/details/{transactionId}
        // Egy adott tranzakció részletes megjelenítése.
        [HttpGet("details/{transactionId}")] // Sub-route details/{transactionId}
        [ProducesResponseType(StatusCodes.Status200OK)] // Corrected casing
        [ProducesResponseType(StatusCodes.Status404NotFound)] // Corrected casing
        public async Task<ActionResult<TransactionDto>> GetTransactionDetails(int transactionId)
        {
            // Find the transaction by ID
            // Include the Cryptocurrency to get its name
            var transaction = await _context.Transactions
                .Include(t => t.Cryptocurrency) // Include related Cryptocurrency entity
                .FirstOrDefaultAsync(t => t.Id == transactionId); // Find specific transaction

            if (transaction == null)
            {
                return NotFound($"Transaction with ID {transactionId} not found."); // Return 404 if not found
            }

            // Map the entity to DTO
            var transactionDto = new TransactionDto
            {
                Id = transaction.Id,
                // UserId = transaction.UserId, // Include if needed in DTO
                CryptoId = transaction.CryptoId,
                CryptoName = transaction.Cryptocurrency.Name, // Get name from included entity
                TransactionType = transaction.TransactionType,
                Quantity = transaction.Quantity,
                PriceAtTrade = transaction.PriceAtTrade,
                Timestamp = transaction.Timestamp
            };

            return Ok(transactionDto); // Return 200 OK with transaction details
        }

        // No POST/PUT/DELETE endpoints for transactions specified here,
        // as they are created by the Buy/Sell operations in the TradeController.
    }
}