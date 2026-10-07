USE PlataformaEventos;
GO

DECLARE @total INT;

EXEC sp_ContarInscritos
-- Ejecutamos la funcion, buscamos y recibimos informacion al buscar por el id del evento.
	@id_evento = 1,
	@cantidad = @total OUTPUT;

SELECT @total AS TotalInscritos;