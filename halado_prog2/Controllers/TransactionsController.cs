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

        public TransactionsController(ITransactionService transactionService)
        {
            _transactionService = transactionService;
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
    }
}