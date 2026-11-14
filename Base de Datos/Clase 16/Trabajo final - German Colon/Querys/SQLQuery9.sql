USE AtuendoDB;
GO

-- Mostrar todas las prendas que tiene un usuario en su armario
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
