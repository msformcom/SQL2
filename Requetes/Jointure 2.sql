/*
| annee | mois | RefProduit | Quantite | CA genere |
| Commandes    | Details_Commandes                 |


1) Identification des tables
2) Identification des conditions de jointure
3) FROM + JOIN
4) Selection
*/
SELECT DATEPART(year,C.DATE_COMMANDE) AS 'Annee',
		DATEPART(month,C.DATE_COMMANDE) AS 'Mois',
		DC.REF_PRODUIT AS 'ref_Produit',
		DC.QUANTITE AS 'Qte',
		DC.PRIX_UNITAIRE * DC.QUANTITE AS 'CA_Genere'
FROM Commandes AS C INNER JOIN DETAILS_COMMANDES AS DC
ON DC.NO_COMMANDE = C.NO_COMMANDE
ORDER BY Annee,Mois
/*
| annee | mois | RefProduit | CA |
*/

