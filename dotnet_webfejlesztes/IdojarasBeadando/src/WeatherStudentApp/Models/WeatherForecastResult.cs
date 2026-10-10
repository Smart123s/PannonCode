namespace WeatherStudentApp.Models;

public sealed class WeatherForecastResult
{
    public string CityName { get; init; } = string.Empty;
    public string Country { get; init; } = string.Empty;
    public double Latitude { get; init; }
    public double Longitude { get; init; }
    public CurrentWeather Current { get; init; } = new();
    public IReadOnlyList<DailyWeather> Daily { get; init; } = [];
}

public sealed class CurrentWeather
{
    public DateTime Time { get; init; }
    public double Temperature { get; init; }
    public double ApparentTemperature { get; init; }
    public double RelativeHumidity { get; init; }
    public double WindSpeed { get; init; }
    public int WeatherCode { get; init; }
}

public sealed class DailyWeather
{
    public DateOnly Date { get; init; }
    public double MaxTemperature { get; init; }
    public double MinTemperature { get; init; }
    public double PrecipitationProbability { get; init; }
    public int WeatherCode { get; init; }
}

public sealed class BrowserPosition
{
    public double Latitude { get; set; }
    public double Longitude { get; set; }
}
