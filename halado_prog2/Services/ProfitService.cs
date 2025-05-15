// File: Services/ProfitService.cs
using Microsoft.EntityFrameworkCore;
using halado_prog2.Entities;
using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public class ProfitService : IProfitService
    {
        private readonly CryptoDbContext _context;
        private readonly ILogger<ProfitService> _logger;

        public ProfitService(CryptoDbContext context, ILogger<ProfitService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task<DetailedProfitLossDto?> GetDetailedProfitLossAsync(int userId)
        {
            return await CalculateProfitLossDetails(userId);
        }

        public async Task<TotalProfitLossDto?> GetTotalProfitLossAsync(int userId)
        {
            var details = await CalculateProfitLossDetails(userId);
            if (details == null) return null;

            decimal totalProfitLoss = details.HoldingsProfitLoss?.Sum(h => h.ProfitLoss) ?? 0M;
            return new TotalProfitLossDto { UserId = userId, TotalProfitLoss = totalProfitLoss };
        }

        private async Task<DetailedProfitLossDto?> CalculateProfitLossDetails(int userId)
        {
            var user = await _context.Users.AsNoTracking().FirstOrDefaultAsync(u => u.Id == userId);
            if (user == null)
            {
                _logger.LogWarning("P/L details: User ID {UserId} not found.", userId);
                return null;
            }

            var userHoldings = await _context.CryptoWallets
                .Include(cw => cw.Cryptocurrency)
                .Where(cw => cw.UserId == userId && cw.Quantity > 0)
                .AsNoTracking()
                .ToListAsync();

            // Get all transactions for the user (buys, sells, and accepted gifts to them, and gifts they sent)
            // We need buys to establish cost basis.
            // We need accepted gifts they received to establish 0 cost basis for those units.
            // We need gifts they sent to apply FIFO for their cost basis reduction.
            var userBuyTransactions = await _context.Transactions
                .Where(t => t.UserId == userId && t.TransactionType == "Buy")
                .OrderBy(t => t.Timestamp) // Crucial for FIFO
                .AsNoTracking()
                .ToListAsync();

            var acceptedGiftsReceived = await _context.GiftTransactions
                .Where(gt => gt.ReceiverUserId == userId && gt.Status == GiftStatus.Accepted)
                .OrderBy(gt => gt.ResolvedAt) // Order by acceptance time
                .AsNoTracking()
                .ToListAsync();

            // Gifts sent by the user that were accepted (these reduce sender's cost basis via FIFO)
            var acceptedGiftsSent = await _context.GiftTransactions
                .Where(gt => gt.SenderUserId == userId && gt.Status == GiftStatus.Accepted)
                .OrderBy(gt => gt.ResolvedAt) // FIFO based on when gift was resolved
                .AsNoTracking()
                .ToListAsync();


            var profitLossDetailsList = new List<CryptoProfitLossDetailDto>();
            _logger.LogDebug("Calculating P/L for User ID {UserId}. Holdings: {Count}", userId, userHoldings.Count);

            foreach (var holding in userHoldings)
            {
                decimal currentQuantityHeld = holding.Quantity;
                decimal currentPrice = holding.Cryptocurrency.CurrentPrice;
                decimal totalCostBasisForHolding = 0;
                decimal effectiveQuantityForAvgCost = 0; // Quantity used to calculate avg cost (excludes 0-cost gifts)

                // --- Determine Cost Basis using FIFO, considering Buys, Gifts Sent, and Gifts Received ---

                // 1. Create a list of "acquisition lots" (Buys and Accepted Gifts Received)
                var acquisitionLots = new List<(DateTime AcquiredAt, decimal Quantity, decimal CostPerUnit, bool IsGift)>();

                foreach (var buyTx in userBuyTransactions.Where(tx => tx.CryptoId == holding.CryptoId))
                {
                    acquisitionLots.Add((buyTx.Timestamp, buyTx.Quantity, buyTx.PriceAtTrade, false));
                }
                foreach (var giftRx in acceptedGiftsReceived.Where(gr => gr.CryptoId == holding.CryptoId))
                {
                    // Gifts received have a cost basis of 0 for the recipient
                    acquisitionLots.Add((giftRx.ResolvedAt.Value, giftRx.Quantity, 0, true));
                }
                acquisitionLots = acquisitionLots.OrderBy(lot => lot.AcquiredAt).ToList(); // Ensure chronological order

                // 2. Create a list of "disposition lots" (Accepted Gifts Sent by this user)
                //    For simplicity, we're not considering "Sell" transactions here as dispositions for calculating
                //    cost basis of *current* holdings. Sells would be for realized P/L.
                //    This calculation focuses on the UNREALIZED P/L of *current* holdings.
                var dispositionGiftLots = acceptedGiftsSent
                    .Where(gs => gs.CryptoId == holding.CryptoId)
                    .Select(gs => (Timestamp: gs.ResolvedAt.Value, gs.Quantity))
                    .OrderBy(lot => lot.Timestamp)
                    .ToList();

                // 3. Apply FIFO: Reduce acquisition lots by disposition (gifted) lots
                //    This determines the cost basis of the *remaining* (currently held) units.
                var remainingAcquisitionLots = new List<(DateTime AcquiredAt, decimal Quantity, decimal CostPerUnit, bool IsGift)>();
                var tempAcquisitionLots = new Queue<(DateTime AcquiredAt, decimal Quantity, decimal CostPerUnit, bool IsGift)>(acquisitionLots);

                foreach (var dispositionLot in dispositionGiftLots)
                {
                    decimal quantityToDispose = dispositionLot.Quantity;
                    while (quantityToDispose > 0 && tempAcquisitionLots.Any())
                    {
                        var currentAcquisitionLot = tempAcquisitionLots.Peek();
                        if (currentAcquisitionLot.Quantity <= quantityToDispose)
                        {
                            // This entire acquisition lot is disposed
                            quantityToDispose -= currentAcquisitionLot.Quantity;
                            tempAcquisitionLots.Dequeue(); // Remove it
                        }
                        else
                        {
                            // Part of this acquisition lot is disposed
                            var remainingInLot = currentAcquisitionLot.Quantity - quantityToDispose;
                            tempAcquisitionLots.Dequeue(); // Remove original
                            tempAcquisitionLots = new Queue<(DateTime AcquiredAt, decimal Quantity, decimal CostPerUnit, bool IsGift)>(
                                new[] { (currentAcquisitionLot.AcquiredAt, remainingInLot, currentAcquisitionLot.CostPerUnit, currentAcquisitionLot.IsGift) }
                                .Concat(tempAcquisitionLots) // Add modified lot back to the front
                            );
                            quantityToDispose = 0;
                        }
                    }
                }
                remainingAcquisitionLots.AddRange(tempAcquisitionLots); // These are the lots that make up the current holding

                // 4. Calculate total cost basis for the current holding from the remaining lots
                //    This needs to account for the `currentQuantityHeld`. The FIFO logic above
                //    just tells us which lots *constitute* the current holding.
                //    We need to ensure we only consider lots up to currentQuantityHeld.
                decimal accountedQuantity = 0;
                foreach (var lot in remainingAcquisitionLots.OrderBy(l => l.AcquiredAt)) // Ensure FIFO for cost basis calc
                {
                    if (accountedQuantity >= currentQuantityHeld) break;

                    decimal quantityFromThisLotToConsider = Math.Min(lot.Quantity, currentQuantityHeld - accountedQuantity);

                    if (!lot.IsGift) // Only non-gifted acquisitions contribute to cost basis
                    {
                        totalCostBasisForHolding += quantityFromThisLotToConsider * lot.CostPerUnit;
                        effectiveQuantityForAvgCost += quantityFromThisLotToConsider;
                    }
                    accountedQuantity += quantityFromThisLotToConsider;
                }


                decimal averagePurchasePriceForHolding = 0;
                if (effectiveQuantityForAvgCost > 0) // Avoid division by zero if all held crypto was gifted
                {
                    averagePurchasePriceForHolding = totalCostBasisForHolding / effectiveQuantityForAvgCost;
                }
                else if (currentQuantityHeld > 0 && remainingAcquisitionLots.Any(l => l.IsGift))
                {
                    // If all remaining quantity is from gifts, average purchase price is 0
                    averagePurchasePriceForHolding = 0;
                }


                _logger.LogDebug("User {UserId}, Crypto {CryptoId}: Held Qty={HeldQty}, Effective Qty for Avg Cost={EffQty}, Total Cost Basis={CostBasis}, Avg Price={AvgBuyPrice}",
                                userId, holding.CryptoId, currentQuantityHeld, effectiveQuantityForAvgCost, totalCostBasisForHolding, averagePurchasePriceForHolding);


                decimal currentMarketValue = currentPrice * currentQuantityHeld;
                // Profit/Loss is based on the carefully calculated totalCostBasisForHolding
                decimal profitLoss = currentMarketValue - totalCostBasisForHolding;

                profitLossDetailsList.Add(new CryptoProfitLossDetailDto
                {
                    CryptoId = holding.CryptoId,
                    CryptoName = holding.Cryptocurrency.Name,
                    QuantityHeld = currentQuantityHeld,
                    AveragePurchasePrice = averagePurchasePriceForHolding, // This is the effective average cost of non-gifted units
                    CurrentPrice = currentPrice,
                    TotalCostBasis = totalCostBasisForHolding,
                    CurrentMarketValue = currentMarketValue,
                    ProfitLoss = profitLoss
                });
            }

            return new DetailedProfitLossDto
            {
                UserId = userId,
                HoldingsProfitLoss = profitLossDetailsList
            };
        }
    }
}