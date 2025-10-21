use test
create table dim_vasarlo (
	vas_aw_id int not null, --OLTP kulcs
	vas_dw_id int identity(1,1) primary key,
	vas_nev nvarchar(110) not null,
	vas_tipus nvarchar(2) not null
)
go

insert dim_vasarlo (vas_aw_id, vas_nev, vas_tipus)
select p.BusinessEntityID as vas_aw_id, p.LastName+' ('+p.FirstName+')' as vas_nev, p.PersonType as vas_tipus
from AdventureWorks2019.Person.Person p
	join AdventureWorks2019.Sales.Customer c on c.PersonID = p.BusinessEntityID --19119db rekord


create table dim_terulet(
	ter_id int primary key, --OLTP kulcs
	kont_nev nvarchar(50), --group
	ter_nev nvarchar(50) --name
)

truncate table dim_terulet;
insert dim_terulet (ter_id, kont_nev, ter_nev)
select distinct t.TerritoryID as ter_id, t.[Group] as kont_nev, t.[Name] as ter_nev
from AdventureWorks2019.Sales.SalesTerritory t
	join AdventureWorks2019.Sales.Customer c on c.TerritoryID = t.TerritoryID --10 rekord
go

create table teny_eladas(
	teny_id int identity(1,1) primary key,
	oltp_tetel_id int not null,
	oltp_rend_id int not null,
	vas_dw_id int not null references dim_vasarlo(vas_dw_id),
	ter_id int not null references dim_terulet(ter_id),
	ertek int not null,
	kedvezmeny int not null
)
go

TRUNCATE TABLE teny_eladas;
insert teny_eladas (olt_rend_id, oltp_tetel_id, vas_dw_id, ter_id, ertek, kedvezmeny)
select h.SalesOrderID, od.SalesOrderDetailID, v.vas_dw_id, c.TerritoryID,
	cast(od.LineTotal as int), cast(od.UnitPriceDiscount * 100 as smallint)
from AdventureWorks2019.Sales.SalesOrderDetail od
	join AdventureWorks2019.Sales.SalesOrderHeader h on od.SalesOrderId=h.SalesOrderId
	join dim_vasarlo v on v.vas_aw_id=h.customerid
	join AdventureWorks2019.Sales.Customer c on c.CustomerID = h.CustomerID
	--37924db rekord
go