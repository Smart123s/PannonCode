using halado_prog2.Entities;
using Microsoft.EntityFrameworkCore;

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
        public DbSet<Cryptocurrency> Cryptocurrencies { get; set; }
        // RENAMED DbSet name
        public DbSet<CryptoWallet> CryptoWallets { get; set; } // Changed from UserCryptos
        public DbSet<Transaction> Transactions { get; set; }
        public DbSet<PriceHistory> PriceHistory { get; set; }
        public DbSet<SystemSetting> SystemSettings { get; set; }
        public DbSet<GiftTransaction> GiftTransactions { get; set; }

        // Configure the model using Fluent API
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // --- Configure Primary Keys --- (remain largely the same, except for the join table)
            modelBuilder.Entity<User>().HasKey(u => u.Id);
            modelBuilder.Entity<Cryptocurrency>().HasKey(c => c.Id);
            modelBuilder.Entity<Transaction>().HasKey(t => t.Id);
            modelBuilder.Entity<PriceHistory>().HasKey(ph => ph.Id);
            // Configured CryptoWallet Composite Key below

            // --- Configure Relationships ---

            // User --> Transactions (One-to-Many) - remains the same
            modelBuilder.Entity<User>()
                .HasMany(u => u.Transactions)
                .WithOne(t => t.User)
                .HasForeignKey(t => t.UserId);

            // Cryptocurrency --> Transactions (One-to-Many) - remains the same
            modelBuilder.Entity<Cryptocurrency>()
                .HasMany(c => c.Transactions)
                .WithOne(t => t.Cryptocurrency)
                .HasForeignKey(t => t.CryptoId)
                .OnDelete(DeleteBehavior.Cascade); // <-- Add this

            // Cryptocurrency --> PriceHistory (One-to-Many) - remains the same
            modelBuilder.Entity<Cryptocurrency>()
                .HasMany(c => c.PriceHistory)
                .WithOne(ph => ph.Cryptocurrency)
                .HasForeignKey(ph => ph.CryptoId);

            // --- CryptoWallet (Many-to-Many Join Entity with Composite Key) ---

            // Composite Primary Key (RENAMED Entity reference)
            modelBuilder.Entity<CryptoWallet>() // Changed from UserCrypto
                .HasKey(cw => new { cw.UserId, cw.CryptoId }); // Property names remain UserId, CryptoId

            // User <--> CryptoWallet (One-to-Many) (RENAMED Entity and Navigation Property)
            modelBuilder.Entity<User>()
                .HasMany(u => u.CryptoWallets) // Changed from UserCryptos
                .WithOne(cw => cw.User) // Changed from uc
                .HasForeignKey(cw => cw.UserId) // Property name remains UserId
                .OnDelete(DeleteBehavior.Cascade); // <-- Add this

            // Cryptocurrency <--> CryptoWallet (One-to-Many) (RENAMED Entity and Navigation Property)
            modelBuilder.Entity<Cryptocurrency>()
                .HasMany(c => c.CryptoWallets) // Changed from UserCryptos
                .WithOne(cw => cw.Cryptocurrency) // Changed from uc
                .HasForeignKey(cw => cw.CryptoId); // Property name remains CryptoId

            // --- Configure Constraints and Data Types --- (remain largely the same)

            // Unique Indexes - remain the same
            modelBuilder.Entity<User>()
                .HasIndex(u => u.Email)
                .IsUnique();

            modelBuilder.Entity<Cryptocurrency>()
                .HasIndex(c => c.Name)
                .IsUnique();

            // Decimal Precision for monetary/quantity values - remain the same
            modelBuilder.Entity<User>()
                 .Property(u => u.Balance)
                 .HasColumnType("decimal(18, 8)");

            modelBuilder.Entity<Cryptocurrency>()
                .Property(c => c.CurrentPrice)
                .HasColumnType("decimal(18, 8)");

            // CryptoWallet Quantity (RENAMED Entity reference)
            modelBuilder.Entity<CryptoWallet>() // Changed from UserCrypto
                .Property(cw => cw.Quantity) // Property name remains Quantity
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

            modelBuilder.Entity<SystemSetting>(entity =>
            {
                entity.HasKey(e => e.SettingKey); // SettingKey is the primary key
                entity.Property(e => e.SettingValue).HasColumnType("decimal(5, 4)"); // e.g., 0.0020
            });


            // Configure string lengths explicitly - remain the same
            modelBuilder.Entity<User>().Property(u => u.Username).HasMaxLength(255);
            modelBuilder.Entity<User>().Property(u => u.Email).HasMaxLength(255);
            modelBuilder.Entity<Cryptocurrency>().Property(c => c.Name).HasMaxLength(50);
            modelBuilder.Entity<Transaction>().Property(t => t.TransactionType).HasMaxLength(10);

            modelBuilder.Entity<GiftTransaction>(entity =>
            {
                entity.HasKey(gt => gt.Id);

                // Relationship: Sender
                entity.HasOne(gt => gt.SenderUser)
                    .WithMany() // A user can send many gifts
                    .HasForeignKey(gt => gt.SenderUserId)
                    .OnDelete(DeleteBehavior.Restrict); // Don't delete user if they sent gifts (or choose Cascade if appropriate)

                // Relationship: Receiver
                entity.HasOne(gt => gt.ReceiverUser)
                    .WithMany() // A user can receive many gifts
                    .HasForeignKey(gt => gt.ReceiverUserId)
                    .OnDelete(DeleteBehavior.Restrict); // Don't delete user if they received gifts

                // Relationship: Cryptocurrency
                entity.HasOne(gt => gt.Cryptocurrency)
                    .WithMany() // A crypto can be gifted many times
                    .HasForeignKey(gt => gt.CryptoId)
                    .OnDelete(DeleteBehavior.Restrict); // Don't delete crypto if it's in a gift transaction

                entity.Property(gt => gt.Status)
                      .HasConversion<string>() // Store enum as string for readability in DB
                      .HasMaxLength(20);
            });

            base.OnModelCreating(modelBuilder);
        }
    }
}