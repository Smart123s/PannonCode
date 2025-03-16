DROP TABLE IF EXISTS EmployeeRecord, EmployeeField, Attributes
/*
1. Másolja át a Northwind adatbázis Employees táblájának EmployeeID, LastName, Title, City adatait a saját adatbázisába, EmployeeField néven.
*/
SELECT EmployeeID, LastName, Title, City
  INTO EmployeeField
  FROM Northwind..Employees

--ellenőrzés
SELECT * FROM EmployeeField

/*
2. Hozzon létre egy Attributes táblát az alábbiak szerint:
	AttribId: egész, elsődleges kulcs
	AttribName: nvarchar, maximum 100 karakter
	AttribType: nvarchar, maximum 100 karakter
*/
CREATE TABLE Attributes (
		AttribId INT PRIMARY KEY,
		AttribName NVARCHAR(100),
		AttribType NVARCHAR(100)
	)

/*
3. Töltse fel az Attributes táblát: 
1 - Last name - text
2 - Title - text
3 - City - text
*/

INSERT INTO Attributes (AttribId, AttribName, AttribType) 
  VALUES (1, 'Last name', 'text'), (2, 'Title', 'text'), (3, 'City', 'text')


/*
4. Hozzon létre egy EmployeeRecord táblát az alábbiak szerint:
EmployeeId:	egész, NULL nem megengedett
AttribId: egész, NULL nem megengedett, idegen kulcs az Attributes táblára
AttribValue: nvarchar, maximum 500 karakter
Elsődleges kulcs: EmployeeId, AttribId		
*/
CREATE TABLE EmployeeRecord ( 
		EmployeeId INT NOT NULL,
		AttribId INT NOT NULL REFERENCES Attributes,
		AttribValue NVARCHAR(500)
		PRIMARY KEY (EmployeeId, AttribId)
	)

/*
5. Töltse fel az EmployeeRecord táblát az EmployeeField adataival! 
*/
insert EmployeeRecord (EmployeeId, AttribId, AttribValue)
select employeeid, 1, lastname from employeefield where lastname is not null
union
select employeeid, 2, title from employeefield where title is not null
union
select employeeid, 3, city from employeefield where city is not null

/*
6. Ellenőrizze, hogy az adatok feltöltése sikerült-e!
*/
SELECT * 
  FROM EmployeeRecord

/*
7. Készítsen egy lekérdezést, mely az EmployeeRecord és az Attributes táblák segítségével megjeleníti az adatokat , azok típusát és nevét.
*/
SELECT e.EmployeeId, a.AttribName, a.AttribType, e.AttribValue
  FROM EmployeeRecord AS e 
		JOIN Attributes AS a ON e.AttribId=a.AttribId

/*
8. Készítsen egy lekérdezést, mely az EmployeeRecord tábla adatait jeleníti meg, az eredeti formátumnak megfelelően!
*/
--Megoldás??


--HF.
--6/#1.


--#########
--# PIVOT #
--#########
--gyümölcsszedés adatbázis
--táblák törlése
DROP TABLE IF EXISTS eredm_pivot, eredm, csapat, gyumolcs

--táblák létrehozása
CREATE TABLE csapat( 
	csapat_id int NOT NULL primary key, 
	csapat_nev nvarchar(50) NOT NULL)
CREATE TABLE gyumolcs(
	gyumolcs_id int NOT NULL primary key, 
	gyumolcs_nev nvarchar(50) NOT NULL)
CREATE TABLE nap( 
	nap_id int NOT NULL primary key,
	nap_nev nvarchar(50) NOT NULL)
CREATE TABLE eredm(
	eredm_id int identity (1,1) primary key, 
	csapat_id int NOT NULL references csapat(csapat_id), 
	nap_id int NOT NULL references nap(nap_id),
	gyumolcs_id int not null references gyumolcs(gyumolcs_id), 
	leadott_lada int NOT NULL)

--táblák feltöltése
INSERT INTO csapat(csapat_id, csapat_nev) VALUES (1,'Szorgos'),(2,'Lusta')
INSERT INTO gyumolcs(gyumolcs_id, gyumolcs_nev) VALUES (1,'alma'),(2,'szilva')
INSERT INTO nap(nap_id, nap_nev) VALUES (1,'hétfő'),(2,'kedd'),(3,'szerda')
INSERT INTO eredm(csapat_id, nap_id, gyumolcs_id, leadott_lada)
	VALUES (1,1,1,50), (1,2,1,60), (1,3,1,70), (1,1,2,100), (1,2,2,120), (1,3,2,140),
			(2,1,1,5), (2,2,1,6), (2,3,1,7), (2,1,2,10), (2,2,2,12), (2,3,2,14)

/*
Gyűjtse ki egy eredm_pivot nevű táblába, hogy a csapatok az egyes napokon az egyes gyümölcsökből hány ládával gyűjtöttek.
*/
SELECT cs.csapat_nev, n.nap_nev, gy.gyumolcs_nev, e.leadott_lada 
  INTO eredm_pivot
  FROM eredm e 
		JOIN csapat cs ON cs.csapat_id=e.csapat_id
		JOIN nap n ON n.nap_id=e.nap_id
		JOIN gyumolcs gy ON gy.gyumolcs_id=e.gyumolcs_id

--ellenőrzés
SELECT * FROM eredm_pivot ORDER BY csapat_nev

/*
P1 feladat: csapatteljesítmények gyümölcsönként (csapatnév, napnév + gyümölcsök)
*/
SELECT csapat_nev, nap_nev, alma, szilva
from eredm_pivot
pivot (sum(leadott_lada) for gyumolcs_nev in (alma, szilva) ) as pt

/*P2*/

/*P3*/

/* EREDETI (bonyolultabb) ÓRAI MEGOLDÁS */
SELECT csapat_nev, alma, szilva
FROM (SELECT csapat_nev, gyumolcs_nev, sum(leadott_lada) AS leadott_lada
FROM eredm_pivot GROUP BY csapat_nev, gyumolcs_nev) AS forras
pivot (sum(leadott_lada) for gyumolcs_nev in (alma, szilva) ) AS pt

/* UGYANAZ, MINT FENT, CSAK ATTI ÓRÁN EGYSZERŰBBEN MEGOLDOTTA*/
SELECT csapat_nev, alma, szilva
FROM (SELECT csapat_nev, gyumolcs_nev, leadott_lada
FROM eredm_pivot) AS forras
pivot (sum(leadott_lada) for gyumolcs_nev in (alma, szilva) ) AS pt

/*P4*/


--###########
--# UNPIVOT #
--###########
SELECT csapat_nev, nap_nev, pt.alma, pt.szilva INTO #temp FROM eredm_pivot
  PIVOT (SUM(leadott_lada) FOR gyumolcs_nev IN ([alma], [szilva])) AS pt
  ORDER BY csapat_nev, nap_nev 
-- ==> visszaforgatás
SELECT csapat_nev, nap_nev, gyumolcs_nev, leadott_lada FROM #temp 
  UNPIVOT (leadott_lada FOR gyumolcs_nev IN (alma, szilva)) AS upt
  ORDER BY csapat_nev, nap_nev, gyumolcs_nev


--HF.
--9/#2. és 9/#3.
