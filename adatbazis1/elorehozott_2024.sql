/*1. FELADAT*/
SELECT * INTO d00_2.dbo.sportagak FROM db_otkarika.dbo.sportagak;
SELECT * INTO d00_2.dbo.erem_tabla FROM db_otkarika.dbo.erem_tabla;


/*2. FELADAT*/
CREATE VIEW v_kanadai_egyeni AS
SELECT eredmenyek.Helyezes, versenyzok.ID, versenyzok.Nev, versenyszamok.Versenyszam, eredmenyek.evszam, sportagak.Megnevezes
FROM eredmenyek
INNER JOIN versenyzok ON eredmenyek.VersenyzoID = versenyzok.ID
INNER JOIN versenyszamok ON versenyszamok.ID = eredmenyek.VersenyszamID
INNER JOIN sportagak ON sportagak.ID = versenyszamok.SportagID
;



/*3. FELADAT*/
DROP INDEX orszag_index ON orszagok;
CREATE UNIQUE INDEX orszag_index ON orszagok(Orszag)
;

/*4. FELADAT*/
ALTER TABLE eredmenyek
ADD Erem varchar(5);

UPDATE eredmenyek SET erem = CASE
WHEN helyezes = 1 THEN 'arany'
WHEN helyezes = 2 THEN 'ezüst'
WHEN helyezes = 3 THEN 'bronz'
ELSE ''
END;



/*5. FELADAT*/


DROP TABLE kabalak;
CREATE TABLE [dbo].[kabalak] (
    [sorszam] INT          NOT NULL,
    [ev]      INT          NOT NULL,
    [orszag]  INT          NOT NULL,
    [varos]   VARCHAR (30) NULL,
    [kabala]  VARCHAR (50) DEFAULT ('') NULL,
    CONSTRAINT [PK_kabalak] PRIMARY KEY CLUSTERED ([sorszam] ASC)
);

SELECT id, Orszag
FROM orszagok
WHERE LEFT(Orszag, 2) = 'Br'
;

INSERT INTO kabalak(sorszam, ev, varos, orszag, kabala)
VALUES (1, 2016, 'Rio de Janeiro', (SELECT id FROM orszagok WHERE orszag = 'Brazília'), 'Vinicius és Tom');
SELECT * FROM kabalak;



ALTER TABLE [dbo].[eredmenyek] ADD PRIMARY KEY CLUSTERED 
(
	[VersenyzoID] ASC,
	[VersenyszamID] ASC,
	[Evszam] ASC
)



/*6. FELADAT*/
SELECT TOP 1 *, DATEDIFF(YEAR, SzulDat, GetDate()) As Kor FROM versenyzok
WHERE SzulDat IS NOT NULL
ORDER BY SzulDat ASC
;


/*7. FELADAT*/
SELECT versenyzok.ID, Nev, versenyszamok.Versenyszam, eredmenyek.Helyezes
FROM versenyzok
INNER JOIN eredmenyek ON eredmenyek.VersenyzoID = versenyzok.ID
INNER JOIN versenyszamok ON versenyszamok.ID = eredmenyek.VersenyszamID
INNER JOIN sportagak ON sportagak.ID = versenyszamok.SportagID
WHERE eredmenyek.Evszam = 2008
AND sportagak.Megnevezes = 'Úszás'
AND versenyszamok.FerfiNoi = 'Férfi'
ORDER BY eredmenyek.Helyezes ASC
;


/*8. FELADAT*/
/*Országok átlagos területe egy földrészen*/
SELECT Foldresz AS 'Földrséz', AVG(Terulet) AS 'Átlagterület', COUNT(ID) AS 'Ország'
FROM Orszagok
GROUP BY Foldresz
HAVING Foldresz IS NOT NULL
ORDER BY AVG(Terulet) DESC
;


/*9. FELADAT*/

