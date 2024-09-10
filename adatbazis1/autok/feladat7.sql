SELECT kolcsonzes.ugyfelID, ugyfel.nev, AVG(DATEDIFF(DAY, kidat, visszadat)) AS napok
FROM kolcsonzes INNER JOIN ugyfel ON ugyfel.ugyfelID=kolcsonzes.ugyfelID
GROUP BY kolcsonzes.ugyfelID, ugyfel.nev
HAVING AVG(DATEDIFF(DAY, kidat, visszadat)) > 6;