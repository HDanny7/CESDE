USE HuellasDB;
GO

CREATE PROCEDURE sp_BuscarAnimal
	@id_animal INT

AS
BEGIN
	SELECT *
	FROM Animales
	WHERE id_animal = @id_animal;
END;
GO