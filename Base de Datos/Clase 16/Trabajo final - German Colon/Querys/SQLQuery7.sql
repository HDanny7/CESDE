USE AtuendoDB;
GO

-- Consultar cuántas prendas tiene cada usuario
SELECT
    Usuarios.nombre,
    COUNT(Armario.id_prenda)
FROM Usuarios
LEFT JOIN Armario ON Usuarios.id_usuario = Armario.id_usuario
GROUP BY Usuarios.id_usuario, Usuarios.nombre
ORDER BY Usuarios.nombre;
GO