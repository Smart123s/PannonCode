SELECT TOP 10 WITH TIES
    allat.nev, allat.ev
FROM allat
WHERE allat.ev IS NOT NULL
ORDER BY allat.ev ASC
;