-- Objectif : Mettre à jour les enregistrements de la tables des employes
-- en fonction des données de la table [PerfEmpl2012]
-- => Jointure entre la tables des employes et la table des PerfEmpl2012
-- => Update sur la selection de la jointure

WITH Commissions AS (
SELECT No_Employe, SUM(CASE WHEN Rank=1 THEN CA*0.01
				WHEN RAnk=2 THEN CA*0.005
				ELSE 0 END) AS Commission2012
FROM [dbo].[PerfEmpl2012]
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

SELECT * FROM Employes

UPDATE Employes SET COMMISSION=0