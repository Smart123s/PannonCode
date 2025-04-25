USE [ConstructionDb]
GO

-- Materials
SET IDENTITY_INSERT [dbo].[Materials] ON
INSERT [dbo].[Materials] ([Id], [Name], [Quantity], [UnitPrice], [ConstructionSiteId]) 
VALUES (1, N'Cement', 1000, 5000.00, 1)
INSERT [dbo].[Materials] ([Id], [Name], [Quantity], [UnitPrice], [ConstructionSiteId]) 
VALUES (2, N'Tégla', 2000, 300.00, 1)
INSERT [dbo].[Materials] ([Id], [Name], [Quantity], [UnitPrice], [ConstructionSiteId]) 
VALUES (3, N'Faanyag', 500, 15000.00, 2)
INSERT [dbo].[Materials] ([Id], [Name], [Quantity], [UnitPrice], [ConstructionSiteId]) 
VALUES (4, N'Festék', 100, 8000.00, 3)
SET IDENTITY_INSERT [dbo].[Materials] OFF
GO
