SELECT nev, ev, CONCAT(nev, ' - ',  ev) AS "Védett Állatok" FROM allat WHERE ev IS NOT NULL;