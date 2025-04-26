// File: Configuration/PriceUpdateSettings.cs
namespace halado_prog2.Configuration
{
    // Class to hold configuration for the price update service
    public class PriceUpdateSettings
    {
        // Section name in appsettings.json, e.g., "PriceUpdate"
        public const string SectionName = "PriceUpdate";

        // Update interval in seconds (e.g., 30 for 30 seconds)
        public int UpdateIntervalSeconds { get; set; } = 60; // Default to 60 seconds

        // Max percentage change (e.g., 0.01 for 1%)
        public decimal MaxPercentageChange { get; set; } = 0.005M; // Default to +/- 0.5%
    }
}