// File: Controllers/PortfolioController.cs
using Microsoft.AspNetCore.Mvc;
using halado_prog2.DTOs; // Needed for WalletDto
using halado_prog2.Services; // Use the service interface

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/[controller]")] // Base route /api/portfolio
    public class PortfolioController : ControllerBase
    {
        // Inject the service interface
        private readonly IPortfolioService _portfolioService;

        public PortfolioController(IPortfolioService portfolioService)
        {
            _portfolioService = portfolioService;
        }

        [HttpGet("{userId}")]
        [ProducesResponseType(typeof(WalletDto), StatusCodes.Status200OK)] // Use WalletDto as response type
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetPortfolio(int userId)
        {
            var portfolioDto = await _portfolioService.GetPortfolioAsync(userId);

            if (portfolioDto == null)
            {
                return NotFound($"User with ID {userId} not found.");
            }

            return Ok(portfolioDto); // Return 200 OK with the portfolio data
        }
    }
}
