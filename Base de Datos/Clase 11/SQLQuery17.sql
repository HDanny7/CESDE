-- Procedimiento almacenado para buscar cuantos eventos existen
-- Este es un parametro de Salida

USE PlataformaEventos;
GO

CREATE PROCEDURE sp_CantidadEventos
	@cantidad INT OUTPUT
	-- OUTPUT lo usamos para devolver informacion, en este caso queremos saber la cantidad de eventos.

AS
BEGIN
	
	SELECT @cantidad = COUNT(*)
	-- COUNT Cuenta la cantidad de eventos en la tabla eventos.
	FROM Eventos;

END;
GO