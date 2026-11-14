USE AtuendoDB;
GO

-- Datos ingresados

-- Usuarios
INSERT INTO Usuarios (nombre, correo, contraseña, fecha_registro)
VALUES
('Laura Gómez', 'laura.gomez@correo.com', 'clave_laura_123', '2026-01-15'),
('Carlos Ramírez', 'carlos.ramirez@correo.com', 'clave_carlos_123', '2026-01-20'),
('Valentina Torres', 'valentina.torres@correo.com', 'clave_valentina_123', '2026-02-03'),
('Andrés Molina', 'andres.molina@correo.com', 'clave_andres_123', '2026-02-18'),
('Sofía Herrera', 'sofia.herrera@correo.com', 'clave_sofia_123', '2026-03-05'),
('Juan Pérez', 'juan.perez@correo.com', 'clave_juan_123', '2026-03-22');
GO

-- Marcas
INSERT INTO Marcas (nombre, pais)
VALUES
('Nike', 'Estados Unidos'),
('Adidas', 'Alemania'),
('Zara', 'España'),
('Levis', 'Estados Unidos'),
('Puma', 'Alemania'),
('Arturo Calle', 'Colombia');
GO

-- Prendas
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

-- Armario
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

-- Outfits
INSERT INTO Outfits (id_usuario, nombre, ocasion, fecha_creacion)
VALUES
(1, 'Casual diario', 'Salir', '2026-04-01'),
(1, 'Estudio relajado', 'Estudiar', '2026-04-03'),
(2, 'Entrenamiento mañana', 'Hacer deporte', '2026-04-05'),
(2, 'Paseo de domingo', 'Salir', '2026-04-07'),
(3, 'Reunión ejecutiva', 'Trabajar', '2026-04-10'),
(5, 'Trabajo creativo', 'Trabajar', '2026-04-12');
GO

-- Outfit_Prendas
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