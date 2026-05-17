--CREATE DATABASE BD2_TPI_G43

USE BD2_TPI_G43

GO

CREATE TABLE Medicamentos(
    Id_medicamento BIGINT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Laboratorio VARCHAR(100) NOT NULL,
    Principio_activo VARCHAR(100) NOT NULL,
    Stock_actual INT NOT NULL,
    Stock_minimo INT DEFAULT 1 NOT NULL, 
    Precio_costo DECIMAL(10,2) NOT NULL,
    Precio_venta DECIMAL(10,2) NOT NULL,
    Requiere_receta BIT DEFAULT 0,
);

CREATE TABLE Clientes(
    Id_cliente BIGINT IDENTITY(1,1) PRIMARY KEY,
    DNI VARCHAR(20) NOT NULL,
    Nombre VARCHAR(80) NOT NULL,
    Apellido VARCHAR(80) NOT NULL,
    Telefono VARCHAR(30) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Obra_social VARCHAR(100),
);

CREATE TABLE Empleados(
    Id_empleado BIGINT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(80) NOT NULL,
    Apellido VARCHAR(80) NOT NULL,
    Rol VARCHAR(50) NOT NULL,
    Usuario VARCHAR(50) NOT NULL,
    Contrasena_hash VARCHAR(255) NOT NULL
);

CREATE TABLE Proveedores(
    Id_proveedor BIGINT IDENTITY(1,1) PRIMARY KEY,
    Razon_social VARCHAR(150) NOT NULL,
    Cuit VARCHAR(20) NOT NULL,
    Telefono VARCHAR(30) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Direccion VARCHAR(200) NOT NULL
);

CREATE TABLE Ventas(
    Id_venta BIGINT IDENTITY(1,1) PRIMARY KEY,
    Id_cliente BIGINT NOT NULL,
    Id_empleado BIGINT NOT NULL,
    Fecha DATE NOT NULL,
    Total DECIMAL(10,2),
    Observaciones VARCHAR(255),

    FOREIGN KEY (Id_cliente)
    REFERENCES Clientes(Id_cliente),

    FOREIGN KEY (Id_empleado)
    REFERENCES Empleados(Id_empleado)
);

CREATE TABLE DetalleVenta(
    Id_detalle BIGINT IDENTITY(1,1) PRIMARY KEY,
    Id_venta BIGINT NOT NULL,
    Id_medicamento BIGINT NOT NULL,
    Cantidad INT NOT NULL,
    Precio_unitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (Id_venta)
    REFERENCES Ventas(Id_venta),

    FOREIGN KEY(Id_medicamento)
    REFERENCES Medicamentos(Id_medicamento)
);

CREATE TABLE IngresoStock(
    Id_ingreso BIGINT IDENTITY(1,1) PRIMARY KEY,
    Id_proveedor BIGINT NOT NULL,
    Id_medicamento BIGINT NOT NULL,
    Cantidad INT NOT NULL,
    Fecha_ingreso DATE NOT NULL, 
    Precio_costo DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (Id_proveedor)
    REFERENCES Proveedores(Id_proveedor),

    FOREIGN KEY (Id_medicamento)
    REFERENCES Medicamentos(Id_medicamento)
);

CREATE TABLE Recetas(
    Id_receta BIGINT IDENTITY(1,1) PRIMARY KEY,
    Id_venta BIGINT NOT NULL,
    Id_cliente BIGINT NOT NULL,
    Medico_prescriptor VARCHAR(150) NOT NULL,
    Fecha_emision DATE NOT NULL,
    Observaciones VARCHAR(255),

    FOREIGN KEY (Id_venta)
    REFERENCES Ventas(Id_venta),

    FOREIGN KEY (Id_cliente)
    REFERENCES Clientes(Id_cliente)
);
