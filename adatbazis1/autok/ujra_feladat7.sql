SELECT ugyfel.nev, COUNT(kolcsID) AS darab
FROM ugyfel
INNER JOIN kolcsonzes ON kolcsonzes.ugyfelID = ugyfel.ugyfelID
GROUP BY ugyfel.nev
HAVING AVG(DATEDIFF(DAY, kolcsonzes.kidat, kolcsonzes.visszadat)) > 6
;