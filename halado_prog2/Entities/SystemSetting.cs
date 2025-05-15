// File: Entities/SystemSetting.cs
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace halado_prog2.Entities
{
    public class SystemSetting
    {
        [Key] // Use a non-auto-incrementing key if you only have one row (e.g., for the fee)
        // Or a simple auto-incrementing ID if you plan more settings
        [MaxLength(50)] // Max length for the setting key
        public string SettingKey { get; set; }

        [Required]
        [Column(TypeName = "decimal(5, 4)")] // e.g., to store 0.0020 for 0.2% (Precision 5, Scale 4)
        public decimal SettingValue { get; set; }

        public DateTime LastModified { get; set; }
    }
}