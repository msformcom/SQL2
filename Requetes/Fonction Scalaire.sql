-- Fonctions de type scalaire
SELECT NOM_PRODUIT,
		PRIX_UNITAIRE,
		CASE WHEN PRIX_UNITAIRE<100 THEN 'Pas cher'
			 WHEN PRIX_UNITAIRE<200 THEN 'Moyen'
			 ELSE 'Cher' END AS IndicationPrix
FROM Produits

SELECT NOM_PRODUIT,
		PRIX_UNITAIRE,
		dbo.IndicPrix(PRIX_UNITAIRE) AS IndicationPrix
FROM Produits

-- Création de fonction
CREATE OR ALTER FUNCTION IndicPrix(
	@valeur DECIMAL(18,2) -- La valeur sur laquelle se baser pour l'indication
	)
	-- Type de retour 
	RETURNS NVARCHAR(20)
	AS 
	BEGIN
	
		RETURN CASE WHEN @valeur<100 THEN N'Pas cher'
				 WHEN @valeur<200 THEN N'Moyen'
				 ELSE N'Cher' END 
	END

	SELECT dbo.IndicPrix(210)