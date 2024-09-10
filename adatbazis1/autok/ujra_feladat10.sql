SELECT szgk.rendszam, szgk.gyarto, szgk.tipus, DATEDIFF(MONTH, 
    (
        SELECT MIN(kidat) FROM kolcsonzes
        WHERE kolcsonzes.rendszam = szgk.rendszam
    ), GETDATE()) AS ELTELT_HONAPOK
    FROM szgk;