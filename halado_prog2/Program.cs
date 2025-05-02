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


var neptunCode = builder.Configuration["NeptunCode"];
if (string.IsNullOrWhiteSpace(neptunCode) || neptunCode.Equals("CHANGEME", StringComparison.OrdinalIgnoreCase))
{
    throw new InvalidOperationException("NeptunCode is not configured correctly in appsettings.json. Please set your Neptun code.");
}

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
