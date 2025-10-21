USE test;

DROP TABLE IF EXISTS teny_rendeles;
DROP TABLE IF EXISTS dim_beszerzo;
DROP TABLE IF EXISTS dim_szallito;

CREATE TABLE dim_beszerzo(
	dw_beszerzo_id INT IDENTITY (1,1) PRIMARY KEY,
	aw_beszerzo_id INT NOT NULL,
	nev NVARCHAR(150) NOT NULL,
	nem NCHAR(1) NOT NULL,
	beosztas NVARCHAR(50) NOT NULL
);

DELETE dim_beszerzo;

INSERT dim_beszerzo (aw_beszerzo_id, nev, nem, beosztas)
SELECT
	p.BusinessEntityID AS aw_beszerzo_id,
	ISNULL(p.Title + ' ', '') + p.FirstName + ' ' + p.LastName AS nev,
	e.Gender AS nem,
	e.JobTitle AS beosztas
FROM AdventureWorks2019.Person.Person AS p
JOIN AdventureWorks2019.HumanResources.Employee e ON e.BusinessEntityID = p.BusinessEntityID;
-- 290 records


CREATE TABLE dim_szallito(
	dw_szallito_id INT IDENTITY (1,1) PRIMARY KEY,
	aw_szallito_id INT NOT NULL,
	nev NVARCHAR(50) NOT NULL,
	ext_alapdij MONEY NOT NULL,
	alapdij_kategoria NVARCHAR(50) NOT NULL
);

DELETE dim_szallito;

INSERT dim_szallito (aw_szallito_id, nev, ext_alapdij, alapdij_kategoria)
SELECT
	m.ShipMethodID AS aw_szallito_id,
	m.Name AS nev,
	m.ShipBase AS ext_alapdij,
	CASE
		WHEN m.ShipBase < 10 THEN 'alacsony_alapdij'
		WHEN m.ShipBase >= 10 THEN 'magas_alapdij'
	END AS alapdij_kategoria
FROM AdventureWorks2019.Purchasing.ShipMethod AS m;
-- 5 records



CREATE TABLE teny_rendeles(
	-- a PurchaseOrderDetailID is lehetne PRIMARY KEY, de ha a jovoben tobb forrasbol lesz osszerakva a tenytabla, akkor bezavarhat
	-- ezrt erdemes uj PRIMAR KEY-t definialni
	teny_rendeles_id INT IDENTITY (1,1) PRIMARY KEY,
	aw_rendeles_reszlet_id INT, -- OLTP adatbazisba nem veszunk fel kulso kulcs kenyszert
	dw_beszerzo_id INT REFERENCES dim_beszerzo(dw_beszerzo_id) NOT NULL,
	dw_szallito_id INT REFERENCES dim_szallito(dw_szallito_id) NOT NULL,
	ext_mennyiseg DECIMAL(9,2) NOT NULL,
	int_egysegar MONEY NOT NULL
);

DELETE teny_rendeles;

INSERT teny_rendeles(aw_rendeles_reszlet_id, dw_beszerzo_id, dw_szallito_id, ext_mennyiseg, int_egysegar)
SELECT
	o.PurchaseOrderDetailID AS aw_rendeles_reszlet_id,
	h.EmployeeID AS dw_beszerzo_id,
	h.ShipMethodID AS dw_szallito_id,
	o.StockedQty AS ext_mennyiseg,
	o.UnitPrice AS int_egysegar
FROM AdventureWorks2019.Purchasing.PurchaseOrderDetail AS o
JOIN AdventureWorks2019.Purchasing.PurchaseOrderHeader h ON h.PurchaseOrderID = o.PurchaseOrderID

-- ez a ketto join nem muszaj, ugyanugy mukoidk nelkule is
-- JOIN AdventureWorks2019.Purchasing.ShipMethod s ON s.ShipMethodID = h.ShipMethodID
-- JOIN AdventureWorks2019.HumanResources.Employee e ON e.BusinessEntityID = h.EmployeeID;
-- 8845 records
