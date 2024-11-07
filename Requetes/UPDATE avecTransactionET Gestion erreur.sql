SELECT * FROM Employes
-- Début de la transaction 
-- - Annuler en cas de problème
-- - Isoler les données en cours de modification
BEGIN TRAN
BEGIN TRY
	-- Bloc de code gerant la survenance d'erreur
	UPDATE Employes SET COMMISSION=Commission-600 WHERE NO_EMPLOYE=1
	SELECT 1/0; -- Erreur en cours de transaction => bloc catch
	UPDATE Employes SET COMMISSION=Commission+600 WHERE NO_EMPLOYE=9

	COMMIT  -- Si on arrive ici sans erreur => valider les changements
END TRY
BEGIN CATCH
	-- Il y a eu un PB => Annule les changements
	ROLLBACK
	-- Sortie de la requète avec un message erreur élégant
	;THROW 50000,'Opération annulée',1
END CATCH 
