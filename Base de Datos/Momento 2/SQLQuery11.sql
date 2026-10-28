USE HuellasDB;
GO

CREATE PROCEDURE sp_ContarDisponibles
	@estado VARCHAR(100),
	@total INT OUTPUT

AS
BEGIN
	SELECT @total = COUNT(*)
	FROM Animales
	WHERE estado = @estado;
END;
GO



