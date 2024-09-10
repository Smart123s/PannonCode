SELECT gyarto, tipus, ar,
    (CASE WHEN ar < 6000 THEN 
'Budget' ELSE CASE WHEN ar > 11000 THEN 'Luxury' ELSE 'Normal' END END ) AS csoport
FROM szgk;