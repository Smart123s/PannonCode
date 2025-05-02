using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using halado_prog2.Entities;
using halado_prog2.DTOs;

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/cryptos")] // Base route /api/cryptos
    public class CryptosController : ControllerBase
    {
        private readonly CryptoDbContext _context;

        public CryptosController(CryptoDbContext context)
        {
            _context = context;
        }

        // GET /api/cryptos
        // Listázza az összes elérhető kriptovalutát és azok aktuális árfolyamát.
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<IEnumerable<CryptoDto>>> GetCryptos()
        {
            // Fetch all cryptocurrencies, INCLUDING PriceHistory
            var cryptos = await _context.Cryptocurrencies
                .Include(c => c.PriceHistory)
                .ToListAsync();

            // Map to DTOs
            var cryptoDtos = cryptos.Select(c => new CryptoDto
            {
                Id = c.Id,
                Name = c.Name,
                CurrentPrice = c.CurrentPrice
            }).ToList();

            return Ok(cryptoDtos);
        }

        // GET /api/cryptos/{cryptoId}
        // Egy adott kriptovaluta lekérdezése.
        [HttpGet("{cryptoId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<CryptoDto>> GetCrypto(int cryptoId)
        {
            // Find the cryptocurrency, INCLUDING PriceHistory
            var crypto = await _context.Cryptocurrencies
                .Include(c => c.PriceHistory)
                .FirstOrDefaultAsync(c => c.Id == cryptoId);

            if (crypto == null)
            {
                return NotFound($"Cryptocurrency with ID {cryptoId} not found.");
            }

            // Map to DTO
            var cryptoDto = new CryptoDto
            {
                Id = crypto.Id,
                Name = crypto.Name,
                CurrentPrice = crypto.CurrentPrice
            };

            return Ok(cryptoDto);
        }

        // POST /api/cryptos
        // Új kriptovaluta hozzáadása.
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status409Conflict)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> CreateCrypto([FromBody] CreateCryptoRequestDto request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Check for name uniqueness
            var existingCrypto = await _context.Cryptocurrencies.FirstOrDefaultAsync(c => c.Name == request.Name);
            if (existingCrypto != null)
            {
                return Conflict(new ProblemDetails
                {
                    Title = "Cryptocurrency already exists",
                    Detail = $"A cryptocurrency with the name '{request.Name}' already exists.",
                    Status = StatusCodes.Status409Conflict,
                    Instance = HttpContext.Request.Path
                });
            }

            var newCrypto = new Cryptocurrency
            {
                Name = request.Name,
            };

            // Add the new crypto and its initial price history
            _context.Cryptocurrencies.Add(newCrypto);

            var initialPriceHistory = new PriceHistory
            {
                Price = request.InitialPrice,
                Timestamp = DateTime.UtcNow
            };
            newCrypto.PriceHistory = new List<PriceHistory> { initialPriceHistory };


            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException dbEx)
            {
                Console.Error.WriteLine($"Database error adding crypto: {dbEx}");
                return StatusCode(StatusCodes.Status500InternalServerError, "An error occurred while saving the new cryptocurrency.");
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"Unexpected error adding crypto: {ex}");
                return StatusCode(StatusCodes.Status500InternalServerError, "An unexpected error occurred.");
            }


            // Prepare the response DTO (CurrentPrice works because PriceHistory was added and is loaded)
            var cryptoDto = new CryptoDto
            {
                Id = newCrypto.Id,
                Name = newCrypto.Name,
                CurrentPrice = newCrypto.CurrentPrice
            };

            // Return 201 Created, pointing to the GET endpoint
            return CreatedAtAction(nameof(GetCrypto), new { cryptoId = newCrypto.Id }, cryptoDto);
        }

        // DELETE /api/cryptos/{cryptoId}
        // Kriptovaluta törlése.
        [HttpDelete("{cryptoId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> DeleteCrypto(int cryptoId)
        {
            var cryptoToDelete = await _context.Cryptocurrencies.FindAsync(cryptoId);

            if (cryptoToDelete == null)
            {
                return NotFound($"Cryptocurrency with ID {cryptoId} not found.");
            }

            _context.Cryptocurrencies.Remove(cryptoToDelete);

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException dbEx)
            {
                Console.Error.WriteLine($"Database error deleting crypto (check for related records): {dbEx}");
                return StatusCode(StatusCodes.Status409Conflict, "Cannot delete cryptocurrency because it is referenced by other records (e.g., transactions, user holdings).");
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"Unexpected error deleting crypto: {ex}");
                return StatusCode(StatusCodes.Status500InternalServerError, "An unexpected error occurred during deletion.");
            }

            return NoContent(); // 204 No Content
        }


        // PUT /api/cryptos/price
        [HttpPut("price")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UpdatePrice([FromBody] UpdatePriceRequestDto request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var cryptoToUpdate = await _context.Cryptocurrencies
                                       .FirstOrDefaultAsync(c => c.Id == request.CryptoId);

            if (cryptoToUpdate == null)
            {
                return NotFound($"Cryptocurrency with ID {request.CryptoId} not found.");
            }

            cryptoToUpdate.CurrentPrice = request.NewPrice;

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
            }
            catch (DbUpdateException dbEx)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, "An error occurred while saving the price update.");
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, "An unexpected error occurred.");
            }

            return NoContent(); // 204 No Content
        }

        // GET /api/cryptos/price/history/{cryptoId}
        // Árfolyamváltozási naplózás lekérdezése.
        [HttpGet("price/history/{cryptoId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<IEnumerable<PriceHistoryDto>>> GetPriceHistory(int cryptoId)
        {
            // Validate that the cryptocurrency exists
            var cryptoExists = await _context.Cryptocurrencies.AnyAsync(c => c.Id == cryptoId);
            if (!cryptoExists)
            {
                return NotFound($"Cryptocurrency with ID {cryptoId} not found.");
            }

            // Fetch the price history for the specific crypto
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

            return Ok(history);
        }
    }
}