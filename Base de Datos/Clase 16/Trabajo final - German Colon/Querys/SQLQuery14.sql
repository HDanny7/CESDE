USE AtuendoDB;
GO

-- INNER JOIN: solo las prendas que tienen marca asociada
SELECT
    Prendas.nombre,
    Marcas.nombre
FROM Prendas
INNER JOIN Marcas ON Prendas.id_marca = Marcas.id_marca;
GO