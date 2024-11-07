/*
| Code client | Nombre de commandes |
*/

SELECT * FROM Commandes
WHERE NO_EMPLOYE=3
ORDER BY CODE_CLIENT

-- Ordre d'ex�cution
-- FROM => WHERE => GROUP BY => HAVING => SELECT => ORDER BY
SELECT CODE_CLIENT,   -- Colonnes du GR�UP BY
		COUNT(*) AS 'Nombre de commandes', -- Aggregation
		MIN(Date_Commande) AS 'Date premi�re commande',
		SUM(Port) AS 'Somme frais de port',
		MAX(Date_Commande) AS 'Date derniere commande',
		DATEDIFF(day,MIN(Date_Commande),MAX(Date_Commande)) AS 'Jours activit�s',
		DATEDIFF(month, MAX(Date_Commande), GETDATE()) AS 'Mois sans commande'
FROM Commandes
WHERE NO_EMPLOYE=3  -- Filtre avant cr�ation des groupes
GROUP BY CODE_CLIENT  -- Crit�re de cr�ation des groupes
HAVING DATEDIFF(month, MAX(Date_Commande), GETDATE())>140 -- Filtre apr�s regroupement
ORDER BY CODE_CLIENT DESC

-- Conception de la requete
-- FROM => SELECT => WHERE => ORDER BY 
-- => GROUP BY =>  SELECT => HAVING => ORDER BY




SELECT * FROM Commandes