/*
	Tous les employes qui ont gener� plus de CA en 2012 qu'en 2013
	S1) SELECT  tous les employes | NO_Employe | Nom | Prenom |  
	S2) SELECT qui ramene le CA d'un employe pour 2012
	S3) SELECT qui ramene le CA d'un employe pour 2013

	4) Int�grer les valeurs de S2 et S3 comme colonne dans la S1
		| NO_Employe | Nom | Prenom | CA 2012 | CA 2013 |
	5) Faire un WHERE
*/
WITH ResumeCA AS (
SELECT C.NO_COMMANDE, 
		CODE_CLIENT, 
		NO_EMPLOYE, 
		DATE_COMMANDE,
		PORT,
		SUM(DC.Quantite*DC.Prix_Unitaire) AS CA
FROM COMMANDES AS C
		INNER JOIN DETAILS_COMMANDES AS DC ON DC.NO_COMMANDE=C.NO_COMMANDE
GROUP BY C.NO_COMMANDE,  CODE_CLIENT,  NO_EMPLOYE, DATE_COMMANDE, PORT
)
,Etape2 AS (
SELECT	E.NO_EMPLOYE,
		E.NOM,
		E.Prenom,
		(SELECT SUM(CA) FROM ResumeCA
			WHERE NO_EMPLOYE=E.NO_EMPLOYE AND YEAR(DATE_COMMANDE)=2012) AS CA2012,
		(SELECT SUM(CA) FROM ResumeCA
			WHERE NO_EMPLOYE=E.NO_EMPLOYE AND YEAR(DATE_COMMANDE)=2013)  AS CA2013
FROM EMPLOYES AS E)
SELECT * FROM Etape2
WHERE CA2012 > = CA2013