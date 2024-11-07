/*
| Nom produit | Nom de categorie |
*/
SELECT  
		P.NOM_PRODUIT AS 'Nom Produit',
		C.Code_Categorie AS 'Code catégorie',
		C.NOM_CATEGORIE AS 'Nom Catégorie'
FROM PRODUITS AS P, CATEGORIES AS C
WHERE P.Code_Categorie= C.Code_Categorie
AND P.PRIX_UNITAIRE>100


SELECT  
		ISNULL(P.NOM_PRODUIT,'Aucun produit') AS 'Nom Produit',
		--P.CODE_CATEGORIE AS 'Code catégorie dans produit',
		-- C.Code_Categorie AS 'Code catégorie dans cat',
		ISNULL(C.NOM_CATEGORIE,'Non catégorisé') AS 'Nom Catégorie'
FROM PRODUITS AS P FULL JOIN  CATEGORIES AS C  
ON P.Code_Categorie= C.Code_Categorie
--WHERE NOM_CATEGORIE  IS NULL



