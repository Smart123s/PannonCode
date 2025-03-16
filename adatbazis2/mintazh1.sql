--######
--# 1. #
--######
--A
/*
SELECT YEAR(o.OrderDate) as Év, 
		c.CategoryName as Kategória,
		SUM(od.Quantity) as Mennyiség
FROM Categories c, 
	Products p,
	[Order Details] od,
    Orders o
WHERE p.UnitPrice > 90	
GROUP BY YEAR(OrderDate), c.CategoryID, c.CategoryName
ORDER BY Év


--B
SELECT * 
FROM (
    SELECT YEAR(o.OrderDate) as Év, 
            c.CategoryName as Kategória,
            SUM(od.Quantity) as Mennyiség
    FROM Categories c, 
        Products p,
        [Order Details] od,
        Orders o
    WHERE p.UnitPrice > 90	
    GROUP BY YEAR(OrderDate), c.CategoryID, c.CategoryName
) as t PIVOT (sum(Mennyiség) for Év in ("1997", "1996")) as a
*/

--######
--# 2. #
--######
	

--szkript
GO

	SET NOCOUNT ON
	DECLARE @azonosito INT --bemenő paraméter
    DECLARE @teruletszam INT
    DECLARE @terulet INT
    DECLARE @darab INT
	SET @azonosito = 1

    begin try
        SELECT @teruletszam=COUNT(TerritoryID)
        FROM EmployeeTerritories
        GROUP BY EmployeeID
        HAVING EmployeeID = @azonosito

        if @teruletszam > 5
            print 'Több mint 5 terület'
        else BEGIN
        
            SELECT TOP 1 @terulet=t.TerritoryID
            FROM Territories t
            LEFT JOIN EmployeeTerritories et ON et.TerritoryID = t.TerritoryID
            WHERE ISNULL(EmployeeID, -1) = -1
            GROUP BY t.TerritoryID, et.EmployeeID, TerritoryDescription
            ORDER BY TerritoryDescription ASC

            if ISNULL(@terulet, -1) = -1
                print 'Nincs nem kiosztott terület'
            else BEGIN
                print @terulet
                begin try
                    INSERT INTO EmployeeTerritories (EmployeeID, TerritoryID) VALUES (@azonosito, @terulet)

                                begin try
                    UPDATE Employees SET Salary = Salary * 1.25
                    WHERE EmployeeID = @azonosito
                    end TRY
                    begin CATCH
                        DELETE FROM EmployeeTerritories WHERE EmployeeID = @azonosito AND TerritoryID=@terulet
                        print ERROR_MESSAGE()
                    end catch

                end TRY
                begin CATCH
                    print ERROR_MESSAGE()
                end catch
            end
        end
                end TRY
    begin CATCH
        print ERROR_MESSAGE()
    end catch
GO	

--tesztelés
--1. teszt eredménye
/*
*/
--2. teszt eredménye
/*
*/
