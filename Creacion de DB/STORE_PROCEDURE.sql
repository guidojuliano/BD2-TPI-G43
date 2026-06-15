USE BD2_TPI_G43;
GO

IF OBJECT_ID('sp_IngresarStock', 'P') IS NOT NULL
    DROP PROCEDURE sp_IngresarStock;
GO

CREATE PROCEDURE sp_IngresarStock (
    @IdProveedor BIGINT,
    @IdPedido BIGINT = NULL,
    @IdMedicamento BIGINT,
    @Cantidad INT,
    @PrecioCosto money
)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE Id_proveedor = @IdProveedor)
    BEGIN
        RAISERROR('El proveedor no existe.', 16, 1)
        RETURN
    END

    IF @IdPedido IS NOT NULL
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM PedidosCompra WHERE Id_pedido = @IdPedido)
        BEGIN
            RAISERROR('El pedido no existe.', 16, 1)
            RETURN
        END

        IF NOT EXISTS (
            SELECT 1 FROM PedidosCompra 
            WHERE Id_pedido = @IdPedido AND Id_proveedor = @IdProveedor
        )
        BEGIN
            RAISERROR('El pedido no corresponde al proveedor indicado.', 16, 1)
            RETURN
        END
    END

    IF NOT EXISTS (SELECT 1 FROM Medicamentos WHERE Id_medicamento = @IdMedicamento)
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
          SELECT 1 FROM Medicamentos
          WHERE Id_medicamento = @IdMedicamento AND Stock_actual >= Stock_minimo
      )
END;
GO

IF OBJECT_ID('sp_RegistrarVenta', 'P') IS NOT NULL
    DROP PROCEDURE sp_RegistrarVenta;
GO

CREATE PROCEDURE sp_RegistrarVenta (
    @IdCliente BIGINT,
    @IdEmpleado BIGINT,
    @IdMedicamento BIGINT,
    @Cantidad INT,
    @PrecioUnitarioCobrado money,
    @Observaciones VARCHAR(255) = NULL
)
AS
BEGIN
    DECLARE @StockActual INT
    DECLARE @StockMinimo INT
    DECLARE @Subtotal money
    DECLARE @Total money
    DECLARE @IdVenta BIGINT

    SELECT
        @StockActual = Stock_actual,
        @StockMinimo = Stock_minimo
    FROM Medicamentos
    WHERE Id_medicamento = @IdMedicamento

    IF @StockActual < @Cantidad
    BEGIN
        RAISERROR('Stock insuficiente para realizar la venta.', 16, 1)
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM Empleados WHERE Id_empleado = @IdEmpleado)
    BEGIN
        RAISERROR('El empleado no existe', 16, 1)
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM Medicamentos WHERE Id_medicamento = @IdMedicamento)
    BEGIN
        RAISERROR('El medicamento no existe', 16, 1)
        RETURN
    END

    SET @Subtotal = @Cantidad * @PrecioUnitarioCobrado
    SET @Total = @Subtotal

    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO Ventas
            (Id_cliente, Id_empleado, Fecha, Total, Observaciones)
        VALUES
            (@IdCliente, @IdEmpleado, GETDATE(), @Total, @Observaciones)

        SET @IdVenta = SCOPE_IDENTITY()

        INSERT INTO DetalleVenta
            (Id_venta, Id_medicamento, Cantidad, Precio_unitario, Subtotal)
        VALUES
            (@IdVenta, @IdMedicamento, @Cantidad, @PrecioUnitarioCobrado, @Subtotal)

        UPDATE Medicamentos
        SET Stock_actual = Stock_actual - @Cantidad
        WHERE Id_medicamento = @IdMedicamento

        IF (@StockActual - @Cantidad) < @StockMinimo
        BEGIN
            INSERT INTO AlertasStock
                (Id_medicamento, Fecha_alerta, Stock_actual, Stock_minimo, Resuelta)
            VALUES
                (@IdMedicamento, GETDATE(), (@StockActual - @Cantidad), @StockMinimo, 0)
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

IF OBJECT_ID('sp_BuscarMedicamento', 'P') IS NOT NULL
    DROP PROCEDURE sp_BuscarMedicamento;
GO

CREATE PROCEDURE sp_BuscarMedicamento (
    @TerminoBusqueda VARCHAR(100)
)
AS
BEGIN
    SELECT 
        Id_medicamento,
        Nombre,
        Laboratorio,
        Principio_activo,
        Stock_actual,
        Stock_minimo,
        Precio_costo,
        Precio_venta_sin_iva,
        Precio_venta_con_iva,
        Requiere_receta
    FROM Medicamentos
    WHERE Nombre LIKE '%' + @TerminoBusqueda + '%'
       OR Laboratorio LIKE '%' + @TerminoBusqueda + '%'
       OR Principio_activo LIKE '%' + @TerminoBusqueda + '%';
END;
GO
