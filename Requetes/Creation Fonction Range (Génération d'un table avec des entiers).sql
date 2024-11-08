-- Creation de fonction pour générer des tables avec des entiers dedans
USE tempdb
GO
CREATE OR ALTER FUNCTION Range(
	@ValeurDebut INT,
	@ValeurFin INT)
	RETURNS @Resultat Table(n INT)
	AS 
	BEGIN
		-- Dans une fonction, les modifs sont impossibles
		-- UPDATE Produits SET Prix_Unitaire=Prix_Unitaire*12
		WHILE @ValeurDebut<= @ValeurFin
			BEGIN
				INSERT INTO @Resultat(n)
				VALUES(@ValeurDebut)

				SET @ValeurDebut=@ValeurDebut+1
			END

		RETURN 
	END