/*
|Annee | Nom employe | Prenom Employe | Ref_Produit | CA |

1) Tables =>Employes , Commandes ,  Details Commandes

Sous totaux par Annee, Employe, Refproduit
*/
WITH Jointure AS (
SELECT YEAR(C.Date_Commande) AS 'Annee',
		E.NO_EMPLOYE AS 'EmpID',
		E.NOM AS 'Nom',
		E.PRENOM AS 'Prenom',
		D.REF_PRODUIT AS 'Ref_Produit',
		D.QUANTITE*D.PRIX_UNITAIRE AS 'CA'
FROM EMPLOYES AS E
		INNER JOIN COMMANDES AS C ON C.NO_EMPLOYE=E.NO_EMPLOYE
		INNER JOIN DETAILS_COMMANDES AS D ON D.NO_COMMANDE=C.NO_COMMANDE
),
Groupement AS (
SELECT Annee, 
		Empid,
		Nom, 
		Prenom,
		Ref_Produit,
		SUM(CA) AS 'CA'
		FROM Jointure
GROUP BY 
GROUPING SETS(
	Annee,
	Ref_Produit,
	(EmpID,Nom,Prenom),
	(Annee,Ref_Produit),
	(EmpID,Nom,Prenom,Ref_Produit),
	(Annee,EmpID,Nom,Prenom,Ref_Produit)
)
)
SELECT * FROM Groupement
WHERE EmpID=2 AND Annee IS NULL 
ORDER BY Annee,Ref_Produit,Nom,Prenom