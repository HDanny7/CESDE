USE PlataformaEventos;
GO

CREATE TABLE Participantes (
	id_participante INT IDENTITY (1,1) PRIMARY KEY,
	nombre VARCHAR (100) NOT NULL,
	apellido VARCHAR (100) NOT NULL,
	documento VARCHAR (20) UNIQUE NOT NULL,
	telefono VARCHAR (20),
	correo VARCHAR (150)
	);
	GO