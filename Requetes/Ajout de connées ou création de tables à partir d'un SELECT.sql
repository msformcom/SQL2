SELECT * FROM [dbo].[PerformancesEmployes2012]

SELECT * FROM [dbo].[PerfEmpl2012]

INSERT INTO [dbo].[PerfEmpl2012]
SELECT * FROM [dbo].[PerformancesEmployes2012]


SELECT * 
INTO Employes_Copy
FROM EMPLOYES

INSERT INTO Employes_Copy
SELECT * FROM Employes AS E
EXCEPT 
SELECT * FROM Employes_Copy
--WHERE NOT EXISTS(SELECT NO_Employe FROM Employes_Copy WHERE NO_EMPLOYE=E.NO_EMPLOYE)