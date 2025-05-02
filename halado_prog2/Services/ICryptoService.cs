using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public interface ICryptoService
    {
        Task<IEnumerable<CryptoDto>> GetAllAsync();
        Task<CryptoDto?> GetByIdAsync(int cryptoId);
        Task<(CryptoDto? CreatedCrypto, string? ErrorMessage, int StatusCode)> CreateAsync(CreateCryptoRequestDto request);
        Task<(bool Success, string? ErrorMessage, int StatusCode)> DeleteAsync(int cryptoId);
        Task<(bool Success, string? ErrorMessage, int StatusCode)> UpdatePriceAsync(UpdatePriceRequestDto request);
        Task<(IEnumerable<PriceHistoryDto>? History, string? ErrorMessage, int StatusCode)> GetPriceHistoryAsync(int cryptoId);
    }
}
