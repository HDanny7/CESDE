CREATE DATABASE AtuendoDB;
GO

USE AtuendoDB;
GO

-- Tabla 1: Usuarios
CREATE TABLE Usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    fecha_registro DATE NOT NULL DEFAULT GETDATE()
);
GO

-- Tabla 2: Marcas
CREATE TABLE Marcas (
    id_marca INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(80) UNIQUE NOT NULL,
    pais VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Prendas (
    id_prenda INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    color VARCHAR(40) NOT NULL,
    talla VARCHAR(10) NOT NULL,

    id_marca INT NOT NULL,

    CONSTRAINT FK_Prenda_Marca
        FOREIGN KEY (id_marca)
        REFERENCES Marcas(id_marca)
);
GO

-- Tabla 4: Armario
CREATE TABLE Armario (
    id_armario INT IDENTITY(1,1) PRIMARY KEY,
    fecha_ingreso DATE NOT NULL DEFAULT GETDATE(),

    id_usuario INT NOT NULL,
    id_prenda INT NOT NULL,

    CONSTRAINT FK_Armario_Usuario
        FOREIGN KEY (id_usuario)
        REFERENCES Usuarios(id_usuario),

    CONSTRAINT FK_Armario_Prenda
        FOREIGN KEY (id_prenda)
        REFERENCES Prendas(id_prenda)
);
GO

-- Tabla 5: Outfits
CREATE TABLE Outfits (
    id_outfit INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ocasion VARCHAR(60) NOT NULL,
    fecha_creacion DATE NOT NULL DEFAULT GETDATE(),

    id_usuario INT NOT NULL,

    CONSTRAINT FK_Outfit_Usuario
        FOREIGN KEY (id_usuario)
        REFERENCES Usuarios(id_usuario)
);
GO

-- Tabla 6: Outfit_Prendas
CREATE TABLE Outfit_Prendas (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,

    id_outfit INT NOT NULL,
    id_prenda INT NOT NULL,

    CONSTRAINT FK_OutfitPrenda_Outfit
        FOREIGN KEY (id_outfit)
        REFERENCES Outfits(id_outfit),

    CONSTRAINT FK_OutfitPrenda_Prenda
        FOREIGN KEY (id_prenda)
        REFERENCES Prendas(id_prenda)
);
GO
