
-- SLOWLY CHANGING DIMENSIONS, SCD
/*
	#5A ÖNÁLLÓ FELADAT
Demonstráljuk a változó dimenziók támogatását egy egyetemi példán, a ténytáblában a kurzus-eredmények féléves időbeli felbontással, tehát szemeszterenként.
A kiinduló állapotban az adattárház hallgató dimenziójában csak az éppen aktuális értékek vannak tárolva.

Ritkán, de előfordul, hogy valaki szakot vált. Hogy a szakonkénti kimutatásaink ilyenkor se legyenek rosszak,
vezessük be az SCD2 megoldást! Egyúttal támogassuk a több egyetemről jövő jelentések összesítését 
kiegészítő kulccsal a hallgató-dimenzió táblájában!

A teszteléshez tegyük fel, hogy Magas Dávid 2018 ősze után jött át a 'mérnök info.' szakra a 'prog. info.' szakról.
*/

--kiinduló állapot:
use test
go
--csillag-szerkezet
create table dim_hallgato (
	hallgato_id int primary key,
	neptun_kod char(6),
	hallgato_nev nvarchar(200),
	szak_nev varchar(100))
create table dim_kurzus (
	kurzus_id int primary key,
	kurzus_nev nvarchar(200))
create table dim_szemeszter (
	szemeszter_id int primary key,
	szemeszter_kod varchar(200))
create table teny_kurzus_eredmeny (
	hallgato_id int not null references dim_hallgato(hallgato_id),
	kurzus_id int not null references dim_kurzus(kurzus_id),
	szemeszter_id int not null references dim_szemeszter(szemeszter_id),
	eredmeny smallint,
	felvetelek_szama smallint,
	constraint p1 primary key (hallgato_id, kurzus_id, szemeszter_id))
go

--néhány demo rekord
--delete dim_szemeszter
insert dim_szemeszter (szemeszter_id, szemeszter_kod) values (1, '2018_1'), (2, '2018_2'), (3, '2019_1') --a kód alapján időben sorba rendezhető
insert dim_kurzus (kurzus_id, kurzus_nev) values (100, 'Adattárházak'), (101, 'Zongora'), (103, 'Filozófia') 
insert dim_hallgato (hallgato_id, neptun_kod, hallgato_nev, szak_nev) values
	(10, 'djkre4', 'Magas Dávid', 'mérnök info.'), (11, 'ds41e4', 'Szép Nóra', 'gazd. info.')
--delete teny_kurzus_eredmeny
insert teny_kurzus_eredmeny (hallgato_id, kurzus_id, szemeszter_id, eredmeny, felvetelek_szama) values
	(10, 100, 1, 50, 1), (10, 101, 2, 70, 1), (10, 100, 3, 50, 2), (11, 100, 1, 70, 1), (11, 101, 2, 80, 1)

select h.szak_nev, avg(t.eredmeny) eredm_avg
from teny_kurzus_eredmeny t inner join dim_hallgato h on t.hallgato_id=h.hallgato_id
group by h.szak_nev 

szak_nev		eredm_avg
gazd. info.		75
mérnök info.	56

/*
Az SCD2 megoldásban a dim_hallgato tábla külön mezőkben tárolja, hogy a szak melyik szemesztertől melyik szemeszterig érvényes. Ehhez hivatkozzon a dim_szemeszter táblára.
A megoldás lépései:

1. jelenlegi teny_kurzus_eredmeny, dim_hallgato táblák megszüntetése (DROP)
2. új kieg. kulcs a dim_hallgató táblához
3. az új dim_hallgató tábla létrehozása az új SCD2 mezőkkel
4. hallgató adatok feltöltése (INSERT)--ehhez tegyük fel, hogy Magas Dávid 2018 ősze után jött át a 'mérnök info.' szakra a 'prog. info.' szakról.
5. új ténytábla létrehozása, mely már a kiegészítő kulcsra hivatkozik
6. tény-adatok beírása (INSERT). Ezek nem változtak!
7. a szakonkénti eredményt helyesn visszaadó SELECT megírása 
*/

  

