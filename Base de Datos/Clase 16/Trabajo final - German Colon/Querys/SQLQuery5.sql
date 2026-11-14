USE AtuendoDB;
GO

-- Mostrar los outfits y sus respectivas ocasiones
SELECT
    nombre,
    ocasion
FROM Outfits
ORDER BY ocasion, nombre;
GO
