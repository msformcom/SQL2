/*
 CA par annee et par produit
	Pour chaque produit => Nom produit, CA pour 2012, CA pour 2013 
*/

-- Sous requ�tes

-- CA Pour refproduit 1 sur 2012
SELECT SUM(DC.QUANTITE*DC.Prix_Unitaire)
FROM DETAILS_COMMANDES AS DC
INNER JOIN COMMANDES AS C ON C.NO_COMMANDE=DC.NO_COMMANDE
WHERE DC.REF_PRODUIT=1 AND YEAR(C.DATE_COMMANDE)=2012

SELECT P.REF_PRODUIT,
		NOM_PRODUIT,
		(SELECT SUM(DC.QUANTITE*DC.Prix_Unitaire)
		FROM DETAILS_COMMANDES AS DC
		INNER JOIN COMMANDES AS C ON C.NO_COMMANDE=DC.NO_COMMANDE
		WHERE DC.REF_PRODUIT=P.REF_PRODUIT AND YEAR(C.DATE_COMMANDE)=2011) AS CA2011,
		(SELECT SUM(DC.QUANTITE*DC.Prix_Unitaire)
		FROM DETAILS_COMMANDES AS DC
		INNER JOIN COMMANDES AS C ON C.NO_COMMANDE=DC.NO_COMMANDE
		WHERE DC.REF_PRODUIT=P.REF_PRODUIT AND YEAR(C.DATE_COMMANDE)=2012) AS CA2012,
		(SELECT SUM(DC.QUANTITE*DC.Prix_Unitaire)
		FROM DETAILS_COMMANDES AS DC
		INNER JOIN COMMANDES AS C ON C.NO_COMMANDE=DC.NO_COMMANDE
		WHERE DC.REF_PRODUIT=P.REF_PRODUIT AND YEAR(C.DATE_COMMANDE)=2013) AS CA2013
FROM PRODUITS AS P

-- Jointure et group by
SELECT	P.REF_PRODUIT, 
		P.NOM_PRODUIT, 
		YEAR(C.DATE_COMMANDE) AS Annee,
		SUM(DC.QUANTITE*DC.Prix_Unitaire) AS CAAnnee,
		(SELECT SUM(QUANTITE*PRIX_UNITAIRE) 
			FROM DETAILS_COMMANDES 
			WHERE REF_PRODUIT=P.REF_PRODUIT) AS CAGlobal
FROM Produits AS P 
INNER JOIN DETAILS_COMMANDES AS DC ON DC.REF_PRODUIT=P.REF_PRODUIT
INNER JOIN COMMANDES AS C ON C.NO_COMMANDE=DC.NO_COMMANDE
GROUP BY P.REF_PRODUIT, P.NOM_PRODUIT, YEAR(C.DATE_COMMANDE)
ORDER BY P.REF_PRODUIT, P.NOM_PRODUIT, YEAR(C.DATE_COMMANDE)