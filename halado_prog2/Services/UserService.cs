// File: Services/UserService.cs
using Microsoft.EntityFrameworkCore;
using halado_prog2.Entities;
using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public class UserService : IUserService
    {
        private readonly CryptoDbContext _context;
        private readonly ILogger<UserService> _logger;

        public UserService(CryptoDbContext context, ILogger<UserService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task<(UserDto? User, string? ErrorMessage, int StatusCode)> RegisterAsync(RegisterRequestDto request)
        {
            // 1. Check email uniqueness (Business Logic)
            if (await _context.Users.AnyAsync(u => u.Email == request.Email))
            {
                return (null, $"Email '{request.Email}' already exists.", StatusCodes.Status409Conflict);
            }

            // 2. Create entity, hash password, set balance (Business Logic)
            var user = new User
            {
                Username = request.Username,
                Email = request.Email,
                PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.Password),
                Balance = 10000.0M // Default balance
            };

            // 3. Save to database
            _context.Users.Add(user);
            try
            {
                await _context.SaveChangesAsync();
                _logger.LogInformation("User registered successfully with ID {UserId}", user.Id);
            }
            catch (DbUpdateException ex)
            {
                _logger.LogError(ex, "Database error during user registration for email {Email}", request.Email);
                return (null, "An error occurred while saving user data.", StatusCodes.Status500InternalServerError);
            }

            // 4. Map to DTO
            var userDto = new UserDto
            {
                Id = user.Id,
                Username = user.Username,
                Email = user.Email,
                Balance = user.Balance
            };

            return (userDto, null, StatusCodes.Status201Created); // Success
        }

        // --- Implement other methods (GetUserAsync, UpdateUserAsync, DeleteUserAsync) ---
        public async Task<UserDto?> GetUserAsync(int userId)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user == null) return null;

            return new UserDto // Map to DTO
            {
                Id = user.Id,
                Username = user.Username,
                Email = user.Email,
                Balance = user.Balance
            };
        }

        // ... Implement UpdateUserAsync and DeleteUserAsync similarly ...
        public async Task<(bool Success, string? ErrorMessage, int StatusCode)> UpdateUserAsync(int userId, UpdateUserRequestDto request)
        {
            // ... fetch user, check email uniqueness if changed, hash password, save ...
            // return (true, null, StatusCodes.Status204NoContent) on success
            // return (false, "User not found", StatusCodes.Status404NotFound)
            // return (false, "Email conflict", StatusCodes.Status409Conflict)
            await Task.Delay(10); // Placeholder
            return (true, null, StatusCodes.Status204NoContent);
        }

        public async Task<(bool Success, string? ErrorMessage)> DeleteUserAsync(int userId)
        {
            // ... fetch user, remove, save ...
            // return (true, null) on success
            // return (false, "User not found")
            await Task.Delay(10); // Placeholder
            return (true, null);
        }
    }
}
