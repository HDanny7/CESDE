USE PlataformaEventos;
GO

CREATE TABLE Pagos (
	id_pago INT IDENTITY (1,1) PRIMARY KEY,
	fecha_pago DATE NOT NULL DEFAULT GETDATE(),
	valor DECIMAL (10,2) NOT NULL,
	metodo_pago VARCHAR (50) NOT NULL,
	estado VARCHAR (30) NOT NULL,

	id_inscripcion INT NOT NULL,

	CONSTRAINT FK_Pago_Inscripcion
		FOREIGN KEY (id_inscripcion)
		REFERENCES Inscripciones (id_inscripcion)
);
GO