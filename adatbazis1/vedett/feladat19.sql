SELECT
    CASE WHEN COUNT(allat.nev) > 0 
THEN 'YES' 
ELSE 'NO' END
FROM allat
    INNER JOIN kategoria ON kategoria.id = allat.katID
    INNER JOIN ertek ON ertek.id = allat.ertekid
WHERE kategoria.nev = 'emlosök' AND ertek.forint = 100000;