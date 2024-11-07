/*
 Travail pratique : Connaitre la demande des  produits avec regroupement suir fournisseur
 de 01/01/203 à 31/03/2013
 Moyenne reduc = Différence entre prix unitaire catalogue (Produits) et Prix unitaire vendu


| Soc Fournisseur | Nom produit | Stock    | Nb Unit Vendues   | Moy reduc € | Moy reduc % | CA       | Perte CA reduc |
| Fournisseurs    | Produits    | Produits | Aggreg            | Aggreg      | Aggreg      | Aggreg   | Aggreg         |
|                 |             |          | Details_Commandes | Produit     | Produit     | Det_Comm | Produit        |
|                 |             |          | Quantite          | Det_Comm    | Det_Comm    |          | Det_Comm       |      

*/


SET DATEFORMAT DMY -- Spécification de l'interpréation des dates dans le code (pas affichage)

-- Date de la première vente (prendra en compte le debut du mois)
DECLARE @DateDebut DATE = '03-01-2013' 
-- Date de la dernière vente (prendra en compte la fin du mois)
DECLARE @DateFin DATE= '30-03-2013'

-- Calculs sur les paramètres

SET  @DateDebut=CAST(CONCAT(YEAR(@DateDebut),'/', MONTH(@DateDebut),'/01') as DAte) -- Calcul du début du mois
SET @DateFin=DATEADD(day,1,EOMONTH(@DateFin)) -- calcul du premier jour du mois suivant

-- Vérification des paramètres

IF @DateDebut>@DateFin
BEGIN
	-- Erreur dans les paramètres d'entrée 
	;THROW 50000,'La date de début ne peut pas être postérieure à la date de fin',1
END

SELECT * FROM Produits 

;WITH Etape1 AS (
-- Jointure et séléction des colonnes interessantes
SELECT F.NO_FOURNISSEUR,
		F.SOCIETE,
		P.REF_PRODUIT,
		P.NOM_PRODUIT,
		P.UNITES_STOCK,
		DC.QUANTITE,
		P.PRIX_UNITAIRE AS 'PrixProduit',
		DC.PRIX_UNITAIRE AS 'PrixVente'
FROM FOURNISSEURS AS F
		INNER JOIN PRODUITS AS P ON P.NO_FOURNISSEUR=F.NO_FOURNISSEUR
		LEFT JOIN DETAILS_COMMANDES AS DC ON DC.REF_PRODUIT=P.REF_PRODUIT
		INNER JOIN COMMANDES AS CO ON CO.NO_COMMANDE=DC.NO_COMMANDE
WHERE CO.DATE_COMMANDE >= @DateDebut AND CO.DATE_COMMANDE<@DateFin
),
Etape2 AS (
-- Group by 
SELECT NO_FOURNISSEUR,SOCIETE, REF_PRODUIT, PrixProduit, NOM_PRODUIT, UNITES_STOCK,
	SUM(Quantite) AS 'Quantite_vendue',
	SUM(PrixProduit*quantite-PrixVente*QUANTITE) AS 'Total_Reduc',
	SUM(PrixVente*QUANTITE) AS 'CAGenere'

FROM Etape1
GROUP BY NO_FOURNISSEUR,SOCIETE, REF_PRODUIT, PrixProduit, NOM_PRODUIT, UNITES_STOCK
), Etape3 AS (
-- Calcul des colonnes déduites du group by
SELECT *, 
	Total_Reduc/Quantite_vendue AS 'MoyenneReducValeur',
	Total_Reduc/CAGenere  AS 'MoyenneReducPercent'
FROM Etape2)
-- Selection finale
SELECT * FROM Etape3