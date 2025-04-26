using System.ComponentModel.DataAnnotations;

namespace halado_prog2.DTOs
{
    public class UpdateBalanceRequestDto // Represents the request body for PUT /api/wallet/{userId}
    {
        [Required] // Require the new balance value
        // Add range/validation if needed, e.g., balance cannot be negative
        // [Range(0, double.MaxValue, ErrorMessage = "Balance must be a non-negative value.")]
        public decimal NewBalance { get; set; }
    }
}