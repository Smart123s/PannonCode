-- ============================================================================
-- initDb.sql
--
-- SQL Script to seed initial data
-- for the Crypto Trading Simulator (halado_prog2 project).
--
-- Target Database: CryptoDb_NEPTUN (Replace NEPTUN with your code)
-- Target RDBMS: Microsoft SQL Server (MSSQL)
-- ============================================================================

-- Optional: Uncomment and set the correct database name if needed.
-- USE CryptoDb_NEPTUN;
-- GO

-- ============================================================================
-- Seed Initial Data
-- ============================================================================
PRINT 'Seeding initial data for Cryptocurrencies...';

-- Enable inserting explicit values into IDENTITY columns for seeding
SET IDENTITY_INSERT dbo.Cryptocurrencies ON;
GO

INSERT INTO dbo.Cryptocurrencies (Id, Name, CurrentPrice) VALUES
(1, N'BTC', 40000.0),
(2, N'ETH', 3000.0),
(3, N'XRP', 0.75),
(4, N'ADA', 1.20),
(5, N'SOL', 150.0),
(6, N'DOGE', 0.15),
(7, N'DOT', 20.0),
(8, N'SHIB', 0.000025),
(9, N'LTC', 150.0),
(10, N'BCH', 300.0),
(11, N'LINK', 25.0),
(12, N'TRX', 0.08),
(13, N'VET', 0.05),
(14, N'ETC', 35.0),
(15, N'XLM', 0.25);
-- ---
GO

-- Disable inserting explicit values into IDENTITY columns
SET IDENTITY_INSERT dbo.Cryptocurrencies OFF;
GO


PRINT 'Seeding initial data for PriceHistory...';

-- Enable inserting explicit values into IDENTITY columns for seeding
SET IDENTITY_INSERT dbo.PriceHistory ON;
GO

INSERT INTO dbo.PriceHistory (Id, CryptoId, Price, Timestamp) VALUES
(1, 1, 40000.0, GETDATE()),
(2, 2, 3000.0, GETDATE()),
(3, 3, 0.75, GETDATE()),
(4, 4, 1.20, GETDATE()),
(5, 5, 150.0, GETDATE()),
(6, 6, 0.15, GETDATE()),
(7, 7, 20.0, GETDATE()),
(8, 8, 0.000025, GETDATE()),
(9, 9, 150.0, GETDATE()),
(10, 10, 300.0, GETDATE()),
(11, 11, 25.0, GETDATE()),
(12, 12, 0.08, GETDATE()),
(13, 13, 0.05, GETDATE()),
(14, 14, 35.0, GETDATE()),
(15, 15, 0.25, GETDATE());
GO

-- Disable inserting explicit values into IDENTITY columns
SET IDENTITY_INSERT dbo.PriceHistory OFF;
GO

SET IDENTITY_INSERT dbo.Users ON;
GO

INSERT INTO dbo.Users (Id, Username, Email, PasswordHash, Balance) VALUES
(1, N'testuser', N'test@example.com', '$2a$11$CPIfGDU06cxWMkUYCow9OeUTo.AtJTZbGP5AwFF7KvumXNnoVsC9y', 10000.0); -- User ID 1 with initial balance
GO

SET IDENTITY_INSERT dbo.Users OFF;
GO

SET IDENTITY_INSERT dbo.SystemSettings ON;
GO

INSERT INTO dbo.SystemSettings (SettingKey, SettingValue, LastModified) VALUES
(N'TransactionFeeRate', 0.0020, GETUTCDATE());
GO

SET IDENTITY_INSERT dbo.SystemSettings OFF;
GO

-- Note: Users are not seeded here. They would be created via the API's registration endpoint.
-- CryptoWallets are created/updated via Buy/Sell API calls.
-- Transactions are created via Buy/Sell API calls.

PRINT 'Database initialization script completed successfully.';
-- ============================================================================
-- End of Script
-- ============================================================================
