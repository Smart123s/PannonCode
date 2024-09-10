SELECT ugyfel.nev
    FROM (
        SELECT COUNT(sub.ugyfelID) AS cou, sub.ugyfelID
        FROM (SELECT DISTINCT ugyfel.ugyfelID, ugyfel.nev, szgk.gyarto
            FROM  ugyfel
            INNER JOIN kolcsonzes ON kolcsonzes.ugyfelID=ugyfel.ugyfelID
            INNER JOIN szgk ON szgk.rendszam = kolcsonzes.rendszam
            GROUP BY ugyfel.ugyfelID, szgk.gyarto, ugyfel.nev
            HAVING (szgk.gyarto = 'BMW' OR szgk.gyarto = 'Chevrolet')
        ) AS sub
        GROUP BY sub.ugyfelID
    ) AS subb
INNER JOIN ugyfel ON ugyfel.ugyfelID = subb.ugyfelID
GROUP BY cou, subb.ugyfelID, ugyfel.nev
HAVING cou = 2

