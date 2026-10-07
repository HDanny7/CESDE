USE PlataformaEventos;
GO

CREATE TABLE Categorias (
id_categoria INT IDENTITY(1, 1) PRIMARY KEY,
nombre VARCHAR (100) NOT NULL,
descripcion VARCHAR (250)
);
GO