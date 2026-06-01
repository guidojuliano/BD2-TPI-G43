USE BD2_TPI_G43;
GO

IF OBJECT_ID('Vista_StockBajo', 'V') IS NOT NULL
    DROP VIEW Vista_StockBajo;
GO

CREATE VIEW Vista_StockBajo AS
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
WHERE Stock_actual <= Stock_minimo;
GO

IF OBJECT_ID('Vista_VentasMes', 'V') IS NOT NULL
    DROP VIEW Vista_VentasMes;
GO

CREATE VIEW Vista_VentasMes AS
SELECT 
    E.Id_empleado,
    E.Nombre AS Nombre_empleado,
    E.Apellido AS Apellido_empleado,
    R.Nombre AS Rol_empleado,
    YEAR(V.Fecha) AS Anio,
    MONTH(V.Fecha) AS Mes,
    COUNT(V.Id_venta) AS Cantidad_ventas,
    SUM(V.Total) AS Total_facturado
FROM Ventas V
INNER JOIN Empleados E ON V.Id_empleado = E.Id_empleado
INNER JOIN Roles R ON E.Id_rol = R.Id_rol
GROUP BY E.Id_empleado, E.Nombre, E.Apellido, R.Nombre, YEAR(V.Fecha), MONTH(V.Fecha);
GO

IF OBJECT_ID('Vista_TopMedicamentos', 'V') IS NOT NULL
    DROP VIEW Vista_TopMedicamentos;
GO

CREATE VIEW Vista_TopMedicamentos AS
SELECT TOP 10
    M.Id_medicamento,
    M.Nombre AS Nombre_medicamento,
    M.Laboratorio,
    M.Principio_activo,
    SUM(DV.Cantidad) AS Cantidad_total_vendida,
    SUM(DV.Subtotal) AS Facturacion_total
FROM DetalleVenta DV
INNER JOIN Medicamentos M ON DV.Id_medicamento = M.Id_medicamento
GROUP BY M.Id_medicamento, M.Nombre, M.Laboratorio, M.Principio_activo
ORDER BY Cantidad_total_vendida DESC;
GO
