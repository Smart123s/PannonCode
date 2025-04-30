-- Adatbázis kezelő rendszerek II. NagyZH 2
-- 2025.04.30 12:10

-- Feladat 1
DROP FUNCTION IF EXISTS fn_legtobbet_rendelt;
go

CREATE FUNCTION fn_legtobbet_rendelt (@orderdate datetime, @shipperid int) returns int as begin
declare @eredm int;

SELECT TOP 1 @eredm=ProductId FROM [Order Details]
JOIN Orders on Orders.OrderID = [Order Details].OrderID
WHERE Orders.OrderDate > @orderdate
AND Orders.ShipVia = @shipperid
GROUP BY ProductID
ORDER BY COUNT(ProductID) DESC
;

return @eredm;

end
go

-- Feladat 1 tesztek
SELECT dbo.fn_legtobbet_rendelt(GETDATE(), 1);
SELECT dbo.fn_legtobbet_rendelt(GETDATE(), 2);
SELECT dbo.fn_legtobbet_rendelt(GETDATE(), 3);
SELECT dbo.fn_legtobbet_rendelt(YEAR(1980), 2);

go

-- Feladat 2
DROP PROCEDURE IF EXISTS eljarasos_feladat;
go

CREATE PROCEDURE eljarasos_feladat
@orderdate datetime,
@shipperid int
AS
begin
begin try

-- a feladat

declare @shippername varchar(255);
declare @shippertel varchar(255);
declare @res_no int;

SELECT @res_no=COUNT(*), @shippername=CompanyName, @shippertel=Phone
FROM Shippers
WHERE ShipperID = @shipperid
GROUP BY CompanyName, Phone
;

if ISNULL(@res_no, 0) = 0 begin
print('Nincs ilyen szallito')
return
end

print('Szallito neve');
print(@shippername)

print('Szallito telefonszama');
print(@shippertel)

-- b feladat

declare @ProductID int;
declare @ProductName varchar(255);
declare @price float;
declare @CategoryName varchar(255);
declare @temp int;

SELECT @ProductID=ProductID, @ProductName=ProductName, @price = UnitPrice, @CategoryName=CategoryName
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
-- GROUP BY ProductID, ProductName, UnitPrice, CategoryName
WHERE ProductID = dbo.fn_legtobbet_rendelt(@orderdate, @shipperid)
;

print('Legtobbet rendelt termek azonosizoja');
print(@ProductID);

print('Legtobbet rendelt termek neve');
print(@ProductName);

print('Legtobbet rendelt termek ara');
print(@price);

print('Legtobbet rendelt termek kategoriaja');
print(@CategoryName);

-- feladat c
--ha több legtöbbet rendelt termék van

-- hany darab volt abbol a termekbol
SELECT @res_no=COUNT(ProductID) FROM [Order Details]
JOIN Orders on Orders.OrderID = [Order Details].OrderID
WHERE Orders.OrderDate > @orderdate
AND Orders.ShipVia = @shipperid
AND ProductID = @ProductID
GROUP BY ProductID

-- hany darab termek van, aminek ugyanaz a darabszama
SELECT @res_no=COUNT(ProductID) FROM [Order Details]
JOIN Orders on Orders.OrderID = [Order Details].OrderID
WHERE Orders.OrderDate > @orderdate
AND Orders.ShipVia = @shipperid
GROUP BY ProductID
HAVING COUNT(ProductID) = @res_no
;

-- ha tobb mint egy, akkor hiba
--if @res_no > 1 begin
--print('Tobb mint 1 leggyakrabban rendelt termek van')
--return
--end

UPDATE Products
SET UnitPrice = UnitPrice * 1.1
WHERE ProductID = @ProductID;

-- visszaallitas eredeti arra
UPDATE Products
SET UnitPrice = @price
WHERE ProductID = @ProductID;

-- legjobb uzletkoto
declare @best_employee_id int;
declare @best_employee_name varchar(255);
declare @best_employee_name_last varchar(255);
declare @best_employee_address varchar(255);
declare @best_employee_salary float;

SELECT TOP 1 @best_employee_id=Employees.EmployeeID,
	@best_employee_name=Employees.FirstName,
	@best_employee_name_last=Employees.LastName,
	@best_employee_address=Employees.Address,
	@best_employee_salary=Employees.Salary
FROM Employees
INNER JOIN Orders ON Orders.EmployeeID = Employees.EmployeeID
INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
WHERE [Order Details].ProductID = @ProductID
ORDER BY Employees.EmployeeID

print('Legjobb elado neve');
print(@best_employee_name);
print(@best_employee_name_last);

print('Legjobb elado cime');
print(@best_employee_address);

print('Legjobb elado fizetese');
print(@best_employee_salary);

end try
begin catch
print('Error message');
print(ERROR_MESSAGE());

rollback tran
end catch

end;
go

-- Feladat 2 tesztek

-- Hibas ShipperID
exec dbo.eljarasos_feladat "2024",2555

-- eloirt teszt
exec dbo.eljarasos_feladat "1997.01.01",3


-- Feladat 3

DROP TABLE IF EXISTS prod_price_log;
CREATE TABLE prod_price_log(ProductId int, old_price float, new_price float, datum datetime)

go

DROP TRIGGER IF EXISTS price_logger;
go

CREATE TRIGGER price_logger ON Products AFTER UPDATE AS BEGIN

declare @ProductId int
declare @old_price float
declare @new_price float
declare @datum datetime

SELECT @ProductId=ProductID, @old_price=0, @new_price=UnitPrice FROM deleted;

SELECT @old_price=UnitPrice FROM Products WHERE ProductID=@ProductId;

INSERT prod_price_log (ProductId, old_price, new_price, datum)
VALUES (@ProductId, @old_price, @new_price, GETDATE())
END
go

-- Feladat 3 teszt

UPDATE Products
SET UnitPrice = 15
WHERE ProductID = 11;

-- visszaallitas eredeti arra
UPDATE Products
SET UnitPrice = 14
WHERE ProductID = 11;

-- tezst feladat 2-vel
exec dbo.eljarasos_feladat "1997.01.01",3

go