--2.1 PÉLDA
use test
--staging area séma létrehozása
go
CREATE SCHEMA stg AUTHORIZATION dbo
go
--stg.person tábla létrehozása SQL-ben: az AW Person.Person tábla kiválasztott mezői
drop table if exists stg.person
go
CREATE TABLE stg.person (
BusinessEntityID INT NULL,
PersonType NCHAR(2) NULL,
Title NVARCHAR(8) NULL,
FirstName NVARCHAR(50) NULL,
MiddleName NVARCHAR(50) NULL,
LastName NVARCHAR(50) NULL,
Suffix NVARCHAR(10) NULL,
ModifiedDate DATETIME NULL
)
go
delete stg.person
go --feltöltés
select count(*) from stg.person
insert stg.person
select BusinessEntityID, PersonType, Title, FirstName, MiddleName, LastName, Suffix, ModifiedDate
from AdventureWorks2019.Person.Person --19972 record
go 
drop table if exists stg.customer
go
CREATE TABLE stg.customer
(
CustomerID INT NULL,
PersonID INT NULL,
StoreID INT NULL,
TerritoryID INT NULL,
ModifiedDate DATETIME NULL,
)
go
delete stg.customer
go --feltöltés
select count(*) from stg.customer --19820 record

insert stg.customer
select CustomerID, PersonID, StoreID, TerritoryID, ModifiedDate
from AdventureWorks2019.Sales.Customer
go
--customer dimenzó tábla létrehozása 
drop table if exists dbo.dim_customers
go
--megfigyelni: számított mezo alkalmazása
CREATE TABLE dbo.dim_customers (
CustomerDwKey INT NOT NULL identity (1,1), -- kiegészítő kulcs ("primary kulcs")
CustomerKey INT NOT NULL, --OLTP kulcs (az eredeti adatbázisból)
FullName NVARCHAR(150) NULL,
EmailAddress NVARCHAR(50) NULL,
BirthYear int NULL, --azért csak az év, mert a kiegészítő személyi adatok között csak ez elérhető
MaritalStatus NCHAR(5) NULL,
Gender NCHAR(5) NULL,
Education NVARCHAR(40) NULL,
Occupation NVARCHAR(100) NULL,
City NVARCHAR(30) NULL,
StateProvince NVARCHAR(50) NULL,
CountryRegion NVARCHAR(50) NULL,
Age AS CASE --computed column, számított mező, lekérdezéskor számítjuk ki
	when birthyear is null then null -- kategorizálás -> nominális változó
	when year(CURRENT_TIMESTAMP)-birthyear <= 40 then 'Younger'
	when year(CURRENT_TIMESTAMP)-birthyear > 50 then 'Older'
	ELSE 'Middle Age' END,
CurrentFlag BIT NOT NULL DEFAULT 1,
CONSTRAINT PK_dimCustomers PRIMARY KEY (CustomerDwKey)
)
go
delete dim_customers
go
--feltöltés
use test
insert dim_customers (CustomerKey, FullName, CountryRegion, StateProvince) 
select p.BusinessEntityID as CustomerKey, p.FirstName+' '+p.LastName as fullname, 
t.CountryRegionCode as CountryRegion,
t.Name as StateProvince
from (stg.person p inner join stg.Customer c on p.BusinessEntityID=c.PersonID)
left outer join AdventureWorks2019.Sales.SalesTerritory t on c.TerritoryID=t.TerritoryID
order by CustomerKey
go

select top 100 * from dim_customers

select count(*) from dim_customers --19119

/*ÖNÁLLÓ FELADAT #7: a Production.Product tábla alábbi 5 mezője alapján készítsünk 
egy staging táblát, majd ebből töltsük fel a dim_product 
táblát. Az érdekes mezők: ProductID, Name, Weight, Color, Style.*/
--1 stg tábla (CREATE TABLE)
--2 feltöltés
--3 dim tábla megtervezése, kiegészítő kulcs (CREATE TABLE)
--4 feltöltés

