CREATE DATABASE BD2_TPI_G43;
GO

USE BD2_TPI_G43;
GO

CREATE TABLE Roles (
    Id_rol INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Descripcion VARCHAR(255) NULL
);
GO

CREATE TABLE ObrasSociales (
    Id_obra_social INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Sigla VARCHAR(20) NULL,
    Descuento_general DECIMAL(5,2) DEFAULT 0.00 NOT NULL
);
GO

CREATE TABLE Medicamentos(
    Id_medicamento BIGINT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Laboratorio VARCHAR(100) NOT NULL,
    Principio_activo VARCHAR(100) NOT NULL,
    Stock_actual INT NOT NULL,
    Stock_minimo INT DEFAULT 1 NOT NULL, 
    Precio_costo money NOT NULL,
    Precio_venta_sin_iva money NOT NULL,
    Precio_venta_con_iva money NOT NULL,
    Requiere_receta BIT DEFAULT 0 NOT NULL
);
GO

CREATE TABLE Clientes(
    Id_cliente BIGINT IDENTITY(1,1) PRIMARY KEY,
    DNI VARCHAR(20) NOT NULL UNIQUE,
    Nombre VARCHAR(80) NOT NULL,
    Apellido VARCHAR(80) NOT NULL,
    Telefono VARCHAR(30) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Id_obra_social INT NULL,
    FOREIGN KEY (Id_obra_social) REFERENCES ObrasSociales(Id_obra_social)
);
GO

CREATE TABLE Empleados(
    Id_empleado BIGINT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(80) NOT NULL,
    Apellido VARCHAR(80) NOT NULL,
    Id_rol INT NOT NULL,
    Usuario VARCHAR(50) NOT NULL UNIQUE,
    Contrasena_hash VARCHAR(255) NOT NULL,
    FOREIGN KEY (Id_rol) REFERENCES Roles(Id_rol)
);
GO

CREATE TABLE Proveedores(
    Id_proveedor BIGINT IDENTITY(1,1) PRIMARY KEY,
    Razon_social VARCHAR(150) NOT NULL,
    Cuit VARCHAR(20) NOT NULL UNIQUE,
    Telefono VARCHAR(30) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Direccion VARCHAR(200) NOT NULL,
    Contacto_nombre VARCHAR(100) NOT NULL,
    Contacto_cargo VARCHAR(50) NOT NULL,
    Contacto_telefono VARCHAR(30) NULL,
    Contacto_email VARCHAR(100) NULL,
    Cbu VARCHAR(22) NOT NULL
);
GO

CREATE TABLE PedidosCompra(
    Id_pedido BIGINT IDENTITY(1,1) PRIMARY KEY,
    Id_proveedor BIGINT NOT NULL,
    Id_empleado BIGINT NOT NULL,
    Fecha_pedido DATETIME NOT NULL DEFAULT GETDATE(),
    Estado VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
    Total_estimado money NOT NULL,
    FOREIGN KEY (Id_proveedor) REFERENCES Proveedores(Id_proveedor),
    FOREIGN KEY (Id_empleado) REFERENCES Empleados(Id_empleado)
);
GO

CREATE TABLE DetallePedidoCompra(
    Id_detalle_pedido BIGINT IDENTITY(1,1) PRIMARY KEY,
    Id_pedido BIGINT NOT NULL,
    Id_medicamento BIGINT NOT NULL,
    Cantidad INT NOT NULL,
    Precio_costo_pactado money NOT NULL,
    Subtotal money NOT NULL,
    FOREIGN KEY (Id_pedido) REFERENCES PedidosCompra(Id_pedido),
    FOREIGN KEY (Id_medicamento) REFERENCES Medicamentos(Id_medicamento)
);
GO

CREATE TABLE Ventas(
    Id_venta BIGINT IDENTITY(1,1) PRIMARY KEY,
    Id_cliente BIGINT NULL,
    Id_empleado BIGINT NOT NULL,
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),
    Total money NOT NULL DEFAULT 0.00,
    Observaciones VARCHAR(255) NULL,
    FOREIGN KEY (Id_cliente) REFERENCES Clientes(Id_cliente),
    FOREIGN KEY (Id_empleado) REFERENCES Empleados(Id_empleado)
);
GO

CREATE TABLE DetalleVenta(
    Id_detalle BIGINT IDENTITY(1,1) PRIMARY KEY,
    Id_venta BIGINT NOT NULL,
    Id_medicamento BIGINT NOT NULL,
    Cantidad INT NOT NULL,
    Precio_unitario money NOT NULL,
    Subtotal money NOT NULL,
    FOREIGN KEY (Id_venta) REFERENCES Ventas(Id_venta),
    FOREIGN KEY (Id_medicamento) REFERENCES Medicamentos(Id_medicamento)
);
GO

CREATE TABLE IngresoStock(
    Id_ingreso BIGINT IDENTITY(1,1) PRIMARY KEY,
    Id_pedido BIGINT NULL,
    Id_proveedor BIGINT NOT NULL,
    Id_medicamento BIGINT NOT NULL,
    Cantidad INT NOT NULL,
    Fecha_ingreso DATETIME NOT NULL DEFAULT GETDATE(), 
    Precio_costo money NOT NULL,
    FOREIGN KEY (Id_pedido) REFERENCES PedidosCompra(Id_pedido),
    FOREIGN KEY (Id_proveedor) REFERENCES Proveedores(Id_proveedor),
    FOREIGN KEY (Id_medicamento) REFERENCES Medicamentos(Id_medicamento)
);
GO

CREATE TABLE Recetas(
    Id_receta BIGINT IDENTITY(1,1) PRIMARY KEY,
    Id_venta BIGINT NOT NULL,
    Id_cliente BIGINT NOT NULL,
    Medico_prescriptor VARCHAR(150) NOT NULL,
    Fecha_emision DATE NOT NULL,
    Observaciones VARCHAR(255) NULL,
    FOREIGN KEY (Id_venta) REFERENCES Ventas(Id_venta),
    FOREIGN KEY (Id_cliente) REFERENCES Clientes(Id_cliente)
);
GO

CREATE TABLE AlertasStock(
    Id_alerta BIGINT IDENTITY(1,1) PRIMARY KEY,
    Id_medicamento BIGINT NOT NULL,
    Fecha_alerta DATETIME NOT NULL DEFAULT GETDATE(),
    Stock_actual INT NOT NULL,
    Stock_minimo INT NOT NULL,
    Resuelta BIT DEFAULT 0 NOT NULL,
    FOREIGN KEY (Id_medicamento) REFERENCES Medicamentos(Id_medicamento)
);
GO
