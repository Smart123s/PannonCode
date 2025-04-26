namespace halado_prog2.DTOs
{
    // DTO for user update request (fields are optional for updates)
    public class UpdateUserRequestDto
    {
        // Username is nullable, allowing partial updates
        public string? Username { get; set; }

        // Email is nullable, allowing partial updates. Add EmailAddress if not null.
        // Email uniqueness check will be done in the controller if email is provided.
        public string? Email { get; set; }

        // NewPassword is nullable. If provided, update the password.
        public string? NewPassword { get; set; }
    }
}
