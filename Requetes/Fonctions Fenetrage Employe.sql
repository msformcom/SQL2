-- Classement des employes en fonction du CA qu'ils ont généré
WITH RawData AS (
SELECT 
No_Employe,
 YEAR(Date_Commande) AS Annee,
SUM(CA) AS CA
FROM ResumeCA
GROUP BY NO_Employe, YEAR(Date_Commande))
SELECT * , 
	DENSE_RANK() OVER (PARTITION BY Annee ORDER BY CA DESC) AS Classement,
	CA/SUM(CA) OVER (PARTITION BY Annee) AS CA_Annee
FROM RawData
