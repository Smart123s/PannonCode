using Microsoft.EntityFrameworkCore;
using NagyZHPractice;


/*
 * 
 * Packages:
 * Tools > NuGet Package Manager > Manage NuGet Packages for Solution
 * Microsoft.Data.SqlClient
 * Microsoft.Data.Sqlite
 * Microsoft.EntityFrameworkCore.Tools
 * Microsoft.EntityFrameworkCore.SqlServer
 * dotnet tool install --global dotnet-ef
 * 
 * 
 * Commands:
 * dotnet ef migrations add AddAddressToOwner
 * dotnet ef database update
 * 
*/

public class CarsContext : DbContext
{
    public DbSet<Car> Cars { get; set; }
    public DbSet<Owner> Owners { get; set; }
    public DbSet<Repair> Repairs { get; set; }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) 
    {
        optionsBuilder.UseSqlServer(@"Server=localhost;" +
            "Database=CarsDb;" +
            // "Trusted_Connection=True;" +
            "TrustServerCertificate=True;" +
            "User Id=sa;" +
            "Password=yourStrong(&)Password");
    }
}
