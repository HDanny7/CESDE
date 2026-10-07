USE ClinicaDB;
GO
/* ESPECIALIDADES */

INSERT INTO Especialidades
    (Nombre, Descripcion)
VALUES
    ('Medicina General', 'Atencion medica general'),
    ('Pediatria', 'Atencion medica para niños'),
    ('Cardiologia', 'Enfermedades del corazon'),
    ('Dermatologia', 'Enfermedades de la piel'),
    ('Ginecologia', 'Salud femenina');
GO

/* MEDICOS */

INSERT INTO Medicos
    (Documento, Nombres, Apellidos, Telefono, Email,
     TarjetaProfesional, IdEspecialidad)
VALUES
    ('1001001001', 'Carlos', 'Gomez', '3001112233',
     'carlos.gomez@clinica.com', 'TP-10001', 1),

    ('1001001002', 'Maria', 'Rodriguez', '3002223344',
     'maria.rodriguez@clinica.com', 'TP-10002', 2),

    ('1001001003', 'Juan', 'Martinez', '3003334455',
     'juan.martinez@clinica.com', 'TP-10003', 3),

    ('1001001004', 'Laura', 'Perez', '3004445566',
     'laura.perez@clinica.com', 'TP-10004', 4);
GO

/* PACIENTES */

INSERT INTO Pacientes
    (Documento, Nombres, Apellidos, FechaNacimiento,
     Sexo, Telefono, Email, Direccion, Ciudad, EPS, TipoSangre)
VALUES
    ('1010101010', 'Pedro', 'Ramirez', '1990-05-15',
     'M', '3101112233', 'pedro@gmail.com',
     'Calle 10 #20-30', 'Medellin', 'Sura', 'O+'),

    ('1020202020', 'Ana', 'Lopez', '1985-08-22',
     'F', '3102223344', 'ana@gmail.com',
     'Carrera 40 #15-20', 'Medellin', 'Sanitas', 'A+'),

    ('1030303030', 'Luis', 'Torres', '2000-01-10',
     'M', '3103334455', 'luis@gmail.com',
     'Carrera 50 #30-40', 'Bello', 'Nueva EPS', 'B+'),

    ('1040404040', 'Sofia', 'Moreno', '1995-11-03',
     'F', '3104445566', 'sofia@gmail.com',
     'Calle 20 #40-50', 'Envigado', 'Sura', 'O+');
GO

/* DIAGNOSTICOS */

INSERT INTO Diagnosticos
    (Codigo, Nombre, Descripcion)
VALUES
    ('J06.9', 'Infeccion respiratoria aguda',
     'Infeccion de las vias respiratorias'),

    ('I10', 'Hipertension esencial',
     'Presion arterial elevada'),

    ('E11', 'Diabetes mellitus tipo 2',
     'Trastorno metabolico caracterizado por hiperglucemia'),

    ('L20.9', 'Dermatitis',
     'Inflamacion de la piel'),

    ('R51', 'Dolor de cabeza',
     'Cefalea');
GO

/* MEDICAMENTOS */

INSERT INTO Medicamentos
    (Nombre, PrincipioActivo, Presentacion,
     Concentracion, Laboratorio)
VALUES
    ('Acetaminofen', 'Paracetamol',
     'Tableta', '500 mg', 'Generico'),

    ('Ibuprofeno', 'Ibuprofeno',
     'Tableta', '400 mg', 'Generico'),

    ('Amoxicilina', 'Amoxicilina',
     'Capsula', '500 mg', 'Generico'),

    ('Losartan', 'Losartan',
     'Tableta', '50 mg', 'Generico'),

    ('Metformina', 'Metformina',
     'Tableta', '850 mg', 'Generico');
GO

/* TIPOS DE EXAMEN */

INSERT INTO TiposExamen
    (Nombre, Descripcion)
VALUES
    ('Hemograma', 'Analisis completo de sangre'),
    ('Glicemia', 'Medicion de glucosa en sangre'),
    ('Perfil lipidico', 'Analisis de colesterol y trigliceridos'),
    ('Orina', 'Examen general de orina'),
    ('Radiografia de torax', 'Imagen diagnostica del torax');
GO

/* ============================================================
   CITAS
   ============================================================ */

INSERT INTO Citas
    (IdPaciente, IdMedico, FechaCita, Motivo, Estado)
VALUES
    (1, 1, '2026-09-20 08:00:00',
     'Dolor de cabeza y fiebre', 'PENDIENTE'),

    (2, 3, '2026-09-20 09:00:00',
     'Control de presion arterial', 'PENDIENTE'),

    (3, 1, '2026-09-21 10:00:00',
     'Consulta general', 'PENDIENTE'),

    (4, 4, '2026-09-21 11:00:00',
     'Problemas en la piel', 'PENDIENTE');
GO

/* ============================================================
   HISTORIA CLINICA
   ============================================================ */

INSERT INTO HistoriasClinicas
    (IdPaciente, IdMedico, IdCita, MotivoConsulta,
     EnfermedadActual, Antecedentes, ExamenFisico,
     PresionArterial, FrecuenciaCardiaca,
     Temperatura, Peso, Talla, Observaciones)
VALUES
    (1, 1, NULL,
     'Dolor de cabeza',
     'Paciente presenta dolor de cabeza desde hace dos dias.',
     'Sin antecedentes relevantes.',
     'Paciente consciente y orientado.',
     '120/80',
     75,
     37.2,
     72.5,
     1.75,
     'Control en una semana');
GO

/* ============================================================
   DIAGNOSTICO DE HISTORIA
   ============================================================ */

INSERT INTO HistoriaDiagnosticos
    (IdHistoria, IdDiagnostico, TipoDiagnostico, Observaciones)
VALUES
    (1, 5, 'PRINCIPAL', 'Cefalea sin signos de alarma');
GO

/* ============================================================
   FORMULA MEDICA
   ============================================================ */

INSERT INTO FormulasMedicas
    (IdHistoria, Observaciones)
VALUES
    (1, 'Tomar abundante liquido y guardar reposo');
GO

INSERT INTO DetalleFormula
    (IdFormula, IdMedicamento, Dosis,
     Frecuencia, Duracion, Cantidad)
VALUES
    (1, 1, '1 tableta',
     'Cada 8 horas', '3 dias', 9);
GO

/* ============================================================
   ORDEN DE EXAMEN
   ============================================================ */

INSERT INTO OrdenesExamenes
    (IdHistoria, IdTipoExamen, Prioridad, Estado)
VALUES
    (1, 1, 'NORMAL', 'SOLICITADO'),
    (1, 2, 'NORMAL', 'SOLICITADO');
GO