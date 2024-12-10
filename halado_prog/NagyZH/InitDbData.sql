USE [ConstructionDb]
GO

-- Contractors
SET IDENTITY_INSERT [dbo].[Contractors] ON
INSERT [dbo].[Contractors] ([Id], [Name], [Email], [PhoneNumber]) VALUES (1, N'Nagy Építő Kft.', N'info@nagyepito.hu', N'+36-30-123-4567')
INSERT [dbo].[Contractors] ([Id], [Name], [Email], [PhoneNumber]) VALUES (2, N'Tóth és Társai', N'contact@tothesco.hu', N'+36-20-234-5678')
INSERT [dbo].[Contractors] ([Id], [Name], [Email], [PhoneNumber]) VALUES (3, N'Kovács Építészet', N'office@kovacsdesign.hu', N'+36-70-345-6789')
SET IDENTITY_INSERT [dbo].[Contractors] OFF
GO

-- ConstructionSites
SET IDENTITY_INSERT [dbo].[ConstructionSites] ON
INSERT [dbo].[ConstructionSites] ([Id], [Location], [StartDate], [EstimatedEndDate], [TotalContractCost])
VALUES (1, N'Budapest, Andrássy út 1.', '2024-01-01', '2024-12-31', 0.0)
INSERT [dbo].[ConstructionSites] ([Id], [Location], [StartDate], [EstimatedEndDate], [TotalContractCost])
VALUES (2, N'Debrecen, Kossuth tér 15.', '2024-02-01', '2025-01-31', 0.0)
INSERT [dbo].[ConstructionSites] ([Id], [Location], [StartDate], [EstimatedEndDate], [TotalContractCost])
VALUES (3, N'Szeged, Széchenyi tér 8.', '2024-03-01', '2025-06-30', 0.0)
SET IDENTITY_INSERT [dbo].[ConstructionSites] OFF
GO

-- Contracts
SET IDENTITY_INSERT [dbo].[Contracts] ON
INSERT [dbo].[Contracts] ([Id], [Description], [Cost], [SignedDate], [ContractorId], [ConstructionSiteId])
VALUES (1, N'Alapozási munkálatok', 1500000.00, '2024-01-15', 1, 1)
INSERT [dbo].[Contracts] ([Id], [Description], [Cost], [SignedDate], [ContractorId], [ConstructionSiteId])
VALUES (2, N'Tetőszerkezet kialakítása', 2500000.00, '2024-02-20', 2, 1)
INSERT [dbo].[Contracts] ([Id], [Description], [Cost], [SignedDate], [ContractorId], [ConstructionSiteId])
VALUES (3, N'Belső burkolatok', 800000.00, '2024-05-10', 3, 2)
INSERT [dbo].[Contracts] ([Id], [Description], [Cost], [SignedDate], [ContractorId], [ConstructionSiteId])
VALUES (4, N'Külső homlokzat festése', 600000.00, '2024-07-01', 1, 3)
SET IDENTITY_INSERT [dbo].[Contracts] OFF
GO
