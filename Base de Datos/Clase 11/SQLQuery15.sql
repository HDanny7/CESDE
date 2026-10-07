-- Procedimiento almacenado para buscar eventos de una determinada categoria
-- Este es un parametro de entrada

USE PlataformaEventos;
GO

CREATE PROCEDURE sp_BuscarEventoCategorias
	@id_categoria INT
	-- Se selecciona aqui por cual parametro se va a buscar al momento de ejecutar la funcion

AS
-- AS Para renombrar Eventos como e, ayuda a simplificar el codigo
BEGIN
-- Inicio de nuestra estructura

	SELECT
	-- Selecciona de la tabla eventos(e) las siguientes columnas
		e.id_evento,
		e.nombre,
		e.fecha,
		e.hora,
		e.precio
		FROM Eventos e
		-- Especificamos que es de la tabla eventos con FROM
		WHERE e.id_categoria = @id_categoria;
		-- WHERE es una condicion, nos dice que la funcion corresponde a buscar por id de categoria a cada evento que coincida, mas o menos asi lo entiendo.
END;
-- Final de la estructura
GO
