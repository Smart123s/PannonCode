SELECT kolcsonzes.rendszam, szgk.gyarto, szgk.tipus, DATEDIFF(MONTH, GETDATE(), MIN(kidat)) * -1 AS honap
FROM kolcsonzes
INNER JOIN szgk ON szgk.rendszam=kolcsonzes.rendszam
GROUP BY kolcsonzes.rendszam, szgk.gyarto, szgk.tipus
