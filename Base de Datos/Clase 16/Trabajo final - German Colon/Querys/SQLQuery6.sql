USE AtuendoDB;
GO

-- Mostrar las prendas que componen un outfit
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