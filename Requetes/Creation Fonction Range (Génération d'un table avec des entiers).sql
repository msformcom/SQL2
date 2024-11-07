-- Creation de fonction pour générer des tables avec des entiers dedans
CREATE OR ALTER FUNCTION Range(
	@ValeurDebut INT,
	@ValeurFin INT)
	RETURNS @Resultat Table(n INT)
	AS 
	BEGIN
		
		WHILE @ValeurDebut<= @ValeurFin
			BEGIN
				INSERT INTO @Resultat(n)
				VALUES(@ValeurDebut)

				SET @ValeurDebut=@ValeurDebut+1
			END

		RETURN 
	END