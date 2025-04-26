// File: DTOs/UserDto.cs
// Need to add the Balance property here
namespace halado_prog2.DTOs // Changed namespace
{
    public class UserDto
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }

        // --- Added Balance property ---
        public decimal Balance { get; set; }
        // ---

        // You could add a list of CryptoWallets here too, if desired for the GetUser endpoint,
        // but for just 'user data', balance is sufficient based on the spec.
        // e.g., public List<CryptoHoldingDto>? Holdings { get; set; }
    }

    // Example DTO if you wanted to include crypto holdings in UserDto
    /*
    public class CryptoHoldingDto
    {
        public int CryptoId { get; set; }
        public string CryptoName { get; set; }
        public decimal Quantity { get; set; }
        public decimal CurrentPrice { get; set; } // Might need to join with Cryptocurrency
    }
    */
}