// File: DTOs/CreateCryptoRequestDto.cs
using System.ComponentModel.DataAnnotations;

// Represents the request body for creating a new cryptocurrency
namespace halado_prog2.DTOs
{
    public class CreateCryptoRequestDto
    {
        [Required] // Name is required
        [MaxLength(50)] // Match entity constraint
        public string Name { get; set; }

        [Required] // Initial price is required
        [Range(0.00000001, double.MaxValue, ErrorMessage = "Initial price must be a positive value.")] // Basic validation
        public decimal InitialPrice { get; set; } // Store the initial price as the first PriceHistory entry
    }
}