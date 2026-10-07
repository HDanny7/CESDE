CREATE DATABASE ClinicaDB;
GO

USE ClinicaDB;
GO

/* ============================================================
   1. ESPECIALIDADES
   ============================================================ */

CREATE TABLE Especialidades (
    IdEspecialidad INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Descripcion VARCHAR(250)
);
GO

/* ============================================================
   2. MEDICOS
   ============================================================ */

CREATE TABLE Medicos (
    IdMedico INT IDENTITY(1,1) PRIMARY KEY,
    Documento VARCHAR(20) NOT NULL UNIQUE,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    TarjetaProfesional VARCHAR(50),
    IdEspecialidad INT NOT NULL,

    CONSTRAINT FK_Medicos_Especialidades
        FOREIGN KEY (IdEspecialidad)
        REFERENCES Especialidades(IdEspecialidad)
);
GO

/* ============================================================
   3. PACIENTES
   ============================================================ */

CREATE TABLE Pacientes (
    IdPaciente INT IDENTITY(1,1) PRIMARY KEY,
    Documento VARCHAR(20) NOT NULL UNIQUE,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo CHAR(1) NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    Direccion VARCHAR(200),
    Ciudad VARCHAR(100),
    EPS VARCHAR(100),
    TipoSangre VARCHAR(5),
    FechaRegistro DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT CK_Pacientes_Sexo
        CHECK (Sexo IN ('M','F','O'))
);
GO

/* ============================================================
   4. CITAS
   ============================================================ */

CREATE TABLE Citas (
    IdCita INT IDENTITY(1,1) PRIMARY KEY,
    IdPaciente INT NOT NULL,
    IdMedico INT NOT NULL,
    FechaCita DATETIME NOT NULL,
    Motivo VARCHAR(500),
    Estado VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',

    CONSTRAINT FK_Citas_Pacientes
        FOREIGN KEY (IdPaciente)
        REFERENCES Pacientes(IdPaciente),

    CONSTRAINT FK_Citas_Medicos
        FOREIGN KEY (IdMedico)
        REFERENCES Medicos(IdMedico),

    CONSTRAINT CK_Citas_Estado
        CHECK (Estado IN (
            'PENDIENTE',
            'ATENDIDA',
            'CANCELADA',
            'NO ASISTIO'
        ))
);
GO

/* ============================================================
   5. HISTORIAS CLINICAS
   ============================================================ */

CREATE TABLE HistoriasClinicas (
    IdHistoria INT IDENTITY(1,1) PRIMARY KEY,
    IdPaciente INT NOT NULL,
    IdMedico INT NOT NULL,
    IdCita INT NULL,
    FechaAtencion DATETIME NOT NULL DEFAULT GETDATE(),

    MotivoConsulta VARCHAR(500),
    EnfermedadActual VARCHAR(MAX),
    Antecedentes VARCHAR(MAX),
    ExamenFisico VARCHAR(MAX),
    PresionArterial VARCHAR(20),
    FrecuenciaCardiaca INT,
    Temperatura DECIMAL(4,1),
    Peso DECIMAL(6,2),
    Talla DECIMAL(5,2),
    Observaciones VARCHAR(MAX),

    CONSTRAINT FK_Historias_Pacientes
        FOREIGN KEY (IdPaciente)
        REFERENCES Pacientes(IdPaciente),

    CONSTRAINT FK_Historias_Medicos
        FOREIGN KEY (IdMedico)
        REFERENCES Medicos(IdMedico),

    CONSTRAINT FK_Historias_Citas
        FOREIGN KEY (IdCita)
        REFERENCES Citas(IdCita)
);
GO

/* ============================================================
   6. DIAGNOSTICOS
   ============================================================ */

CREATE TABLE Diagnosticos (
    IdDiagnostico INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(20) NOT NULL UNIQUE,
    Nombre VARCHAR(200) NOT NULL,
    Descripcion VARCHAR(500)
);
GO

/* ============================================================
   7. DIAGNOSTICOS DE LA HISTORIA CLINICA
   ============================================================ */

CREATE TABLE HistoriaDiagnosticos (
    IdHistoriaDiagnostico INT IDENTITY(1,1) PRIMARY KEY,
    IdHistoria INT NOT NULL,
    IdDiagnostico INT NOT NULL,
    TipoDiagnostico VARCHAR(20) NOT NULL DEFAULT 'PRINCIPAL',
    Observaciones VARCHAR(500),

    CONSTRAINT FK_HistoriaDiagnosticos_Historia
        FOREIGN KEY (IdHistoria)
        REFERENCES HistoriasClinicas(IdHistoria),

    CONSTRAINT FK_HistoriaDiagnosticos_Diagnostico
        FOREIGN KEY (IdDiagnostico)
        REFERENCES Diagnosticos(IdDiagnostico),

    CONSTRAINT CK_TipoDiagnostico
        CHECK (TipoDiagnostico IN (
            'PRINCIPAL',
            'SECUNDARIO'
        ))
);
GO

/* ============================================================
   8. MEDICAMENTOS
   ============================================================ */