drop table if exists stg.products
go
CREATE TABLE stg.products (
ProductID INT NULL,
Name NVARCHAR(50) NULL,
Weight DECIMAL(8,2) NULL,
Color NVARCHAR(15) NULL,
Style NCHAR(2) NULL
)
go
delete stg.products
go --feltöltés

insert stg.products
select ProductID, Name, Weight, Color, Style
from AdventureWorks2019.Production.Product
go 


drop table if exists dbo.dim_products
go
CREATE TABLE dbo.dim_products (
ProductDwKey INT NOT NULL identity (1,1), -- kiegészítő kulcs ("primary kulcs")
ProductID INT NULL,
Name NVARCHAR(50) NULL,
Weight DECIMAL(8,2) NULL,
Color NVARCHAR(15) NULL,
Style NCHAR(2) NULL
CONSTRAINT PK_dimProducts PRIMARY KEY (ProductDwKey)
)
go
delete dim_products
go
--feltöltés
use test
insert dim_products
select ProductID, Name, Weight, Color, Style
from stg.products
go









/*
PÉLDA 2.2.: Készítsük el a feltöltött dim_customer ténytábláját. A tábla neve legyen fact_internetsales, 
mértékei a unitprice és a tétel számított értéke. Három külső kulccsal biztosítsuk a vevő, a dátum és a 
termék dimenzió becsatolhatóságát (CustomerDWKey, ProductKey, DateKey)! A ténytáblát csatoljuk a dimenzió-táblához 
a CustomerDwKey alapján, és töltsük fel adatokkal az AW adatbázisból, a CustomerKey által hivatkozott vásárló 
vásárlásaival! Segítség a tételek számításához az #1 önálló feladat megoldásában.
*/
use test
drop table if exists fact_internetsales
go
CREATE TABLE fact_internetsales (
InternetSalesKey INT NOT NULL IDENTITY(1,1) primary key,
CustomerDwKey INT NOT NULL references dim_customers (CustomerDwKey) ,
ProductKey INT NOT NULL ,
DateKey date NOT NULL,
ItemPrice money NOT NULL DEFAULT 0,
UnitPrice MONEY NOT NULL DEFAULT 0,
DiscountAmount FLOAT NOT NULL DEFAULT 0
)
go 
delete fact_internetsales
go
use AdventureWorks2019
insert test..fact_internetsales (CustomerDwKey, ProductKey, DateKey, ItemPrice, UnitPrice, DiscountAmount)

select dwc.CustomerDwKey, sod.ProductID as ProductKey, cast(soh.OrderDate as date) as DateKey, 
sod.LineTotal as ItemPrice, sod.UnitPrice, sod.UnitPriceDiscount as DiscountAmount 

from Sales.SalesOrderHeader AS soh inner join Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID 
inner join Sales.Customer AS c ON soh.CustomerID = c.CustomerID 
inner join test.dbo.dim_customers dwc on dwc.CustomerKey=c.PersonID --121317
go
select distinct Gender from dim_customers 
--rendezzük a hiányzó értékeket
update dim_customers set Gender='N/A' where gender ='' or Gender is null --2000

/*
ÖNÁLLÓ FELADAT #8: készítsünk most ténytáblát az előző feladatban elkészített product 
dimenzióhoz a Production.ProductInventory (raktárkészlet) tábla alapján! Erről eLőször 
készítsünk másolatot a staging sémába, majd hozzuk létre a ténytáblát fact_inventory néven. 
A tábla csak a product dimenzióra hivatkozik, a mértéke a Quantity mező legyen. 
Végül töltsük fel a ténytáblát!*/


--AZ ETL AUTOMATIZÁLÁSA

--customerinfo tábla


