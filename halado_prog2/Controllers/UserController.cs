using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using halado_prog2.Entities; // Your Entity models namespace
using halado_prog2.DTOs; // Your DTOs namespace

namespace halado_prog2.Controllers // Changed namespace
{
    [ApiController]
    [Route("api/[controller]")] // Base route /api/users
    public class UsersController : ControllerBase
    {
        private readonly CryptoDbContext _context;

        public UsersController(CryptoDbContext context)
        {
            _context = context;
        }

        // POST /api/users/register
        [HttpPost("register")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status409Conflict)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Register([FromBody] RegisterRequestDto request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Validation: Check if email already exists
            var existingUser = await _context.Users.FirstOrDefaultAsync(u => u.Email == request.Email);
            if (existingUser != null)
            {
                return Conflict(new ProblemDetails
                {
                    Title = "Email already exists",
                    Detail = $"A user with the email address '{request.Email}' already exists.",
                    Status = StatusCodes.Status409Conflict,
                    Instance = HttpContext.Request.Path
                });
            }

            // Create a new User entity
            var user = new User
            {
                Username = request.Username,
                Email = request.Email,
                PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.Password),
                // --- Set initial Balance directly on the User ---
                Balance = 10000.0M // Initial balance as per spec requirement example
                // --- Removed Wallet creation ---
            };

            // Add the new user to the context
            _context.Users.Add(user);

            // Save changes to the database. This will assign an ID to the user.
            await _context.SaveChangesAsync();

            // Prepare the response DTO
            var userDto = new UserDto
            {
                Id = user.Id,
                Username = user.Username,
                Email = user.Email,
                // --- Include the Balance in the DTO ---
                Balance = user.Balance
                // ---
            };

            // Return 201 Created status and the newly created user's data
            return CreatedAtAction(nameof(GetUser), new { userId = user.Id }, userDto);
        }

        // GET /api/users/{userId}
        [HttpGet("{userId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetUser(int userId)
        {
            // Find the user by ID
            var user = await _context.Users.FindAsync(userId);

            if (user == null)
            {
                return NotFound(); // Return 404 if user is not found
            }

            // Map the User entity to a DTO for the response
            var userDto = new UserDto
            {
                Id = user.Id,
                Username = user.Username,
                Email = user.Email,
                // --- Include the Balance in the DTO ---
                Balance = user.Balance
                // ---
                // Do NOT include PasswordHash
            };

            return Ok(userDto); // Return 200 OK with the user data
        }

        // PUT /api/users/{userId}
        [HttpPut("{userId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status409Conflict)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UpdateUser(int userId, [FromBody] UpdateUserRequestDto request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Find the user to update
            var user = await _context.Users.FindAsync(userId);

            if (user == null)
            {
                return NotFound(); // Return 404 if user is not found
            }

            // Apply updates from the request DTO if fields are provided
            if (!string.IsNullOrEmpty(request.Username))
            {
                user.Username = request.Username;
            }

            if (!string.IsNullOrEmpty(request.Email) && request.Email != user.Email)
            {
                // Check for email uniqueness if the email is being changed
                var existingUserWithEmail = await _context.Users.FirstOrDefaultAsync(u => u.Email == request.Email && u.Id != userId);
                if (existingUserWithEmail != null)
                {
                    return Conflict(new ProblemDetails
                    {
                        Title = "Email already exists",
                        Detail = $"A user with the email address '{request.Email}' already exists.",
                        Status = StatusCodes.Status409Conflict,
                        Instance = HttpContext.Request.Path
                    });
                }
                user.Email = request.Email;
            }

            if (!string.IsNullOrEmpty(request.NewPassword))
            {
                user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.NewPassword);
            }

            // No changes needed here related to balance or crypto holdings updates
            // as the UpdateUserRequestDto doesn't include them.

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_context.Users.Any(e => e.Id == userId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent(); // Return 204 No Content for successful update
        }

        // DELETE /api/users/{userId}
        [HttpDelete("{userId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> DeleteUser(int userId)
        {
            // Find the user to delete
            var user = await _context.Users
                .Include(u => u.CryptoWallets) // Include related CryptoWallet entities
                .Include(u => u.Transactions) // Include related Transaction entities
                .FirstOrDefaultAsync(u => u.Id == userId); // Use FirstOrDefaultAsync with Include

            if (user == null)
            {
                return NotFound(); // Return 404 if user is not found
            }

            // --- Rely on cascading delete ---
            // If cascading delete is NOT configured in DbContext, you'd need to remove them manually first:
            // _context.CryptoWallets.RemoveRange(user.CryptoWallets);
            // _context.Transactions.RemoveRange(user.Transactions);
            // --- Assuming cascading delete is configured (recommended) ---

            // Remove the user from the context
            _context.Users.Remove(user);

            // Save changes. Cascading delete will handle CryptoWallet and Transaction entries
            await _context.SaveChangesAsync();

            return NoContent(); // Return 204 No Content for successful deletion
        }
    }
}