using Microsoft.EntityFrameworkCore;
using halado_prog2.Entities;
using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public class TradeService : ITradeService
    {
        private readonly CryptoDbContext _context;
        private readonly ILogger<TradeService> _logger;

        public TradeService(CryptoDbContext context, ILogger<TradeService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task<(int? TransactionId, string? ErrorMessage, int StatusCode)> BuyCryptoAsync(TradeRequestDto request)
        {
            // Using a transaction scope to ensure atomicity
            using var dbTransaction = await _context.Database.BeginTransactionAsync();

            try
            {
                // 1. Fetch Required Entities (Lock rows for update if needed, depends on isolation level)
                var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == request.UserId);
                // Potentially use .FromSqlInterpolated($"SELECT * FROM Users WITH (UPDLOCK) WHERE Id = {request.UserId}").FirstOrDefaultAsync();
                // if high concurrency is expected, but requires careful consideration. Default EF Core tracking often sufficient.

                if (user == null)
                {
                    return (null, $"User with ID {request.UserId} not found.", StatusCodes.Status404NotFound);
                }

                var crypto = await _context.Cryptocurrencies.FirstOrDefaultAsync(c => c.Id == request.CryptoId);
                if (crypto == null)
                {
                    return (null, $"Cryptocurrency with ID {request.CryptoId} not found.", StatusCodes.Status404NotFound);
                }
                // CurrentPrice is read directly from the entity

                // 2. Calculate Cost and Check Funds
                if (crypto.CurrentPrice <= 0)
                {
                    return (null, $"Cannot trade {crypto.Name} at zero or negative price.", StatusCodes.Status400BadRequest);
                }
                var tradeCost = request.Quantity * crypto.CurrentPrice;

                if (user.Balance < tradeCost)
                {
                    return (null, $"Insufficient funds. Required: {tradeCost:N8}, Available: {user.Balance:N8}.", StatusCodes.Status409Conflict);
                }

                // 3. Perform Trade Logic
                user.Balance -= tradeCost; // Debit user

                var cryptoWallet = await _context.CryptoWallets
                    .FirstOrDefaultAsync(cw => cw.UserId == user.Id && cw.CryptoId == crypto.Id);

                if (cryptoWallet == null)
                {
                    cryptoWallet = new CryptoWallet { UserId = user.Id, CryptoId = crypto.Id, Quantity = request.Quantity };
                    _context.CryptoWallets.Add(cryptoWallet);
                }
                else
                {
                    cryptoWallet.Quantity += request.Quantity;
                }

                // 4. Record Transaction
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

                // 5. Save Changes within the transaction scope
                await _context.SaveChangesAsync();

                // 6. Commit the database transaction
                await dbTransaction.CommitAsync();

                _logger.LogInformation("Buy successful for User ID {UserId}, Crypto ID {CryptoId}, Transaction ID {TransactionId}", request.UserId, request.CryptoId, transaction.Id);
                return (transaction.Id, null, StatusCodes.Status200OK); // Return Transaction ID and OK status
            }
            catch (DbUpdateConcurrencyException ex)
            {
                await dbTransaction.RollbackAsync(); // Rollback on concurrency error
                _logger.LogError(ex, "Concurrency error during BUY trade for User ID {UserId}, Crypto ID {CryptoId}", request.UserId, request.CryptoId);
                return (null, "Data conflict occurred. Please try again.", StatusCodes.Status409Conflict);
            }
            catch (Exception ex)
            {
                await dbTransaction.RollbackAsync(); // Rollback on any other error
                _logger.LogError(ex, "Error during BUY trade for User ID {UserId}, Crypto ID {CryptoId}", request.UserId, request.CryptoId);
                return (null, "An internal error occurred during the trade.", StatusCodes.Status500InternalServerError);
            }
        }

        public async Task<(int? TransactionId, string? ErrorMessage, int StatusCode)> SellCryptoAsync(TradeRequestDto request)
        {
            using var dbTransaction = await _context.Database.BeginTransactionAsync();
            try
            {
                // 1. Fetch Required Entities
                var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == request.UserId);
                if (user == null)
                {
                    return (null, $"User with ID {request.UserId} not found.", StatusCodes.Status404NotFound);
                }

                var crypto = await _context.Cryptocurrencies.FirstOrDefaultAsync(c => c.Id == request.CryptoId);
                if (crypto == null)
                {
                    return (null, $"Cryptocurrency with ID {request.CryptoId} not found.", StatusCodes.Status404NotFound);
                }

                var cryptoWallet = await _context.CryptoWallets
                    .FirstOrDefaultAsync(cw => cw.UserId == user.Id && cw.CryptoId == crypto.Id);

                // 2. Check Holdings
                if (cryptoWallet == null || cryptoWallet.Quantity < request.Quantity)
                {
                    var detail = cryptoWallet == null
                        ? $"User does not hold {crypto.Name}."
                        : $"Insufficient holdings. Trying to sell {request.Quantity:N8} {crypto.Name}, but only hold {cryptoWallet.Quantity:N8}.";
                    return (null, detail, StatusCodes.Status409Conflict);
                }


                // 3. Calculate Revenue
                if (crypto.CurrentPrice <= 0)
                {
                    return (null, $"Cannot trade {crypto.Name} at zero or negative price.", StatusCodes.Status400BadRequest);
                }
                var tradeRevenue = request.Quantity * crypto.CurrentPrice;

                // 4. Perform Trade Logic
                user.Balance += tradeRevenue; // Credit user
                cryptoWallet.Quantity -= request.Quantity; // Debit holding

                if (cryptoWallet.Quantity <= 0.000000005M) // Use a small threshold for floating point comparison
                {
                    // Remove if effectively zero to avoid tiny fractional dust
                    _context.CryptoWallets.Remove(cryptoWallet);
                    _logger.LogInformation("Removing CryptoWallet entry for User ID {UserId}, Crypto ID {CryptoId} as quantity reached zero.", user.Id, crypto.Id);
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
                await _context.SaveChangesAsync();

                // 7. Commit Transaction
                await dbTransaction.CommitAsync();

                _logger.LogInformation("Sell successful for User ID {UserId}, Crypto ID {CryptoId}, Transaction ID {TransactionId}", request.UserId, request.CryptoId, transaction.Id);
                return (transaction.Id, null, StatusCodes.Status200OK);
            }
            catch (DbUpdateConcurrencyException ex)
            {
                await dbTransaction.RollbackAsync();
                _logger.LogError(ex, "Concurrency error during SELL trade for User ID {UserId}, Crypto ID {CryptoId}", request.UserId, request.CryptoId);
                return (null, "Data conflict occurred. Please try again.", StatusCodes.Status409Conflict);
            }
            catch (Exception ex)
            {
                await dbTransaction.RollbackAsync();
                _logger.LogError(ex, "Error during SELL trade for User ID {UserId}, Crypto ID {CryptoId}", request.UserId, request.CryptoId);
                return (null, "An internal error occurred during the trade.", StatusCodes.Status500InternalServerError);
            }
        }
    }
}