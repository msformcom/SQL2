/****** Script de la commande SelectTopNRows à partir de SSMS  ******/
WITH RawData AS(
SELECT  YEAR(SOH.OrderDate) AS Annee,
		MONTH(OrderDate) AS Mois, 
		P.ProductID,
		SUM(SOD.LineTotal) AS CA,
		SUM(SOD.OrderQty) AS Quantite
   
FROM            Production.Product AS P INNER JOIN
                         Sales.SalesOrderDetail AS SOD ON P.ProductID = SOD.ProductID INNER JOIN
                         Sales.SalesOrderHeader AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE P.ProductSubcategoryID=1
GROUP BY YEAR(SOH.OrderDate), MONTH(OrderDate), P.ProductID

)
SELECT * ,
	SUM(CA) OVER (PARTITION  BY Annee,Mois) AS CAMois,
	CA/SUM(CA) OVER (PArtition BY Annee,Mois) AS PercentCAProduitParRapportAuMois,
	CA/SUM(CA) OVER (PArtition BY Annee,ProductId) AS PercentCAAnnee,
	RANK() OVER (PArtition BY Annee, Mois ORDER BY Quantite DESC) AS ClassementProduitSurMois,
	CA-AVG(CA) OVER (PARTITION BY ProductId ORDER BY Annee,Mois ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING ) AS EvolutionMoyGlissante
FROM RawData
ORDER BY ProductID,Annee,Mois