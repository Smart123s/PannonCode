# WeatherLab – Blazor Web App beadandó (.NET 10)

Ez a megoldás egy 5-ös szintű **időjárás-előrejelző** alkalmazás, amelybe az alacsonyabb nehézségi szintek technikái is be vannak építve. A projekt célja, hogy egyetlen koherens alkalmazáson belül demonstrálja a kurzus fő Blazor témáit.

## Funkciók

- Város keresése név alapján.
- Aktuális időjárás és 7 napos előrejelzés az Open-Meteo API-ból.
- Böngészős helymeghatározás JavaScript interoppal.
- Kedvenc városok kezelése: Create / Read / Update / Delete.
- Kedvencek megőrzése navigációk között scoped service segítségével.
- Kedvencek perzisztálása böngésző `localStorage`-ba JavaScript interoppal.
- Validált Blazor űrlapok DataAnnotations használatával.
- Külön gyermekkomponensek és `EventCallback` alapú kommunikáció.
- Razor Class Library (`WeatherStudentApp.Ui`) a megosztható UI-komponensekhez.
- Generikus templated komponens (`TemplatedList<TItem>`) `RenderFragment<TItem>` sablonnal.
- Több útvonal: `/`, `/weather`, `/favorites`, `/about`.

## Követelmény -> megvalósítás

| Kurzus téma | Hol található? |
|---|---|
| Kétirányú adatközlés | `CitySearchForm.razor`, `FavoriteEditor.razor` – `@bind-Value` |
| Űrlap és validáció | `EditForm`, `DataAnnotationsValidator`, `ValidationMessage` |
| Eseményvisszahívás | `OnSearch`, `OnUseLocation`, `OnSaved`, `OnCanceled` (`EventCallback`) |
| Routing | `/weather`, `/favorites`, `/about` |
| Scoped állapot | `FavoriteCityState` |
| CRUD | Kedvencek létrehozása, listázása, szerkesztése, törlése |
| JS interop | `weatherInterop.js` – geolocation + localStorage |
| RCL | `WeatherStudentApp.Ui` projekt |
| Templated component | `TemplatedList.razor` |
| Külső API | `OpenMeteoWeatherService` |

## Projektstruktúra

```text
WeatherStudentApp.sln
src/
  WeatherStudentApp/              # Blazor Web App
    Components/
      Pages/
        Home.razor
        Weather.razor
        Favorites.razor
        About.razor
      CitySearchForm.razor
      FavoriteEditor.razor
    Models/
    Services/
      IWeatherService.cs
      OpenMeteoWeatherService.cs
      FavoriteCityState.cs
    wwwroot/
      css/app.css
      js/weatherInterop.js

  WeatherStudentApp.Ui/           # Razor Class Library
    Components/
      WeatherCard.razor
      TemplatedList.razor
    wwwroot/weather-ui.css
```

## Futtatás

Előfeltétel: **.NET 10 SDK** vagy újabb, amely képes `net10.0` projektet fordítani.

A solution gyökeréből:

```bash
dotnet restore WeatherStudentApp.sln
dotnet build WeatherStudentApp.sln
dotnet run --project src/WeatherStudentApp/WeatherStudentApp.csproj
```

Ezután a konzolban megjelenő HTTPS címet kell megnyitni. A `launchSettings.json` alapján fejlesztői környezetben tipikusan:

```text
https://localhost:7188
```

## API

A projekt az Open-Meteo szolgáltatást használja:

- Geocoding: városnév -> koordináta
- Forecast: koordináta -> aktuális időjárás + 7 napos előrejelzés

A demonstrációhoz **nem szükséges API-kulcs**.

## Bemutatási forgatókönyv

1. Nyisd meg a `/weather` oldalt.
2. Keress rá például „Budapest” városra – ezzel látszik az `EditForm`, validáció, `@bind` és EventCallback.
3. Mutasd meg az aktuális és 7 napos előrejelzést – az utóbbi a generikus `TemplatedList<TItem>` RCL komponenssel készül.
4. Kattints a „Kedvencekhez adás” gombra – Create.
5. Navigálj a `/favorites` oldalra – Read + scoped state.
6. Szerkeszd a becenevet vagy a megjegyzést – Update + validált űrlap.
7. Törölj egy kedvencet – Delete.
8. Frissítsd a böngészőt – a kedvencek localStorage-ból visszatöltődnek.
9. Az Időjárás oldalon kattints a „Saját helyzet” gombra – JS interop + Geolocation API.
10. Az `/about` oldalon egy helyen látható a technológiák összefoglalása.

## Megjegyzés beadáshoz

A forráskód oktatási célú. Érdemes a beadás előtt a saját kurzus szerinti névkonvenciókat, solution-nevet és esetleges formai elvárásokat hozzáigazítani.
