USE AtuendoDB;
GO

-- Consultar las prendas de una marca determinada (ejemplo: Nike)
SELECT
    Prendas.nombre,
    Prendas.categoria,
    Prendas.color,
    Prendas.talla
FROM Prendas
INNER JOIN Marcas ON Prendas.id_marca = Marcas.id_marca
WHERE Marcas.nombre = 'Nike';
GO