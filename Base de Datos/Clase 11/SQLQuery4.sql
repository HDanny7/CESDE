USE PlataformaEventos;
GO

CREATE TABLE Organizadores (
id_organizador INT IDENTITY (1,1) PRIMARY KEY,
nombre VARCHAR (100) NOT NULL,
apellido VARCHAR (100) NOT NULL,
telefono VARCHAR (100),
correo VARCHAR (150)
);
GO