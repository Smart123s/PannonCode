using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection; // Required for IServiceScopeFactory
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging; // For logging
using Microsoft.Extensions.Options; // For configuration
using halado_prog2.Entities; // Your Entity models namespace
using halado_prog2.Configuration;
using Microsoft.EntityFrameworkCore; // Your configuration class namespace

namespace halado_prog2.Services
{
    // !!! NOTE: Accessing the database requires an instance of CryptoDbContext,
    // which is defined in the halado_prog2.DataAccess namespace.
    // Therefore, the 'using halado_prog2.DataAccess;' directive is necessary. !!!


    // Background service to periodically update cryptocurrency prices
    public class PriceUpdateBackgroundService : BackgroundService // Inheriting from BackgroundService simplifies implementation
    {
        private readonly IServiceScopeFactory _scopeFactory; // Needed to create scoped DbContext instances
        private readonly ILogger<PriceUpdateBackgroundService> _logger;
        private readonly PriceUpdateSettings _settings;
        private readonly Random _random; // For simulating random price changes

        // Constructor with dependency injection
        public PriceUpdateBackgroundService(
            IServiceScopeFactory scopeFactory,
            ILogger<PriceUpdateBackgroundService> logger,
            IOptions<PriceUpdateSettings> settings)
        {
            _scopeFactory = scopeFactory;
            _logger = logger;
            _settings = settings.Value; // Get the configuration values
            _random = new Random();
        }

        // This method is called when the service starts. It runs in the background.
        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("Price Update Background Service started.");

            // Loop indefinitely until the application is shutting down
            while (!stoppingToken.IsCancellationRequested)
            {
                _logger.LogInformation("Price Update Background Service working.");

                try
                {
                    // Create a new scope for each cycle to get a fresh DbContext
                    using (var scope = _scopeFactory.CreateScope())
                    {
                        var context = scope.ServiceProvider.GetRequiredService<CryptoDbContext>();

                        // Fetch all cryptocurrencies *including* their price history
                        // We need the latest price from the history to calculate the new price
                        var cryptos = await context.Cryptocurrencies
                             .Include(c => c.PriceHistory) // Crucial for getting the current price
                             .ToListAsync(stoppingToken);

                        foreach (var crypto in cryptos)
                        {
                            var currentPrice = crypto.CurrentPrice; // Uses the [NotMapped] getter

                            // Only simulate if current price is available (history exists)
                            if (currentPrice > 0)
                            {
                                // Simulate price change: random percentage up or down
                                var percentageChange = (_random.NextDouble() * 2 - 1) * (double)_settings.MaxPercentageChange; // Random double between -Max% and +Max%
                                var priceMultiplier = (decimal)(1 + percentageChange);
                                var newPrice = currentPrice * priceMultiplier;

                                // Ensure price doesn't go negative (optional, but good for simulation)
                                newPrice = Math.Max(0.0M, newPrice);

                                // Create a new PriceHistory entry
                                var newPriceHistory = new PriceHistory
                                {
                                    CryptoId = crypto.Id,
                                    Price = newPrice,
                                    Timestamp = DateTime.UtcNow // Log the time of the update
                                };

                                context.PriceHistory.Add(newPriceHistory);
                                _logger.LogDebug($"Updating price for {crypto.Name}: {currentPrice:N8} -> {newPrice:N8}");
                            }
                            else
                            {
                                _logger.LogWarning($"Cryptocurrency {crypto.Name} has no price history. Skipping update.");
                            }
                        }

                        // Save all the new price history entries in a single transaction
                        await context.SaveChangesAsync(stoppingToken);
                        _logger.LogInformation($"Prices updated successfully for {cryptos.Count} cryptocurrencies.");
                    } // Scope is disposed here, releasing the DbContext

                }
                catch (TaskCanceledException)
                {
                    // Task was cancelled (application is shutting down)
                    break; // Exit the loop gracefully
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error occurred in Price Update Background Service.");
                    // Optionally, wait longer after an error before trying again
                    // await Task.Delay(TimeSpan.FromMinutes(1), stoppingToken);
                }

                // Wait for the specified interval before the next update
                await Task.Delay(TimeSpan.FromSeconds(_settings.UpdateIntervalSeconds), stoppingToken);
            }

            _logger.LogInformation("Price Update Background Service stopped.");
        }


        public override Task StartAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("Price Update Background Service starting.");
            return base.StartAsync(cancellationToken);
        }

        public override Task StopAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("Price Update Background Service stopping.");
            // Cleanup can be done here if needed
            return base.StopAsync(cancellationToken);
        }
        
    }
}