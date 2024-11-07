-- Utilisation de la tables des nums
WITH Mois AS (
-- Mois : Le nombres de 1 a 12
SELECT * FROM Nums WHERE n BETWEEN 1 AND 12
),
Annees AS ( 
-- Années : Nombre de 2011 à 2012
SELECT * FROM Nums WHERE n BETWEEN 2011 AND 2013
),
AnneesMois AS (
-- Combinaisons de Annees et mois 
SELECT Annees.n as Annee, Mois.n AS Mois FROM Annees ,Mois
),
Data AS (
	SELECT  YEAR(C.DATE_COMMANDE) AS Annee, 
			MONTH(C.DATE_COMMANDE) AS Mois,
			SUM(DC.QUANTITE) AS QTE
	FROM DETAILS_COMMANDES AS DC 
		INNER JOIN COMMANDES C ON C.NO_COMMANDE=DC.NO_COMMANDE
	WHERE DC.REF_PRODUIT=5
	GROUP BY YEAR(C.DATE_COMMANDE), MONTH(C.DATE_COMMANDE)
)
SELECT AM.Annee,
		AM.Mois,
		ISNULL(QTE,0)
FROM AnneesMois AS AM
LEFT JOIN DATA AS D ON AM.Annee=D.Annee AND AM.Mois=D.Mois
