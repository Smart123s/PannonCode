// File: DTOs/UpdateFeeRateRequestDto.cs
using System.ComponentModel.DataAnnotations;

namespace halado_prog2.DTOs
{
    public class UpdateFeeRateRequestDto
    {
        [Required]
        [Range(0, 50, ErrorMessage = "Fee rate must be between 0 and 50 percent.")]
        public decimal NewFee { get; set; } // Percentage value, e.g., 0.2 for 0.2%
    }
}