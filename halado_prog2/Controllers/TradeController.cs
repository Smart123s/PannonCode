// File: Controllers/TradeController.cs
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using halado_prog2.DTOs;
using halado_prog2.Services; // Use the service interface

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/[controller]")] // Base route /api/trade
    public class TradeController : ControllerBase
    {
        // Inject the service interface
        private readonly ITradeService _tradeService;

        public TradeController(ITradeService tradeService)
        {
            _tradeService = tradeService;
        }

        [HttpPost("buy")]
        [ProducesResponseType(typeof(TradeResponseDto), StatusCodes.Status200OK)] // Success
        [ProducesResponseType(StatusCodes.Status404NotFound)] // User or Crypto not found
        [ProducesResponseType(StatusCodes.Status409Conflict)] // Insufficient funds or concurrency issue
        [ProducesResponseType(StatusCodes.Status400BadRequest)] // Validation errors or zero price
        [ProducesResponseType(StatusCodes.Status500InternalServerError)] // Other errors
        public async Task<IActionResult> BuyCrypto([FromBody] TradeRequestDto request)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            var (tradeConfirmation, errorMessage, statusCode) = await _tradeService.BuyCryptoAsync(request);

            if (tradeConfirmation != null)
            {
                return Ok(tradeConfirmation);
            }
            var problemDetails = new ProblemDetails { Title = "Buy Error", Detail = errorMessage, Status = statusCode };
            return StatusCode(statusCode, problemDetails);
        }

        [HttpPost("sell")]
        [ProducesResponseType(typeof(TradeResponseDto), StatusCodes.Status200OK)] // Success
        [ProducesResponseType(StatusCodes.Status404NotFound)] // User or Crypto not found
        [ProducesResponseType(StatusCodes.Status409Conflict)] // Insufficient holdings or concurrency issue
        [ProducesResponseType(StatusCodes.Status400BadRequest)] // Validation errors or zero price
        [ProducesResponseType(StatusCodes.Status500InternalServerError)] // Other errors
        public async Task<IActionResult> SellCrypto([FromBody] TradeRequestDto request)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            var (tradeConfirmation, errorMessage, statusCode) = await _tradeService.SellCryptoAsync(request);

            if (tradeConfirmation != null)
            {
                return Ok(tradeConfirmation);
            }
            var problemDetails = new ProblemDetails { Title = "Sell Error", Detail = errorMessage, Status = statusCode };
            return StatusCode(statusCode, problemDetails);
        }
    }

}