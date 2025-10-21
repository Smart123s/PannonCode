use master
set nocount on
create database test
go
use test
--staging táblák
go
CREATE SCHEMA stg AUTHORIZATION dbo
go
--stg.person tábla létrehozása SQL-ben: az AW Person.Person tábla kiválasztott mezői
--drop table stg.person
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
--select count(*) from stg.person
insert stg.person
select BusinessEntityID, PersonType, Title, FirstName, MiddleName, LastName, Suffix, ModifiedDate
from AdventureWorks2019.Person.Person
go 
--drop table stg.customer
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
go 

--feltöltés
--select count(*) from stg.customer
insert stg.customer
select CustomerID, PersonID, StoreID, TerritoryID, ModifiedDate
from AdventureWorks2019.Sales.Customer
go

--kieg. adatok a vásárlókhoz (ezt majd egy szövegfájlból töltjük fel)
set nocount on
create table stg.customerinfo(
	PersonID int ,
	EnglishEducation nvarchar(30) ,
	EnglishOccupation nvarchar(50) ,
	BirthYear int ,
	Gender nchar(5) ,
	MaritalStatus nchar(5) ,
	EmailAddress nvarchar(50) 
) 

--vásárló dim. tábla létrehozása
GO
drop table if exists dbo.dim_customers
go
CREATE TABLE dbo.dim_customers (
CustomerDwKey INT identity(1,1) primary key,
CustomerKey INT NOT NULL,
FullName NVARCHAR(150) NULL default 'N/A',
EmailAddress NVARCHAR(50) NULL default 'N/A',
BirthYear int NULL, --azért csak az év, mert a kiegészítő személyi adatok között csak ez elérhető
MaritalStatus NCHAR(5) NULL default 'N/A',
Gender NCHAR(5) NULL default 'N/A',
Education NVARCHAR(40) NULL default 'N/A',
Occupation NVARCHAR(100) NULL default 'N/A',
City NVARCHAR(30) NULL default 'N/A',
StateProvince NVARCHAR(50) NULL default 'N/A',
CountryRegion NVARCHAR(50) NULL default 'N/A',
Age AS CASE 
when birthyear is null then 'N/A'
when year(CURRENT_TIMESTAMP)-birthyear <= 40 then 'Younger'
when year(CURRENT_TIMESTAMP)-birthyear > 50 then 'Older'
ELSE 'Middle Age' END,
CurrentFlag BIT NOT NULL DEFAULT 1
)
go
delete dim_customers
go
--feltöltés
use test
/*
insert dim_customers (CustomerKey, FullName, CountryRegion, StateProvince, BirthYear, Education, EmailAddress, 
Occupation, Gender, MaritalStatus) 
select p.BusinessEntityID as CustomerKey, p.FirstName+p.LastName as fullname, t.CountryRegionCode as CountryRegion,
t.Name as StateProvince, ci.BirthYear, ci.EnglishEducation, ci.EmailAddress, ci.EnglishOccupation, 
ci.Gender, ci.MaritalStatus
from (stg.person p inner join stg.Customer c on p.BusinessEntityID=c.PersonID)
left outer join AdventureWorks2019.Sales.SalesTerritory t on c.TerritoryID=t.TerritoryID
left outer join stg.customerinfo ci on ci.PersonID=p.BusinessEntityID
order by CustomerKey
*/
go
--select top 1000 * from dim_customers
--select Age, COUNT(*)  from dim_customers group by age

--most készítsük el az idő dim. táblát
use test
drop table if exists dim_dates
go
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
use test
drop table if exists fact_internetsales
go
CREATE TABLE fact_internetsales (
InternetSalesKey INT NOT NULL IDENTITY(1,1) primary key,
CustomerDwKey INT NOT NULL references dim_customers (CustomerDwKey) ,
ProductKey INT NOT NULL ,
DateKey date NOT NULL references dim_dates (datekey),
ItemPrice money NOT NULL DEFAULT 0,
UnitPrice MONEY NOT NULL DEFAULT 0,
DiscountAmount FLOAT NOT NULL DEFAULT 0
)
go 
delete fact_internetsales
go
use AdventureWorks2019
/*
insert test..fact_internetsales (CustomerDwKey, ProductKey, DateKey, ItemPrice, UnitPrice, DiscountAmount)
select dwc.CustomerDwKey, sod.ProductID as ProductKey, cast(soh.OrderDate as date) as DateKey, 
sod.LineTotal as ItemPrice, sod.UnitPrice, sod.UnitPriceDiscount as DiscountAmount 
from Sales.SalesOrderHeader AS soh inner join Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID 
inner join Sales.Customer AS c ON soh.CustomerID = c.CustomerID 
inner join test.dbo.dim_customers dwc on dwc.CustomerKey=c.PersonID --121317
*/
go
use test
--select count(*) from fact_internetSales f inner join dim_customers d on f.CustomerDwKey=d.CustomerDwKey –121317

--Mikor az OLAP-szerver felderíti a dimenzió tagjait, a NULL-ból ’’ (üres string) lesz, ezért ha NULL és ’’ is van a mezőben, hibát kapunk. 

update dim_customers set Gender='N/A' where Gender ='' or Gender is null
update dim_customers set MaritalStatus='N/A' where MaritalStatus ='' or MaritalStatus is null
update dim_customers set CountryRegion='N/A' where CountryRegion ='' or CountryRegion is null
update dim_customers set StateProvince='N/A' where StateProvince ='' or StateProvince is null
