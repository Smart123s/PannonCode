CREATE TABLE [null_table] (  [kod] VARCHAR(3),  [nev] VARCHAR(10))
GO

CREATE TABLE [BlueSet] (  ID TINYINT,  Code CHAR)
GO

CREATE TABLE [szgk] (  [rendszam]       CHAR(6) PRIMARY KEY,  [gyarto]         VARCHAR(32) NOT NULL,  [tipus]          VARCHAR(50) NOT NULL,  [evjarat]        SMALLINT CHECK ([evjarat] BETWEEN 1980 AND YEAR(GETDATE())),  [ar]             INT         NOT NULL,  [biztositasidij] AS [ar] * 2.3,  [uzemanyag]      VARCHAR(10) CHECK ([uzemanyag] IN ('benzin', 'diesel', 'hybrid', 'elektromos')),  [szemelyek]      TINYINT CHECK ([szemelyek] > 0),  [kolcsonozheto]  BIT)
GO

CREATE TABLE [felszereltseg] (  [felszID] INT IDENTITY (1, 1) PRIMARY KEY,  [felsz]   VARCHAR(20))
GO

CREATE TABLE [szgk_felsz] (  [rendszam] CHAR(6) REFERENCES [szgk]      ON DELETE CASCADE      ON UPDATE CASCADE,  [felszID]  INT PRIMARY KEY ([rendszam], [felszID])      REFERENCES [felszereltseg]          ON DELETE CASCADE          ON UPDATE CASCADE)
GO

CREATE TABLE [orszag] (  [orszagID] CHAR(3) PRIMARY KEY,  [orszag]   VARCHAR(15))
GO

CREATE TABLE [ugyfel] (  [ugyfelID] INT IDENTITY (1, 1) PRIMARY KEY,  [nev]      VARCHAR(50) NOT NULL,  [szuldat]  DATE,  [neme]     CHAR(1) DEFAULT 'f',  [lakcim]   VARCHAR(50),  [telefon]  VARCHAR(12),  [orszagID] CHAR(3) REFERENCES [orszag])
GO

CREATE TABLE [kolcsonzes] (  [kolcsID]     INT IDENTITY (1, 1) PRIMARY KEY,  [ugyfelID] INT  NOT NULL REFERENCES [ugyfel]      ON DELETE CASCADE      ON UPDATE CASCADE,  [rendszam]    CHAR(6) REFERENCES [szgk]      ON DELETE SET NULL      ON UPDATE CASCADE,  [kidat]       DATE NOT NULL UNIQUE ([ugyfelID], [rendszam], [kidat]),  [hatdat]      DATE,  [visszadat]   DATE,  [kedvezmeny]  NUMERIC(2, 1),  [kolcsdij]    NUMERIC(8, 1),  [potdij]      NUMERIC(5, 0))

GO
INSERT [dbo].[BlueSet] ([ID], [Code]) VALUES (1, N'A')
GO
INSERT [dbo].[BlueSet] ([ID], [Code]) VALUES (2, N'G')
GO
INSERT [dbo].[BlueSet] ([ID], [Code]) VALUES (3, N'B')
GO
INSERT [dbo].[BlueSet] ([ID], [Code]) VALUES (4, N'B')
GO
INSERT [dbo].[BlueSet] ([ID], [Code]) VALUES (5, N'O')
GO
INSERT [dbo].[BlueSet] ([ID], [Code]) VALUES (6, N'I')
GO
INSERT [dbo].[BlueSet] ([ID], [Code]) VALUES (7, N'E')
GO
INSERT [dbo].[BlueSet] ([ID], [Code]) VALUES (8, N'E')
GO
INSERT [dbo].[BlueSet] ([ID], [Code]) VALUES (9, N'I')
GO
INSERT [dbo].[BlueSet] ([ID], [Code]) VALUES (10, N'U')
GO
INSERT [dbo].[BlueSet] ([ID], [Code]) VALUES (11, N'U')
GO
INSERT [dbo].[BlueSet] ([ID], [Code]) VALUES (12, N'U')
GO
SET IDENTITY_INSERT [dbo].[felszereltseg] ON 
GO
INSERT [dbo].[felszereltseg] ([felszID], [felsz]) VALUES (1, N'GPS')
GO
INSERT [dbo].[felszereltseg] ([felszID], [felsz]) VALUES (2, N'BSM')
GO
INSERT [dbo].[felszereltseg] ([felszID], [felsz]) VALUES (3, N'TolatĂłradar')
GO
INSERT [dbo].[felszereltseg] ([felszID], [felsz]) VALUES (4, N'Automata vĂĄltĂł')
GO
INSERT [dbo].[felszereltseg] ([felszID], [felsz]) VALUES (5, N'NapfĂŠnyteto')
GO
INSERT [dbo].[felszereltseg] ([felszID], [felsz]) VALUES (6, N'LED')
GO
INSERT [dbo].[felszereltseg] ([felszID], [felsz]) VALUES (7, N'CD')
GO
INSERT [dbo].[felszereltseg] ([felszID], [felsz]) VALUES (8, N'PrĂŠmium hangrendszer')
GO
SET IDENTITY_INSERT [dbo].[felszereltseg] OFF
GO

