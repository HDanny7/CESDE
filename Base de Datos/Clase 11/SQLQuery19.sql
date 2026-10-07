-- Procedimiento almacenado para buscar cuantas personas estan inscritas a un evento
-- Este es un parametro tanto de Entrada como de Salida

USE PlataformaEventos;
GO

CREATE PROCEDURE sp_ContarInscritos
-- Aqui se unen tanto la busqueda como la salida de datos en el CREATE PROCEDURE
	@id_evento INT,
	@cantidad INT OUTPUT

AS
BEGIN
	SELECT @cantidad = COUNT(*)
	FROM Inscripciones
	-- Como es de donde queremos buscar el FROM lo usamos para la Inscripciones.
	WHERE id_evento = @id_evento;

END;
GO