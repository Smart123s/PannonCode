using Microsoft.AspNetCore.Mvc;
using halado_prog2.DTOs;
using halado_prog2.Services;

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/[controller]")] // Base route /api/profit
    public class ProfitController : ControllerBase
    {
        // Inject the service interface
        private readonly IProfitService _profitService;

        public ProfitController(IProfitService profitService)
        {
            _profitService = profitService;
        }

        [HttpGet("{userId}")]
        [ProducesResponseType(typeof(TotalProfitLossDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetTotalProfitLoss(int userId)
        {
            var result = await _profitService.GetTotalProfitLossAsync(userId);

            if (result == null)
            {
                return NotFound($"User with ID {userId} not found or profit/loss could not be calculated.");
            }

            return Ok(result);
        }

        [HttpGet("details/{userId}")]
        [ProducesResponseType(typeof(DetailedProfitLossDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetDetailedProfitLoss(int userId)
        {
            var result = await _profitService.GetDetailedProfitLossAsync(userId);

            if (result == null)
            {
                return NotFound($"User with ID {userId} not found or profit/loss could not be calculated.");
            }

            return Ok(result);
        }
    }
}