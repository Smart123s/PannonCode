// File: Controllers/UsersController.cs
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using halado_prog2.DTOs;
using halado_prog2.Services; // Use the service interface

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        // Inject the service interface, NOT the DbContext
        private readonly IUserService _userService;

        public UsersController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpPost("register")]
        [ProducesResponseType(typeof(UserDto), StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status409Conflict)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> Register([FromBody] RegisterRequestDto request)
        {
            // 1. Input Validation (remains in controller)
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // 2. Call the service
            var (userDto, errorMessage, statusCode) = await _userService.RegisterAsync(request);

            // 3. Map service result to IActionResult
            if (userDto != null)
            {
                // Success (201 Created)
                return CreatedAtAction(nameof(GetUser), new { userId = userDto.Id }, userDto);
            }
            else if (statusCode == StatusCodes.Status409Conflict)
            {
                // Specific, known error (Conflict)
                return Conflict(new ProblemDetails { Title = "Registration Error", Detail = errorMessage, Status = statusCode });
            }
            else
            {
                // Generic internal server error
                return StatusCode(statusCode, new ProblemDetails { Title = "Registration Error", Detail = errorMessage, Status = statusCode });
            }
        }

        [HttpGet("{userId}")]
        [ProducesResponseType(typeof(UserDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetUser(int userId)
        {
            var userDto = await _userService.GetUserAsync(userId);

            if (userDto == null)
            {
                return NotFound();
            }
            return Ok(userDto);
        }

        // --- Refactor other actions (UpdateUser, DeleteUser) similarly ---
        [HttpPut("{userId}")]
        public async Task<IActionResult> UpdateUser(int userId, [FromBody] UpdateUserRequestDto request)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);
            var (success, error, statusCode) = await _userService.UpdateUserAsync(userId, request);
            if (success) return NoContent();
            if (statusCode == StatusCodes.Status404NotFound) return NotFound(error);
            if (statusCode == StatusCodes.Status409Conflict) return Conflict(error);
            return StatusCode(statusCode, error); // Or generic error
        }

        [HttpDelete("{userId}")]
        public async Task<IActionResult> DeleteUser(int userId)
        {
            var (success, error) = await _userService.DeleteUserAsync(userId);
            if (success) return NoContent();
            return NotFound(error); // Assuming only 404 is possible failure here
        }
    }
}