CREATE TABLE stg.customerinfo(
	[PersonID] [int] NULL,
	[EnglishEducation] [nvarchar](30) NULL,
	[EnglishOccupation] [nvarchar](50) NULL,
	[BirthYear] [int] NULL,
	[Gender] [nchar](5) NULL,
	[MaritalStatus] [nchar](5) NULL,
	[EmailAddress] [nvarchar](50) NULL
) 
GO
truncate table stg.customerinfo
go
--SSIS csomaggal feltöltjük a táblát, utána:
select * from stg.customerinfo  --18484
select * from dim_customers where CustomerKey not in (select PersonID from stg.customerinfo) --1999

--a teljes dim. tábla kiegészítő adatokkal együtt:
use test
delete dim_customers
go
insert dim_customers (CustomerKey, FullName, CountryRegion, StateProvince, BirthYear, Education, EmailAddress, 
Occupation, Gender, MaritalStatus, Age) 
select p.BusinessEntityID as CustomerKey, p.FirstName+p.LastName as fullname, t.CountryRegionCode as CountryRegion,
t.Name as StateProvince, ci.BirthYear, ci.EnglishEducation, ci.EmailAddress, ci.EnglishOccupation, ci.Gender, ci.MaritalStatus
from (stg.person p inner join stg.Customer c on p.BusinessEntityID=c.PersonID)
left outer join AdventureWorks2019.Sales.SalesTerritory t on c.TerritoryID=t.TerritoryID
left outer join stg.customerinfo ci on ci.PersonID=p.BusinessEntityID
order by CustomerKey
go
select top 1000 * from dim_customers

--most készítsük el az idő dim. táblát
use test
create table dim_dates (
	datekey date not null primary key,
	date_year char(4) not null,
	date_month char(2) not null,
	date_day char(2) not null
)
--feltöltés
use AdventureWorks2019
insert test..dim_dates(DateKey, date_year, date_month, date_day)
select distinct  OrderDate, format(OrderDate, 'yyyy'),format(OrderDate, 'MM'),format(OrderDate, 'dd')
from Sales.SalesOrderHeader --1124

--ténytábla:
/***********************
ÖNÁLLÓ FELADAT: Készítsük el a feltöltött dim_customer ténytábláját. 
A tábla neve legyen fact_internetsales, mértékei a unitprice és a tétel számított értéke. 
Két külső kulccsal biztosítsuk a dátum és termék dimenzió későbbi 
becsatolhatóságát (ProductKey, DateKey)! 
A ténytáblát csatoljuk a dimenzió-táblához a CustomerDwKey alapján, 
és töltsük fel adatokkal az AW adatbázisból, a CustomerKey által hivatkozott vásárló vásárlásaival! 
Segítség a tételek számításához az 1. órai önálló feladat megoldásában.
***************************/

--SCD 1 változáskezelés a dim_customers dimenzióban: Upsert
--=========================================================
use test
select * from dim_customers--0
--1. a még nem létező rekordokat beszúrjuk
insert dim_customers (CustomerKey, FullName, CountryRegion, StateProvince) 
select p.BusinessEntityID as CustomerKey, p.FirstName+' '+p.LastName as fullname, t.CountryRegionCode as CountryRegion,
t.Name as StateProvince
from (stg.person p inner join stg.Customer c on p.BusinessEntityID=c.PersonID)
left outer join AdventureWorks2019.Sales.SalesTerritory t on c.TerritoryID=t.TerritoryID
where p.BusinessEntityID not in (select CustomerKey from dim_customers)

--2. a változott rekordokat átírjuk
--tegyük fel, hogy a CountryRegion és a StateProvince mezőket szeretnénk követni
update dim_customers set CountryRegion=stg.CountryRegion, StateProvince=stg.StateProvince
from dim_customers d inner join (
	select p.BusinessEntityID as CustomerKey, p.FirstName+p.LastName as fullname, t.CountryRegionCode as CountryRegion,
	t.Name as StateProvince
	from (stg.person p inner join stg.Customer c on p.BusinessEntityID=c.PersonID)
	left outer join AdventureWorks2019.Sales.SalesTerritory t on c.TerritoryID=t.TerritoryID
) as stg on d.CustomerKey=stg.CustomerKey	--az OLTP kulcs nem változhat!!

