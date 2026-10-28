USE HuellasDB;
GO

CREATE TABLE Voluntarios
(
	id_voluntario INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	telefono varchar(20)
	);

CREATE TABLE Revisiones
(
	id_revision INT IDENTITY(1,1) PRIMARY KEY,
	id_animal INT NOT NULL,
	id_voluntario INT NOT NULL,
	fecha DATE NOT NULL DEFAULT GETDATE(),
	resultado VARCHAR(200) NOT NULL,

	CONSTRAINT FK_Revisiones_Animales
		FOREIGN KEY (id_animal)
		REFERENCES Animales(id_animal),

	CONSTRAINT FK_Revisiones_Voluntarios
		FOREIGN KEY (id_voluntario)
		REFERENCES Voluntarios(id_voluntario)
);
GO