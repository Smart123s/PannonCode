using halado_prog2;
using halado_prog2.Configuration;
using halado_prog2.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


// Load Neptun code from neptun.txt
// I didn't want to commit this to git
// Yes, I've heard of appsettings.json...
string neptunCode = NeptunCodeLoader.LoadNeptunCodeFromFile("neptun.txt");

builder.Services.AddDbContext<CryptoDbContext>(options =>
options.UseSqlServer(@"Server=localhost;" +
                $"Database=CryptoDb_{neptunCode};" +
                // "Trusted_Connection=True;" +
                "TrustServerCertificate=True;" +
                "User Id=sa;" +
                "Password=yourStrong(&)Password"));

// Configure the Price Update Settings
builder.Services.Configure<PriceUpdateSettings>(builder.Configuration.GetSection(PriceUpdateSettings.SectionName));
builder.Services.AddHostedService<PriceUpdateBackgroundService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseAuthorization();

app.MapControllers();

app.Run();
