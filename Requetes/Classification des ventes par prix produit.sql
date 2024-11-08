/*
 TP : Classification des ventes en fonction du prix du produit
 Sur les 6 derniers mois d'activité


 | De   | à    | Nb Produits dans le catalogue | Qte Produits vendus|   CA généré | Rank(qte) | Rank(CA) | % CA |
 -------------------------------------------------------------------------------------------------------------------------------
 | 0    | 100  | 13							   | 1000               |   50000     | 5         | 7        | 0.1
 | 100  | 200  | 25							   | 1456               |   30000     | 3         | 5        | 0.11
 
 | 300  | 400  | 25							   | 1456               |   30000     | 3         | 5        | 0.11
 
 | 500  | 600  | 25							   | 1456               |   70000     | 4         | 1        | 1.2
 
 
 | 1300 | 1400 | 3							   | 19                 |   27000     | 10        | 9        |

1) Calculer la date de la derniere commande => enlever 6 mois => Variable
2) TAbles => Commandes Produits DetailsCommande
3) Générer les intervales => Intervales
4) Jointure avec les tables Commandes Produits DetailsCommande
5) Group BY
6) Ajouter les 3 dernière colones (travail sur les fenêtre


*/
-- Calcul du prix Maximum pour limiter les intervales
DECLARE @MaxPrice DECIMAL(18,2)
SELECT @MaxPrice=MAX(Prix_Unitaire) FROM ProduitS

-- Calcul de la date de début des  6 derniers mois d'activité
DECLARE @DateMax DATE
DECLARE @DateMin DATE
--SET @DateMax=(SELECT MAX(DATE_COMMANDE) FROM COMMANDES)

--SELECT @DateMin=MIN(DATE_COMMANDE), 
--		@DateMax=MAX(DATE_COMMANDE) FROM COMMANDES

-- Calcul de la date de dernière commande
SELECT @DateMax=MAX(DATE_COMMANDE) FROM COMMANDES
-- Calcul de 6 mois avant
SET @DateMin=DATEADD(month,-6,@DateMax)

--SELECT @DateMin

-- Création de la table des intervales avec deux colonnes (en mémoire)
DECLARE @Intervales TABLE(
				de DECIMAL(18,2),
				a DECIMAL(18,2)
				)
DECLARE @de INT =0;
WHILE @de <=@MaxPrice
BEGIN 
	INSERT INTO @Intervales(de,a)
	VALUES(@de,@de+100)   --(0,100) (100,200)  (200,300) ... (1300,1400)
	SET @de=@de+100
END

;WITH Valeurs AS (
-- Jointure et filtrage des lignes à utiliser
SELECT P.REF_PRODUIT, 
		P.PRIX_UNITAIRE AS 'PrixCatalogue',
		DC.QUANTITE,
		DC.PRIX_UNITAIRE AS 'PrixVente'
FROM Produits AS P
	LEFT JOIN DETAILS_COMMANDES AS DC ON DC.REF_PRODUIT=P.REF_PRODUIT
	INNER JOIN COMMANDES AS C On C.NO_COMMANDE=DC.NO_COMMANDE
WHERE DATE_COMMANDE>=@DateMin),


Etape2 AS (
--Regroupement par intervalle
	SELECT  I.de,
		I.a,
		ISNULL(COUNT(DISTINCT REF_PRODUIT),0) AS 'Nb prod cat',
		ISNULL(SUM(QUANTITE),0) AS 'Quantite',
		ISNULL(SUM(Quantite*Prixvente),0) AS CA,
		AVG(PrixVente-PrixCatalogue) AS 'MoyenneReduc'
		FROM @Intervales AS I
	LEFT JOIN Valeurs AS V ON V.PrixCatalogue>=I.de AND V.PrixCatalogue<I.a
	GROUP BY I.de,I.a
)

-- Ajout des colonnes de ranking (fenétrage)
SELECT *,
RANK() OVER (ORDER BY Quantite DESC) AS Rank_Quantite,
RANK() OVER (ORDER BY CA DESC) AS Rank_CA,
CA/SUM(CA) OVER() AS 'PercentCA'
	
FROM Etape2
ORDER BY de