using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using halado_prog2.DTOs;

namespace halado_prog2.Controllers
{
    [ApiController]
    [Route("api/[controller]")] // Base route /api/wallet
    public class WalletController : ControllerBase
    {
        private readonly CryptoDbContext _context;

        public WalletController(CryptoDbContext context)
        {
            _context = context;
        }

        // GET /api/wallet/{userId}
        // Lekérdezi a felhasználó aktuális egyenlegét és kriptovalutáit.
        [HttpGet("{userId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<WalletDto>> GetWallet(int userId)
        {
            var user = await _context.Users
                .Include(u => u.CryptoWallets)
                    .ThenInclude(cw => cw.Cryptocurrency)
                .FirstOrDefaultAsync(u => u.Id == userId);

            if (user == null)
            {
                return NotFound($"User with ID {userId} not found.");
            }

            var walletDto = new WalletDto
            {
                UserId = user.Id,
                FiatBalance = user.Balance, // Get balance directly from User entity
                CryptoHoldings = user.CryptoWallets.Select(cw => new CryptoHoldingDto
                {
                    CryptoId = cw.CryptoId,
                    CryptoName = cw.Cryptocurrency.Name,
                    Quantity = cw.Quantity,
                    CurrentPrice = cw.Cryptocurrency.CurrentPrice
                }).ToList()
            };

            return Ok(walletDto);
        }

        // PUT /api/wallet/{userId}
        // Az egyenleg manuális módosítása.
        [HttpPut("{userId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UpdateBalance(int userId, [FromBody] UpdateBalanceRequestDto request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var user = await _context.Users.FindAsync(userId);

            if (user == null)
            {
                return NotFound($"User with ID {userId} not found.");
            }

            user.Balance = request.NewBalance;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_context.Users.Any(e => e.Id == userId))
                {
                    return NotFound($"User with ID {userId} not found after update attempt.");
                }
                else
                {
                    throw;
                }
            }
            return NoContent();
        }

        // DELETE /api/wallet/{userId}
        // Pénztárca törlése.
        // NOTE: In this schema, deleting a user effectively deletes their "wallet" (balance on User)
        // and crypto holdings (via cascading delete on CryptoWallet).
        // A separate wallet deletion endpoint might not be functionally distinct from user deletion
        // unless it had specific rules (e.g., clear holdings but keep user).
        // As requested, this method signature is added but its implementation is left empty.
        [HttpDelete("{userId}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)] // Assume success would return 204
        [ProducesResponseType(StatusCodes.Status404NotFound)] // Assume user not found would return 404
        public async Task<IActionResult> DeleteWallet(int userId)
        {
            // --- Implementation omitted as requested ---

            // Example placeholder return:
            // In a real scenario, you would typically fetch the user,
            // perform deletion logic (perhaps calling the user deletion logic
            // if that's the intended behavior for "wallet deletion"),
            // and return appropriate status codes (204, 404, etc.).

            // return NoContent(); // Example success return
            // return NotFound($"User with ID {userId} not found."); // Example not found return

            // Placeholder comment indicating it's not implemented
            await Task.CompletedTask; // Use Task.CompletedTask to satisfy async return type without blocking
            throw new NotImplementedException("Wallet deletion endpoint is not implemented."); // Or maybe return a 501 Not Implemented status

            // return StatusCode(StatusCodes.Status501NotImplemented); // Another option
        }
    }
}