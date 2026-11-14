-- =====================================================================
-- ACTIVIDAD FINAL: ATUENDO - MI ARMARIO DIGITAL
-- Base de datos: AtuendoDB (SQL Server)
-- Puntos 1 al 6 del documento
-- Sintaxis basada en el modelo "Plataforma de eventos y experiencias"
-- (GO separa los lotes: se usa en SQL Server Management Studio)
-- =====================================================================


-- =====================================================================
-- PUNTO 1. CREAR LA BASE DE DATOS Y LAS TABLAS BASE
-- Tablas que no dependen de ninguna otra: Usuarios y Marcas
-- =====================================================================

-- Se crea la base de datos y se selecciona para trabajar
CREATE DATABASE AtuendoDB;
GO

USE AtuendoDB;
GO

-- Tabla 1: Usuarios (personas registradas en la aplicación)
CREATE TABLE Usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    fecha_registro DATE NOT NULL DEFAULT GETDATE()
);
GO

-- Tabla 2: Marcas (marcas de las prendas)
CREATE TABLE Marcas (
    id_marca INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(80) UNIQUE NOT NULL,
    pais VARCHAR(50) NOT NULL
);
GO


-- =====================================================================
-- PUNTO 2. TABLAS RELACIONADAS (CLAVES FORÁNEAS)
-- Las relaciones se crean dentro de cada tabla con CONSTRAINT ... FOREIGN KEY
-- Orden: primero las tablas padre, luego las que dependen de ellas
-- =====================================================================

-- Tabla 3: Prendas (una marca puede tener muchas prendas)
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

-- Tabla 4: Armario (un usuario tiene muchas prendas y una prenda puede estar en muchos armarios)
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

-- Tabla 5: Outfits (un usuario puede crear muchos outfits)
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

-- Tabla 6: Outfit_Prendas (un outfit tiene varias prendas y una prenda puede usarse en varios outfits)
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


-- =====================================================================
-- PUNTO 3. ESTRUCTURA DE LAS TABLAS Y CAMPOS
-- Se verifica que cada tabla quedó con los campos pedidos
-- (las tablas aún están vacías: solo se muestran los nombres de las columnas)
-- =====================================================================

SELECT * FROM Usuarios;
GO

SELECT * FROM Marcas;
GO

SELECT * FROM Prendas;
GO

SELECT * FROM Armario;
GO

SELECT * FROM Outfits;
GO

SELECT * FROM Outfit_Prendas;
GO


-- =====================================================================
-- PUNTO 4. DISTRIBUCIÓN DE EQUIPOS: REGISTROS DE PRUEBA POR TABLA
-- Cada equipo inserta los registros de su tabla (mínimo 5 por tabla)
-- Orden: primero las tablas padre, luego las que tienen claves foráneas
-- =====================================================================

-- Equipo 1: Usuarios (6 registros)
INSERT INTO Usuarios (nombre, correo, contraseña, fecha_registro)
VALUES
('Laura Gómez', 'laura.gomez@correo.com', 'clave_laura_123', '2026-01-15'),
('Carlos Ramírez', 'carlos.ramirez@correo.com', 'clave_carlos_123', '2026-01-20'),
('Valentina Torres', 'valentina.torres@correo.com', 'clave_valentina_123', '2026-02-03'),
('Andrés Molina', 'andres.molina@correo.com', 'clave_andres_123', '2026-02-18'),
('Sofía Herrera', 'sofia.herrera@correo.com', 'clave_sofia_123', '2026-03-05'),
('Juan Pérez', 'juan.perez@correo.com', 'clave_juan_123', '2026-03-22');
GO

-- Equipo 2: Marcas (6 registros)
INSERT INTO Marcas (nombre, pais)
VALUES
('Nike', 'Estados Unidos'),
('Adidas', 'Alemania'),
('Zara', 'España'),
('Levis', 'Estados Unidos'),
('Puma', 'Alemania'),
('Arturo Calle', 'Colombia');
GO

-- Equipo 3: Prendas (10 registros, cada una con su marca)
INSERT INTO Prendas (nombre, categoria, color, talla, id_marca)
VALUES
('Camiseta básica', 'Camiseta', 'Blanco', 'M', 3),
('Jean clásico', 'Pantalón', 'Azul', '32', 4),
('Chaqueta de cuero', 'Chaqueta', 'Negro', 'L', 3),
('Zapatillas Air Max', 'Zapatos', 'Blanco', '41', 1),
('Camiseta deportiva', 'Camiseta', 'Negro', 'L', 2),
('Pantaloneta running', 'Pantaloneta', 'Gris', 'M', 1),
('Camisa de lino', 'Camisa', 'Beige', 'M', 6),
('Pantalón de vestir', 'Pantalón', 'Negro', '34', 6),
('Tenis Suede', 'Zapatos', 'Azul', '40', 5),
('Chaqueta cortavientos', 'Chaqueta', 'Rojo', 'M', 2);
GO

