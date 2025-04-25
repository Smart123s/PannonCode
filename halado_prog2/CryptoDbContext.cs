using halado_prog2.Entities;
using Microsoft.EntityFrameworkCore;
using System.Linq; // Required for .Any() in seeding example

namespace halado_prog2
{




    public class CryptoDbContext : DbContext
    {
        // Constructor that accepts DbContextOptions (standard for ASP.NET Core DI)
        public CryptoDbContext(DbContextOptions<CryptoDbContext> options)
            : base(options)
        {
        }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        //optionsBuilder.UseSqlServer("Server=localhost;Database=ConstructionDb;User ID=sa;Password=Qwe_dsa01;TrustServerCertificate=true;");
        optionsBuilder.UseSqlServer();

    }

    // DbSets represent your tables in the database
    public DbSet<User> Users { get; set; }
        public DbSet<Wallet> Wallets { get; set; }
        public DbSet<Cryptocurrency> Cryptocurrencies { get; set; }
        public DbSet<WalletCrypto> WalletCryptos { get; set; }
        public DbSet<Transaction> Transactions { get; set; }
        public DbSet<PriceHistory> PriceHistory { get; set; }

        // Configure the model using Fluent API
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // --- Configure Primary Keys (mostly covered by convention, but can be explicit) ---
            modelBuilder.Entity<User>().HasKey(u => u.Id);
            modelBuilder.Entity<Wallet>().HasKey(w => w.Id); // Wallet ID is also the FK to User
            modelBuilder.Entity<Cryptocurrency>().HasKey(c => c.Id);
            modelBuilder.Entity<Transaction>().HasKey(t => t.Id);
            modelBuilder.Entity<PriceHistory>().HasKey(ph => ph.Id);

            // --- Configure Relationships ---

            // User <--> Wallet (One-to-One)
            modelBuilder.Entity<User>()
                .HasOne(u => u.Wallet)      // User has one Wallet
                .WithOne(w => w.User)       // Wallet is associated with one User
                .HasForeignKey<Wallet>(w => w.Id); // The FK is on the Wallet entity, using Wallet.Id

            // User --> Transactions (One-to-Many)
            modelBuilder.Entity<User>()
                .HasMany(u => u.Transactions)
                .WithOne(t => t.User)
                .HasForeignKey(t => t.UserId);

            // Cryptocurrency --> Transactions (One-to-Many)
            modelBuilder.Entity<Cryptocurrency>()
                .HasMany(c => c.Transactions)
                .WithOne(t => t.Cryptocurrency)
                .HasForeignKey(t => t.CryptoId);

            // Cryptocurrency --> PriceHistory (One-to-Many)
            modelBuilder.Entity<Cryptocurrency>()
                .HasMany(c => c.PriceHistory)
                .WithOne(ph => ph.Cryptocurrency)
                .HasForeignKey(ph => ph.CryptoId);

            // Wallet <--> WalletCrypto (One-to-Many)
            modelBuilder.Entity<Wallet>()
                .HasMany(w => w.WalletCryptos)
                .WithOne(wc => wc.Wallet)
                .HasForeignKey(wc => wc.WalletId);

            // Cryptocurrency <--> WalletCrypto (One-to-Many)
            modelBuilder.Entity<Cryptocurrency>()
                .HasMany(c => c.WalletCryptos)
                .WithOne(wc => wc.Cryptocurrency)
                .HasForeignKey(wc => wc.CryptoId);

            // WalletCrypto (Many-to-Many Join Entity with Composite Key)
            modelBuilder.Entity<WalletCrypto>()
                .HasKey(wc => new { wc.WalletId, wc.CryptoId }); // Composite Key

            // --- Configure Constraints and Data Types ---

            // Unique Indexes
            modelBuilder.Entity<User>()
                .HasIndex(u => u.Email)
                .IsUnique();

            modelBuilder.Entity<Cryptocurrency>()
                .HasIndex(c => c.Name)
                .IsUnique();

            // Decimal Precision for monetary/quantity values
            modelBuilder.Entity<Wallet>()
                .Property(w => w.Balance)
                .HasColumnType("decimal(18, 8)"); // Example precision, adjust if needed

            modelBuilder.Entity<Cryptocurrency>()
                .Property(c => c.CurrentPrice)
                .HasColumnType("decimal(18, 8)");

            // If you added StartingPrice
            // modelBuilder.Entity<Cryptocurrency>()
            //    .Property(c => c.StartingPrice)
            //    .HasColumnType("decimal(18, 8)");


            modelBuilder.Entity<WalletCrypto>()
                .Property(wc => wc.Quantity)
                .HasColumnType("decimal(18, 8)");

            modelBuilder.Entity<Transaction>()
                .Property(t => t.Quantity)
                .HasColumnType("decimal(18, 8)");

            modelBuilder.Entity<Transaction>()
                .Property(t => t.PriceAtTrade)
                .HasColumnType("decimal(18, 8)");

            modelBuilder.Entity<PriceHistory>()
                .Property(ph => ph.Price)
                .HasColumnType("decimal(18, 8)");


            // Configure string lengths explicitly if not using Data Annotations
            modelBuilder.Entity<User>().Property(u => u.Username).HasMaxLength(255);
            modelBuilder.Entity<User>().Property(u => u.Email).HasMaxLength(255);
            modelBuilder.Entity<Cryptocurrency>().Property(c => c.Name).HasMaxLength(50);
            modelBuilder.Entity<Transaction>().Property(t => t.TransactionType).HasMaxLength(10);


            base.OnModelCreating(modelBuilder);
        }

    }
}