using System.ComponentModel.DataAnnotations;

namespace WeatherStudentApp.Models;

public sealed class FavoriteCity
{
    public Guid Id { get; set; } = Guid.NewGuid();

    [Required]
    public string Name { get; set; } = string.Empty;

    public string Country { get; set; } = string.Empty;

    public double Latitude { get; set; }

    public double Longitude { get; set; }

    [Required(ErrorMessage = "A megjelenített név kötelező.")]
    [StringLength(40, MinimumLength = 2, ErrorMessage = "A név 2 és 40 karakter közötti lehet.")]
    public string Nickname { get; set; } = string.Empty;

    [StringLength(200, ErrorMessage = "A megjegyzés legfeljebb 200 karakter lehet.")]
    public string Notes { get; set; } = string.Empty;

    public bool IsPinned { get; set; }

    public FavoriteCity Copy() => new()
    {
        Id = Id,
        Name = Name,
        Country = Country,
        Latitude = Latitude,
        Longitude = Longitude,
        Nickname = Nickname,
        Notes = Notes,
        IsPinned = IsPinned
    };
}
