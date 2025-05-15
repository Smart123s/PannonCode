// File: Services/TransactionFeeService.cs
using Microsoft.EntityFrameworkCore;
using halado_prog2.Entities;
using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public class TransactionFeeService : ITransactionFeeService
    {
        private readonly CryptoDbContext _context;
        private readonly ILogger<TransactionFeeService> _logger;
        private const string TransactionFeeRateKey = "TransactionFeeRate";

        public TransactionFeeService(CryptoDbContext context, ILogger<TransactionFeeService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task<(TransactionFeeSummaryDto? Summary, bool UserFound)> GetFeeSummaryAsync(int userId)
        {
            var userExists = await _context.Users.AnyAsync(u => u.Id == userId);
            if (!userExists)
            {
                _logger.LogWarning("Fee summary requested for non-existent User ID {UserId}", userId);
                return (null, false);
            }

            var userTransactions = await _context.Transactions
                .Include(t => t.Cryptocurrency) // For CryptoName
                .Where(t => t.UserId == userId && t.FeeAmount > 0)
                .OrderBy(t => t.Timestamp)
                .ToListAsync();

            if (!userTransactions.Any())
            {
                return (new TransactionFeeSummaryDto { UserId = userId, TotalFeesPaid = 0 }, true);
            }

            var totalFeesPaid = userTransactions.Sum(t => t.FeeAmount);

            var dailySummaries = userTransactions
                .GroupBy(t => t.Timestamp.Date) // Group by date part only
                .Select(g => new DailyFeeSummaryDto
                {
                    Date = g.Key,
                    TotalFeesForDay = g.Sum(t => t.FeeAmount)
                })
                .OrderBy(ds => ds.Date)
                .ToList();

            var individualDetails = userTransactions
                .Select(t => new IndividualFeeDetailDto
                {
                    TransactionId = t.Id,
                    CryptoName = t.Cryptocurrency.Name,
                    TransactionType = t.TransactionType,
                    FeeAmount = t.FeeAmount,
                    Timestamp = t.Timestamp
                })
                .ToList();

            var summaryDto = new TransactionFeeSummaryDto
            {
                UserId = userId,
                TotalFeesPaid = totalFeesPaid,
                DailySummaries = dailySummaries,
                IndividualFeeDetails = individualDetails
            };
            return (summaryDto, true);
        }

        public async Task<(bool Success, string? ErrorMessage)> UpdateFeeRateAsync(decimal newFeePercentage)
        {
            // Convert percentage to decimal rate (e.g., 0.2% -> 0.002)
            decimal newRate = newFeePercentage / 100.0M;

            var setting = await _context.SystemSettings.FindAsync(TransactionFeeRateKey);
            if (setting == null)
            {
                // Should not happen if seeded, but handle defensively
                setting = new SystemSetting
                {
                    SettingKey = TransactionFeeRateKey,
                    SettingValue = newRate,
                    LastModified = DateTime.UtcNow
                };
                _context.SystemSettings.Add(setting);
                _logger.LogInformation("Created new TransactionFeeRate setting: {NewRate}", newRate);
            }
            else
            {
                setting.SettingValue = newRate;
                setting.LastModified = DateTime.UtcNow;
                _logger.LogInformation("Updated TransactionFeeRate setting to: {NewRate}", newRate);
            }

            try
            {
                await _context.SaveChangesAsync();
                return (true, null);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error updating transaction fee rate to {NewFeePercentage}%", newFeePercentage);
                return (false, "Failed to update fee rate.");
            }
        }
    }
}
