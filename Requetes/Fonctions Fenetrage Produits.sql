-- Fonction de fenètrage

SELECT REF_PRODUIT,
		NOM_PRODUIT,
		CODE_CATEGORIE,
		PRIX_UNITAIRE,
		ROW_NUMBER() OVER (ORDER BY Prix_Unitaire) AS RowNumber,
		RANK() OVER (ORDER BY Prix_Unitaire) AS Rank,
		DENSE_RANK() OVER (PARTITION BY Code_Categorie ORDER BY Prix_Unitaire) AS DENSE_RANK,
		MIN(Prix_Unitaire) OVER (PARTITION BY Code_Categorie) AS MinPrixCat,
		AVG(Prix_Unitaire) OVER (PARTITION BY Code_Categorie) AS MoyennePrixCat

FROM PRODUITS
ORDER BY Code_Categorie,Prix_Unitaire