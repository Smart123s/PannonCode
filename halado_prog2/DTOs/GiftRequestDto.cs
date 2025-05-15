// File: DTOs/GiftRequestDto.cs
using System.ComponentModel.DataAnnotations;

namespace halado_prog2.DTOs
{
    public class GiftRequestDto
    {
        [Required]
        public int SenderUserId { get; set; } // Could be inferred from authenticated user in a real system

        [Required]
        public int ReceiverUserId { get; set; }

        [Required]
        public int CryptoId { get; set; }

        [Required]
        [Range(0.00000001, double.MaxValue, ErrorMessage = "Quantity must be positive.")]
        public decimal Quantity { get; set; }
    }
}