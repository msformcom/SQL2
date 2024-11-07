SELECT DISTINCT Pays, Ville FROM Clients

SELECT COUNT(*)
FROM CLIENTS
WHERE Pays='AllemAgne'

SELECT *
FROM Produits

SELECT MIN(Prix_Unitaire) AS Prix_Min,
		AVG(Prix_unitaire) AS Prix_Mmoyen,
		MAx(Prix_Unitaire)  AS Prix_Max,
		SUM(Prix_Unitaire) AS Prix_Total
FROM Produits
