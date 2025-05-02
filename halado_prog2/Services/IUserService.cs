// File: Services/IUserService.cs
using System.Threading.Tasks;
using halado_prog2.DTOs;
// Optional: Using a custom Result class for better error handling from services
// using YourProject.Common;

namespace halado_prog2.Services
{
    public interface IUserService
    {
        // Consider returning a result object or tuple to indicate success/failure/specific errors
        Task<(UserDto? User, string? ErrorMessage, int StatusCode)> RegisterAsync(RegisterRequestDto request);
        Task<UserDto?> GetUserAsync(int userId);
        Task<(bool Success, string? ErrorMessage, int StatusCode)> UpdateUserAsync(int userId, UpdateUserRequestDto request);
        Task<(bool Success, string? ErrorMessage)> DeleteUserAsync(int userId);
    }
}
