USE BD2_TPI_G43;
GO

CREATE TRIGGER trg_DescuentoStock ON DetalleVenta
AFTER INSERT
AS
BEGIN
    UPDATE M
    SET Stock_actual = M.Stock_actual - I.Cantidad
    FROM Medicamentos M
    INNER JOIN inserted I ON M.Id_medicamento = I.Id_medicamento
END;
GO

CREATE TRIGGER trg_AlertaStockMinimo ON Medicamentos
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Stock_actual)
    BEGIN
        INSERT INTO AlertasStock (Id_medicamento, Fecha_alerta, Stock_actual, Stock_minimo, Resuelta)
        SELECT i.Id_medicamento, GETDATE(), i.Stock_actual, i.Stock_minimo, 0
        FROM inserted i
        WHERE i.Stock_actual <= i.Stock_minimo
            AND NOT EXISTS (
                SELECT 1
                FROM AlertasStock a
                WHERE a.Id_medicamento = i.Id_medicamento
                    AND a.Resuelta = 0
            )
    END
END;
GO

CREATE TRIGGER trg_ValidarReceta ON DetalleVenta
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted I
        INNER JOIN Medicamentos M ON I.Id_medicamento = M.Id_medicamento
        WHERE M.Requiere_receta = 1
            AND NOT EXISTS (
                SELECT 1
                FROM Recetas R
                WHERE R.Id_venta = I.Id_venta
            )
    )
    BEGIN
        RAISERROR('No se puede vender un medicamento que requiere receta sin una receta asociada.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
GO
