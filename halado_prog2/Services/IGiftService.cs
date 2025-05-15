// File: Services/IGiftService.cs
using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public interface IGiftService
    {
        Task<(GiftCreationResponseDto? Response, string? ErrorMessage, int StatusCode)> CreateGiftAsync(GiftRequestDto request);
        Task<(AcceptGiftResponseDto? Response, string? ErrorMessage, int StatusCode)> ResolveGiftAsync(int giftId, bool accepted);
        Task<(UserGiftHistoryDto? History, bool UserFound)> GetUserGiftHistoryAsync(int userId);
    }
}