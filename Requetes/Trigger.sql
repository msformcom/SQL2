/****** Script de la commande SelectTopNRows à partir de SSMS  ******/
SELECT * FROM Commandes

UPDATE DETAILS_COMMANDES SET PRIX_UNITAIRE=PRIX_UNITAIRE+1 WHERE NO_COMMANDE=10702


;WITH S AS (
SELECT C.NO_COMMANDE, C.MontantLignes, CA FROM ResumeCA AS RC 
			INNER JOIN Commandes AS C ON C.NO_Commande=RC.NO_Commande)
UPDATE S SET MontantLignes=CA


CREATE TRIGGER MAJMontantLignes ON Details_Commandes FOR UPDATE,DELETE,INSERT
AS 
BEGIN
	;WITH S AS (
	SELECT C.NO_COMMANDE, C.MontantLignes, CA FROM ResumeCA AS RC 
				INNER JOIN Commandes AS C ON C.NO_Commande=RC.NO_Commande)
	UPDATE S SET MontantLignes=CA

END