GO

DECLARE @i INT;
DECLARE @eredmeny INT;

SELECT @i = 1;
SELECT @eredmeny = 0;

WHILE @i <= 50
BEGIN
    SELECT @eredmeny = @eredmeny + @i;
    SELECT @i = @i + 1;
END;

PRINT 'Az első 50 szám összege: ' + CAST(@eredmeny AS VARCHAR(10));

GO
