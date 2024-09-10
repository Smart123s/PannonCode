SELECT ugyfel.nev
FROM ugyfel
    INNER JOIN kolcsonzes ON kolcsonzes.ugyfelid = ugyfel.ugyfelid
    INNER JOIN szgk ON szgk.rendszam = kolcsonzes.rendszam
WHERE kolcsonzes.kidat = (SELECT MAX(kolcsonzes.kidat) AS last
    FROM kolcsonzes
        INNER JOIN szgk ON szgk.rendszam = kolcsonzes.rendszam
    GROUP BY kolcsonzes.ugyfelid
    HAVING kolcsonzes.ugyfelid = ugyfel.ugyfelid) AND szgk.gyarto = 'Opel';
 