use test;

DROP TABLE IF EXISTS FactProductInventory;
DROP TABLE IF EXISTS DimProduct;
DROP TABLE IF EXISTS DimDate;

-- feladat 1

-- tablak masolasa
select * into FactProductInventory from AdventureWorksDW2019..FactProductInventory
WHERE UnitsIn > 0 OR UnitsOut > 0;
select * into DimProduct from AdventureWorksDW2019..DimProduct;
select * into DimDate from AdventureWorksDW2019..DimDate;

-- kulcsok
alter table DimDate add constraint sk1 primary key (DateKey);
alter table DimProduct add constraint sk2 primary key (ProductKey);
alter table FactProductInventory add constraint sk3 primary key (ProductKey, DateKey);

alter table FactProductInventory add constraint fk1 foreign key (ProductKey) references DimProduct (ProductKey);
alter table FactProductInventory add constraint fk2 foreign key (DateKey) references DimDate (DateKey);

-- legnagyobb kikeresese kezzel
SELECT TOP 1 DealerPrice
FROM DimProduct
WHERE DealerPrice IS NOT NULL
ORDER BY DealerPrice DESC;
-- 2146.962

-- szamitott mezo
alter table DimProduct add ArKategoria AS CASE
	WHEN DealerPrice IS NULL THEN 'N/A'
	WHEN DealerPrice > 644 THEN 'Kat60' -- 2146.962 * 0.3
	WHEN DealerPrice > 1288 THEN 'Kat30' -- 2146.962 * 0.6
	ELSE 'Kat0' end;


/*
Bongeszes eredmenyek:

1. feladat:
Legnagyobb forgalmu Termek Kategoria: R
Legnagyobb forgalmu 
Termek: HL Road Frame

2. feladat
2012-ben a prios a Kat60 kategoriaban volt a legnagyobb forgalmi erteku

*/
