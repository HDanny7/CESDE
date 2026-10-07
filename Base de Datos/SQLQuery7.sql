CREATE PROCEDURE BuscarPacienteId
@IdPaciente INT
AS
BEGIN
	SELECT
		IdPaciente,
		Nombre,
		Documento,
		Edad,
		Ciudad,
		EPS,
		Telefono,
		Estado
	FROM Pacientes
	WHERE IdPaciente = @IdPaciente;
END;
GO

-- Probar procedimiento

EXEC BuscarPacienteId 1;
GO