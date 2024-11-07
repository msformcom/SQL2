-- Exécution sans index => recherche parmi les millions d'enregistrement => Cout 16,88
SELECT * 
FROM Francais
WHERE Nom='2765E191-1360-4BFD-952B-8A9BD0E1EC2F'


DROP INDEX IX_NOM ON Francais
CREATE INDEX IX_NOM ON Francais(Nom,prenom)
CREATE INDEX IX_PreNOM ON Francais(Prenom,nom)


-- Avec index => Cout 0.0003
SELECT * 
FROM Francais
WHERE Prenom='2765E191-1360-4BFD-952B-8A9BD0E1EC2F'


SELECT * FROM Francais WHERE Age=35
CREATE INDEX IX_Age ON Francais(Age)
-- Utilisé dans certains cas, pas dans d'autres (fonction des statistiques)
SELECT * FROM Francais WHERE Age=35

-- Si les factures sont recherchées par code client 
-- => INDEX en Cluster sur Code_Client
SELECT * FROM COMMANDES
WHERE CODE_CLIENT='ALFKI'


-- Comparer le plan d'exécution de deux requètes différentes 
-- mais qui retournent le meme jeu de données
-- Cout Requete 1
-- Cout requete 2
-- En cas de suspicion d'index manquant => Faire remonter l'info
