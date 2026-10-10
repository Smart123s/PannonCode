using System.Text.Json;
using Microsoft.JSInterop;
using WeatherStudentApp.Models;

namespace WeatherStudentApp.Services;

public sealed class FavoriteCityState(IJSRuntime js)
{
    private const string StorageKey = "weather-student-app:favorites";
    private readonly List<FavoriteCity> _items = [];
    private bool _initialized;

    public IReadOnlyList<FavoriteCity> Items => _items;

    public event Action? Changed;

    public async Task InitializeAsync()
    {
        if (_initialized)
        {
            return;
        }

        _initialized = true;

        try
        {
            var json = await js.InvokeAsync<string?>("weatherInterop.loadFavorites", StorageKey);
            if (!string.IsNullOrWhiteSpace(json))
            {
                var stored = JsonSerializer.Deserialize<List<FavoriteCity>>(json);
                if (stored is not null)
                {
                    _items.Clear();
                    _items.AddRange(stored);
                }
            }
        }
        catch (JSException)
        {
            // Az alkalmazás localStorage nélkül is működőképes marad.
        }

        Changed?.Invoke();
    }

    public async Task CreateAsync(FavoriteCity city)
    {
        if (_items.Any(x => string.Equals(x.Name, city.Name, StringComparison.OrdinalIgnoreCase)))
        {
            return;
        }

        if (city.Id == Guid.Empty)
        {
            city.Id = Guid.NewGuid();
        }

        if (string.IsNullOrWhiteSpace(city.Nickname))
        {
            city.Nickname = city.Name;
        }

        _items.Add(city.Copy());
        await PersistAsync();
    }

    public async Task UpdateAsync(FavoriteCity updated)
    {
        var index = _items.FindIndex(x => x.Id == updated.Id);
        if (index < 0)
        {
            return;
        }

        _items[index] = updated.Copy();
        await PersistAsync();
    }

    public async Task DeleteAsync(Guid id)
    {
        var removed = _items.RemoveAll(x => x.Id == id) > 0;
        if (removed)
        {
            await PersistAsync();
        }
    }

    private async Task PersistAsync()
    {
        Changed?.Invoke();

        try
        {
            var json = JsonSerializer.Serialize(_items);
            await js.InvokeVoidAsync("weatherInterop.saveFavorites", StorageKey, json);
        }
        catch (JSException)
        {
            // A scoped, memóriabeli állapot ettől még megmarad a circuit élettartamáig.
        }
    }
}
