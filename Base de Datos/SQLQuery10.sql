DECLARE @NombrePaciente VARCHAR(100);
EXEC ObtenerNombrePaciente
	'123456789',
	@NombrePaciente OUTPUT;
SELECT @NombrePaciente AS NombrePaciente;
GO
