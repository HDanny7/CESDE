USE PlataformaEventos;
GO

CREATE TABLE Inscripciones (
	id_inscripcion INT IDENTITY (1,1) PRIMARY KEY,
	fecha_inscripcion DATE NOT NULL DEFAULT GETDATE(),
	estado VARCHAR (30) NOt NULL,

id_participante INT NOT NULL,
id_evento INT NOT NULL,

CONSTRAINT FK_Inscripcion_Participante
	FOREIGN KEY (id_participante)
	REFERENCES Participantes (id_participante),

CONSTRAINT Fk_Incripcion_evento
	FOREIGN KEY (id_evento)
	REFERENCES Eventos (id_evento)
);
GO