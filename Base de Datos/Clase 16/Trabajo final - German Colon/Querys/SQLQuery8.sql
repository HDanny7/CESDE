USE AtuendoDB;
GO

-- Mostrar los outfits creados por cada usuario
SELECT
    Usuarios.nombre,
    Outfits.nombre
FROM Usuarios
INNER JOIN Outfits ON Usuarios.id_usuario = Outfits.id_usuario
ORDER BY Usuarios.nombre;
GO