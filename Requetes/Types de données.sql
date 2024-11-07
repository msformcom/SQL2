DECLARE @Val INT -- => 32Bits => -2 131 000 000 => 2 131 000 000 
DECLARE @Val1 BIGINT -- => 64bit => 

DECLARE @float FLOAT
DECLARE @decimal DECIMAL(18,2) -- => 18 chiffres significatifs dont 2 après la virgule

DECLARE  @text VARCHAR(10)='Dom' -- => 10 Caracteres 'DOM      '
PRINT @text+@text

-- CHAR(10)
-- VARCHAR(10)
-- NCHAR(10)
-- NVARCHAR(10)

-- N => Unicode <=> ASCII

-- rené => ASCII(FR) => 56 76 89 156   => ASCII(DK) => renô
-- rené => Unicode => 56 76 89 (156 87 56) => Unicode => rené

DECLARE  @text1 VARCHAR(10)=N'Do?????'
PRINT @text1
DECLARE  @text2 NVARCHAR(10)=N'Dom'

DECLARE @a FLOAT=1;
DECLARE @i INT =0;
WHILE @i<10
BEGIN
	SET @a=@a+0.3
	SET @i=@i+1
END

IF @a=4
BEGIN
	PRINT @a
END