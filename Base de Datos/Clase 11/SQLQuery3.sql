USE PlataformaEventos;
GO

CREATE TABLE Lugares (
id_lugar INT IDENTITY (1,1) PRIMARY KEY,
nombre VARCHAR (150) NOT NULL,
ciudad VARCHAR (150) NOT NULL,
capacidad INT NOT NULL,
direccion VARCHAR (200) NOT NULL
);
GO