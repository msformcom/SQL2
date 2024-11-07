-- Ordre de conception FROM => SELECT => WHERE => ORDER BY
-- Ordre d'apparition (syntaxe) => SELECT => FROM => WHERE => ORDER
-- Ordre ex�cution FROM => WHERE => SELECT => ORDER BY

SELECT TOP 10 NOM_PRODUIT AS 'Nom',
		PRIX_UNITAIRE * 1.2 AS 'Prix'
FROM PRODUITS
WHERE PRIX_UNITAIRE * 1.2 >10
ORDER BY PRIX_UNITAIRE DESC,
QUANTITE ,
		NOM ASC

SELECT TOP 10 PERCENT * FROM PRODUITS

SELECT * FROM PRODUITS
ORDER BY  PRIX_UNITAIRE
OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY
