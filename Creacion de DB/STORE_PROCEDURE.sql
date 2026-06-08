USE BD2_TPI_G43;
GO

IF OBJECT_ID('sp_IngresarStock', 'P') IS NOT NULL
    DROP PROCEDURE sp_IngresarStock;
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
END;
GO

IF OBJECT_ID('sp_RegistrarVenta', 'P') IS NOT NULL
    DROP PROCEDURE sp_RegistrarVenta;
GO

CREATE PROCEDURE sp_RegistrarVenta(
    @IdCliente INT,
    @IdEmpleado INT,
    @IdMedicamento INT,
    @Cantidad INT,
    @Observaciones VARCHAR = NULL
)
AS
BEGIN
    DECLARE @StockActual        INT
    DECLARE @StockMinimo        INT
    DECLARE @PrecioUnitario     MONEY
    DECLARE @Subtotal           MONEY
    DECLARE @Descuento          DECIMAL(5,2) = 0
    DECLARE @Total              MONEY
    DECLARE @IdObraSocial       INT
    DECLARE @IdVenta            BIGINT

    SELECT
        @StockActual    = Stock_actual,
        @StockMinimo    = Stock_minimo,
        @PrecioUnitario = Precio_venta_con_iva
    FROM Medicamentos
    WHERE Id_medicamento = @IdMedicamento

    IF @StockActual < @Cantidad
    BEGIN
        RAISERROR('Stock insuficiente para realizar la venta.', 16, 1)
        RETURN
    END

    IF @IdCliente IS NOT NULL
    BEGIN
        SELECT @IdObraSocial = Id_obra_social
        FROM Clientes
        WHERE Id_cliente = @IdCliente

        IF @IdObraSocial IS NOT NULL
            SELECT @Descuento = Descuento_general
        FROM ObrasSociales
        WHERE Id_obra_social = @IdObraSocial
    END

    IF NOT EXISTS (SELECT 1
    FROM Empleados
    WHERE Id_empleado = @IdEmpleado)
    BEGIN
        RAISERROR('El empleado no existe', 16, 1)
        RETURN
    END

    IF NOT EXISTS (SELECT 1
    FROM Medicamentos
    WHERE Id_medicamento = @IdMedicamento)
    BEGIN
        RAISERROR('El medicamento no existe', 16, 1)
        RETURN
    END

    SET @Subtotal = @Cantidad * @PrecioUnitario
    SET @Total    = @Subtotal * (1 - @Descuento / 100)

    INSERT INTO Ventas
        (Id_cliente, Id_empleado, Fecha, Total, Observaciones)
    VALUES
        (@IdCliente, @IdEmpleado, GETDATE(), @Total, @Observaciones)

    SET @IdVenta = SCOPE_IDENTITY()

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
END;
GO
