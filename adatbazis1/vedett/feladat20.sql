SELECT DISTINCT kategoria.nev FROM kategoria
INNER JOIN allat ON kategoria.id = allat.katid
INNER JOIN ertek ON allat.ertekid = ertek.id
WHERE ertek.forint > 100000 /*0*/