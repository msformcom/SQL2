-- Recherche des produits
/*
 indisponible => 0 dispo, -1 => en cours de r�appro => 1 indispoo
 prix unitaire => <100 Bon march� , 101 a 200 normal, 201 a 500 Cher >500 tres cher
*/
SELECT	[NOM_PRODUIT] AS 'Nom produit', 
		[PRIX_UNITAIRE] * 1.2 AS "Unit price",	-- calcul
		[QUANTITE]  AS [Quantity],
		[INDISPONIBLE]  AS 'Availibility',
		CASE	WHEN INDISPONIBLE=0 THEN 'Dispo'   -- cas fonction de la valeur
				WHEN INDISPONIBLE=-1 THEN 'Reappro'
				ELSE 'Indispo' END AS 'Availibility',
		CASE WHEN PRIX_UNITAIRE<=100 THEN 'Bon march�'
			 WHEN PRIX_UNITAIRE<=200 THEN 'Normal'
			  WHEN PRIX_UNITAIRE<=500 THEN 'Cher'
			  ELSE 'Tr�s cher' END AS 'Indication',
		[NOM_PRODUIT] + ' ('+ QUANTITE + ')' AS 'Produit', -- Concatenation avec +
		CONCAT(Nom_Produit,' (', QUANTITE,')')  AS 'Produit', -- Concat
		CONCAT(FORMAT([PRIX_UNITAIRE] * 1.2,'N','fr-fr'), ' �') AS 'Prix HT' -- Formatage nombre

FROM Produits