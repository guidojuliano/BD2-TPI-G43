USE BD2_TPI_G43;
GO

IF OBJECT_ID('fn_ObtenerDescuentoObraSocial', 'FN') IS NOT NULL
    DROP FUNCTION fn_ObtenerDescuentoObraSocial;
GO

CREATE FUNCTION fn_ObtenerDescuentoObraSocial (@Id_cliente BIGINT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @Descuento DECIMAL(5,2) = 0.00;
    IF @Id_cliente IS NOT NULL
    BEGIN
        SELECT @Descuento = OS.Descuento_general
        FROM Clientes C
        INNER JOIN ObrasSociales OS ON C.Id_obra_social = OS.Id_obra_social
        WHERE C.Id_cliente = @Id_cliente;
    END
    RETURN ISNULL(@Descuento, 0.00);
END;
GO

IF OBJECT_ID('fn_CalcularPrecioConIva', 'FN') IS NOT NULL
    DROP FUNCTION fn_CalcularPrecioConIva;
GO

CREATE FUNCTION fn_CalcularPrecioConIva (@Precio_neto money)
RETURNS money
AS
BEGIN
    RETURN @Precio_neto * 1.21;
END;
GO
