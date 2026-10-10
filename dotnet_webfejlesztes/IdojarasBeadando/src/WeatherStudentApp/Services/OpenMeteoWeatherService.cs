using System.Net.Http.Json;
using System.Text.Json.Serialization;
using WeatherStudentApp.Models;

namespace WeatherStudentApp.Services;

public sealed class OpenMeteoWeatherService(IHttpClientFactory httpClientFactory) : IWeatherService
{
    private readonly HttpClient _client = httpClientFactory.CreateClient("OpenMeteo");

    public async Task<WeatherForecastResult?> GetForecastAsync(
        string city,
        CancellationToken cancellationToken = default)
    {
        var geoUrl = $"https://geocoding-api.open-meteo.com/v1/search?name={Uri.EscapeDataString(city)}&count=1&language=hu&format=json";
        var geo = await _client.GetFromJsonAsync<GeocodingResponse>(geoUrl, cancellationToken);
        var location = geo?.Results?.FirstOrDefault();

        if (location is null)
        {
            return null;
        }

        return await GetForecastCoreAsync(
            location.Latitude,
            location.Longitude,
            location.Name,
            location.Country ?? location.CountryCode ?? string.Empty,
            cancellationToken);
    }

    public Task<WeatherForecastResult> GetForecastAsync(
        double latitude,
        double longitude,
        string displayName,
        CancellationToken cancellationToken = default) =>
        GetForecastCoreAsync(latitude, longitude, displayName, string.Empty, cancellationToken);

    private async Task<WeatherForecastResult> GetForecastCoreAsync(
        double latitude,
        double longitude,
        string cityName,
        string country,
        CancellationToken cancellationToken)
    {
        var forecastUrl = FormattableString.Invariant(
            $"https://api.open-meteo.com/v1/forecast?latitude={latitude}&longitude={longitude}&current=temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max&timezone=auto&forecast_days=7");

        var response = await _client.GetFromJsonAsync<ForecastResponse>(forecastUrl, cancellationToken)
            ?? throw new HttpRequestException("Az Open-Meteo üres választ adott.");

        var current = response.Current ?? new CurrentResponse();
        var daily = response.Daily ?? new DailyResponse();
        var dayCount = new[]
        {
            daily.Time.Count,
            daily.WeatherCode.Count,
            daily.Temperature2MMax.Count,
            daily.Temperature2MMin.Count,
            daily.PrecipitationProbabilityMax.Count
        }.Min();

        var days = new List<DailyWeather>(dayCount);
        for (var i = 0; i < dayCount; i++)
        {
            if (!DateOnly.TryParse(daily.Time[i], out var date))
            {
                continue;
            }

            days.Add(new DailyWeather
            {
                Date = date,
                WeatherCode = daily.WeatherCode[i],
                MaxTemperature = daily.Temperature2MMax[i],
                MinTemperature = daily.Temperature2MMin[i],
                PrecipitationProbability = daily.PrecipitationProbabilityMax[i]
            });
        }

        DateTime.TryParse(current.Time, out var currentTime);

        return new WeatherForecastResult
        {
            CityName = cityName,
            Country = country,
            Latitude = latitude,
            Longitude = longitude,
            Current = new CurrentWeather
            {
                Time = currentTime,
                Temperature = current.Temperature2M,
                ApparentTemperature = current.ApparentTemperature,
                RelativeHumidity = current.RelativeHumidity2M,
                WindSpeed = current.WindSpeed10M,
                WeatherCode = current.WeatherCode
            },
            Daily = days
        };
    }

    private sealed class GeocodingResponse
    {
        [JsonPropertyName("results")]
        public List<GeocodingLocation>? Results { get; set; }
    }

    private sealed class GeocodingLocation
    {
        [JsonPropertyName("name")]
        public string Name { get; set; } = string.Empty;

        [JsonPropertyName("latitude")]
        public double Latitude { get; set; }

        [JsonPropertyName("longitude")]
        public double Longitude { get; set; }

        [JsonPropertyName("country")]
        public string? Country { get; set; }

        [JsonPropertyName("country_code")]
        public string? CountryCode { get; set; }
    }

    private sealed class ForecastResponse
    {
        [JsonPropertyName("current")]
        public CurrentResponse? Current { get; set; }

        [JsonPropertyName("daily")]
        public DailyResponse? Daily { get; set; }
    }

    private sealed class CurrentResponse
    {
        [JsonPropertyName("time")]
        public string Time { get; set; } = string.Empty;

        [JsonPropertyName("temperature_2m")]
        public double Temperature2M { get; set; }

        [JsonPropertyName("relative_humidity_2m")]
        public double RelativeHumidity2M { get; set; }

        [JsonPropertyName("apparent_temperature")]
        public double ApparentTemperature { get; set; }

        [JsonPropertyName("weather_code")]
        public int WeatherCode { get; set; }

        [JsonPropertyName("wind_speed_10m")]
        public double WindSpeed10M { get; set; }
    }

    private sealed class DailyResponse
    {
        [JsonPropertyName("time")]
        public List<string> Time { get; set; } = [];

        [JsonPropertyName("weather_code")]
        public List<int> WeatherCode { get; set; } = [];

        [JsonPropertyName("temperature_2m_max")]
        public List<double> Temperature2MMax { get; set; } = [];

        [JsonPropertyName("temperature_2m_min")]
        public List<double> Temperature2MMin { get; set; } = [];

        [JsonPropertyName("precipitation_probability_max")]
        public List<double> PrecipitationProbabilityMax { get; set; } = [];
    }
}
