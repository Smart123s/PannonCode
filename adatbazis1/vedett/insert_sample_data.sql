SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[allat](
	[id] [int] NOT NULL,
	[nev] [nvarchar](50) NOT NULL,
	[ertekid] [int] NOT NULL,
	[ev] [int] NULL,
	[katid] [int] NOT NULL,
 CONSTRAINT [PK_allat] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ertek](
	[id] [int] NOT NULL,
	[forint] [int] NOT NULL,
 CONSTRAINT [PK_ertek] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kategoria](
	[id] [int] NOT NULL,
	[nev] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_kategoria] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1768, 'dobozi pikkelyescsiga', 1, NULL, 5)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1772, 'ritka hegyiszitakötő', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1774, 'álolaszsáska', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1775, 'magyar tarsza', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1776, 'Stys-tarsza', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1779, 'beregi futrinka', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1780, 'magyar futrinka', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1781, 'zempléni futrinka', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1783, 'pusztai gyalogcincér', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1784, 'atracélcincér', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1786, 'remetebogár', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1788, 'drávai tegzes', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1789, 'mecseki őszitegzes', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1792, 'sztyeplepke', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1794, 'budai szakállasmoly', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1796, 'fóti boglárka', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1797, 'csíkos boglárka', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1799, 'ezüstsávos szénalepke', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1801, 'magyar ősziaraszoló', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1802, 'bükki hegyiaraszoló', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1803, 'Anker-araszoló', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1804, 'füstös ősziaraszoló', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1805, 'csüngőaraszoló', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1807, 'Metelka-medvelepke', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1809, 'keleti lápibagoly', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1810, 'magyar őszi-fésűsbagoly', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1811, 'díszes csuklyásbagoly', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1812, 'vértesi csuklyásbagoly', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1813, 'magyar tavaszi-fésűsbagoly', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1814, 'nagy szikibagoly', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1815, 'nagyfoltú bagoly', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1816, 'villányi télibagoly', 1, NULL, 8)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1821, 'tiszai ingola', 2, 1974, 2)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1822, 'dunai ingola', 1, 1974, 2)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1826, 'Petényi-márna', 1, 1974, 1)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1829, 'lápi póc', 1, 1974, 1)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1831, 'dunai galóca', 1, 1974, 1)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1834, 'magyar bucó', 1, 1974, 1)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1835, 'német bucó', 1, 1974, 1)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1839, 'pannon gyík', 1, 1974, 6)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1841, 'haragos sikló', 3, 1974, 6)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1843, 'parlagi vipera', 4, 1974, 6)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1847, 'kis kárókatona', 3, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1849, 'rózsás gödény', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1850, 'borzas gödény', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1853, 'bölömbika', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1854, 'törpegém', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1855, 'bakcsó', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1856, 'üstökösgém', 2, 1912, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1857, 'kis kócsag', 2, 1912, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1858, 'nagy kócsag', 1, 1912, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1859, 'vörös gém', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1861, 'fekete gólya', 3, 1906, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1862, 'fehér gólya', 1, 1906, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1864, 'batla', 2, 1912, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1865, 'kanalasgém', 3, 1912, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1868, 'kis lilik', 4, 1982, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1869, 'vörösnyakú lúd', 3, 1971, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1870, 'márványos réce', 2, 1971, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1871, 'cigányréce', 3, 1971, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1872, 'kékcsőrű réce', 3, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1875, 'halászsas', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1877, 'darázsölyv', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1878, 'barna kánya', 2, 1971, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1879, 'vörös kánya', 3, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1880, 'rétisas', 4, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1881, 'dögkeselyű', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1882, 'barátkeselyű', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1883, 'kígyászölyv', 3, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1884, 'fakó rétihéja', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1885, 'hamvas rétihéja', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1886, 'kis héja', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1887, 'pusztai ölyv', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1888, 'békászó sas', 4, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1889, 'fekete sas', 3, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1890, 'parlagi sas', 4, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1891, 'szirti sas', 3, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1892, 'törpesas', 3, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1893, 'héjasas', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1895, 'fehérkarmú vércse', 3, 1906, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1896, 'kék vércse', 3, 1906, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1897, 'Eleonóra-sólyom', 1, 1971, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1898, 'Feldegg-sólyom', 1, 1996, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1899, 'kerecsensólyom', 4, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1900, 'északi sólyom', 1, 1996, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1901, 'vándorsólyom', 3, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1904, 'császármadár', 3, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1907, 'törpevízicsibe', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1908, 'haris', 3, 1971, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1910, 'reznek', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1911, 'túzok', 4, 1971, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1914, 'gólyatöcs', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1915, 'gulipán', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1917, 'ugartyúk', 2, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1919, 'székicsér', 3, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1920, 'feketeszárnyú székicsér', 3, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1922, 'széki lile', 3, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1923, 'lilebíbic', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1925, 'nagy sárszalonka', 2, 1971, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1926, 'nagy goda', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1927, 'vékonycsőrű póling', 4, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1928, 'nagy póling', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1929, 'piroslábú cankó', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1930, 'tavi cankó', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1932, 'kis csér', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1933, 'fattyúszerkő', 1, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1934, 'kormos szerkő', 2, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1935, 'fehérszárnyú szerkő', 2, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1938, 'gyöngybagoly', 1, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1940, 'uhu', 2, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1941, 'hóbagoly', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1942, 'kuvik', 1, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1943, 'urali bagoly', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1944, 'réti fülesbagoly', 2, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1947, 'gyurgyalag', 1, 1954, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1949, 'szalakóta', 3, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1952, 'fehérhátú fakopáncs', 1, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1955, 'sziki pacsirta', 2, 1971, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1957, 'vízirigó', 2, 1904, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1959, 'nagy fülemüle', 1, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1960, 'kövirigó', 3, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1962, 'csíkosfejű nádiposzáta', 3, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1964, 'kerti sármány', 2, 1901, 3)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1968, 'kereknyergű patkósdenevér', 1, 1901, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1969, 'nagy patkósdenevér', 1, 1901, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1971, 'piszedenevér', 1, 1901, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1972, 'hosszúszárnyú denevér', 1, 1901, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1973, 'nagyfülű denevér', 1, 1901, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1974, 'tavi denevér', 1, 1901, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1975, 'csonkafülű denevér', 1, 1901, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1976, 'óriás-koraidenevér', 1, 1901, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1979, 'farkas', 2, 1993, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1981, 'vidra', 2, 1974, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1983, 'hiúz', 3, 1988, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1986, 'nyugati földikutya', 3, 1974, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1988, 'északi pocok', 2, 1974, 7)
