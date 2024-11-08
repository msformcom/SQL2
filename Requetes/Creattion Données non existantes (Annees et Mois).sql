-- SQL SERVER 2022 => SELECT FROM VALUES => 
--SELECT * FROM
--(VALUES((2011),(2012),(2013))  T(n)

-- Creation de table avec une colonne n
-- CREATE TABLE n�cessite des droits
CREATE TABLE Nums(     
	n INT PRIMARY KEY
)
-- Nom de table avec  # => Cr��e dans la BDD TempDB
-- Automatiquement supprim�e � la deconnexion
CREATE TABLE #Nums(     
	n INT PRIMARY KEY
)

-- Cr�ation d'une variable de type table => RAM
-- A condition de ne pas trop charger des donn�es
DECLARE @Nums TABLE(
	n INT 
)

-- Remplissage de table
DECLARE @i INT=2011
WHILE @i<=2013
BEGIN 
	INSERT INTO @Nums (n) VALUES(@i)
	SET @i=@i+1
END
SELECT * FROM @Nums
-- Id�alement : JE veux avoir une fonction qui me donne le r�sultat que j'attens
SELECT * FROM Range(2011,2013) AS Annees , Range(1,12) AS Mois