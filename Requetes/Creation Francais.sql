CREATE TABLE Francais(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nom NVARCHAR(50) NOT NULL,
	Prenom NVARCHAR(50) NOT NULL,
	Age INT NOT NULL,
	Salaire DECIMAL(18,2) DEFAULT 1800.45
)

SELECT * FROM Francais

INSERT INTO Francais ( Nom, Prenom,Age,Salaire)
VALUES(newid(),newid(),18,1800)


INSERT INTO Francais ( Nom, Prenom,Age,Salaire)
SELECT newid(),newid(),age+1,salaire+10  FROM Francais