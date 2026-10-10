using System.ComponentModel.DataAnnotations;

namespace WeatherStudentApp.Models;

public sealed class CitySearchInput
{
    [Required(ErrorMessage = "A város neve kötelező.")]
    [StringLength(80, MinimumLength = 2, ErrorMessage = "A város neve 2 és 80 karakter közötti lehet.")]
    public string City { get; set; } = string.Empty;
}
