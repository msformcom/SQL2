-- SQL SERVER 2022 => SELECT FROM VALUES => 
--SELECT * FROM
--(VALUES((2011),(2012),(2013))  T(n)

-- Creation de table avec une colonne n
-- CREATE TABLE nécessite des droits
CREATE TABLE Nums(     
	n INT PRIMARY KEY
)
-- Nom de table avec  # => Créée dans la BDD TempDB
-- Automatiquement supprimée à la deconnexion
CREATE TABLE #Nums(     
	n INT PRIMARY KEY
)

-- Création d'une variable de type table => RAM
-- A condition de ne pas trop charger des données
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
-- Idéalement : JE veux avoir une fonction qui me donne le résultat que j'attens
SELECT * FROM Range(2011,2013) AS Annees , Range(1,12) AS Mois