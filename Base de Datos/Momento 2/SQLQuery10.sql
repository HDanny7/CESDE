USE HuellasDB;
GO

DECLARE @Cantidad INT;

EXEC sp_TotalAnimales @Cantidad OUTPUT;

SELECT @Cantidad AS TotalAnimales;
GO