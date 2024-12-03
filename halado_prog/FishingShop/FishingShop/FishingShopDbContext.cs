using FishingShop.Entities;
using Microsoft.EntityFrameworkCore;

namespace FishingShop
{
    public class FishingShopDbContext : DbContext
    {
        public DbSet<Customer> Customers { get; set; } = null!;
        public DbSet<Product> Products { get; set; } = null!;
        public DbSet<Order> Orders { get; set; } = null!;
        public DbSet<OrderProduct> OrderProducts { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder
                // .LogTo(Console.WriteLine)
                .UseSqlServer(@"Server=localhost;" +
                "Database=FishingShopDb;" +
                // "Trusted_Connection=True;" +
                "TrustServerCertificate=True;" +
                "User Id=sa;" +
                "Password=yourStrong(&)Password");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
        }
    }
}