// File: DTOs/CryptoDto.cs
// Represents a cryptocurrency in API responses
namespace halado_prog2.DTOs
{
    public class CryptoDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal CurrentPrice { get; set; } // This comes from the [NotMapped] helper property
    }
}