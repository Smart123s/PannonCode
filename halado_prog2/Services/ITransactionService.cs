using halado_prog2.DTOs;

namespace halado_prog2.Services
{
    public interface ITransactionService
    {
        // Returns null if user not found, otherwise list of transactions (can be empty)
        Task<(IEnumerable<TransactionDto>? Transactions, bool UserFound)> GetUserTransactionsAsync(int userId);

        // Returns null if transaction not found
        Task<TransactionDto?> GetTransactionDetailsAsync(int transactionId);
    }
}