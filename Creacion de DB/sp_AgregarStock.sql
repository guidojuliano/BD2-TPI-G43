USE BD2_TPI_G43
GO
CREATE PROCEDURE sp_IngresarStock
    (@IdProveedor INT,
    @IdPedido INT = NULL,
    @IdMedicamento INT,
    @Cantidad INT,
    @PrecioCosto DECIMAL(10,2)
)
AS

BEGIN
    IF NOT EXISTS (SELECT 1
    FROM Proveedores
    WHERE Id_proveedor = @IdProveedor)
    BEGIN
        RAISERROR('El proveedor no existe.', 16, 1)
        RETURN
    END

    IF @IdPedido IS NOT NULL
    BEGIN
        IF NOT EXISTS (SELECT 1
        FROM PedidosCompra
        WHERE Id_pedido = @IdPedido)
        BEGIN
            RAISERROR('El pedido no existe.', 16, 1)
            RETURN
        END

        IF NOT EXISTS (
            SELECT 1
        FROM PedidosCompra
        WHERE Id_pedido = @IdPedido AND Id_proveedor = @IdProveedor
        )
        BEGIN
            RAISERROR('El pedido no corresponde al proveedor indicado.', 16, 1)
            RETURN
        END
    END

    IF NOT EXISTS (SELECT 1
    FROM Medicamentos
    WHERE Id_medicamento = @IdMedicamento)
    BEGIN
        RAISERROR('El medicamento no existe.', 16, 1)
        RETURN
    END

    IF @Cantidad <= 0
    BEGIN
        RAISERROR('La cantidad debe ser mayor a cero.', 16, 1)
        RETURN
    END

    IF @PrecioCosto <= 0
    BEGIN
        RAISERROR('El precio de costo debe ser mayor a cero.', 16, 1)
        RETURN
    END

    INSERT INTO IngresoStock
        (Id_pedido, Id_proveedor, Id_medicamento, Cantidad, Precio_costo, Fecha_ingreso)
    VALUES
        (@IdPedido, @IdProveedor, @IdMedicamento, @Cantidad, @PrecioCosto, GETDATE())


    UPDATE Medicamentos
    SET Stock_actual = Stock_actual + @Cantidad,
        Precio_costo = @PrecioCosto
    WHERE Id_medicamento = @IdMedicamento

    UPDATE AlertasStock
        SET Resuelta = 1
        WHERE Id_medicamento = @IdMedicamento
        AND Resuelta = 0
        AND EXISTS (
              SELECT 1
        FROM Medicamentos
        WHERE Id_medicamento = @IdMedicamento
            AND Stock_actual >= Stock_minimo
          )
END
