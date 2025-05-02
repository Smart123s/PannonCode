using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public interface IProfitService
    {
        // Returns TotalProfitLossDto or null if user not found
        Task<TotalProfitLossDto?> GetTotalProfitLossAsync(int userId);

        // Returns DetailedProfitLossDto or null if user not found
        Task<DetailedProfitLossDto?> GetDetailedProfitLossAsync(int userId);
    }
}