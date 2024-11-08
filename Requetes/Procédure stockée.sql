-- Création de procedure
-- EXEC MajCommisions 2012 pour exécuter
CREATE OR ALTER PROCEDURE MajCommisions (@Annee INT=NULL) 
AS 
BEGIN
	IF @Annee IS NULL
	BEGIN
		SET @Annee=YEAR(GETDATE())
	END
	BEGIN TRAN  -- Début des opérations


	BEGIN TRY
		-- Faire des choses en s'assurant que les erreurs soient gérées
		-- Suppression des commision dans les employes
					UPDATE Employes SET Commission=0;


					;WITH Etape1 AS (
					SELECT  MONTH(Date_Commande) AS Mois,
							NO_Employe,
							SUM(CA) AS CA
					FROM ResumeCA
					WHERE YEAR(Date_Commande)=@Annee
					GROUP BY MONTH(Date_Commande),NO_Employe

					),
					Etape2 AS(
					SELECT * ,
						RANK() OVER(PARTITION BY Mois ORDER BY CA DESC) AS RANK
	
					FROM Etape1
					), Etape3 AS (

					SELECT Mois,
							E2.NO_Employe,
							E.Nom,
							E.PRENOM,
							Rank,
							CA

							FROM Etape2 AS E2
					 RIGHT JOIN EMPLOYES AS E ON E.NO_EMPLOYE=E2.NO_EMPLOYE
					WHERE Rank<=2),
					Commissions AS (
					SELECT No_Employe, SUM(CASE WHEN Rank=1 THEN CA*0.01
									WHEN RAnk=2 THEN CA*0.005
									ELSE 0 END) AS Commission2012
					FROM Etape3
					GROUP BY NO_Employe
					), MAJ AS (
					-- Prendre les données de [PerfEmpl2012]
					-- Si employe arrive en 1 sur le mois => 1%
					-- Si employe arrive en 1 sur le mois => 0.5%
					SELECT E.NO_EMPLOYE, 
							COMMISSION,  
							Commission2012 FROM Employes 
						AS E INNER JOIN Commissions AS C
						ON E.NO_EMPLOYE=C.NO_Employe
						)
					-- SELECT * FROM Maj
					-- UPDATE SUR les lignes de la selection 
					UPDATE MAJ SET Commission=Commission2012

					SELECT * FROM Employes;
					 DECLARE @message NVARCHAR(50) = CONCAT('Mise à jour faite : ',@Annee)
					PRINT @message  
		COMMIT -- Tout c'est bien passé : Validation
	END TRY
	BEGIN CATCH
		ROLLBACK -- Une erreur est survénue : Annulation
		;THROW 50000, 'Erreur pendant le procédure',1
	END CATCH









					

END