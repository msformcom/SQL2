/*
| Nom produit | Nom de categorie |
*/
SELECT  
		P.NOM_PRODUIT AS 'Nom Produit',
		C.Code_Categorie AS 'Code cat�gorie',
		C.NOM_CATEGORIE AS 'Nom Cat�gorie'
FROM PRODUITS AS P, CATEGORIES AS C
WHERE P.Code_Categorie= C.Code_Categorie
AND P.PRIX_UNITAIRE>100


SELECT  
		ISNULL(P.NOM_PRODUIT,'Aucun produit') AS 'Nom Produit',
		--P.CODE_CATEGORIE AS 'Code cat�gorie dans produit',
		-- C.Code_Categorie AS 'Code cat�gorie dans cat',
		ISNULL(C.NOM_CATEGORIE,'Non cat�goris�') AS 'Nom Cat�gorie'
FROM PRODUITS AS P FULL JOIN  CATEGORIES AS C  
ON P.Code_Categorie= C.Code_Categorie
--WHERE NOM_CATEGORIE  IS NULL



