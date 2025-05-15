// File: Services/GiftService.cs
using Microsoft.EntityFrameworkCore;
using halado_prog2.Entities;
using halado_prog2.DTOs;


namespace halado_prog2.Services
{
    public class GiftService : IGiftService
    {
        private readonly CryptoDbContext _context;
        private readonly ILogger<GiftService> _logger;

        public GiftService(CryptoDbContext context, ILogger<GiftService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task<(GiftCreationResponseDto? Response, string? ErrorMessage, int StatusCode)> CreateGiftAsync(GiftRequestDto request)
        {
            if (request.SenderUserId == request.ReceiverUserId)
            {
                return (null, "Sender and receiver cannot be the same user.", StatusCodes.Status400BadRequest);
            }

            // Use a database transaction for atomicity
            using var dbTransaction = await _context.Database.BeginTransactionAsync();

            try
            {
                // 1. Validate Sender, Receiver, Crypto
                var sender = await _context.Users.FirstOrDefaultAsync(u => u.Id == request.SenderUserId);
                if (sender == null) return (null, $"Sender (User ID {request.SenderUserId}) not found.", StatusCodes.Status404NotFound);

                var receiver = await _context.Users.FirstOrDefaultAsync(u => u.Id == request.ReceiverUserId);
                if (receiver == null) return (null, $"Receiver (User ID {request.ReceiverUserId}) not found.", StatusCodes.Status404NotFound);

                var crypto = await _context.Cryptocurrencies.FirstOrDefaultAsync(c => c.Id == request.CryptoId);
                if (crypto == null) return (null, $"Cryptocurrency (ID {request.CryptoId}) not found.", StatusCodes.Status404NotFound);

                if (crypto.CurrentPrice <= 0) return (null, $"Cannot gift {crypto.Name} at zero or negative price.", StatusCodes.Status400BadRequest);


                // 2. Check Sender's Holdings
                var senderWalletHolding = await _context.CryptoWallets
                    .FirstOrDefaultAsync(cw => cw.UserId == request.SenderUserId && cw.CryptoId == request.CryptoId);

                if (senderWalletHolding == null || senderWalletHolding.Quantity < request.Quantity)
                {
                    return (null, $"Sender has insufficient {crypto.Name} to gift. Required: {request.Quantity}, Available: {senderWalletHolding?.Quantity ?? 0}.", StatusCodes.Status409Conflict);
                }

                // 3. "Debit" from sender's wallet (This makes the amount unavailable for other trades/gifts)
                senderWalletHolding.Quantity -= request.Quantity;
                if (senderWalletHolding.Quantity < 0.000000005M) // Effectively zero
                {
                    _context.CryptoWallets.Remove(senderWalletHolding); // Remove if dust
                }


                // 4. Create GiftTransaction
                var giftTransaction = new GiftTransaction
                {
                    SenderUserId = request.SenderUserId,
                    ReceiverUserId = request.ReceiverUserId,
                    CryptoId = request.CryptoId,
                    Quantity = request.Quantity,
                    PriceAtGifting = crypto.CurrentPrice, // Store market price at time of gifting
                    Status = GiftStatus.Pending,
                    CreatedAt = DateTime.UtcNow
                };
                _context.GiftTransactions.Add(giftTransaction);

                // 5. Save changes (sender's wallet update and new gift transaction)
                await _context.SaveChangesAsync();

                // 6. Commit DB transaction
                await dbTransaction.CommitAsync();

                _logger.LogInformation("Gift created: ID {GiftId} from User {SenderId} to User {ReceiverId} for {Quantity} of Crypto {CryptoId}",
                    giftTransaction.Id, sender.Id, receiver.Id, request.Quantity, crypto.Id);

                var response = new GiftCreationResponseDto
                {
                    GiftId = giftTransaction.Id,
                    Status = giftTransaction.Status,
                    Message = $"Gift of {request.Quantity} {crypto.Name} initiated to {receiver.Username}. Awaiting acceptance."
                };
                return (response, null, StatusCodes.Status201Created);
            }
            catch (Exception ex)
            {
                await dbTransaction.RollbackAsync();
                _logger.LogError(ex, "Error creating gift from User {SenderId} for Crypto {CryptoId}", request.SenderUserId, request.CryptoId);
                return (null, "An internal error occurred while creating the gift.", StatusCodes.Status500InternalServerError);
            }
        }

        public async Task<(AcceptGiftResponseDto? Response, string? ErrorMessage, int StatusCode)> ResolveGiftAsync(int giftId, bool accepted)
        {
            using var dbTransaction = await _context.Database.BeginTransactionAsync();
            try
            {
                var gift = await _context.GiftTransactions
                    .Include(g => g.SenderUser)
                    .Include(g => g.ReceiverUser)
                    .Include(g => g.Cryptocurrency)
                    .FirstOrDefaultAsync(g => g.Id == giftId);

                if (gift == null)
                {
                    return (null, $"Gift with ID {giftId} not found.", StatusCodes.Status404NotFound);
                }

                if (gift.Status != GiftStatus.Pending)
                {
                    return (null, $"Gift is no longer pending. Current status: {gift.Status}.", StatusCodes.Status409Conflict);
                }

                string message;
                if (accepted)
                {
                    // Credit Receiver's Wallet
                    var receiverWalletHolding = await _context.CryptoWallets
                        .FirstOrDefaultAsync(cw => cw.UserId == gift.ReceiverUserId && cw.CryptoId == gift.CryptoId);

                    if (receiverWalletHolding == null)
                    {
                        receiverWalletHolding = new CryptoWallet
                        {
                            UserId = gift.ReceiverUserId, // Use ReceiverUserId from the gift
                            CryptoId = gift.CryptoId,
                            Quantity = gift.Quantity
                        };
                        _context.CryptoWallets.Add(receiverWalletHolding);
                    }
                    else
                    {
                        receiverWalletHolding.Quantity += gift.Quantity;
                    }
                    gift.Status = GiftStatus.Accepted;
                    message = $"Gift of {gift.Quantity} {gift.Cryptocurrency.Name} accepted by {gift.ReceiverUser.Username}.";
                    _logger.LogInformation("Gift ID {GiftId} accepted by designated receiver User {ReceiverId}", giftId, gift.ReceiverUserId);
                }
                else // Rejected
                {
                    // Return crypto to Sender's Wallet
                    var senderWalletHolding = await _context.CryptoWallets
                        .FirstOrDefaultAsync(cw => cw.UserId == gift.SenderUserId && cw.CryptoId == gift.CryptoId);

                    if (senderWalletHolding == null)
                    {
                        senderWalletHolding = new CryptoWallet
                        {
                            UserId = gift.SenderUserId,
                            CryptoId = gift.CryptoId,
                            Quantity = gift.Quantity
                        };
                        _context.CryptoWallets.Add(senderWalletHolding);
                    }
                    else
                    {
                        senderWalletHolding.Quantity += gift.Quantity;
                    }
                    gift.Status = GiftStatus.Rejected;
                    message = $"Gift of {gift.Quantity} {gift.Cryptocurrency.Name} rejected by {gift.ReceiverUser.Username}. Crypto returned to sender.";
                    _logger.LogInformation("Gift ID {GiftId} rejected by designated receiver User {ReceiverId}. Crypto returned to sender {SenderId}", giftId, gift.ReceiverUserId, gift.SenderUserId);
                }

                gift.ResolvedAt = DateTime.UtcNow;
                await _context.SaveChangesAsync();
                await dbTransaction.CommitAsync();

                var response = new AcceptGiftResponseDto
                {
                    GiftId = gift.Id,
                    NewStatus = gift.Status,
                    Message = message
                };
                return (response, null, StatusCodes.Status200OK);
            }
            catch (Exception ex)
            {
                await dbTransaction.RollbackAsync();
                _logger.LogError(ex, "Error resolving gift ID {GiftId}", giftId); // Removed resolvingUserId from log
                return (null, "An internal error occurred while resolving the gift.", StatusCodes.Status500InternalServerError);
            }
        }

        public async Task<(UserGiftHistoryDto? History, bool UserFound)> GetUserGiftHistoryAsync(int userId)
        {
            var user = await _context.Users.AsNoTracking().FirstOrDefaultAsync(u => u.Id == userId);
            if (user == null)
            {
                _logger.LogWarning("Gift history requested for non-existent User ID {UserId}", userId);
                return (null, false);
            }

            var sentGifts = await _context.GiftTransactions
                .Where(g => g.SenderUserId == userId)
                .Include(g => g.ReceiverUser) // For receiver's username
                .Include(g => g.Cryptocurrency) // For crypto name and current price
                                                // .ThenInclude(c => c.PriceHistory) // Not needed if CurrentPrice is stored
                .OrderByDescending(g => g.CreatedAt)
                .ToListAsync();

            var receivedGifts = await _context.GiftTransactions
                .Where(g => g.ReceiverUserId == userId)
                .Include(g => g.SenderUser) // For sender's username
                .Include(g => g.Cryptocurrency) // For crypto name and current price
                                                // .ThenInclude(c => c.PriceHistory) // Not needed if CurrentPrice is stored
                .OrderByDescending(g => g.CreatedAt)
                .ToListAsync();

            var historyItems = new List<GiftHistoryItemDto>();

            foreach (var gift in sentGifts)
            {
                historyItems.Add(new GiftHistoryItemDto
                {
                    GiftId = gift.Id,
                    ActionUserId = gift.SenderUserId,
                    ActionUserUsername = user.Username, // The current user is the sender
                    OtherPartyUsername = gift.ReceiverUser.Username,
                    Direction = "Sent",
                    CryptoName = gift.Cryptocurrency.Name,
                    Quantity = gift.Quantity,
                    PriceAtGifting = gift.PriceAtGifting,
                    CurrentPriceOfCrypto = gift.Cryptocurrency.CurrentPrice,
                    Status = gift.Status,
                    CreatedAt = gift.CreatedAt,
                    ResolvedAt = gift.ResolvedAt
                });
            }

            foreach (var gift in receivedGifts)
            {
                historyItems.Add(new GiftHistoryItemDto
                {
                    GiftId = gift.Id,
                    ActionUserId = gift.ReceiverUserId,
                    ActionUserUsername = user.Username, // The current user is the receiver
                    OtherPartyUsername = gift.SenderUser.Username,
                    Direction = "Received",
                    CryptoName = gift.Cryptocurrency.Name,
                    Quantity = gift.Quantity,
                    PriceAtGifting = gift.PriceAtGifting,
                    CurrentPriceOfCrypto = gift.Cryptocurrency.CurrentPrice,
                    Status = gift.Status,
                    CreatedAt = gift.CreatedAt,
                    ResolvedAt = gift.ResolvedAt
                });
            }

            var userGiftHistoryDto = new UserGiftHistoryDto
            {
                UserId = userId,
                Gifts = historyItems.OrderByDescending(h => h.CreatedAt).ToList() // Final sort by creation time
            };

            return (userGiftHistoryDto, true);
        }
    }
}