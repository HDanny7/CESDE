USE HuellasDB;
GO

CREATE TABLE Adopciones
(
	id_adopcion INT IDENTITY(1,1) PRIMARY KEY,
	id_animal INT NOT NULL UNIQUE,
	responsable VARCHAR(100) NOT NULL,
	fecha_adopcion DATE NOT NULL DEFAULT GETDATE(),

	CONSTRAINT FK_Adopciones_Animales
	FOREIGN KEY (id_animal)
	REFERENCES Animales(id_animal)
);
GO