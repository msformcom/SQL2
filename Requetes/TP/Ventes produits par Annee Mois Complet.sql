DECLARE @annee1 INT
DECLARE @annee2 INT

--SET @Annee1=(SELECT MIN(Annee) FROM VentesProduits(10))
--SET @Annee2=(SELECT MAX(Annee) FROM VentesProduits(10))

SELECT @annee1=MIN(Annee),@annee2=MAX(Annee) FROM VentesProduits(10)
-- Jointure entre annees, mois, et les donnees de vente produit pour le produit 10
SELECT @annee1,@annee2


SELECT Annees.N as Annee,
		Mois.N as Mois,
		ISNULL(V.QuantiteTotal,0) AS Quantite,
		ISNULL(V.MontantTotal,0) AS Montant
FROM Range(@annee1,@annee2) AS Annees
	CROSS JOIN Range(1,12) AS Mois
	LEFT JOIN VentesProduits(10) AS V
	ON Annees.N=V.annee AND Mois.N=V.Mois



