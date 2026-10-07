USE PlataformaEventos;
GO

CREATE TABLE Eventos (
id_evento INT IDENTITY (1,1) PRIMARY KEY,
nombre VARCHAR (150) NOT NULL,
descripcion VARCHAR (300),
fecha DATE NOT NULL,
hora TIME NOT NULL,
precio DECIMAL(10,2) NOT NULL,

id_categoria INT NOT NULL,
id_lugar INT NOT NULL,
id_organizador INT NOT NULL,

CONSTRAINT FK_evento_Categoria
	FOREIGN KEY (id_categoria)
	REFERENCES Categorias (id_categoria),

CONSTRAINT FK_evento_Lugar
	FOREIGN KEY (id_lugar)
	REFERENCES Lugares (id_lugar),

CONSTRAINT FK_evento_Organizador
	FOREIGN KEY (id_organizador)
	REFERENCES Organizadores (id_organizador)

);
GO