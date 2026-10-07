-- PROCEDIMIENTO CON PARÁMETRO OUTPUT

CREATE PROCEDURE ObtenerNombrePaciente
	@Documento VARCHAR(20),
	@Nombre VARCHAR(100) OUTPUT
AS
BEGIN

	SELECT @Nombre = Nombre
	FROM Pacientes
	WHERE Documento = @Documento;

END;
GO