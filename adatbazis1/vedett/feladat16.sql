SELECT DISTINCT kategoria.nev FROM kategoria
WHERE kategoria.id NOT IN (SELECT allat.katid FROM ALLAT)
/*LEFT JOIN allat ON allat.katid = kategoria.id;*/;