SELECT sub.Nev AS 'Név', sub.ID AS 'Versenyzőszám', COUNT(eredmenyek.Evszam) AS 'Indulásszám'
FROM (
    SELECT versenyzok.Nev, versenyzok.ID
    FROM versenyzok
    INNER JOIN eredmenyek ON eredmenyek.VersenyzoID = versenyzok.ID
    /* A feladat nem köti ki, hogy mind a két olimpián 1-5 helyezést kell-e elérniük */
    WHERE Versenyzok.Egyen_Csapat = 'e' AND eredmenyek.Helyezes >= 5
) AS sub
INNER JOIN eredmenyek ON eredmenyek.VersenyzoID = sub.ID
INNER JOIN versenyszamok ON versenyszamok.ID = eredmenyek.VersenyszamID
INNER JOIN sportagak ON sportagak.ID = versenyszamok.SportagID
GROUP BY sub.Nev, sub.ID
HAVING COUNT(eredmenyek.Evszam) >= 2
ORDER BY COUNT(eredmenyek.Evszam) DESC
;



/*10. FELADAT*/

SELECT sub.Nev AS 'Név', sub.ID AS 'Versenyzőszám'
FROM 
(
    SELECT versenyzok.ID, versenyzok.Nev
    FROM versenyzok
    INNER JOIN eredmenyek ON eredmenyek.VersenyzoID = versenyzok.ID
    INNER JOIN versenyszamok ON versenyszamok.ID = eredmenyek.VersenyszamID
    INNER JOIN sportagak ON sportagak.ID = versenyszamok.SportagID
    WHERE eredmenyek.Evszam = 2016 AND eredmenyek.Helyezes <= 3
    AND versenyzok.Egyen_Csapat = 'e'
) AS sub
INNER JOIN eredmenyek ON eredmenyek.VersenyzoID = sub.ID
INNER JOIN versenyszamok ON versenyszamok.ID = eredmenyek.VersenyszamID
INNER JOIN sportagak ON sportagak.ID = versenyszamok.SportagID
WHERE eredmenyek.Evszam = 2012 AND eredmenyek.Helyezes <= 3
;



/*11. FELADAT*/

SELECT csapattagok.CsapatID, versenyzok.Nev, CONCAT(sportagak.Megnevezes, ' - ', versenyszamok.Versenyszam) AS 'Sportag'
FROM csapattagok
INNER JOIN versenyzok ON csapattagok.VersenyzoID = versenyzok.ID
INNER JOIN eredmenyek ON eredmenyek.VersenyzoID = versenyzok.ID
INNER JOIN versenyszamok ON versenyszamok.ID = eredmenyek.VersenyszamID
INNER JOIN sportagak ON sportagak.ID = versenyszamok.SportagID
WHERE csapattagok.CsapatID IN (
    SELECT csapattagok.CsapatID
    FROM csapattagok
    INNER JOIN versenyzok ON csapattagok.VersenyzoID = versenyzok.ID
    WHERE versenyzok.SzulHely = 'Veszprém'
)
AND NOT versenyzok.SzulHely = 'Veszprém'
ORDER BY csapattagok.CsapatID ASC
;



/*12. FELADAT*/

SELECT versenyzok.ID, versenyzok.Nev, sub.Legjobb, DATEDIFF(YEAR, versenyzok.SzulDat, GETDATE()) AS kor
FROM (
    SELECT DISTINCT versenyzok.ID, MIN(eredmenyek.Helyezes) AS 'Legjobb'
    FROM versenyzok
    INNER JOIN eredmenyek ON eredmenyek.VersenyzoID = versenyzok.ID
    GROUP BY versenyzok.Id, versenyzok.Nev
    HAVING MIN(eredmenyek.Helyezes) <= 5
) AS sub
INNER JOIN versenyzok ON versenyzok.ID = sub.ID
INNER JOIN eredmenyek ON eredmenyek.VersenyzoID = versenyzok.ID
WHERE eredmenyek.Helyezes = sub.Legjobb
AND versenyzok.ID = sub.ID
;