-- Equipo 4: Armario (14 registros: prendas de cada usuario)
INSERT INTO Armario (id_usuario, id_prenda, fecha_ingreso)
VALUES
(1, 1, '2026-02-01'),
(1, 2, '2026-02-01'),
(1, 3, '2026-02-10'),
(1, 4, '2026-02-15'),
(2, 5, '2026-02-12'),
(2, 6, '2026-02-12'),
(2, 2, '2026-02-20'),
(2, 9, '2026-03-01'),
(3, 7, '2026-03-02'),
(3, 8, '2026-03-02'),
(3, 1, '2026-03-10'),
(4, 10, '2026-03-15'),
(5, 4, '2026-03-20'),
(5, 8, '2026-03-20');
GO

-- Equipo 5: Outfits (6 registros)
INSERT INTO Outfits (id_usuario, nombre, ocasion, fecha_creacion)
VALUES
(1, 'Casual diario', 'Salir', '2026-04-01'),
(1, 'Estudio relajado', 'Estudiar', '2026-04-03'),
(2, 'Entrenamiento mañana', 'Hacer deporte', '2026-04-05'),
(2, 'Paseo de domingo', 'Salir', '2026-04-07'),
(3, 'Reunión ejecutiva', 'Trabajar', '2026-04-10'),
(5, 'Trabajo creativo', 'Trabajar', '2026-04-12');
GO

-- Equipo 6: Outfit_Prendas (14 registros: prendas de cada outfit)
INSERT INTO Outfit_Prendas (id_outfit, id_prenda)
VALUES
(1, 1),
(1, 2),
(1, 4),
(2, 1),
(2, 2),
(3, 5),
(3, 6),
(4, 2),
(4, 9),
(4, 5),
(5, 7),
(5, 8),
(6, 8),
(6, 4);
GO


-- =====================================================================
-- PUNTO 5. REQUISITOS OBLIGATORIOS: REGISTROS, SELECT, INNER JOIN, LEFT JOIN
-- =====================================================================

-- 5.1 Registros por tabla (deben ser mínimo 5 en cada una)
SELECT COUNT(*) FROM Usuarios;
SELECT COUNT(*) FROM Marcas;
SELECT COUNT(*) FROM Prendas;
SELECT COUNT(*) FROM Armario;
SELECT COUNT(*) FROM Outfits;
SELECT COUNT(*) FROM Outfit_Prendas;
GO

-- 5.2 INNER JOIN: solo las prendas que tienen marca asociada
SELECT
    Prendas.nombre,
    Marcas.nombre
FROM Prendas
INNER JOIN Marcas ON Prendas.id_marca = Marcas.id_marca;
GO

-- 5.3 LEFT JOIN: todos los usuarios, tengan o no outfits creados
SELECT
    Usuarios.nombre,
    Outfits.nombre
FROM Usuarios
LEFT JOIN Outfits ON Usuarios.id_usuario = Outfits.id_usuario;
GO


-- =====================================================================
-- PUNTO 6. CONSULTAS QUE DEBEN IMPLEMENTAR
-- =====================================================================

-- 6.1 Mostrar todos los usuarios registrados
SELECT * FROM Usuarios;
GO

-- 6.2 Mostrar todas las prendas disponibles en el catálogo
SELECT * FROM Prendas
ORDER BY nombre;
GO

-- 6.3 Consultar las prendas de una marca determinada (ejemplo: Nike)
SELECT
    Prendas.nombre,
    Prendas.categoria,
    Prendas.color,
    Prendas.talla
FROM Prendas
INNER JOIN Marcas ON Prendas.id_marca = Marcas.id_marca
WHERE Marcas.nombre = 'Nike';
GO

-- 6.4 Mostrar todas las prendas que tiene un usuario en su armario (ejemplo: Laura Gómez)
SELECT
    Usuarios.nombre,
    Prendas.nombre,
    Prendas.categoria,
    Prendas.color,
    Prendas.talla
FROM Armario
INNER JOIN Usuarios ON Armario.id_usuario = Usuarios.id_usuario
INNER JOIN Prendas ON Armario.id_prenda = Prendas.id_prenda
WHERE Usuarios.nombre = 'Laura Gómez';
GO

-- 6.5 Mostrar los outfits creados por cada usuario
SELECT
    Usuarios.nombre,
    Outfits.nombre
FROM Usuarios
INNER JOIN Outfits ON Usuarios.id_usuario = Outfits.id_usuario
ORDER BY Usuarios.nombre;
GO

-- 6.6 Mostrar las prendas que componen un outfit (ejemplo: outfit número 1)
SELECT
    Outfits.nombre,
    Prendas.nombre,
    Prendas.categoria,
    Prendas.color
FROM Outfit_Prendas
INNER JOIN Outfits ON Outfit_Prendas.id_outfit = Outfits.id_outfit
INNER JOIN Prendas ON Outfit_Prendas.id_prenda = Prendas.id_prenda
WHERE Outfits.id_outfit = 1;
GO

-- 6.7 Consultar cuántas prendas tiene cada usuario
-- (LEFT JOIN para que también aparezcan los usuarios con 0 prendas)
SELECT
    Usuarios.nombre,
    COUNT(Armario.id_prenda)
FROM Usuarios
LEFT JOIN Armario ON Usuarios.id_usuario = Armario.id_usuario
GROUP BY Usuarios.id_usuario, Usuarios.nombre
ORDER BY Usuarios.nombre;
GO

-- 6.8 Mostrar los outfits y sus respectivas ocasiones
SELECT
    nombre,
    ocasion
FROM Outfits
ORDER BY ocasion, nombre;
GO
