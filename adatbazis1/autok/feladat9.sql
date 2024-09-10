SELECT ugyfel.nev
FROM (

SELECT ugyfel.ugyfelID, MAX(kolcsonzes.kidat) AS m
    FROM ugyfel
        INNER JOIN kolcsonzes ON ugyfel.ugyfelID = kolcsonzes.ugyfelID
        INNER JOIN szgk ON szgk.rendszam = kolcsonzes.rendszam
    GROUP BY ugyfel.ugyfelID
) sub
    INNER JOIN ugyfel ON sub.ugyfelID=ugyfel.ugyfelID
    INNER JOIN kolcsonzes ON ugyfel.ugyfelID = kolcsonzes.ugyfelID AND sub.m=kolcsonzes.kidat
    INNER JOIN szgk ON szgk.rendszam = kolcsonzes.rendszam
WHERE szgk.gyarto = 'Opel'
;