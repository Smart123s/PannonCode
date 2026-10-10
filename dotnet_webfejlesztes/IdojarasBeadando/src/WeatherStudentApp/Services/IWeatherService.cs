using WeatherStudentApp.Models;

namespace WeatherStudentApp.Services;

public interface IWeatherService
{
    Task<WeatherForecastResult?> GetForecastAsync(string city, CancellationToken cancellationToken = default);

    Task<WeatherForecastResult> GetForecastAsync(
        double latitude,
        double longitude,
        string displayName,
        CancellationToken cancellationToken = default);
}
