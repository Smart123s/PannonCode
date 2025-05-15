// File: DTOs/TransactionFeeSummaryDto.cs
using System.Collections.Generic;

namespace halado_prog2.DTOs
{
    public class TransactionFeeSummaryDto
    {
        public int UserId { get; set; }
        public decimal TotalFeesPaid { get; set; }
        public List<DailyFeeSummaryDto> DailySummaries { get; set; } = new List<DailyFeeSummaryDto>();
        public List<IndividualFeeDetailDto> IndividualFeeDetails { get; set; } = new List<IndividualFeeDetailDto>();
    }

    public class DailyFeeSummaryDto
    {
        public DateTime Date { get; set; }
        public decimal TotalFeesForDay { get; set; }
    }

    public class IndividualFeeDetailDto
    {
        public int TransactionId { get; set; }
        public string CryptoName { get; set; }
        public string TransactionType { get; set; }
        public decimal FeeAmount { get; set; }
        public DateTime Timestamp { get; set; }
    }
}