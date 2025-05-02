// File: DTOs/CreateCryptoRequestDto.cs
using System.ComponentModel.DataAnnotations;
namespace halado_prog2.DTOs
{
    public class CreateCryptoRequestDto
    {
        [Required]
        [MaxLength(50)]
        public string Name { get; set; }

        [Required]
        [Range(0.00000001, double.MaxValue, ErrorMessage = "Initial price must be a positive value.")]
        public decimal InitialPrice { get; set; }
    }
}