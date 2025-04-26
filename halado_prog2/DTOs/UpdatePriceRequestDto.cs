// File: DTOs/UpdatePriceRequestDto.cs
using System.ComponentModel.DataAnnotations;

namespace halado_prog2.DTOs
{
    // DTO for the manual price update request
    public class UpdatePriceRequestDto
    {
        [Required] // Crypto ID is required
        public int CryptoId { get; set; }

        [Required] // New price is required
        // Ensure price is positive (or >= 0 if price can drop to 0)
        [Range(0, double.MaxValue, ErrorMessage = "New price must be a non-negative value.")]
        public decimal NewPrice { get; set; }
    }
}