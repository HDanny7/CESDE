USE HuellasDB;
GO
CREATE TABLE Animales
(
	id_animal INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	especie VARCHAR(30) NOT NULL,
	edad INT NOT NULL,
	estado VARCHAR(30) NOT NULL,

	CONSTRAINT CK_Animales_Edad
		CHECK (edad >= 0),

	CONSTRAINT CK_Animales_Estado
		CHECK (estado IN
		('Disponible', 'Adoptado', 'En tratamiento'))
);
GO