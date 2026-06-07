USE BD2_TPI_G43
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
END


/* Tomar el Id del cliente y el Id del empleado y verificarlos*/
/* Insertar la venta con la fecha actual y el total insertado */
/* Las observaciones son opcionales */
/* Pedir el id del medicamento y verifcarlo tambien con la cantidad */
/* Calcular el subtotal y tomar el precio unitario de medicamentos de precio venta con iva */