USE HuellasDB;
GO

CREATE PROCEDURE sp_TotalAnimales
	@total INT OUTPUT

AS
BEGIN
	SELECT @total = COUNT(*)
	FROM Animales;
END;
GO
