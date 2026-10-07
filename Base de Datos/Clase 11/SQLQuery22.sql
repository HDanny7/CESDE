USE PlataformaEventos;
GO

CREATE PROCEDURE sp_BuscarEventos
	@id_evento INT

AS
BEGIN

	SELECT
		Eventos.nombre AS Evento,
		Eventos.fecha AS Fecha,
		Eventos.hora AS Hora,
		Eventos.precio AS Precio,
		Lugares.nombre AS Lugar,
		Categorias.nombre AS Categoria

	FROM Eventos

	INNER JOIN Lugares
		ON Eventos.id_lugar = Lugares.id_lugar

	INNER JOIN Categorias
		ON Eventos.id_categoria = Categorias.id_categoria

	WHERE Eventos.id_evento = @id_evento;

END;
GO