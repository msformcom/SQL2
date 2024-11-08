-- Sauvegarde de base de données
BACKUP DATABASE [LA300] 
TO  DISK = N'C:\Data\LA300.bak'
GO

-- Restauration
USE [master]
RESTORE DATABASE AW FROM  DISK = N'C:\Data\AdventureWorksLT2019.bak' 
WITH  FILE = 1,  NOUNLOAD,  STATS = 5, REPLACE

GO
SELECT @@version

