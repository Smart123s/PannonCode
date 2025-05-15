using Microsoft.AspNetCore.Mvc;
using halado_prog2.DTOs;
using halado_prog2.Services;

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/[controller]")] // Base route /api/transactions
    public class TransactionsController : ControllerBase
    {
        // Inject the service interface
        private readonly ITransactionService _transactionService;
        private readonly ITransactionFeeService _feeService;

        public TransactionsController(ITransactionService transactionService, ITransactionFeeService feeService)
        {
            _transactionService = transactionService;
            _feeService = feeService;
        }

        [HttpGet("{userId}")]
        [ProducesResponseType(typeof(IEnumerable<TransactionDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetUserTransactions(int userId)
        {
            var (transactions, userFound) = await _transactionService.GetUserTransactionsAsync(userId);

            if (!userFound)
            {
                return NotFound($"User with ID {userId} not found.");
            }

            // If user found, return transactions (which might be an empty list)
            return Ok(transactions);
        }

        [HttpGet("details/{transactionId}")]
        [ProducesResponseType(typeof(TransactionDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetTransactionDetails(int transactionId)
        {
            var transactionDto = await _transactionService.GetTransactionDetailsAsync(transactionId);

            if (transactionDto == null)
            {
                return NotFound($"Transaction with ID {transactionId} not found.");
            }

            return Ok(transactionDto);
        }

        // GET /api/transactions/fees/{userId}
        [HttpGet("fees/{userId}")]
        [ProducesResponseType(typeof(TransactionFeeSummaryDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetTransactionFeeSummary(int userId)
        {
            var (summary, userFound) = await _feeService.GetFeeSummaryAsync(userId);
            if (!userFound)
            {
                return NotFound($"User with ID {userId} not found.");
            }
            return Ok(summary); // summary will contain TotalFeesPaid = 0 if user has no fee transactions
        }

        // PUT /api/transactions/fees
        [HttpPut("fees")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<IActionResult> UpdateTransactionFeeRate([FromBody] UpdateFeeRateRequestDto request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var (success, errorMessage) = await _feeService.UpdateFeeRateAsync(request.NewFee);
            if (success)
            {
                return NoContent();
            }
            return StatusCode(StatusCodes.Status500InternalServerError, errorMessage ?? "Failed to update fee rate.");
        }
    }
}