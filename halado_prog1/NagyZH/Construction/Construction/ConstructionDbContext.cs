using Construction.Entities;
using Microsoft.EntityFrameworkCore;

namespace Construction;

public class ConstructionDbContext : DbContext
{
    public DbSet<Contractor> Contractors { get; set; } = null!;
    public DbSet<ConstructionSite> ConstructionSites { get; set; } = null!;
    public DbSet<Contract> Contracts { get; set; } = null!;

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        //optionsBuilder.UseSqlServer("Server=localhost;Database=ConstructionDb;User ID=sa;Password=Qwe_dsa01;TrustServerCertificate=true;");
        optionsBuilder.UseSqlServer(
            @"Server=localhost;" +
            "Database=ConstructionDb;" +
            // "Trusted_Connection=True;" +
            "TrustServerCertificate=True;" +
            "User Id=sa;" +
            "Password=yourStrong(&)Password"
        );
    }
}