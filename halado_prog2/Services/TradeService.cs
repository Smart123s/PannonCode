// File: Services/TradeService.cs
// ... (usings remain the same) ...
using halado_prog2.DTOs;
using halado_prog2.Entities;
using Microsoft.EntityFrameworkCore;

namespace halado_prog2.Services
{
    public class TradeService : ITradeService
    {
        private readonly CryptoDbContext _context;
        private readonly ILogger<TradeService> _logger;
        private const string TransactionFeeRateKey = "TransactionFeeRate"; // Key for SystemSettings

        public TradeService(CryptoDbContext context, ILogger<TradeService> logger)
        {
            _context = context;
            _logger = logger;
        }

        private async Task<decimal> GetTransactionFeeRateAsync()
        {
            var setting = await _context.SystemSettings.FindAsync(TransactionFeeRateKey);
            return setting?.SettingValue ?? 0.002M; // Default to 0.2% if not found
        }

        public async Task<(TradeResponseDto? TradeConfirmation, string? ErrorMessage, int StatusCode)> BuyCryptoAsync(TradeRequestDto request)
        {
            using var dbTransaction = await _context.Database.BeginTransactionAsync();
            try
            {
                var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == request.UserId);
                if (user == null) return (null, $"User {request.UserId} not found.", StatusCodes.Status404NotFound);

                var crypto = await _context.Cryptocurrencies.FirstOrDefaultAsync(c => c.Id == request.CryptoId);
                if (crypto == null) return (null, $"Crypto {request.CryptoId} not found.", StatusCodes.Status404NotFound);

                if (crypto.CurrentPrice <= 0) return (null, "Cannot trade at zero/negative price.", StatusCodes.Status400BadRequest);

                decimal grossAmount = request.Quantity * crypto.CurrentPrice;
                decimal feeRate = await GetTransactionFeeRateAsync();
                decimal feeAmount = grossAmount * feeRate; // Fee is 0.2% of the gross crypto value
                decimal totalUserPays = grossAmount + feeAmount;

                if (user.Balance < totalUserPays)
                {
                    return (null, $"Insufficient funds. Required: {totalUserPays:N8} (incl. fee {feeAmount:N8}), Available: {user.Balance:N8}.", StatusCodes.Status409Conflict);
                }

                user.Balance -= totalUserPays; // Debit user for gross amount + fee

                var cryptoWallet = await _context.CryptoWallets.FirstOrDefaultAsync(cw => cw.UserId == user.Id && cw.CryptoId == crypto.Id);
                if (cryptoWallet == null)
                {
                    cryptoWallet = new CryptoWallet { UserId = user.Id, CryptoId = crypto.Id, Quantity = request.Quantity };
                    _context.CryptoWallets.Add(cryptoWallet);
                }
                else
                {
                    cryptoWallet.Quantity += request.Quantity;
                }

                var transaction = new Transaction
                {
                    UserId = user.Id,
                    CryptoId = crypto.Id,
                    TransactionType = "Buy",
                    Quantity = request.Quantity,
                    PriceAtTrade = crypto.CurrentPrice,
                    FeeAmount = feeAmount, // Store the calculated fee
                    Timestamp = DateTime.UtcNow
                };
                _context.Transactions.Add(transaction);

                await _context.SaveChangesAsync();
                await dbTransaction.CommitAsync();

                var confirmation = new TradeResponseDto
                {
                    TransactionId = transaction.Id,
                    UserId = user.Id,
                    CryptoId = crypto.Id,
                    Amount = grossAmount, // Gross value of crypto
                    Fee = feeAmount,
                    TotalAmount = totalUserPays, // What the user actually paid
                    Timestamp = transaction.Timestamp,
                    TransactionType = "Buy",
                    Quantity = request.Quantity,
                    PriceAtTrade = crypto.CurrentPrice
                };
                return (confirmation, null, StatusCodes.Status200OK);
            }
            // ... (catch blocks remain the same) ...
            catch (Exception ex)
            {
                await dbTransaction.RollbackAsync();
                _logger.LogError(ex, "Error during BUY trade for User ID {UserId}, Crypto ID {CryptoId}", request.UserId, request.CryptoId);
                return (null, "An internal error occurred.", StatusCodes.Status500InternalServerError);
            }
        }

        public async Task<(TradeResponseDto? TradeConfirmation, string? ErrorMessage, int StatusCode)> SellCryptoAsync(TradeRequestDto request)
        {
            using var dbTransaction = await _context.Database.BeginTransactionAsync();
            try
            {
                var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == request.UserId);
                if (user == null) return (null, $"User {request.UserId} not found.", StatusCodes.Status404NotFound);

                var crypto = await _context.Cryptocurrencies.FirstOrDefaultAsync(c => c.Id == request.CryptoId);
                if (crypto == null) return (null, $"Crypto {request.CryptoId} not found.", StatusCodes.Status404NotFound);

                if (crypto.CurrentPrice <= 0) return (null, "Cannot trade at zero/negative price.", StatusCodes.Status400BadRequest);

                var cryptoWallet = await _context.CryptoWallets.FirstOrDefaultAsync(cw => cw.UserId == user.Id && cw.CryptoId == crypto.Id);
                if (cryptoWallet == null || cryptoWallet.Quantity < request.Quantity)
                {
                    return (null, "Insufficient crypto holdings.", StatusCodes.Status409Conflict);
                }

                decimal grossAmount = request.Quantity * crypto.CurrentPrice;
                decimal feeRate = await GetTransactionFeeRateAsync();
                decimal feeAmount = grossAmount * feeRate; // Fee is 0.2% of the gross crypto value
                decimal netUserReceives = grossAmount - feeAmount;

                user.Balance += netUserReceives; // Credit user for net amount (gross - fee)
                cryptoWallet.Quantity -= request.Quantity;

                if (cryptoWallet.Quantity <= 0.000000005M)
                {
                    _context.CryptoWallets.Remove(cryptoWallet);
                }

                var transaction = new Transaction
                {
                    UserId = user.Id,
                    CryptoId = crypto.Id,
                    TransactionType = "Sell",
                    Quantity = request.Quantity,
                    PriceAtTrade = crypto.CurrentPrice,
                    FeeAmount = feeAmount, // Store the calculated fee
                    Timestamp = DateTime.UtcNow
                };
                _context.Transactions.Add(transaction);

                await _context.SaveChangesAsync();
                await dbTransaction.CommitAsync();

                var confirmation = new TradeResponseDto
                {
                    TransactionId = transaction.Id,
                    UserId = user.Id,
                    CryptoId = crypto.Id,
                    Amount = grossAmount, // Gross value of crypto
                    Fee = feeAmount,
                    TotalAmount = netUserReceives, // What the user actually received
                    Timestamp = transaction.Timestamp,
                    TransactionType = "Sell",
                    Quantity = request.Quantity,
                    PriceAtTrade = crypto.CurrentPrice
                };
                return (confirmation, null, StatusCodes.Status200OK);
            }
            // ... (catch blocks remain the same) ...
            catch (Exception ex)
            {
                await dbTransaction.RollbackAsync();
                _logger.LogError(ex, "Error during SELL trade for User ID {UserId}, Crypto ID {CryptoId}", request.UserId, request.CryptoId);
                return (null, "An internal error occurred.", StatusCodes.Status500InternalServerError);
            }
        }
    }
}