INSERT [dbo].[null_table] ([kod], [nev]) VALUES (N'abc', N'Arnold')
GO
INSERT [dbo].[null_table] ([kod], [nev]) VALUES (N'def', N'DezsĂľ')
GO
INSERT [dbo].[null_table] ([kod], [nev]) VALUES (NULL, N'Null')
GO
INSERT [dbo].[null_table] ([kod], [nev]) VALUES (N'ghi', N'Gizi')
GO
INSERT [dbo].[null_table] ([kod], [nev]) VALUES (NULL, N'MackĂł')
GO
INSERT [dbo].[null_table] ([kod], [nev]) VALUES (NULL, N'Piroska')
GO
INSERT [dbo].[null_table] ([kod], [nev]) VALUES (N'xyz', NULL)
GO
INSERT [dbo].[null_table] ([kod], [nev]) VALUES (NULL, NULL)
GO
INSERT [dbo].[orszag] ([orszagID], [orszag]) VALUES (N'AUT', N'Ausztria')
GO
INSERT [dbo].[orszag] ([orszagID], [orszag]) VALUES (N'GER', N'NĂŠmetorszĂĄg')
GO
INSERT [dbo].[orszag] ([orszagID], [orszag]) VALUES (N'HUN', N'MagyarorszĂĄg')
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'CBS832', N'BMW', N'Mini', 2018, 5200, N'benzin', 4, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'FKN783', N'Opel', N'Astra', 2017, 6700, N'benzin', 5, 0)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'GHJ923', N'Mazda', N'Mazda 5', 2014, 9700, N'diesel', 7, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'GHL793', N'Mazda', N'Mazda 5', 2015, 9800, N'diesel', 7, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'GHV199', N'Volkswagen', N'Touran', 2018, 9900, N'benzin', 7, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'GJK663', N'Chevrolet', N'Spark', 2014, 4200, N'benzin', 4, 0)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'GJK699', N'Fiat', N'Cinquecento', 2014, 4200, N'benzin', 4, 0)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'GKP729', N'Skoda', N'Fabia', 2017, 6700, N'benzin', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'HGL712', N'Mazda', N'Mazda 6', 2017, 9900, N'benzin', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'HJP377', N'Opel', N'Ampera', 2019, 13000, N'hybrid', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'HLI190', N'Chevrolet', N'Aveo', 2015, 5600, N'diesel', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'JGB783', N'Opel', N'Vivaro', 2015, 11000, N'diesel', 9, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'JKT414', N'Volkswagen', N'Polo', 2016, 5500, N'benzin', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'KBL152', N'Chevrolet', N'Spark', 2016, 4400, N'benzin', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'KKL299', N'Opel', N'Astra', 2015, 5000, N'benzin', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'KKL556', N'Opel', N'Zafira', 2016, 8900, N'benzin', 7, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'KKT352', N'Ford', N'Ka', 2016, 4400, N'benzin', 4, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'LFZ412', N'Skoda', N'Fabia', 2017, 6700, N'benzin', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'LFZ952', N'Renault', N'Kangoo', 2013, 8400, N'diesel', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'LLK312', N'Opel', N'Astra', 2016, 5600, N'benzin', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'LRR154', N'Renault', N'Scenic', NULL, 7700, N'diesel', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'LTT532', N'Volkswagen', N'Passat', 2018, 11000, N'benzin', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'NNK346', N'Opel', N'Zafira', 2016, 9200, N'diesel', 7, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'NNN724', N'Volkswagen', N'Beetle Cabrio', 2019, 12000, N'benzin', 4, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'PUR759', N'Toyota', N'CH-R', 2018, 8000, N'hybrid', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'RAA123', N'Toyota', N'Prius', 2018, 12000, N'hybrid', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'RCA937', N'Honda', N'CRV', 2019, 12000, N'hybrid', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'RRG789', N'Nissan', N'Leaf', 2019, 13500, N'elektromos', 5, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'TES001', N'Tesla', N'Model', 2019, 50000, N'elektromos', 7, 1)
GO
INSERT [dbo].[szgk] ([rendszam], [gyarto], [tipus], [evjarat], [ar], [uzemanyag], [szemelyek], [kolcsonozheto]) VALUES (N'TOY001', N'Toyota', N'Supra', 2019, 12000, N'benzin', 3, 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'CBS832', 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'CBS832', 4)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'CBS832', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'FKN783', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'GHJ923', 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'GHL793', 6)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'GHL793', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'GHV199', 3)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'GHV199', 6)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'GHV199', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'GJK663', 6)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'GJK663', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'GJK699', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'GKP729', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'HGL712', 3)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'HGL712', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'HJP377', 4)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'HJP377', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'HLI190', 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'HLI190', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'JGB783', 3)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'JGB783', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'JKT414', 3)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'JKT414', 4)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'JKT414', 6)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'JKT414', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'KBL152', 6)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'KBL152', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'KKL299', 3)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'KKL299', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'KKL556', 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'KKL556', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'KKT352', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LFZ412', 6)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LFZ412', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LFZ952', 3)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LLK312', 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LLK312', 6)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LLK312', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LRR154', 4)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LRR154', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LTT532', 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LTT532', 2)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LTT532', 4)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LTT532', 5)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'LTT532', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'NNK346', 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'NNK346', 3)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'NNK346', 5)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'NNK346', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'NNN724', 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'NNN724', 4)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'NNN724', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'PUR759', 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'PUR759', 4)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'PUR759', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'RAA123', 3)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'RAA123', 4)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'RCA937', 4)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'RCA937', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'RRG789', 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'RRG789', 3)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'RRG789', 4)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'RRG789', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'TES001', 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'TES001', 4)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'TES001', 6)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'TES001', 7)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'TOY001', 1)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'TOY001', 6)
GO
INSERT [dbo].[szgk_felsz] ([rendszam], [felszID]) VALUES (N'TOY001', 7)
GO
SET IDENTITY_INSERT [dbo].[ugyfel] ON 
GO
INSERT [dbo].[ugyfel] ([ugyfelID], [nev], [szuldat], [neme], [lakcim], [telefon], [orszagID]) VALUES (1, N'KovĂĄcs Elek', CAST(N'1950-05-09' AS Date), N'f', N'8200 VeszprĂŠm, KistĂł u. 12.', N'36309234231', N'HUN')
GO
INSERT [dbo].[ugyfel] ([ugyfelID], [nev], [szuldat], [neme], [lakcim], [telefon], [orszagID]) VALUES (2, N'TĂłth Piroska', CAST(N'1982-11-20' AS Date), N'n', N'8400 Ajka, FĂľ u. 3', NULL, N'HUN')
GO
INSERT [dbo].[ugyfel] ([ugyfelID], [nev], [szuldat], [neme], [lakcim], [telefon], [orszagID]) VALUES (3, N'VarjĂş Varga PĂĄl', CAST(N'1982-02-12' AS Date), N'f', N'8200 VeszprĂŠm, CipĂł u. 24.', N'', N'HUN')
GO
INSERT [dbo].[ugyfel] ([ugyfelID], [nev], [szuldat], [neme], [lakcim], [telefon], [orszagID]) VALUES (4, N'Peter Schwartz', CAST(N'1968-12-22' AS Date), N'f', NULL, NULL, N'GER')
GO
INSERT [dbo].[ugyfel] ([ugyfelID], [nev], [szuldat], [neme], [lakcim], [telefon], [orszagID]) VALUES (5, N'Johann Klein', CAST(N'1945-10-09' AS Date), N'f', NULL, NULL, N'GER')
GO
INSERT [dbo].[ugyfel] ([ugyfelID], [nev], [szuldat], [neme], [lakcim], [telefon], [orszagID]) VALUES (6, N'Nagy JĂĄnos', CAST(N'1990-05-09' AS Date), N'f', N'8230 BalatonfĂźred, FĂźrdĂľ u. 1.', N'36201638261', N'HUN')
GO
INSERT [dbo].[ugyfel] ([ugyfelID], [nev], [szuldat], [neme], [lakcim], [telefon], [orszagID]) VALUES (7, N'Nagy PĂŠter', CAST(N'1970-06-07' AS Date), N'f', N'8200 VeszprĂŠm, Kossuth u. 12.', N'36208368123', N'HUN')
GO
INSERT [dbo].[ugyfel] ([ugyfelID], [nev], [szuldat], [neme], [lakcim], [telefon], [orszagID]) VALUES (8, N'Kiss Etelka', CAST(N'1989-12-10' AS Date), N'n', N'8200 VeszprĂŠm, KĂśkĂśrcsin . 34.', NULL, N'HUN')
GO
INSERT [dbo].[ugyfel] ([ugyfelID], [nev], [szuldat], [neme], [lakcim], [telefon], [orszagID]) VALUES (9, N'Nagy PĂŠter', CAST(N'1971-09-07' AS Date), N'f', N'8200 VeszprĂŠm, Stadion u. 13.', N'36308368124', N'HUN')
GO
INSERT [dbo].[ugyfel] ([ugyfelID], [nev], [szuldat], [neme], [lakcim], [telefon], [orszagID]) VALUES (10, N'Lusta Aranka', CAST(N'1966-11-01' AS Date), N'n', N'8200 VeszprĂŠm, Nagyalma u. 2.', N'36306489277', NULL)
GO
INSERT [dbo].[ugyfel] ([ugyfelID], [nev], [szuldat], [neme], [lakcim], [telefon], [orszagID]) VALUES (11, N'MĂŠzga GĂŠza', CAST(N'1961-09-07' AS Date), N'f', N'8248 VeszprĂŠmfajsz, 34. utca 2.', N'  ', NULL)
GO
INSERT [dbo].[ugyfel] ([ugyfelID], [nev], [szuldat], [neme], [lakcim], [telefon], [orszagID]) VALUES (12, N'Tavaszi VirĂĄg', CAST(N'1999-03-23' AS Date), N'n', N'8220 BalatonalmĂĄdi, Magyar utca 1.', N'	', NULL)
GO
SET IDENTITY_INSERT [dbo].[ugyfel] OFF
GO
SET IDENTITY_INSERT [dbo].[kolcsonzes] ON 
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (1, 1, N'GHL793', CAST(N'2019-02-12' AS Date), CAST(N'2019-02-14' AS Date), CAST(N'2019-02-14' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(19600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (2, 1, N'GHL793', CAST(N'2019-08-09' AS Date), CAST(N'2019-08-17' AS Date), CAST(N'2019-08-17' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(78400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (3, 1, N'GHV199', CAST(N'2019-11-17' AS Date), CAST(N'2019-11-28' AS Date), CAST(N'2019-11-28' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(98010.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (4, 1, N'GJK663', CAST(N'2019-04-18' AS Date), CAST(N'2019-04-22' AS Date), CAST(N'2019-04-22' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(16800.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (5, 1, N'GJK663', CAST(N'2019-06-17' AS Date), CAST(N'2019-06-23' AS Date), CAST(N'2019-06-25' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(43200.0 AS Numeric(8, 1)), CAST(18000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (6, 1, N'GKP729', CAST(N'2019-03-09' AS Date), CAST(N'2019-03-12' AS Date), CAST(N'2019-03-12' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(20100.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (7, 1, N'HJP377', CAST(N'2019-07-25' AS Date), CAST(N'2019-08-01' AS Date), CAST(N'2019-08-01' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(91000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (8, 1, N'HJP377', CAST(N'2019-11-18' AS Date), CAST(N'2019-11-29' AS Date), CAST(N'2019-11-29' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(128700.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (9, 1, N'HLI190', CAST(N'2019-01-25' AS Date), CAST(N'2019-01-26' AS Date), CAST(N'2019-01-26' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(5600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (10, 1, N'JGB783', CAST(N'2019-06-11' AS Date), CAST(N'2019-06-17' AS Date), CAST(N'2019-06-17' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(66000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (11, 1, N'KBL152', CAST(N'2019-06-27' AS Date), CAST(N'2019-07-03' AS Date), CAST(N'2019-07-03' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(26400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (12, 1, N'KKL556', CAST(N'2019-01-29' AS Date), CAST(N'2019-01-30' AS Date), CAST(N'2019-01-30' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(8900.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (13, 1, N'LLK312', CAST(N'2019-09-14' AS Date), CAST(N'2019-09-23' AS Date), CAST(N'2019-09-23' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(50400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (14, 1, N'LTT532', CAST(N'2019-09-23' AS Date), CAST(N'2019-10-02' AS Date), CAST(N'2019-10-02' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(99000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (15, 1, N'NNN724', CAST(N'2019-01-15' AS Date), CAST(N'2019-01-16' AS Date), CAST(N'2019-01-16' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(12000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (16, 1, N'PUR759', CAST(N'2019-10-26' AS Date), CAST(N'2019-11-05' AS Date), CAST(N'2019-11-05' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(80000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (17, 1, N'RAA123', CAST(N'2019-07-23' AS Date), CAST(N'2019-07-30' AS Date), CAST(N'2019-07-30' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(75600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (18, 1, N'TES001', CAST(N'2019-09-23' AS Date), CAST(N'2019-10-02' AS Date), CAST(N'2019-10-02' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(450000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (19, 1, N'TOY001', CAST(N'2019-08-23' AS Date), CAST(N'2019-08-31' AS Date), CAST(N'2019-08-31' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(96000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (20, 2, N'GHV199', CAST(N'2019-01-17' AS Date), CAST(N'2019-01-18' AS Date), CAST(N'2019-01-18' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(9900.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (21, 2, N'GJK663', CAST(N'2019-08-01' AS Date), CAST(N'2019-08-09' AS Date), CAST(N'2019-08-09' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(33600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (22, 2, N'GJK663', CAST(N'2019-09-11' AS Date), CAST(N'2019-09-20' AS Date), CAST(N'2019-09-20' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(37800.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (23, 2, N'GJK699', CAST(N'2019-04-15' AS Date), CAST(N'2019-04-19' AS Date), CAST(N'2019-04-19' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(16800.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (24, 2, N'GKP729', CAST(N'2019-10-28' AS Date), CAST(N'2019-11-07' AS Date), CAST(N'2019-11-07' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(67000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (25, 2, N'HGL712', CAST(N'2019-06-05' AS Date), CAST(N'2019-06-11' AS Date), CAST(N'2019-06-11' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(59400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (26, 2, N'HGL712', CAST(N'2019-08-01' AS Date), CAST(N'2019-08-09' AS Date), CAST(N'2019-08-09' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(79200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (27, 2, N'HJP377', CAST(N'2019-05-18' AS Date), CAST(N'2019-05-23' AS Date), CAST(N'2019-05-23' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(65000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (28, 2, N'JGB783', CAST(N'2019-04-24' AS Date), CAST(N'2019-04-28' AS Date), CAST(N'2019-04-28' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(39600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (29, 2, N'JKT414', CAST(N'2019-03-14' AS Date), CAST(N'2019-03-17' AS Date), CAST(N'2019-03-17' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(14850.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (30, 2, N'JKT414', CAST(N'2019-05-29' AS Date), CAST(N'2019-06-03' AS Date), CAST(N'2019-06-03' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(27500.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (31, 2, N'JKT414', CAST(N'2019-10-19' AS Date), CAST(N'2019-10-29' AS Date), CAST(N'2019-10-29' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(55000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (32, 2, N'KKL299', CAST(N'2019-08-17' AS Date), CAST(N'2019-08-25' AS Date), CAST(N'2019-08-25' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(40000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (33, 2, N'KKT352', CAST(N'2019-07-02' AS Date), CAST(N'2019-07-09' AS Date), CAST(N'2019-07-09' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(30800.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (34, 2, N'KKT352', CAST(N'2019-08-04' AS Date), CAST(N'2019-08-12' AS Date), CAST(N'2019-08-12' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(35200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (35, 2, N'LRR154', CAST(N'2019-10-02' AS Date), CAST(N'2019-10-12' AS Date), CAST(N'2019-10-12' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(77000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (36, 2, N'LTT532', CAST(N'2019-09-13' AS Date), CAST(N'2019-09-22' AS Date), CAST(N'2019-09-22' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(99000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (37, 2, N'NNN724', CAST(N'2019-12-13' AS Date), CAST(N'2019-12-25' AS Date), CAST(N'2019-12-25' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(144000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (38, 2, N'RCA937', CAST(N'2019-05-19' AS Date), CAST(N'2019-05-24' AS Date), CAST(N'2019-05-24' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(60000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (39, 2, N'RCA937', CAST(N'2019-08-27' AS Date), CAST(N'2019-09-04' AS Date), CAST(N'2019-09-04' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(96000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (40, 2, N'RCA937', CAST(N'2019-11-08' AS Date), CAST(N'2019-11-19' AS Date), CAST(N'2019-11-19' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(132000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (41, 2, N'RRG789', CAST(N'2019-08-25' AS Date), CAST(N'2019-09-02' AS Date), CAST(N'2019-09-02' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(108000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (42, 2, N'TES001', CAST(N'2019-06-27' AS Date), CAST(N'2019-07-03' AS Date), CAST(N'2019-07-03' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(300000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (43, 2, N'TES001', CAST(N'2019-08-16' AS Date), CAST(N'2019-08-24' AS Date), CAST(N'2019-08-24' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(400000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (44, 2, N'TES001', CAST(N'2019-09-01' AS Date), CAST(N'2019-09-10' AS Date), CAST(N'2019-09-10' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(450000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (45, 2, N'TOY001', CAST(N'2019-05-17' AS Date), CAST(N'2019-05-22' AS Date), CAST(N'2019-05-22' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(60000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (46, 3, N'CBS832', CAST(N'2019-10-16' AS Date), CAST(N'2019-10-26' AS Date), CAST(N'2019-10-26' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(52000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (47, 3, N'GHV199', CAST(N'2019-04-21' AS Date), CAST(N'2019-04-25' AS Date), CAST(N'2019-04-25' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(39600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (48, 3, N'GJK663', CAST(N'2019-05-20' AS Date), CAST(N'2019-05-25' AS Date), CAST(N'2019-05-25' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(18900.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (49, 3, N'GKP729', CAST(N'2019-06-16' AS Date), CAST(N'2019-06-22' AS Date), CAST(N'2019-06-22' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(40200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (50, 3, N'GKP729', CAST(N'2019-06-22' AS Date), CAST(N'2019-06-28' AS Date), CAST(N'2019-06-28' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(40200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (51, 3, N'GKP729', CAST(N'2019-11-09' AS Date), CAST(N'2019-11-20' AS Date), CAST(N'2019-11-20' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(73700.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (52, 3, N'HJP377', CAST(N'2019-08-06' AS Date), CAST(N'2019-08-14' AS Date), CAST(N'2019-08-14' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(93600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (53, 3, N'HLI190', CAST(N'2019-08-05' AS Date), CAST(N'2019-08-13' AS Date), CAST(N'2019-08-14' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(57800.0 AS Numeric(8, 1)), CAST(13000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (54, 3, N'JGB783', CAST(N'2019-06-23' AS Date), CAST(N'2019-06-29' AS Date), CAST(N'2019-06-29' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(66000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (55, 3, N'JGB783', CAST(N'2019-11-08' AS Date), CAST(N'2019-11-19' AS Date), CAST(N'2019-11-19' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(121000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (56, 3, N'JKT414', CAST(N'2019-04-20' AS Date), CAST(N'2019-04-24' AS Date), CAST(N'2019-04-24' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(22000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (57, 3, N'KBL152', CAST(N'2019-05-04' AS Date), CAST(N'2019-05-09' AS Date), CAST(N'2019-05-09' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(22000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (58, 3, N'KBL152', CAST(N'2019-06-03' AS Date), CAST(N'2019-06-09' AS Date), CAST(N'2019-06-09' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(26400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (59, 3, N'KKT352', CAST(N'2019-06-06' AS Date), CAST(N'2019-06-12' AS Date), CAST(N'2019-06-12' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(26400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (60, 3, N'KKT352', CAST(N'2019-10-08' AS Date), CAST(N'2019-10-18' AS Date), CAST(N'2019-10-18' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(44000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (61, 3, N'LFZ952', CAST(N'2019-01-17' AS Date), CAST(N'2019-01-18' AS Date), CAST(N'2019-01-18' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(8400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (62, 3, N'LFZ952', CAST(N'2019-05-27' AS Date), CAST(N'2019-06-01' AS Date), CAST(N'2019-06-01' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(42000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (63, 3, N'LLK312', CAST(N'2019-02-21' AS Date), CAST(N'2019-02-23' AS Date), CAST(N'2019-02-23' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(11200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (64, 3, N'NNK346', CAST(N'2019-02-07' AS Date), CAST(N'2019-02-09' AS Date), CAST(N'2019-02-09' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(18400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (65, 3, N'NNK346', CAST(N'2019-10-22' AS Date), CAST(N'2019-11-01' AS Date), CAST(N'2019-11-01' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(92000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (66, 3, N'PUR759', CAST(N'2019-07-05' AS Date), CAST(N'2019-07-12' AS Date), CAST(N'2019-07-12' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(56000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (67, 3, N'RAA123', CAST(N'2019-02-21' AS Date), CAST(N'2019-02-23' AS Date), CAST(N'2019-02-23' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(24000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (68, 3, N'RAA123', CAST(N'2019-06-16' AS Date), CAST(N'2019-06-22' AS Date), CAST(N'2019-06-22' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(72000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (69, 3, N'RCA937', CAST(N'2019-06-16' AS Date), CAST(N'2019-06-22' AS Date), CAST(N'2019-06-23' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(85000.0 AS Numeric(8, 1)), CAST(13000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (70, 3, N'RRG789', CAST(N'2019-09-04' AS Date), CAST(N'2019-09-13' AS Date), CAST(N'2019-09-13' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(121500.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (71, 3, N'TES001', CAST(N'2019-06-01' AS Date), CAST(N'2019-06-07' AS Date), CAST(N'2019-06-08' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(313000.0 AS Numeric(8, 1)), CAST(13000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (72, 3, N'TES001', CAST(N'2019-12-23' AS Date), CAST(N'2020-01-04' AS Date), CAST(N'2020-01-04' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(600000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (73, 4, N'FKN783', CAST(N'2019-04-07' AS Date), CAST(N'2019-04-11' AS Date), CAST(N'2019-04-11' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(26800.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (74, 4, N'GHJ923', CAST(N'2019-08-09' AS Date), CAST(N'2019-08-17' AS Date), CAST(N'2019-08-17' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(77600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (75, 4, N'GHV199', CAST(N'2019-02-24' AS Date), CAST(N'2019-02-26' AS Date), CAST(N'2019-02-26' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(19800.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (76, 4, N'JGB783', CAST(N'2019-03-02' AS Date), CAST(N'2019-03-05' AS Date), CAST(N'2019-03-05' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(33000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (77, 4, N'JGB783', CAST(N'2019-03-22' AS Date), CAST(N'2019-03-25' AS Date), CAST(N'2019-03-25' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(33000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (78, 4, N'KKT352', CAST(N'2019-03-24' AS Date), CAST(N'2019-03-27' AS Date), CAST(N'2019-03-27' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(13200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (79, 4, N'LFZ952', CAST(N'2019-12-03' AS Date), CAST(N'2019-12-15' AS Date), CAST(N'2019-12-15' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(100800.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (80, 4, N'LLK312', CAST(N'2019-05-02' AS Date), CAST(N'2019-05-07' AS Date), CAST(N'2019-05-07' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(28000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (81, 4, N'LRR154', CAST(N'2019-02-24' AS Date), CAST(N'2019-02-26' AS Date), CAST(N'2019-02-26' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(15400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (82, 4, N'LRR154', CAST(N'2019-06-28' AS Date), CAST(N'2019-07-04' AS Date), CAST(N'2019-07-04' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(46200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (83, 4, N'LTT532', CAST(N'2019-11-26' AS Date), CAST(N'2019-12-07' AS Date), CAST(N'2019-12-07' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(121000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (84, 4, N'NNK346', CAST(N'2019-06-19' AS Date), CAST(N'2019-06-25' AS Date), CAST(N'2019-06-25' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(55200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (85, 4, N'NNK346', CAST(N'2019-07-24' AS Date), CAST(N'2019-07-31' AS Date), CAST(N'2019-07-31' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(64400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (86, 4, N'NNN724', CAST(N'2019-02-26' AS Date), CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(21600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (87, 4, N'RAA123', CAST(N'2019-02-23' AS Date), CAST(N'2019-02-25' AS Date), CAST(N'2019-02-26' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(37000.0 AS Numeric(8, 1)), CAST(13000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (88, 4, N'TES001', CAST(N'2019-11-06' AS Date), CAST(N'2019-11-17' AS Date), CAST(N'2019-11-17' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(550000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (89, 5, N'GJK663', CAST(N'2019-04-26' AS Date), CAST(N'2019-04-30' AS Date), CAST(N'2019-04-30' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(15120.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (90, 5, N'GJK663', CAST(N'2019-08-16' AS Date), CAST(N'2019-08-24' AS Date), CAST(N'2019-08-24' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(33600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (91, 5, N'GKP729', CAST(N'2019-05-04' AS Date), CAST(N'2019-05-09' AS Date), CAST(N'2019-05-09' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(33500.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (92, 5, N'HJP377', CAST(N'2019-09-09' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'2019-09-18' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(117000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (93, 5, N'HLI190', CAST(N'2019-10-22' AS Date), CAST(N'2019-11-01' AS Date), CAST(N'2019-11-01' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(56000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (94, 5, N'KBL152', CAST(N'2019-03-24' AS Date), CAST(N'2019-03-27' AS Date), CAST(N'2019-03-28' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(26200.0 AS Numeric(8, 1)), CAST(13000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (95, 5, N'KKL299', CAST(N'2019-01-15' AS Date), CAST(N'2019-01-16' AS Date), CAST(N'2019-01-16' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(5000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (96, 5, N'KKT352', CAST(N'2019-04-24' AS Date), CAST(N'2019-04-28' AS Date), CAST(N'2019-04-28' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(15840.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (97, 5, N'KKT352', CAST(N'2019-05-30' AS Date), CAST(N'2019-06-04' AS Date), CAST(N'2019-06-04' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(22000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (98, 5, N'LFZ412', CAST(N'2019-09-18' AS Date), CAST(N'2019-09-27' AS Date), CAST(N'2019-09-27' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(54270.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (99, 5, N'LLK312', CAST(N'2019-09-13' AS Date), CAST(N'2019-09-22' AS Date), CAST(N'2019-09-22' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(50400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (100, 5, N'NNK346', CAST(N'2019-08-17' AS Date), CAST(N'2019-08-25' AS Date), CAST(N'2019-08-25' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(73600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (101, 5, N'NNK346', CAST(N'2019-10-05' AS Date), CAST(N'2019-10-15' AS Date), CAST(N'2019-10-15' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(92000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (102, 5, N'NNN724', CAST(N'2019-06-30' AS Date), CAST(N'2019-07-06' AS Date), CAST(N'2019-07-06' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(72000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (103, 5, N'NNN724', CAST(N'2019-07-23' AS Date), CAST(N'2019-07-30' AS Date), CAST(N'2019-07-30' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(84000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (104, 5, N'RAA123', CAST(N'2019-06-22' AS Date), CAST(N'2019-06-28' AS Date), CAST(N'2019-06-28' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(72000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (105, 5, N'RRG789', CAST(N'2019-05-18' AS Date), CAST(N'2019-05-23' AS Date), CAST(N'2019-05-23' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(67500.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (106, 5, N'TES001', CAST(N'2019-01-14' AS Date), CAST(N'2019-01-15' AS Date), CAST(N'2019-01-15' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(50000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (107, 5, N'TES001', CAST(N'2019-03-18' AS Date), CAST(N'2019-03-21' AS Date), CAST(N'2019-03-21' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(150000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (108, 5, N'TOY001', CAST(N'2019-09-02' AS Date), CAST(N'2019-09-11' AS Date), CAST(N'2019-09-11' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(108000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (109, 5, N'TOY001', CAST(N'2019-09-26' AS Date), CAST(N'2019-10-05' AS Date), CAST(N'2019-10-05' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(108000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (110, 5, N'TOY001', CAST(N'2019-11-29' AS Date), CAST(N'2019-12-10' AS Date), CAST(N'2019-12-10' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(132000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (111, 6, N'CBS832', CAST(N'2019-08-14' AS Date), CAST(N'2019-08-22' AS Date), CAST(N'2019-08-22' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(41600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (112, 6, N'GHJ923', CAST(N'2019-06-27' AS Date), CAST(N'2019-07-03' AS Date), CAST(N'2019-07-03' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(58200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (113, 6, N'GJK663', CAST(N'2019-09-15' AS Date), CAST(N'2019-09-24' AS Date), CAST(N'2019-09-24' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(37800.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (114, 6, N'GJK699', CAST(N'2019-12-14' AS Date), CAST(N'2019-12-26' AS Date), CAST(N'2019-12-26' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(50400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (115, 6, N'HJP377', CAST(N'2019-12-11' AS Date), CAST(N'2019-12-23' AS Date), CAST(N'2019-12-23' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(156000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (116, 6, N'HLI190', CAST(N'2019-06-21' AS Date), CAST(N'2019-06-27' AS Date), CAST(N'2019-06-28' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(46600.0 AS Numeric(8, 1)), CAST(13000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (117, 6, N'JGB783', CAST(N'2019-04-07' AS Date), CAST(N'2019-04-11' AS Date), CAST(N'2019-04-11' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(44000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (118, 6, N'KBL152', CAST(N'2019-05-28' AS Date), CAST(N'2019-06-02' AS Date), CAST(N'2019-06-02' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(22000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (119, 6, N'KKL299', CAST(N'2019-06-13' AS Date), CAST(N'2019-06-19' AS Date), CAST(N'2019-06-19' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(30000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (120, 6, N'LFZ952', CAST(N'2019-03-03' AS Date), CAST(N'2019-03-06' AS Date), CAST(N'2019-03-06' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(22680.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (121, 6, N'LFZ952', CAST(N'2019-09-13' AS Date), CAST(N'2019-09-22' AS Date), CAST(N'2019-09-23' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(88600.0 AS Numeric(8, 1)), CAST(13000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (122, 6, N'NNK346', CAST(N'2019-05-23' AS Date), CAST(N'2019-05-28' AS Date), CAST(N'2019-05-28' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(46000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (123, 6, N'RAA123', CAST(N'2019-07-10' AS Date), CAST(N'2019-07-17' AS Date), CAST(N'2019-07-17' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(75600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (124, 6, N'RCA937', CAST(N'2019-06-15' AS Date), CAST(N'2019-06-21' AS Date), CAST(N'2019-06-23' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(90000.0 AS Numeric(8, 1)), CAST(18000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (125, 6, N'TOY001', CAST(N'2019-04-17' AS Date), CAST(N'2019-04-21' AS Date), CAST(N'2019-04-21' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(48000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (126, 6, N'TOY001', CAST(N'2019-09-28' AS Date), CAST(N'2019-10-07' AS Date), CAST(N'2019-10-07' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(108000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (127, 6, N'TOY001', CAST(N'2019-12-25' AS Date), CAST(N'2020-01-06' AS Date), CAST(N'2020-01-06' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(144000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (128, 7, N'CBS832', CAST(N'2019-06-30' AS Date), CAST(N'2019-07-06' AS Date), CAST(N'2019-07-06' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(31200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (129, 7, N'GHL793', CAST(N'2019-08-03' AS Date), CAST(N'2019-08-11' AS Date), CAST(N'2019-08-11' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(78400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (130, 7, N'GHV199', CAST(N'2019-12-22' AS Date), CAST(N'2020-01-03' AS Date), CAST(N'2020-01-03' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(118800.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (131, 7, N'GJK699', CAST(N'2019-12-09' AS Date), CAST(N'2019-12-21' AS Date), CAST(N'2019-12-21' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(45360.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (132, 7, N'JGB783', CAST(N'2019-07-18' AS Date), CAST(N'2019-07-25' AS Date), CAST(N'2019-07-25' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(69300.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (133, 7, N'JGB783', CAST(N'2019-09-24' AS Date), CAST(N'2019-10-03' AS Date), CAST(N'2019-10-03' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(99000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (134, 7, N'JGB783', CAST(N'2019-12-12' AS Date), CAST(N'2019-12-24' AS Date), CAST(N'2019-12-24' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(132000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (135, 7, N'JKT414', CAST(N'2019-12-21' AS Date), CAST(N'2020-01-02' AS Date), CAST(N'2020-01-02' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(66000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (136, 7, N'KBL152', CAST(N'2019-02-25' AS Date), CAST(N'2019-02-27' AS Date), CAST(N'2019-02-27' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(8800.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (137, 7, N'KKL299', CAST(N'2019-07-23' AS Date), CAST(N'2019-07-30' AS Date), CAST(N'2019-07-30' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(35000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (138, 7, N'LFZ952', CAST(N'2019-04-13' AS Date), CAST(N'2019-04-17' AS Date), CAST(N'2019-04-17' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(33600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (139, 7, N'LFZ952', CAST(N'2019-08-16' AS Date), CAST(N'2019-08-24' AS Date), CAST(N'2019-08-24' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(67200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (140, 7, N'LLK312', CAST(N'2019-09-27' AS Date), CAST(N'2019-10-06' AS Date), CAST(N'2019-10-06' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(50400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (141, 7, N'LRR154', CAST(N'2019-06-23' AS Date), CAST(N'2019-06-29' AS Date), CAST(N'2019-06-29' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(46200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (142, 7, N'LTT532', CAST(N'2019-06-25' AS Date), CAST(N'2019-07-01' AS Date), CAST(N'2019-07-01' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(66000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (143, 7, N'NNN724', CAST(N'2019-03-08' AS Date), CAST(N'2019-03-11' AS Date), CAST(N'2019-03-11' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(36000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (144, 7, N'NNN724', CAST(N'2019-03-13' AS Date), CAST(N'2019-03-16' AS Date), CAST(N'2019-03-16' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(36000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (145, 7, N'PUR759', CAST(N'2019-05-13' AS Date), CAST(N'2019-05-18' AS Date), CAST(N'2019-05-19' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(49000.0 AS Numeric(8, 1)), CAST(13000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (146, 7, N'RAA123', CAST(N'2019-05-19' AS Date), CAST(N'2019-05-24' AS Date), CAST(N'2019-05-24' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(60000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (147, 7, N'RAA123', CAST(N'2019-07-08' AS Date), CAST(N'2019-07-15' AS Date), CAST(N'2019-07-15' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(84000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (148, 7, N'RAA123', CAST(N'2019-08-20' AS Date), CAST(N'2019-08-28' AS Date), CAST(N'2019-08-28' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(96000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (149, 7, N'RRG789', CAST(N'2019-10-31' AS Date), CAST(N'2019-11-10' AS Date), CAST(N'2019-11-10' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(121500.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (150, 8, N'FKN783', CAST(N'2019-03-21' AS Date), CAST(N'2019-03-24' AS Date), CAST(N'2019-03-24' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(20100.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (151, 8, N'FKN783', CAST(N'2019-09-24' AS Date), CAST(N'2019-10-03' AS Date), CAST(N'2019-10-03' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(60300.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (152, 8, N'GHJ923', CAST(N'2019-09-05' AS Date), CAST(N'2019-09-14' AS Date), CAST(N'2019-09-15' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(100300.0 AS Numeric(8, 1)), CAST(13000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (153, 8, N'GHV199', CAST(N'2019-08-01' AS Date), CAST(N'2019-08-09' AS Date), CAST(N'2019-08-09' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(79200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (154, 8, N'GJK699', CAST(N'2019-07-13' AS Date), CAST(N'2019-07-20' AS Date), CAST(N'2019-07-20' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(29400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (155, 8, N'GJK699', CAST(N'2019-11-15' AS Date), CAST(N'2019-11-26' AS Date), CAST(N'2019-11-26' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(46200.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (156, 8, N'HGL712', CAST(N'2019-02-24' AS Date), CAST(N'2019-02-26' AS Date), CAST(N'2019-02-28' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(37800.0 AS Numeric(8, 1)), CAST(18000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (157, 8, N'HGL712', CAST(N'2019-04-09' AS Date), CAST(N'2019-04-13' AS Date), CAST(N'2019-04-13' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(39600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (158, 8, N'HGL712', CAST(N'2019-06-13' AS Date), CAST(N'2019-06-19' AS Date), CAST(N'2019-06-19' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(59400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (159, 8, N'HLI190', CAST(N'2019-06-30' AS Date), CAST(N'2019-07-06' AS Date), CAST(N'2019-07-06' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(33600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (160, 8, N'HLI190', CAST(N'2019-11-09' AS Date), CAST(N'2019-11-20' AS Date), CAST(N'2019-11-20' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(61600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (161, 8, N'JKT414', CAST(N'2019-12-26' AS Date), CAST(N'2020-01-07' AS Date), CAST(N'2020-01-07' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(66000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (162, 8, N'KKL299', CAST(N'2019-05-28' AS Date), CAST(N'2019-06-02' AS Date), CAST(N'2019-06-03' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(38000.0 AS Numeric(8, 1)), CAST(13000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (163, 8, N'KKL299', CAST(N'2019-10-22' AS Date), CAST(N'2019-11-01' AS Date), CAST(N'2019-11-01' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(50000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (164, 8, N'KKL556', CAST(N'2019-04-21' AS Date), CAST(N'2019-04-25' AS Date), CAST(N'2019-04-25' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(35600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (165, 8, N'KKL556', CAST(N'2019-06-25' AS Date), CAST(N'2019-07-01' AS Date), CAST(N'2019-07-01' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(53400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (166, 8, N'KKT352', CAST(N'2019-04-26' AS Date), CAST(N'2019-04-30' AS Date), CAST(N'2019-04-30' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(17600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (167, 8, N'LFZ952', CAST(N'2019-01-06' AS Date), CAST(N'2019-01-07' AS Date), CAST(N'2019-01-07' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(8400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (168, 8, N'LFZ952', CAST(N'2019-07-29' AS Date), CAST(N'2019-08-05' AS Date), CAST(N'2019-08-05' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(58800.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (169, 8, N'LLK312', CAST(N'2019-05-17' AS Date), CAST(N'2019-05-22' AS Date), CAST(N'2019-05-24' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(46000.0 AS Numeric(8, 1)), CAST(18000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (170, 8, N'LTT532', CAST(N'2019-05-28' AS Date), CAST(N'2019-06-02' AS Date), CAST(N'2019-06-02' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(55000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (171, 8, N'NNK346', CAST(N'2019-03-19' AS Date), CAST(N'2019-03-22' AS Date), CAST(N'2019-03-22' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(27600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (172, 8, N'NNK346', CAST(N'2019-12-31' AS Date), CAST(N'2020-01-12' AS Date), CAST(N'2020-01-12' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(110400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (173, 8, N'NNN724', CAST(N'2019-01-16' AS Date), CAST(N'2019-01-17' AS Date), CAST(N'2019-01-17' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(12000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (174, 8, N'RCA937', CAST(N'2019-01-16' AS Date), CAST(N'2019-01-17' AS Date), CAST(N'2019-01-17' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(12000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (175, 8, N'RCA937', CAST(N'2019-05-13' AS Date), CAST(N'2019-05-18' AS Date), CAST(N'2019-05-18' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(60000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (176, 8, N'TOY001', CAST(N'2019-07-23' AS Date), CAST(N'2019-07-30' AS Date), CAST(N'2019-07-30' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(84000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (177, 9, N'GHJ923', CAST(N'2019-02-12' AS Date), CAST(N'2019-02-14' AS Date), CAST(N'2019-02-14' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(19400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (178, 9, N'GHL793', CAST(N'2019-12-15' AS Date), CAST(N'2019-12-27' AS Date), CAST(N'2019-12-27' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(117600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (179, 9, N'GJK663', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-04' AS Date), CAST(N'2019-03-04' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(12600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (180, 9, N'GJK663', CAST(N'2019-10-14' AS Date), CAST(N'2019-10-24' AS Date), CAST(N'2019-10-24' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(42000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (181, 9, N'GKP729', CAST(N'2019-05-27' AS Date), CAST(N'2019-06-01' AS Date), CAST(N'2019-06-01' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(33500.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (182, 9, N'HGL712', CAST(N'2019-07-13' AS Date), CAST(N'2019-07-20' AS Date), CAST(N'2019-07-20' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(69300.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (183, 9, N'HLI190', CAST(N'2019-12-26' AS Date), CAST(N'2020-01-07' AS Date), CAST(N'2020-01-07' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(60480.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (184, 9, N'JGB783', CAST(N'2019-02-08' AS Date), CAST(N'2019-02-10' AS Date), CAST(N'2019-02-10' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(22000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (185, 9, N'KBL152', CAST(N'2019-12-11' AS Date), CAST(N'2019-12-23' AS Date), CAST(N'2019-12-24' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(65800.0 AS Numeric(8, 1)), CAST(13000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (186, 9, N'KKL556', CAST(N'2019-06-30' AS Date), CAST(N'2019-07-06' AS Date), CAST(N'2019-07-06' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(53400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (187, 9, N'KKL556', CAST(N'2019-11-25' AS Date), CAST(N'2019-12-06' AS Date), CAST(N'2019-12-06' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(97900.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (188, 9, N'LFZ412', CAST(N'2019-12-25' AS Date), CAST(N'2020-01-06' AS Date), CAST(N'2020-01-06' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(80400.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (189, 9, N'LFZ952', CAST(N'2019-05-31' AS Date), CAST(N'2019-06-05' AS Date), CAST(N'2019-06-05' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(42000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (190, 9, N'LFZ952', CAST(N'2019-07-11' AS Date), CAST(N'2019-07-18' AS Date), CAST(N'2019-07-18' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(58800.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (191, 9, N'LLK312', CAST(N'2019-11-11' AS Date), CAST(N'2019-11-22' AS Date), CAST(N'2019-11-22' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(61600.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (192, 9, N'LTT532', CAST(N'2019-05-09' AS Date), CAST(N'2019-05-14' AS Date), CAST(N'2019-05-14' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(49500.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (193, 9, N'LTT532', CAST(N'2019-10-21' AS Date), CAST(N'2019-10-31' AS Date), CAST(N'2019-10-31' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(110000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (194, 9, N'LTT532', CAST(N'2019-11-19' AS Date), CAST(N'2019-11-30' AS Date), CAST(N'2019-11-30' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(121000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (195, 9, N'NNK346', CAST(N'2019-03-14' AS Date), CAST(N'2019-03-17' AS Date), CAST(N'2019-03-19' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(45600.0 AS Numeric(8, 1)), CAST(18000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (196, 9, N'NNN724', CAST(N'2019-11-03' AS Date), CAST(N'2019-11-14' AS Date), CAST(N'2019-11-14' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(132000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (197, 9, N'PUR759', CAST(N'2019-08-27' AS Date), CAST(N'2019-09-04' AS Date), CAST(N'2019-09-06' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(82000.0 AS Numeric(8, 1)), CAST(18000 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (198, 9, N'PUR759', CAST(N'2019-10-11' AS Date), CAST(N'2019-10-21' AS Date), CAST(N'2019-10-21' AS Date), CAST(0.1 AS Numeric(2, 1)), CAST(72000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (199, 9, N'RCA937', CAST(N'2019-03-22' AS Date), CAST(N'2019-03-25' AS Date), CAST(N'2019-03-25' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(36000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (200, 9, N'TES001', CAST(N'2019-06-09' AS Date), CAST(N'2019-06-15' AS Date), CAST(N'2019-06-15' AS Date), CAST(0.0 AS Numeric(2, 1)), CAST(300000.0 AS Numeric(8, 1)), CAST(0 AS Numeric(5, 0)))
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (201, 1, N'FKN783', CAST(N'2020-08-24' AS Date), CAST(N'2020-08-31' AS Date), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[kolcsonzes] ([kolcsID], [ugyfelID], [rendszam], [kidat], [hatdat], [visszadat], [kedvezmeny], [kolcsdij], [potdij]) VALUES (202, 1, N'HLI190', CAST(N'2020-08-28' AS Date), CAST(N'2020-09-02' AS Date), NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[kolcsonzes] OFF
GO