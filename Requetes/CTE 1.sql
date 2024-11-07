-- CTE : Common Table Expression
-- Nommer une selection en vue de la réutiliser en suivant

WITH Etape1 AS  
-- Jointure et sélection de annee et mois
(
SELECT DATEPART(year,C.DATE_COMMANDE) AS 'Annee',
		DATEPART(month,C.DATE_COMMANDE) AS 'Mois',
		DC.REF_PRODUIT AS 'ref_Produit',
		DC.QUANTITE AS 'Qte',
		DC.PRIX_UNITAIRE * DC.QUANTITE AS 'CA_Genere'
FROM Commandes AS C INNER JOIN DETAILS_COMMANDES AS DC
ON DC.NO_COMMANDE = C.NO_COMMANDE
-- GROUP BY		DATEPART(year,C.DATE_COMMANDE),
--				DATEPART(month,C.DATE_COMMANDE)	
),
 Etape2 AS 
-- Group by 
(
SELECT Annee,
		Mois, 
		Ref_Produit,
		SUM(Qte) AS 'Quantite',
		Sum(CA_Genere) AS 'CA'

FROM Etape1
GROUP BY Annee,Mois, ref_Produit
)
SELECT * FROM Etape2