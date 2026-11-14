USE AtuendoDB;
GO

-- LEFT JOIN: todos los usuarios, tengan o no outfits creados
SELECT
    Usuarios.nombre,
    Outfits.nombre
FROM Usuarios
LEFT JOIN Outfits ON Usuarios.id_usuario = Outfits.id_usuario;
GO
