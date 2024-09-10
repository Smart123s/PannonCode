SELECT ugyfel.nev FROM ugyfel
WHERE ugyfel.ugyfelid IN 
(
    SELECT kolcsonzes.ugyfelID
    FROM kolcsonzes
    INNER JOIN szgk ON szgk.rendszam = kolcsonzes.rendszam
    WHERE szgk.gyarto = 'BMW'
)
AND
ugyfel.ugyfelid IN 
(
    SELECT kolcsonzes.ugyfelID
    FROM kolcsonzes
    INNER JOIN szgk ON szgk.rendszam = kolcsonzes.rendszam
    WHERE szgk.gyarto = 'Chevrolet'
)
;