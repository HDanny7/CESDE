USE HuellasDB;
GO

DECLARE @Cantida INT;

EXEC sp_ContarDisponibles
	'Disponible',
	@Cantida OUTPUT;

SELECT @Cantida AS CantidadDisponible;

GO
