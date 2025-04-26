using System.ComponentModel.DataAnnotations; // Required for validation attributes

namespace halado_prog2.DTOs
{
    // DTO for user registration request
    public class RegisterRequestDto
    {
        [Required] // Ensure username is provided
        public string Username { get; set; }

        [Required] // Ensure email is provided
        [EmailAddress] // Basic email format validation
        public string Email { get; set; }

        [Required] // Ensure password is provided
        public string Password { get; set; }
    }
}
