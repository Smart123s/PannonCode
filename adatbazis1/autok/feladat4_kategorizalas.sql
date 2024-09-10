SELECT gyarto, tipus, ar, CASE 
    WHEN ar < 6000 THEN 'Budget'
    WHEN ar > 11000 THEN 'Luxury'
    ELSE 'Normal'
END AS tipus FROM szgk;