GO
INSERT [dbo].[allat] ([id], [nev], [ertekid], [ev], [katid]) VALUES (1990, 'csíkos szöcskeegér', 2, 1974, 7)
GO
INSERT [dbo].[ertek] ([id], [forint]) VALUES (1, 100000)
GO
INSERT [dbo].[ertek] ([id], [forint]) VALUES (2, 250000)
GO
INSERT [dbo].[ertek] ([id], [forint]) VALUES (3, 500000)
GO
INSERT [dbo].[ertek] ([id], [forint]) VALUES (4, 1000000)
GO
INSERT [dbo].[kategoria] ([id], [nev]) VALUES (1, 'halak')
GO
INSERT [dbo].[kategoria] ([id], [nev]) VALUES (2, 'körszájúak')
GO
INSERT [dbo].[kategoria] ([id], [nev]) VALUES (3, 'madarak')
GO
INSERT [dbo].[kategoria] ([id], [nev]) VALUES (4, 'kétéltűek')
GO
INSERT [dbo].[kategoria] ([id], [nev]) VALUES (5, 'puhatestűek')
GO
INSERT [dbo].[kategoria] ([id], [nev]) VALUES (6, 'hüllők')
GO
INSERT [dbo].[kategoria] ([id], [nev]) VALUES (7, 'emlősök')
GO
INSERT [dbo].[kategoria] ([id], [nev]) VALUES (8, 'ízeltlábúak')
GO
