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

            while (!stoppingToken.IsCancellationRequested)
            {
                _logger.LogInformation("Price Update Background Service working.");
                try
                {
                    using (var scope = _scopeFactory.CreateScope())
                    {
                        var context = scope.ServiceProvider.GetRequiredService<CryptoDbContext>();

                        // Fetch all cryptocurrencies. No longer strictly need Include(PriceHistory)
                        // just to get the current price.
                        var cryptos = await context.Cryptocurrencies.ToListAsync(stoppingToken);

                        var newHistoryEntries = new List<PriceHistory>();

                        foreach (var crypto in cryptos)
                        {
                            // --- Read CurrentPrice directly from the entity ---
                            var currentPrice = crypto.CurrentPrice;
                            // ---

                            // Only simulate if current price is positive
                            if (currentPrice > 0)
                            {
                                var percentageChange = (_random.NextDouble() * 2 - 1) * (double)_settings.MaxPercentageChange;
                                var priceMultiplier = (decimal)(1 + percentageChange);
                                var newPrice = currentPrice * priceMultiplier;
                                newPrice = Math.Max(0.0M, newPrice); // Ensure non-negative

                                // --- Update CurrentPrice directly on the entity ---
                                crypto.CurrentPrice = newPrice;
                                // ---

                                // --- Create the PriceHistory entry for logging ---
                                newHistoryEntries.Add(new PriceHistory
                                {
                                    CryptoId = crypto.Id,
                                    Price = newPrice, // Log the same new price
                                    Timestamp = DateTime.UtcNow
                                });
                                // ---
                                _logger.LogDebug($"Updating price for {crypto.Name}: {currentPrice:N8} -> {newPrice:N8}");
                            }
                            else
                            {
                                _logger.LogWarning($"Cryptocurrency {crypto.Name} has zero or negative price ({currentPrice}). Skipping update.");
                            }
                        }

                        // Add all new history entries to the context
                        context.PriceHistory.AddRange(newHistoryEntries);

                        // Save changes (updates Cryptocurrencies AND adds PriceHistory)
                        await context.SaveChangesAsync(stoppingToken);
                        _logger.LogInformation($"Prices updated successfully for {cryptos.Count} cryptocurrencies.");
                    }
                }
                catch (TaskCanceledException) { break; }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error occurred in Price Update Background Service.");
                }

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