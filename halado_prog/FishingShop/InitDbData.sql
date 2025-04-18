USE [FishingShopDb]
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (1, N'Kovács István', N'kovács.istván@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (2, N'Szabó Tamás', N'szabó.tamás@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (3, N'Kiss Anna', N'kiss.anna@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (4, N'Nagy Péter', N'nagy.péter@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (5, N'Tóth Zoltán', N'tóth.zoltán@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (6, N'Horváth Gábor', N'horváth.gábor@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (7, N'Molnár Ádám', N'molnár.ádám@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (8, N'Farkas Réka', N'farkas.réka@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (9, N'Balogh István', N'balogh.istván@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (10, N'Varga Katalin', N'varga.katalin@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (11, N'Simon András', N'simon.andrás@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (12, N'Szalai Gabriella', N'szalai.gabriella@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (13, N'Kiss Levente', N'kiss.levente@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (14, N'Lakatos Béla', N'lakatos.béla@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (15, N'Takács Krisztián', N'takács.krisztián@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (16, N'Németh Júlia', N'németh.júlia@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (17, N'Bíró Erika', N'bíró.erika@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (18, N'Veres Csaba', N'veres.csaba@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (19, N'Fekete Tamás', N'fekete.tamás@gmail.com')
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (20, N'Papp Emese', N'papp.emese@gmail.com')
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (1, CAST(N'2024-11-20T00:00:00.0000000' AS DateTime2), 16)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (2, CAST(N'2024-11-03T00:00:00.0000000' AS DateTime2), 13)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (3, CAST(N'2024-11-12T00:00:00.0000000' AS DateTime2), 4)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (4, CAST(N'2024-11-10T00:00:00.0000000' AS DateTime2), 12)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (5, CAST(N'2024-11-08T00:00:00.0000000' AS DateTime2), 4)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (6, CAST(N'2024-11-24T00:00:00.0000000' AS DateTime2), 14)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (7, CAST(N'2024-11-30T00:00:00.0000000' AS DateTime2), 13)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (8, CAST(N'2024-11-27T00:00:00.0000000' AS DateTime2), 18)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (9, CAST(N'2024-11-17T00:00:00.0000000' AS DateTime2), 9)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (10, CAST(N'2024-11-10T00:00:00.0000000' AS DateTime2), 16)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (11, CAST(N'2024-11-30T00:00:00.0000000' AS DateTime2), 5)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (12, CAST(N'2024-11-14T00:00:00.0000000' AS DateTime2), 2)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (13, CAST(N'2024-11-25T00:00:00.0000000' AS DateTime2), 12)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (14, CAST(N'2024-11-28T00:00:00.0000000' AS DateTime2), 12)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (15, CAST(N'2024-11-24T00:00:00.0000000' AS DateTime2), 3)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (16, CAST(N'2024-11-14T00:00:00.0000000' AS DateTime2), 12)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (17, CAST(N'2024-11-19T00:00:00.0000000' AS DateTime2), 11)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (18, CAST(N'2024-11-11T00:00:00.0000000' AS DateTime2), 7)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (19, CAST(N'2024-11-08T00:00:00.0000000' AS DateTime2), 16)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (20, CAST(N'2024-11-03T00:00:00.0000000' AS DateTime2), 13)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (21, CAST(N'2024-11-14T00:00:00.0000000' AS DateTime2), 20)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (22, CAST(N'2024-11-13T00:00:00.0000000' AS DateTime2), 6)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (23, CAST(N'2024-11-07T00:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (24, CAST(N'2024-11-19T00:00:00.0000000' AS DateTime2), 13)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (25, CAST(N'2024-11-01T00:00:00.0000000' AS DateTime2), 10)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (26, CAST(N'2024-11-19T00:00:00.0000000' AS DateTime2), 13)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (27, CAST(N'2024-11-03T00:00:00.0000000' AS DateTime2), 18)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (28, CAST(N'2024-11-26T00:00:00.0000000' AS DateTime2), 15)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (29, CAST(N'2024-11-04T00:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (30, CAST(N'2024-11-21T00:00:00.0000000' AS DateTime2), 20)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (31, CAST(N'2024-11-01T00:00:00.0000000' AS DateTime2), 20)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (32, CAST(N'2024-11-28T00:00:00.0000000' AS DateTime2), 10)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (33, CAST(N'2024-11-05T00:00:00.0000000' AS DateTime2), 6)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (34, CAST(N'2024-11-02T00:00:00.0000000' AS DateTime2), 5)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (35, CAST(N'2024-11-03T00:00:00.0000000' AS DateTime2), 15)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (36, CAST(N'2024-11-29T00:00:00.0000000' AS DateTime2), 6)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (37, CAST(N'2024-11-03T00:00:00.0000000' AS DateTime2), 9)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (38, CAST(N'2024-11-26T00:00:00.0000000' AS DateTime2), 16)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (39, CAST(N'2024-11-27T00:00:00.0000000' AS DateTime2), 5)
INSERT [dbo].[Orders] ([Id], [OrderDate], [CustomerId]) VALUES (40, CAST(N'2024-11-24T00:00:00.0000000' AS DateTime2), 9)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (1, 12001, N'Pontyozó bot', N'Horgászbotok', 30777)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (2, 12002, N'Pergető orsó', N'Orsók', 27580)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (3, 12003, N'Feeder szék', N'Kiegészítők', 12516)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (4, 12004, N'Csali keverék', N'Csali', 3409)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (5, 12005, N'Gumihal készlet', N'Orsók', 39553)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (6, 12006, N'Horgászláda', N'Csali', 9128)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (7, 12007, N'Bojlis szett', N'Horgászbotok', 31449)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (8, 12008, N'Kapásjelző szett', N'Orsók', 29534)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (9, 12009, N'Csontkukac', N'Horgászbotok', 10870)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (10, 12010, N'Fenekező bot', N'Kiegészítők', 36320)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (11, 12011, N'Pergető gumihal', N'Elektronika', 51359)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (12, 12012, N'Távdobó orsó', N'Horgászbotok', 48939)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (13, 12013, N'Etetőrakéta', N'Elektronika', 12057)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (14, 12014, N'Merítő háló', N'Kiegészítők', 56824)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (15, 12015, N'Halradar', N'Elektronika', 56806)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (16, 12016, N'Etetőanyag', N'Csali', 48758)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (17, 12017, N'Spinner műcsali', N'Orsók', 3956)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (18, 12018, N'Carp bot', N'Horgászbotok', 45908)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (19, 12019, N'Hordozható szék', N'Csali', 2795)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (20, 12020, N'Laposólom készlet', N'Orsók', 57444)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (21, 12021, N'Etetőcső', N'Elektronika', 59533)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (22, 12022, N'Marker úszó', N'Horgászbotok', 53540)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (23, 12023, N'Lebegő bojli', N'Horgászbotok', 36757)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (24, 12024, N'Halas pelletek', N'Horgászbotok', 32315)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (25, 12025, N'Etetőcsónak', N'Csali', 37606)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (26, 12026, N'Bojlis bot', N'Horgászbotok', 30291)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (27, 12027, N'Wobblerek', N'Orsók', 39028)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (28, 12028, N'Zsinór tartó', N'Csali', 57667)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (29, 12029, N'Horgásztáska', N'Elektronika', 49861)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (30, 12030, N'Halas vödör', N'Kiegészítők', 2107)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (31, 12031, N'Etetőhajó', N'Kiegészítők', 39932)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (32, 12032, N'Halász kötél', N'Orsók', 14090)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (33, 12033, N'Úszós bot', N'Horgászbotok', 29817)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (34, 12034, N'Teleszkópos bot', N'Horgászbotok', 38255)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (35, 12035, N'Halas akvárium', N'Kiegészítők', 29204)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (36, 12036, N'Parti szék', N'Horgászbotok', 23364)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (37, 12037, N'Partvédő háló', N'Horgászbotok', 11080)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (38, 12038, N'Halas etetőanyag', N'Kiegészítők', 26821)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (39, 12039, N'Bojlis orsó', N'Horgászbotok', 4818)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (40, 12040, N'Csali ragasztó', N'Csali', 55229)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (41, 12041, N'Horgász kalap', N'Csali', 44541)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (42, 12042, N'Lámpás fejvédő', N'Orsók', 39219)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (43, 12043, N'Csali akasztó', N'Csali', 33618)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (44, 12044, N'Egykezes bot', N'Csali', 54179)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (45, 12045, N'Halradar kiegészítő', N'Elektronika', 45300)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (46, 12046, N'Elektromos csónakmotor', N'Kiegészítők', 14621)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (47, 12047, N'Csali szárító', N'Elektronika', 35810)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (48, 12048, N'Halas etetőtartály', N'Kiegészítők', 33917)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (49, 12049, N'Kapásjelző LED', N'Kiegészítők', 15384)
INSERT [dbo].[Products] ([Id], [ProductId], [Name], [Category], [Price]) VALUES (50, 12050, N'Elektromos kapásjelző', N'Orsók', 55061)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderProducts] ON 

INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (1, 1, 15, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (2, 1, 43, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (3, 2, 49, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (4, 3, 2, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (5, 3, 17, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (6, 3, 38, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (7, 3, 34, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (8, 3, 50, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (9, 4, 30, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (10, 4, 36, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (11, 5, 23, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (12, 5, 16, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (13, 5, 47, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (14, 6, 28, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (15, 6, 27, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (16, 7, 50, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (17, 7, 12, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (18, 8, 24, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (19, 8, 41, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (20, 8, 32, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (21, 8, 7, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (22, 9, 10, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (23, 9, 5, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (24, 9, 16, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (25, 9, 17, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (26, 10, 48, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (27, 11, 35, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (28, 11, 23, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (29, 11, 30, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (30, 11, 25, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (31, 11, 6, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (32, 12, 43, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (33, 12, 12, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (34, 12, 6, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (35, 12, 49, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (36, 12, 30, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (37, 13, 27, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (38, 13, 24, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (39, 14, 20, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (40, 14, 7, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (41, 14, 2, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (42, 14, 4, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (43, 14, 12, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (44, 14, 45, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (45, 15, 13, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (46, 16, 3, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (47, 16, 14, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (48, 16, 6, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (49, 16, 30, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (50, 17, 31, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (51, 17, 25, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (52, 17, 39, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (53, 18, 31, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (54, 18, 36, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (55, 18, 24, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (56, 18, 17, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (57, 18, 47, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (58, 18, 26, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (59, 19, 35, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (60, 19, 50, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (61, 19, 20, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (62, 20, 46, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (63, 20, 45, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (64, 21, 1, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (65, 21, 17, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (66, 21, 30, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (67, 22, 13, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (68, 22, 25, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (69, 22, 42, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (70, 22, 4, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (71, 22, 11, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (72, 23, 7, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (73, 23, 33, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (74, 23, 40, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (75, 23, 35, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (76, 24, 43, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (77, 24, 4, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (78, 24, 19, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (79, 24, 9, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (80, 25, 40, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (81, 25, 3, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (82, 25, 13, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (83, 25, 5, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (84, 26, 30, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (85, 26, 4, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (86, 26, 44, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (87, 26, 28, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (88, 27, 25, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (89, 27, 14, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (90, 27, 18, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (91, 28, 20, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (92, 28, 39, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (93, 29, 4, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (94, 29, 21, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (95, 29, 30, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (96, 30, 14, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (97, 30, 6, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (98, 30, 1, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (99, 30, 40, 3)
GO
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (100, 30, 22, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (101, 31, 47, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (102, 32, 23, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (103, 32, 46, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (104, 32, 41, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (105, 32, 10, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (106, 32, 18, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (107, 33, 41, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (108, 33, 26, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (109, 33, 38, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (110, 33, 3, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (111, 33, 22, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (112, 34, 28, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (113, 34, 12, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (114, 34, 6, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (115, 34, 3, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (116, 34, 33, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (117, 35, 23, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (118, 35, 50, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (119, 35, 16, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (120, 35, 20, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (121, 35, 24, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (122, 36, 49, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (123, 36, 14, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (124, 36, 23, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (125, 37, 3, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (126, 37, 21, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (127, 37, 9, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (128, 38, 39, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (129, 38, 35, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (130, 38, 36, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (131, 38, 8, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (132, 38, 17, 3)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (133, 38, 26, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (134, 39, 35, 5)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (135, 39, 11, 4)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (136, 40, 49, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (137, 40, 43, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (138, 40, 10, 1)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (139, 40, 47, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (140, 40, 37, 2)
INSERT [dbo].[OrderProducts] ([Id], [OrderId], [ProductId], [Quantity]) VALUES (141, 40, 15, 3)
SET IDENTITY_INSERT [dbo].[OrderProducts] OFF
GO
