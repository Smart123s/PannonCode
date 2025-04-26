// File: DTOs/TradeRequestDto.cs
using System.ComponentModel.DataAnnotations;

namespace halado_prog2.DTOs
{
    // DTO for both Buy and Sell requests
    public class TradeRequestDto
    {
        [Required] // User ID is required
        public int UserId { get; set; }

        [Required] // Crypto ID is required
        public int CryptoId { get; set; }

        [Required] // Quantity is required
        // Ensure quantity is positive, allowing for small decimal amounts
        [Range(0.00000001, double.MaxValue, ErrorMessage = "Quantity must be a positive value.")]
        public decimal Quantity { get; set; }
    }
}