--teszt
insert stg.person (BusinessEntityID, LastName, FirstName) values (100000, 'Joe', 'New')
insert stg.customer (TerritoryID, CustomerID, PersonID) values (6, 200000, 100000)
--1) futtatása után: 
select * from dim_customers where CustomerKey=100000  --1 rekord, Kanadában

update stg.customer set TerritoryID=7 where PersonID=100000  --elköltözött
--2) futtatása után:
select * from dim_customers where CustomerKey=100000  --1 rekord, Franciaországban

--(az INSERT/UPDATE egy MERGE utasítással is megoldható lenne)

--SCD 2 változáskezelés
--===============================
--dim. tábla kibővítése Validfrom, ValidTo, Current mezőkkel
CREATE TABLE dbo.dim_customers_scd2 (
CustomerDwKey INT NOT NULL default next value for SeqCustomerDwKey,
CustomerKey INT NOT NULL,
FullName NVARCHAR(150) NULL,
StateProvince NVARCHAR(50) NULL,
CountryRegion NVARCHAR(50) NULL,
CurrentFlag BIT NOT NULL DEFAULT 1,
ValidFrom date,
ValidTo date
CONSTRAINT PK_dimCustomers_2 PRIMARY KEY (CustomerDwKey)
)
go
truncate table dim_customers
go
--a változást úgy vesszük észre, hogy a stg.customer táblában a ModifiedDate mező későbbi, mint a 
--current mező ValidFrom dátuma
--lépések:
--1. az új rekordok beszúrása
--2. meglévő rekordok aktualizálása beszúrással

--1. az új rekordok beszúrása
insert dim_customers_scd2 (CustomerKey, FullName, CountryRegion, StateProvince, ValidFrom) 
select p.BusinessEntityID as CustomerKey, p.FirstName+' '+p.LastName as fullname, t.CountryRegionCode as CountryRegion,
t.Name as StateProvince, c.ModifiedDate as ValidFrom --figyelem: itt az új mező
from (stg.person p inner join stg.Customer c on p.BusinessEntityID=c.PersonID)
left outer join AdventureWorks2019.Sales.SalesTerritory t on c.TerritoryID=t.TerritoryID
where p.BusinessEntityID not in (select CustomerKey from dim_customers_scd2)

