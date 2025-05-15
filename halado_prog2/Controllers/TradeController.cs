// File: Controllers/TradeController.cs
using Microsoft.AspNetCore.Mvc;
using halado_prog2.DTOs;
using halado_prog2.Services;

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/[controller]")] // Base route /api/trade
    public class TradeController : ControllerBase
    {
        // Inject the service interface
        private readonly ITradeService _tradeService;
        private readonly IGiftService _giftService;

        public TradeController(ITradeService tradeService, IGiftService giftService)
        {
            _tradeService = tradeService;
            _giftService = giftService;
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

        // POST /api/trade/gift
        [HttpPost("gift")]
        [ProducesResponseType(typeof(GiftCreationResponseDto), StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status409Conflict)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> GiftCrypto([FromBody] GiftRequestDto request)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            // In a real app with authentication, SenderUserId would come from the authenticated user context
            // For now, we trust the DTO. Or add validation if SenderUserId must match an 'authenticated' user.

            var (response, errorMessage, statusCode) = await _giftService.CreateGiftAsync(request);

            if (response != null)
            {
                return CreatedAtAction(nameof(GetGiftDetails), new { giftId = response.GiftId }, response); // Assuming a GetGiftDetails endpoint
            }
            var problemDetails = new ProblemDetails { Title = "Gift Error", Detail = errorMessage, Status = statusCode };
            return StatusCode(statusCode, problemDetails);
        }

        // PUT /api/trade/accept/{giftId}/{accepted}
        [HttpPut("accept/{giftId}/{accepted}")]
        [ProducesResponseType(typeof(AcceptGiftResponseDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)] // Bad giftId or bool
        // Status403Forbidden might not be applicable anymore without explicit user check
        [ProducesResponseType(StatusCodes.Status404NotFound)] // Gift not found
        [ProducesResponseType(StatusCodes.Status409Conflict)] // Gift not pending
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> ResolveGift(int giftId, bool accepted) // Removed resolvingUserIdHeader
        {
            // No longer need to extract resolvingUserId from header

            var (response, errorMessage, statusCode) = await _giftService.ResolveGiftAsync(giftId, accepted); // Call service without resolvingUserId

            if (response != null)
            {
                return Ok(response);
            }
            var problemDetails = new ProblemDetails { Title = "Resolve Gift Error", Detail = errorMessage, Status = statusCode };
            return StatusCode(statusCode, problemDetails);
        }

        // GET /api/trade/gifts/{userId}
        [HttpGet("gifts/{userId}")]
        [ProducesResponseType(typeof(UserGiftHistoryDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetUserGiftHistory(int userId)
        {
            var (history, userFound) = await _giftService.GetUserGiftHistoryAsync(userId);
            if (!userFound)
            {
                return NotFound($"User with ID {userId} not found.");
            }
            return Ok(history);
        }

        // Placeholder for CreatedAtAction if needed
        [HttpGet("gift/{giftId}", Name = "GetGiftDetails")] // Example name for CreatedAtAction
        [ApiExplorerSettings(IgnoreApi = true)] // Hide from Swagger for now if not fully implemented
        public IActionResult GetGiftDetails(int giftId)
        {
            // In a full implementation, this would fetch details of a specific gift.
            return Ok(new { Message = $"Details for gift {giftId} would be here." });
        }
    }

}