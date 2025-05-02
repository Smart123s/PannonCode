// File: Controllers/CryptosController.cs
using Microsoft.AspNetCore.Mvc;
using halado_prog2.DTOs;
using halado_prog2.Services;

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/cryptos")] // Base route
    public class CryptosController : ControllerBase
    {
        // Inject the service interface
        private readonly ICryptoService _cryptoService;
        // Inject logger if needed for controller-specific logging (optional)
        // private readonly ILogger<CryptosController> _logger;

        public CryptosController(ICryptoService cryptoService)
        {
            _cryptoService = cryptoService;
        }

        [HttpGet]
        [ProducesResponseType(typeof(IEnumerable<CryptoDto>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetCryptos()
        {
            var result = await _cryptoService.GetAllAsync();
            return Ok(result);
        }

        [HttpGet("{cryptoId}")]
        [ProducesResponseType(typeof(CryptoDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetCrypto(int cryptoId)
        {
            var result = await _cryptoService.GetByIdAsync(cryptoId);
            if (result == null)
            {
                return NotFound($"Cryptocurrency with ID {cryptoId} not found.");
            }
            return Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(typeof(CryptoDto), StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status409Conflict)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> CreateCrypto([FromBody] CreateCryptoRequestDto request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var (createdDto, errorMessage, statusCode) = await _cryptoService.CreateAsync(request);

            if (createdDto != null)
            {
                return CreatedAtAction(nameof(GetCrypto), new { cryptoId = createdDto.Id }, createdDto);
            }

            // Handle errors based on status code from service
            var problemDetails = new ProblemDetails { Title = "Creation Error", Detail = errorMessage, Status = statusCode };
            return StatusCode(statusCode, problemDetails);
        }

        [HttpDelete("{cryptoId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status409Conflict)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> DeleteCrypto(int cryptoId)
        {
            var (success, errorMessage, statusCode) = await _cryptoService.DeleteAsync(cryptoId);

            if (success)
            {
                return NoContent();
            }

            var problemDetails = new ProblemDetails { Title = "Deletion Error", Detail = errorMessage, Status = statusCode };
            return StatusCode(statusCode, problemDetails);
        }

        [HttpPut("price")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> UpdatePrice([FromBody] UpdatePriceRequestDto request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var (success, errorMessage, statusCode) = await _cryptoService.UpdatePriceAsync(request);

            if (success)
            {
                return NoContent();
            }

            var problemDetails = new ProblemDetails { Title = "Price Update Error", Detail = errorMessage, Status = statusCode };
            return StatusCode(statusCode, problemDetails);
        }

        [HttpGet("price/history/{cryptoId}")]
        [ProducesResponseType(typeof(IEnumerable<PriceHistoryDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> GetPriceHistory(int cryptoId)
        {
            var (history, errorMessage, statusCode) = await _cryptoService.GetPriceHistoryAsync(cryptoId);

            if (history != null)
            {
                return Ok(history);
            }

            var problemDetails = new ProblemDetails { Title = "Get History Error", Detail = errorMessage, Status = statusCode };
            return StatusCode(statusCode, problemDetails);
        }
    }
}