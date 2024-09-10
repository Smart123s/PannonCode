SELECT allat.nev, kategoria.nev FROM allat
INNER JOIN kategoria ON allat.katid = kategoria.id
WHERE allat.ev = 1993
;