--2. a meglévő rekordok aktualizálása, azaz új rekord beszúrás
--tegyük fel, hogy az adattárházunk még 2011-ben lett létrehozva:
use test
update stg.customer set ModifiedDate='2010-09-10'
update dim_customers_scd2 set validfrom='2011-01-10' 
--kiválasztunk egy vásárlót:
select top 1 * from dim_customers_scd2 --CustomerKey=291
--ő eredetileg US volt (mikor a dim-táblát feltöltöttük) 
--customerkey, tehát customer.PersonID=291, customer.territoryid=1 
--Tegyük fel, hogy 2012. febr. 10-én ő átköltözött Ausztráliába, territoryid = 9
--a 2012-es staging táblában már ez van:
update test.stg.Customer set TerritoryID=9, ModifiedDate='2012-02-10' where PersonID=291
--SCD2 MEGOLDÁS:
--az új stg táblából észrevesszük, hogy változás történt
--és a változott vásárlókat megyjegyezzük
USE test
select d.CustomerKey 
into #valtozott
from dim_customers_scd2 d inner join stg.customer c on d.CustomerKey=c.PersonID
where d.CurrentFlag=1 and d.ValidFrom<c.ModifiedDate   
--módosult vásárlónként csak egy rekord lehet a CurrentFlag miatt
--a módosult korábbi rekordokat lezárjuk:
update dim_customers_scd2 set CurrentFlag=0, ValidTo=c.ModifiedDate
from dim_customers_scd2 d inner join stg.customer c on d.CustomerKey=c.PersonID
where d.CurrentFlag=1 and d.ValidFrom<c.ModifiedDate 
--új rekordokba beszúrjuk az új értéket:
insert dim_customers_scd2 (CustomerKey, FullName, CountryRegion, StateProvince, ValidFrom) 
select p.BusinessEntityID as CustomerKey, p.FirstName+' '+p.LastName as fullname, t.CountryRegionCode as CountryRegion,
t.Name as StateProvince, c.ModifiedDate 
from (stg.person p inner join stg.Customer c on p.BusinessEntityID=c.PersonID)
left outer join AdventureWorks2019.Sales.SalesTerritory t on c.TerritoryID=t.TerritoryID
where p.BusinessEntityID in (select CustomerKey from #valtozott)
--már 2 rekordja van a 291-nek:
use test
select * from dim_customers_scd2 where CustomerKey=291

/******************************************************
--demo: SCD2 nélkül rossz országhoz kerül egy korábbi bevétel
*******************************************************/
--ha csak a mostani állapot érdekes (SCD1), akkor ez a lekérdezés:
use AdventureWorks2019
SELECT year(soh.OrderDate) as Év, d.CountryRegion as Ország, cast(sum(sod.LineTotal) as money)as Összeg
FROM Sales.SalesOrderHeader AS soh 
INNER JOIN Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID 
INNER JOIN test.stg.Customer AS c ON soh.CustomerID = c.CustomerID 
inner join test.dbo.dim_customers d on d.CustomerKey=c.PersonID --itt a korábbi, SCD1-es dim táblát használjuk
where c.PersonID=291
group by  year(soh.OrderDate), d.CountryRegion
order by Év, Ország, Összeg  --2011,12,13: mindhárom összeg AU, hamis az eredmény
--ha az SCD2-vel csak a legfrissebb értéket nézzük, ugyanezt kapjuk:
SELECT year(soh.OrderDate) as Év, d.CountryRegion as Ország, cast(sum(sod.LineTotal) as money)as Összeg
FROM Sales.SalesOrderHeader AS soh 
INNER JOIN Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID 
INNER JOIN test.stg.Customer AS c ON soh.CustomerID = c.CustomerID 
inner join test.dbo.dim_customers_scd2 d on d.CustomerKey=c.PersonID --itt már az SCD2-es dim táblát használjuk
where c.PersonID=291 and d.CurrentFlag=1 --tehát nem a régi címét nézzük
group by  year(soh.OrderDate), d.CountryRegion
order by Év, Ország, Összeg  --hamis az eredmény, mert mind3 év AU
2011	AU	4049.988  --ez a sor hibás, mert akkor még az USA-ban lakott
2012	AU	65177.168 --ezt az évet kell majd megbontani, mert 2012-ben költözött
2013	AU	61875.8264	--ez a sor jó

--SCD2-vel, helyesen:
SELECT year(soh.OrderDate) as Év, d.CountryRegion as Ország, cast(sum(sod.LineTotal) as money)as Összeg
FROM Sales.SalesOrderHeader AS soh 
INNER JOIN Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID 
INNER JOIN test.stg.Customer AS c ON soh.CustomerID = c.CustomerID 
inner join test.dbo.dim_customers_scd2 d on d.CustomerKey=c.PersonID 
where c.PersonID=291 and (	--és itt jön a lényeg:
	(soh.OrderDate >= d.ValidFrom and soh.OrderDate < d.ValidTo)  	--ez a már nem aktív dim rekordok közül pontosan 1-re sül el, 
	or										--mert a From-To értékek nem lapolódnak át (a BETWEEN duplázott volna a határnapon)
	(d.CurrentFlag=1 and soh.OrderDate>d.ValidFrom))	--ez pedig az egyetlen aktuális rekordra
group by  year(soh.OrderDate), d.CountryRegion
order by Év, Ország, Összeg  
--az eredmény: sikerült megbontani a 2012-es évet, jó a lekérdezés:
2011	US	4049.988
2012	US	4079.988
2012	AU	61097.18
2013	AU	61875.8264
--Hurrá!
