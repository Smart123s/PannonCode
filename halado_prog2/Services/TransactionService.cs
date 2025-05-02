using Microsoft.EntityFrameworkCore;
using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public class TransactionService : ITransactionService
    {
        private readonly CryptoDbContext _context;
        private readonly ILogger<TransactionService> _logger;

        public TransactionService(CryptoDbContext context, ILogger<TransactionService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task<(IEnumerable<TransactionDto>? Transactions, bool UserFound)> GetUserTransactionsAsync(int userId)
        {
            // Check if user exists
            var userExists = await _context.Users.AnyAsync(u => u.Id == userId);
            if (!userExists)
            {
                _logger.LogWarning("Transaction history requested for non-existent User ID {UserId}", userId);
                return (null, false); // Indicate user not found
            }

            // Fetch transactions, include Crypto for name, order by time
            var transactions = await _context.Transactions
                .Include(t => t.Cryptocurrency) // Include related Cryptocurrency entity
                .Where(t => t.UserId == userId)
                .OrderBy(t => t.Timestamp) // Order chronologically
                .Select(t => new TransactionDto // Project into DTO
                {
                    Id = t.Id,
                    CryptoId = t.CryptoId,
                    CryptoName = t.Cryptocurrency.Name, // Get name from included entity
                    TransactionType = t.TransactionType,
                    Quantity = t.Quantity,
                    PriceAtTrade = t.PriceAtTrade,
                    Timestamp = t.Timestamp
                })
                .AsNoTracking() // Read-only query
                .ToListAsync();

            _logger.LogInformation("Retrieved {TransactionCount} transactions for User ID {UserId}", transactions.Count, userId);
            return (transactions, true); // Return list (can be empty) and indicate user was found
        }

        public async Task<TransactionDto?> GetTransactionDetailsAsync(int transactionId)
        {
            var transaction = await _context.Transactions
                .Include(t => t.Cryptocurrency) // Include related Cryptocurrency entity
                .AsNoTracking() // Read-only query
                .FirstOrDefaultAsync(t => t.Id == transactionId); // Find specific transaction

            if (transaction == null)
            {
                _logger.LogWarning("Details requested for non-existent Transaction ID {TransactionId}", transactionId);
                return null; // Indicate transaction not found
            }

            // Map to DTO
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

            _logger.LogInformation("Retrieved details for Transaction ID {TransactionId}", transactionId);
            return transactionDto;
        }
    }
}