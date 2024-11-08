
WITH Etape1 AS (
SELECT  MONTH(Date_Commande) AS Mois,
		NO_Employe,
		SUM(CA) AS CA
FROM ResumeCA
WHERE YEAR(Date_Commande)=2012
GROUP BY MONTH(Date_Commande),NO_Employe

),
Etape2 AS(
SELECT * ,
	RANK() OVER(PARTITION BY Mois ORDER BY CA DESC) AS RANK
	
FROM Etape1
)

SELECT Mois,
		E2.NO_Employe,
		E.Nom,
		E.PRENOM,
		Rank,
		CA
		INTO [PerfEmpl2012]
		FROM Etape2 AS E2
 RIGHT JOIN EMPLOYES AS E ON E.NO_EMPLOYE=E2.NO_EMPLOYE
WHERE Rank<=2
