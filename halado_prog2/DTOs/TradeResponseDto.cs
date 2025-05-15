// File: DTOs/TradeResponseDto.cs
using System; // For DateTime

namespace halado_prog2.DTOs
{
    public class TradeResponseDto
    {
        public int TransactionId { get; set; }
        public int UserId { get; set; }
        public int CryptoId { get; set; }
        public decimal Amount { get; set; } // Gross amount (Quantity * PriceAtTrade)
        public decimal Fee { get; set; } // FeeAmount
        public decimal TotalAmount { get; set; } // Net amount (Amount - Fee for buy, Amount + Fee for sell if fee is added, or just Amount if fee is from the crypto side)
                                                 // Let's clarify: "levonásra kerül a végső tranzakciós összegből"
                                                 // For BUY: User pays GrossAmount + Fee. Fiat debited: GrossAmount + Fee.
                                                 // For SELL: User receives GrossAmount - Fee. Fiat credited: GrossAmount - Fee.
                                                 // Here, let TotalAmount be the fiat change for the user.
                                                 // For BUY: -(Quantity * PriceAtTrade + Fee)
                                                 // For SELL: Quantity * PriceAtTrade - Fee
                                                 // OR more simply, TotalAmount = the net fiat credited/debited.
                                                 // Let's define TotalAmount as the actual fiat change to user's balance.
                                                 // For BUY: Amount = Quantity * PriceAtTrade, FeeAmount = Fee, TotalAmount_UserPays = Amount + FeeAmount
                                                 // For SELL: Amount = Quantity * PriceAtTrade, FeeAmount = Fee, TotalAmount_UserReceives = Amount - FeeAmount
                                                 // The spec seems to imply:
                                                 // amount = Quantity * PriceAtTrade (the "value" of crypto traded)
                                                 // fee = the calculated fee
                                                 // totalAmount = what the user actually paid/received in fiat
                                                 // So, for BUY, totalAmount = amount + fee. For SELL, totalAmount = amount - fee.
                                                 // The DTO field names are a bit ambiguous. Let's use what spec says.
        public DateTime Timestamp { get; set; }

        // Additional fields for clarity
        public string TransactionType { get; set; } // "Buy" or "Sell"
        public decimal Quantity { get; set; }
        public decimal PriceAtTrade { get; set; }
    }
}