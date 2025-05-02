using Microsoft.Extensions.Options;
using halado_prog2.Entities;
using halado_prog2.Configuration;
using Microsoft.EntityFrameworkCore;

namespace halado_prog2.Services
{
    public class PriceUpdateBackgroundService : BackgroundService
    {
        private readonly IServiceScopeFactory _scopeFactory;
        private readonly ILogger<PriceUpdateBackgroundService> _logger;
        private readonly PriceUpdateSettings _settings;
        private readonly Random _random;
        public PriceUpdateBackgroundService(
            IServiceScopeFactory scopeFactory,
            ILogger<PriceUpdateBackgroundService> logger,
            IOptions<PriceUpdateSettings> settings)
        {
            _scopeFactory = scopeFactory;
            _logger = logger;
            _settings = settings.Value;
            _random = new Random();
        }
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
                        var cryptos = await context.Cryptocurrencies.ToListAsync(stoppingToken);

                        var newHistoryEntries = new List<PriceHistory>();

                        foreach (var crypto in cryptos)
                        {
                            var currentPrice = crypto.CurrentPrice;
                            if (currentPrice > 0)
                            {
                                var percentageChange = (_random.NextDouble() * 2 - 1) * (double)_settings.MaxPercentageChange;
                                var priceMultiplier = (decimal)(1 + percentageChange);
                                var newPrice = currentPrice * priceMultiplier;
                                newPrice = Math.Max(0.0M, newPrice);
                                crypto.CurrentPrice = newPrice;
                                newHistoryEntries.Add(new PriceHistory
                                {
                                    CryptoId = crypto.Id,
                                    Price = newPrice,
                                    Timestamp = DateTime.UtcNow
                                });
                                _logger.LogDebug($"Updating price for {crypto.Name}: {currentPrice:N8} -> {newPrice:N8}");
                            }
                            else
                            {
                                _logger.LogWarning($"Cryptocurrency {crypto.Name} has zero or negative price ({currentPrice}). Skipping update.");
                            }
                        }
                        context.PriceHistory.AddRange(newHistoryEntries);
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
            return base.StopAsync(cancellationToken);
        }
        
    }
}