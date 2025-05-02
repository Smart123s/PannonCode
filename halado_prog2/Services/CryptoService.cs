// File: Services/CryptoService.cs
using Microsoft.EntityFrameworkCore;
using halado_prog2.Entities;
using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public class CryptoService : ICryptoService
    {
        private readonly CryptoDbContext _context;
        private readonly ILogger<CryptoService> _logger;

        public CryptoService(CryptoDbContext context, ILogger<CryptoService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task<IEnumerable<CryptoDto>> GetAllAsync()
        {
            // Reads CurrentPrice directly from the stored column
            return await _context.Cryptocurrencies
                .Select(c => new CryptoDto
                {
                    Id = c.Id,
                    Name = c.Name,
                    CurrentPrice = c.CurrentPrice
                })
                .ToListAsync();
        }

        public async Task<CryptoDto?> GetByIdAsync(int cryptoId)
        {
            var crypto = await _context.Cryptocurrencies
                                       .AsNoTracking() // Use AsNoTracking for read-only queries
                                       .FirstOrDefaultAsync(c => c.Id == cryptoId);

            if (crypto == null) return null;

            return new CryptoDto
            {
                Id = crypto.Id,
                Name = crypto.Name,
                CurrentPrice = crypto.CurrentPrice
            };
        }

        public async Task<(CryptoDto? CreatedCrypto, string? ErrorMessage, int StatusCode)> CreateAsync(CreateCryptoRequestDto request)
        {
            // Check for name uniqueness
            if (await _context.Cryptocurrencies.AnyAsync(c => c.Name == request.Name))
            {
                return (null, $"Cryptocurrency '{request.Name}' already exists.", StatusCodes.Status409Conflict);
            }

            var newCrypto = new Cryptocurrency
            {
                Name = request.Name,
                CurrentPrice = request.InitialPrice // Set the initial price directly
            };

            var initialPriceHistory = new PriceHistory
            {
                // Relationship will link CryptoId on save
                Price = request.InitialPrice,
                Timestamp = DateTime.UtcNow
            };
            // Associate the history entry with the new crypto
            newCrypto.PriceHistory = new List<PriceHistory> { initialPriceHistory };

            _context.Cryptocurrencies.Add(newCrypto);

            try
            {
                await _context.SaveChangesAsync();
                _logger.LogInformation("Cryptocurrency {CryptoName} created with ID {CryptoId}", newCrypto.Name, newCrypto.Id);
            }
            catch (DbUpdateException ex)
            {
                _logger.LogError(ex, "Database error creating cryptocurrency {CryptoName}", request.Name);
                return (null, "Database error occurred.", StatusCodes.Status500InternalServerError);
            }

            var createdDto = new CryptoDto
            {
                Id = newCrypto.Id,
                Name = newCrypto.Name,
                CurrentPrice = newCrypto.CurrentPrice
            };

            return (createdDto, null, StatusCodes.Status201Created);
        }

        public async Task<(bool Success, string? ErrorMessage, int StatusCode)> DeleteAsync(int cryptoId)
        {
            var cryptoToDelete = await _context.Cryptocurrencies.FindAsync(cryptoId);

            if (cryptoToDelete == null)
            {
                return (false, $"Cryptocurrency with ID {cryptoId} not found.", StatusCodes.Status404NotFound);
            }

            _context.Cryptocurrencies.Remove(cryptoToDelete);

            try
            {
                // Relying on cascading delete for PriceHistory and CryptoWallets
                await _context.SaveChangesAsync();
                _logger.LogInformation("Deleted cryptocurrency with ID {CryptoId}", cryptoId);
                return (true, null, StatusCodes.Status204NoContent);
            }
            catch (DbUpdateException ex) // Catches potential FK constraint violations if cascade fails
            {
                _logger.LogError(ex, "Database error deleting cryptocurrency ID {CryptoId}. Check dependencies.", cryptoId);
                // Check for specific SQL Server error numbers if needed, e.g., 547 for FK violation
                return (false, "Cannot delete cryptocurrency, it might be in use (e.g., in transactions or held by users).", StatusCodes.Status409Conflict);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error deleting cryptocurrency ID {CryptoId}", cryptoId);
                return (false, "An unexpected error occurred during deletion.", StatusCodes.Status500InternalServerError);
            }
        }

        public async Task<(bool Success, string? ErrorMessage, int StatusCode)> UpdatePriceAsync(UpdatePriceRequestDto request)
        {
            var cryptoToUpdate = await _context.Cryptocurrencies
                                      .FirstOrDefaultAsync(c => c.Id == request.CryptoId);

            if (cryptoToUpdate == null)
            {
                return (false, $"Cryptocurrency with ID {request.CryptoId} not found.", StatusCodes.Status404NotFound);
            }

            // Update the stored CurrentPrice
            cryptoToUpdate.CurrentPrice = request.NewPrice;

            // Add a history entry
            var newPriceHistory = new PriceHistory
            {
                CryptoId = request.CryptoId,
                Price = request.NewPrice,
                Timestamp = DateTime.UtcNow
            };
            _context.PriceHistory.Add(newPriceHistory);

            try
            {
                await _context.SaveChangesAsync();
                _logger.LogInformation("Updated price for cryptocurrency ID {CryptoId} to {NewPrice}", request.CryptoId, request.NewPrice);
                return (true, null, StatusCodes.Status204NoContent);
            }
            catch (DbUpdateException ex)
            {
                _logger.LogError(ex, "Database error updating price for CryptoId {CryptoId}", request.CryptoId);
                return (false, "Database error occurred saving price update.", StatusCodes.Status500InternalServerError);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error updating price for CryptoId {CryptoId}", request.CryptoId);
                return (false, "An unexpected error occurred during price update.", StatusCodes.Status500InternalServerError);
            }
        }

        public async Task<(IEnumerable<PriceHistoryDto>? History, string? ErrorMessage, int StatusCode)> GetPriceHistoryAsync(int cryptoId)
        {
            // Check if crypto exists first
            if (!await _context.Cryptocurrencies.AnyAsync(c => c.Id == cryptoId))
            {
                return (null, $"Cryptocurrency with ID {cryptoId} not found.", StatusCodes.Status404NotFound);
            }

            var history = await _context.PriceHistory
                .Where(ph => ph.CryptoId == cryptoId)
                .OrderBy(ph => ph.Timestamp)
                .Select(ph => new PriceHistoryDto
                {
                    Id = ph.Id,
                    Price = ph.Price,
                    Timestamp = ph.Timestamp
                })
                .ToListAsync();

            return (history, null, StatusCodes.Status200OK);
        }
    }
}