CREATE TABLE Medicamentos (
    IdMedicamento INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    PrincipioActivo VARCHAR(150),
    Presentacion VARCHAR(100),
    Concentracion VARCHAR(100),
    Laboratorio VARCHAR(150)
);
GO

/* ============================================================
   9. FORMULAS MEDICAS
   ============================================================ */

CREATE TABLE FormulasMedicas (
    IdFormula INT IDENTITY(1,1) PRIMARY KEY,
    IdHistoria INT NOT NULL,
    FechaFormula DATETIME NOT NULL DEFAULT GETDATE(),
    Observaciones VARCHAR(500),

    CONSTRAINT FK_Formulas_Historias
        FOREIGN KEY (IdHistoria)
        REFERENCES HistoriasClinicas(IdHistoria)
);
GO

/* ============================================================
   10. DETALLE DE FORMULA MEDICA
   ============================================================ */

CREATE TABLE DetalleFormula (
    IdDetalle INT IDENTITY(1,1) PRIMARY KEY,
    IdFormula INT NOT NULL,
    IdMedicamento INT NOT NULL,
    Dosis VARCHAR(100) NOT NULL,
    Frecuencia VARCHAR(100) NOT NULL,
    Duracion VARCHAR(100) NOT NULL,
    Cantidad INT,

    CONSTRAINT FK_DetalleFormula_Formulas
        FOREIGN KEY (IdFormula)
        REFERENCES FormulasMedicas(IdFormula),

    CONSTRAINT FK_DetalleFormula_Medicamentos
        FOREIGN KEY (IdMedicamento)
        REFERENCES Medicamentos(IdMedicamento)
);
GO

/* ============================================================
   11. TIPOS DE EXAMEN
   ============================================================ */

CREATE TABLE TiposExamen (
    IdTipoExamen INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL UNIQUE,
    Descripcion VARCHAR(500)
);
GO

/* ============================================================
   12. ORDENES DE EXAMENES
   ============================================================ */

CREATE TABLE OrdenesExamenes (
    IdOrden INT IDENTITY(1,1) PRIMARY KEY,
    IdHistoria INT NOT NULL,
    IdTipoExamen INT NOT NULL,
    FechaOrden DATETIME NOT NULL DEFAULT GETDATE(),
    Prioridad VARCHAR(20) NOT NULL DEFAULT 'NORMAL',
    Estado VARCHAR(30) NOT NULL DEFAULT 'SOLICITADO',
    Resultado VARCHAR(MAX),
    FechaResultado DATETIME NULL,

    CONSTRAINT FK_Ordenes_Historias
        FOREIGN KEY (IdHistoria)
        REFERENCES HistoriasClinicas(IdHistoria),

    CONSTRAINT FK_Ordenes_TiposExamen
        FOREIGN KEY (IdTipoExamen)
        REFERENCES TiposExamen(IdTipoExamen),

    CONSTRAINT CK_Ordenes_Prioridad
        CHECK (Prioridad IN ('NORMAL','URGENTE')),

    CONSTRAINT CK_Ordenes_Estado
        CHECK (Estado IN (
            'SOLICITADO',
            'EN PROCESO',
            'COMPLETADO',
            'CANCELADO'
        ))
);
GO

/* ============================================================
   13. FACTURAS
   ============================================================ */

CREATE TABLE Facturas (
    IdFactura INT IDENTITY(1,1) PRIMARY KEY,
    IdPaciente INT NOT NULL,
    FechaFactura DATETIME NOT NULL DEFAULT GETDATE(),
    Subtotal DECIMAL(12,2) NOT NULL DEFAULT 0,
    Impuesto DECIMAL(12,2) NOT NULL DEFAULT 0,
    Total AS (Subtotal + Impuesto) PERSISTED,
    Estado VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',

    CONSTRAINT FK_Facturas_Pacientes
        FOREIGN KEY (IdPaciente)
        REFERENCES Pacientes(IdPaciente),

    CONSTRAINT CK_Facturas_Estado
        CHECK (Estado IN (
            'PENDIENTE',
            'PAGADA',
            'ANULADA'
        ))
);
GO

/* ============================================================
   14. DETALLE DE FACTURA
   ============================================================ */

CREATE TABLE DetalleFactura (
    IdDetalle INT IDENTITY(1,1) PRIMARY KEY,
    IdFactura INT NOT NULL,
    Descripcion VARCHAR(250) NOT NULL,
    Cantidad INT NOT NULL DEFAULT 1,
    PrecioUnitario DECIMAL(12,2) NOT NULL,

    Subtotal AS (Cantidad * PrecioUnitario) PERSISTED,

    CONSTRAINT FK_DetalleFactura_Facturas
        FOREIGN KEY (IdFactura)
        REFERENCES Facturas(IdFactura),

    CONSTRAINT CK_DetalleFactura_Cantidad
        CHECK (Cantidad > 0),

    CONSTRAINT CK_DetalleFactura_Precio
        CHECK (PrecioUnitario >= 0)
);
GO