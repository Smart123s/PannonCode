// File: Services/ITransactionFeeService.cs
using System.Threading.Tasks;
using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public interface ITransactionFeeService
    {
        Task<(TransactionFeeSummaryDto? Summary, bool UserFound)> GetFeeSummaryAsync(int userId);
        Task<(bool Success, string? ErrorMessage)> UpdateFeeRateAsync(decimal newFeePercentage);
    }
}