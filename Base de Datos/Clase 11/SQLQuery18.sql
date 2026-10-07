USE PlataformaEventos;
GO

DECLARE @resultado INT;
-- Declaramos una nueva variable llamada resultados, en esta se va a almacenar la cantidad de datos contados de la tabla eventos.

EXEC sp_CantidadEventos @resultado OUTPUT;
-- Ejecutamos sp_CantidadEventos que es nuestra funcion y le decimos que guarde el resultado en @resultado
SELECT @resultado AS CantidadEventos;
-- Ledecimos que nos muestre el resultado y le cambiamos el nombre a la tabla ahora que se llama CantidadEventos.
GO