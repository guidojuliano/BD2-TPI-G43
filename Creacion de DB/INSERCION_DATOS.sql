USE BD2_TPI_G43;
GO

SET DATEFORMAT ymd;
GO

DELETE FROM AlertasStock;
DELETE FROM Recetas;
DELETE FROM DetalleVenta;
DELETE FROM Ventas;
DELETE FROM IngresoStock;
DELETE FROM DetallePedidoCompra;
DELETE FROM PedidosCompra;
DELETE FROM Medicamentos;
DELETE FROM Clientes;
DELETE FROM Empleados;
DELETE FROM Proveedores;
DELETE FROM ObrasSociales;
DELETE FROM Roles;
GO

SET IDENTITY_INSERT Roles ON;
INSERT INTO Roles (Id_rol, Nombre, Descripcion) VALUES
(1, 'Administrador', 'Acceso total a la configuracion y reportes de la farmacia'),
(2, 'Farmaceutico', 'Responsable de la atencion al cliente y validacion de recetas'),
(3, 'Cajero', 'Responsable de la facturacion y cobro de ventas'),
(4, 'Repositor', 'Responsable del control de inventario e ingreso de stock'),
(5, 'Auditor', 'Responsable de controlar recetas y convenios con obras sociales');
SET IDENTITY_INSERT Roles OFF;
GO

SET IDENTITY_INSERT ObrasSociales ON;
INSERT INTO ObrasSociales (Id_obra_social, Nombre, Sigla, Descuento_general) VALUES
(1, 'Obra Social de Empleados de Comercio y Actividades Civiles', 'OSECAC', 40.00),
(2, 'Programa de Atencion Medica Integral', 'PAMI', 80.00),
(3, 'Obra Social de Ejecutivos y Asociados', 'OSDE', 40.00),
(4, 'Swiss Medical Group', 'Swiss Medical', 50.00),
(5, 'Galeno Argentina', 'Galeno', 40.00),
(6, 'Instituto de Obra Medico Asistencial', 'IOMA', 60.00),
(7, 'Sancor Salud', 'Sancor', 50.00),
(8, 'Medife', 'Medife', 40.00),
(9, 'Obra Social del Personal de la Actividad Vial', 'OSPAV', 30.00),
(10, 'Obra Social de la Union del Personal Civil de la Nacion', 'UPCN', 40.00);
SET IDENTITY_INSERT ObrasSociales OFF;
GO

SET IDENTITY_INSERT Medicamentos ON;
INSERT INTO Medicamentos (Id_medicamento, Nombre, Laboratorio, Principio_activo, Stock_actual, Stock_minimo, Precio_costo, Precio_venta_sin_iva, Precio_venta_con_iva, Requiere_receta) VALUES
(1, 'Ibuprofeno 600mg (Actron)', 'Bayer', 'Ibuprofeno', 150, 20, 850.00, 1198.35, 1450.00, 0),
(2, 'Paracetamol 1g (Tafirol)', 'Genomma Lab', 'Paracetamol', 200, 25, 600.00, 909.09, 1100.00, 0),
(3, 'Amoxicilina 500mg (Optamox)', 'Roemmers', 'Amoxicilina', 8, 15, 1800.00, 2644.63, 3200.00, 1),
(4, 'Clonazepam 2mg (Rivotril)', 'Roche', 'Clonazepam', 40, 10, 1500.00, 2231.40, 2700.00, 1),
(5, 'Aspirina 100mg (Aspirineta)', 'Bayer', 'Acido Acetilsalicilico', 300, 30, 300.00, 495.87, 600.00, 0),
(6, 'Atorvastatina 20mg (Lipitor)', 'Pfizer', 'Atorvastatina', 90, 15, 2500.00, 3719.01, 4500.00, 1),
(7, 'Metformina 850mg (Dianben)', 'Merck', 'Metformina', 120, 20, 1200.00, 1818.18, 2200.00, 1),
(8, 'Losartan 50mg (Cozaar)', 'Merck', 'Losartan', 5, 15, 1400.00, 2148.76, 2600.00, 1),
(9, 'Enalapril 10mg (Lotrial)', 'Roemmers', 'Enalapril', 180, 20, 800.00, 1239.67, 1500.00, 1),
(10, 'Omeprazol 20mg (Ulcozol)', 'Bago', 'Omeprazol', 160, 25, 1000.00, 1528.93, 1850.00, 0),
(11, 'Loratadina 10mg (Aerotina)', 'Raffo', 'Loratadina', 250, 15, 750.00, 1115.70, 1350.00, 0),
(12, 'Salbutamol Aerosol', 'GlaxoSmithKline', 'Salbutamol', 3, 10, 2100.00, 3140.50, 3800.00, 1),
(13, 'Sertralina 50mg (Zoloft)', 'Pfizer', 'Sertralina', 55, 8, 3100.00, 4628.10, 5600.00, 1),
(14, 'Ibupirac Suspension Infantil', 'Pfizer', 'Ibuprofeno', 80, 12, 1100.00, 1735.54, 2100.00, 0),
(15, 'Sildenafil 50mg (Magnus)', 'Sidus', 'Sildenafil', 110, 10, 900.00, 1404.96, 1700.00, 1),
(16, 'Buscapina Composite', 'Boehringer Ingelheim', 'Hioscina + Dipirona', 140, 15, 1300.00, 1983.47, 2400.00, 0),
(17, 'Alprazolam 1mg (Alplax)', 'Gador', 'Alprazolam', 60, 12, 1400.00, 2107.44, 2550.00, 1),
(18, 'Decadron 4mg (Dexametasona)', 'Sidus', 'Dexametasona', 4, 8, 1600.00, 2396.69, 2900.00, 1),
(19, 'Tiroxina 100mcg (T4)', 'Montpellier', 'Levotiroxina', 190, 20, 1250.00, 1900.83, 2300.00, 1),
(20, 'Bactrim Forte', 'Roche', 'Sulfametoxazol + Trimetoprima', 75, 10, 1950.00, 2892.56, 3500.00, 1);
SET IDENTITY_INSERT Medicamentos OFF;
GO

SET IDENTITY_INSERT Clientes ON;
INSERT INTO Clientes (Id_cliente, DNI, Nombre, Apellido, Telefono, Email, Id_obra_social) VALUES
(1, '28345678', 'Guido', 'Juliano', '11-6543-2109', 'guido.juliano@gmail.com', 3),
(2, '35432109', 'Thiago', 'Sandoval', '11-7654-3210', 'thiago.sandoval@outlook.com', 2),
(3, '40123456', 'Dilan', 'Benitez', '11-8765-4321', 'dilan.benitez@yahoo.com.ar', 1),
(4, '15987654', 'Alberto', 'Fernandez', '11-2345-6789', 'alberto@gmail.com', 2),
(5, '31456789', 'Maria Laura', 'Gonzalez', '0341-1559999', 'mlgonzalez@gmail.com', 7),
(6, '22345987', 'Carlos Alberto', 'Rodriguez', '0351-4569871', 'carlos.rod@hotmail.com', NULL),
(7, '38765432', 'Florencia', 'Gomez', '11-3456-7890', 'flor.gomez@gmail.com', 3),
(8, '44123987', 'Lucas', 'Martinez', '0223-4552211', 'lucas.martinez@live.com.ar', 6),
(9, '25654321', 'Patricia', 'Bullrich', '11-9876-5432', 'patricia@gmail.com', NULL),
(10, '33987456', 'Javier', 'Milei', '11-5678-9012', 'milei.javier@economia.org', 5),
(11, '18456123', 'Marta', 'Sanchez', '11-3322-1100', 'marta.sanchez@gmail.com', 2),
(12, '29456781', 'Ricardo', 'Darin', '11-5544-3322', 'ricardo.darin@sagai.org', 4),
(13, '36123456', 'Sofia', 'Loren', '11-6677-8899', 'sofia.loren@gmail.com', 3),
(14, '41098765', 'Mateo', 'Retegui', '11-8899-0011', 'mateo.retegui@hotmail.com', 1),
(15, '20987654', 'Eduardo', 'Duhalde', '011-48229900', 'eduardo@duhalde.com', 2),
(16, '32123789', 'Romina', 'Tejerina', '11-2244-6688', 'romi.tejerina@gmail.com', 5),
(17, '27890432', 'Esteban', 'Bullrich', '11-3355-7799', 'esteban.bullrich@senado.gov.ar', 4),
(18, '39123852', 'Camila', 'Homs', '11-7788-9900', 'camila.homs@gmail.com', 3),
(19, '30789456', 'Lionel', 'Messi', '0341-4889900', 'liomessi10@gmail.com', 4),
(20, '34765123', 'Antonela', 'Roccuzzo', '0341-4889901', 'anto.roccuzzo@gmail.com', 4);
SET IDENTITY_INSERT Clientes OFF;
GO

SET IDENTITY_INSERT Empleados ON;
INSERT INTO Empleados (Id_empleado, Nombre, Apellido, Id_rol, Usuario, Contrasena_hash) VALUES
(1, 'Admin', 'Farmacia', 1, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918'),
(2, 'Juan Manuel', 'Perez', 2, 'jperez', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(3, 'Ana Maria', 'Lopez', 3, 'alopez', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(4, 'Diego Armando', 'Maradona', 3, 'd10s', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(5, 'Claudio Paul', 'Caniggia', 3, 'pajaro', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(6, 'Gabriel Omar', 'Batistuta', 2, 'batigol', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(7, 'Juan Roman', 'Riquelme', 1, 'roman10', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(8, 'Martin', 'Palermo', 2, 'titan9', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(9, 'Ariel', 'Ortega', 3, 'burrito', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(10, 'Enzo', 'Francescoli', 2, 'principe', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(11, 'Marcelo', 'Gallardo', 1, 'muneco', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(12, 'Carlos', 'Tevez', 3, 'apache', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(13, 'Angel', 'Di Maria', 3, 'fideo', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(14, 'Emiliano', 'Martinez', 2, 'dibu', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(15, 'Rodrigo', 'De Paul', 3, 'motorcito', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(16, 'Lautaro', 'Martinez', 3, 'toro', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(17, 'Julian', 'Alvarez', 2, 'arana', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(18, 'Alexis', 'Mac Allister', 3, 'colorado', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(19, 'Enzo', 'Fernandez', 3, 'enzo_f', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
(20, 'Nicolas', 'Otamendi', 3, 'general', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3');
SET IDENTITY_INSERT Empleados OFF;
GO

SET IDENTITY_INSERT Proveedores ON;
INSERT INTO Proveedores (Id_proveedor, Razon_social, Cuit, Telefono, Email, Direccion, Contacto_nombre, Contacto_cargo, Contacto_telefono, Contacto_email, Cbu) VALUES
(1, 'Drogueria del Sud S.A.', '30-50123456-9', '011-43456789', 'ventas@drogueriadelsud.com.ar', 'Av. Caseros 3039, CABA', 'Gomez Marcelo', 'Gerente Comercial', '11-3001-2321', 'mgomez@drogueriadelsud.com.ar', '0070001020000012345671'),
(2, 'Drogueria Monroe Americana', '30-51234567-8', '011-48569900', 'contacto@monroe.com.ar', 'Olavarria 120, Avellaneda', 'Perez Jose', 'Ejecutivo de Ventas', '11-4403-2901', 'jperez@monroe.com.ar', '0070001020000012345672'),
(3, 'Drogueria Saporiti S.A.', '30-52345678-7', '011-49812323', 'info@saporiti.com.ar', 'Warnes 1450, CABA', 'Saporiti Carlos', 'Director de Ventas', '11-5092-2309', 'csaporiti@saporiti.com.ar', '0070001020000012345673'),
(4, 'Drogueria Kellerhoff S.A.', '30-53456789-6', '0341-4206000', 'keller@kellerhoff.com.ar', 'Santa Fe 1240, Rosario', 'Kellerhoff Luis', 'Socio Gerente', '341-4091-239', 'lkeller@kellerhoff.com.ar', '0070001020000012345674'),
(5, 'Drogueria Barracas S.R.L.', '30-54567890-5', '011-43015566', 'pedidos@drogueriabarracas.com', 'Herrera 1600, CABA', 'Lopez Ruben', 'Responsable Despacho', '11-6029-3382', 'rlopez@drogueriabarracas.com', '0070001020000012345675'),
(6, 'Farmaceutica del Plata S.A.', '30-55678901-4', '011-47895522', 'contacto@fplata.com.ar', 'Belgrano 2500, San Martin', 'Ferreira Hugo', 'Vendedor de Cuentas', '11-3092-8401', 'hferreira@fplata.com.ar', '0070001020000012345676'),
(7, 'Distribuidora Fenix', '30-56789012-3', '0351-4778899', 'ventas@fenixdist.com', 'Av. Colon 4500, Cordoba', 'Mendez Ariel', 'Lider de Distribucion', '351-5091-923', 'amendez@fenixdist.com', '0070001020000012345677'),
(8, 'Drogueria Sur Oeste S.A.', '30-57890123-2', '0291-4556677', 'ventas@suroeste.com', 'Donado 340, Bahia Blanca', 'Romero Pablo', 'Administrador de Cuentas', '291-4019-382', 'promero@suroeste.com', '0070001020000012345678'),
(9, 'Lafedar Laboratorios S.A.', '30-58901234-1', '0343-4362200', 'contacto@lafedar.com.ar', 'Parque Industrial, Parana', 'Lafedar Jorge', 'Jefe de Logistica', '343-4819-209', 'jlafedar@lafedar.com.ar', '0070001020000012345679'),
(10, 'Drogueria Asoprof S.R.L.', '30-59012345-0', '011-46332211', 'compras@asoprof.com.ar', 'Pedernera 50, CABA', 'Alvarez Maria', 'Supervisora de Ventas', '11-6029-9482', 'malvarez@asoprof.com.ar', '0070001020000012345680'),
(11, 'Gador S.A. (Directo)', '30-60123456-9', '011-48509000', 'institucional@gador.com.ar', 'Darwin 429, CABA', 'Gador Pedro', 'Director Comercial', '11-5029-9238', 'pgador@gador.com.ar', '0070001020000012345681'),
(12, 'Roemmers S.A.I.C.F. (Directo)', '30-61234567-8', '011-43405000', 'ventas@roemmers.com.ar', 'Fray Justo Sarmiento 2350, Olivos', 'Roemmers Alberto', 'Director Operaciones', '11-6029-1923', 'aroemmers@roemmers.com.ar', '0070001020000012345682'),
(13, 'Bago S.A. (Directo)', '30-62345678-7', '011-43440000', 'bago@bago.com.ar', 'Bernardo de Irigoyen 248, CABA', 'Bago Juan', 'Gerente General', '11-3094-9582', 'jbago@bago.com.ar', '0070001020000012345683'),
(14, 'Montpellier S.A.', '30-63456789-6', '011-45889200', 'pedidos@montpellier.com.ar', 'Migueletes 1243, CABA', 'Montpellier Gaston', 'Jefe de Canal Directo', '11-4902-1209', 'gmontpellier@montpellier.com.ar', '0070001020000012345684'),
(15, 'Bayer S.A. Argentina', '30-64567890-5', '011-47627000', 'bayer.arg@bayer.com', 'Ricardo Gutierrez 3652, Munro', 'Bayer Andreas', 'Ejecutivo de Cuentas', '11-3094-1923', 'abayer@bayer.com', '0070001020000012345685'),
(16, 'Laboratorio Casasco S.A.', '30-65678901-4', '011-43639000', 'casasco@casasco.com.ar', 'Boyaca 237, CABA', 'Casasco Pedro', 'Gerente de Ventas', '11-6092-2391', 'pcasasco@casasco.com.ar', '0070001020000012345686'),
(17, 'Raffo Laboratorios S.A.', '30-66789012-3', '011-45097100', 'contacto@raffo.com.ar', 'Av. Constituyentes 4531, CABA', 'Raffo Juan Carlos', 'Supervisor Canal Farmacias', '11-5092-1290', 'jcraffo@raffo.com.ar', '0070001020000012345687'),
(18, 'Elea Phoenix S.A.', '30-67890123-2', '011-43794300', 'elea@elea.com', 'Av. Alt. Brown 1200, San Fernando', 'Elea Nestor', 'Jefe Convenios Especiales', '11-3091-2309', 'nelea@elea.com', '0070001020000012345688'),
(19, 'Sandoz Argentina S.A.', '30-68901234-1', '011-48914400', 'sandoz@sandoz.com', 'Ramallo 2940, CABA', 'Sandoz Martin', 'Ejecutivo Convenios', '11-5091-3921', 'msandoz@sandoz.com', '0070001020000012345689'),
(20, 'Pfizer S.R.L.', '30-69012345-0', '011-47887000', 'pfizerarg@pfizer.com', 'Av. del Libertador 4980, CABA', 'Pfizer Roberto', 'Gerente Institucional', '11-4091-2391', 'rpfizer@pfizer.com', '0070001020000012345690');
SET IDENTITY_INSERT Proveedores OFF;
GO

SET IDENTITY_INSERT PedidosCompra ON;
INSERT INTO PedidosCompra (Id_pedido, Id_proveedor, Id_empleado, Fecha_pedido, Estado, Total_estimado) VALUES
(1, 1, 1, '2026-05-01 09:00:00', 'Completado', 85000.00),
(2, 2, 1, '2026-05-02 10:00:00', 'Completado', 90000.00),
(3, 3, 7, '2026-05-03 11:30:00', 'Completado', 36000.00),
(4, 4, 7, '2026-05-04 12:00:00', 'Completado', 45000.00),
(5, 5, 11, '2026-05-05 14:00:00', 'Completado', 60000.00),
(6, 6, 11, '2026-05-06 15:30:00', 'Completado', 125000.00),
(7, 7, 1, '2026-05-07 16:00:00', 'Completado', 96000.00),
(8, 8, 1, '2026-05-08 17:00:00', 'Completado', 21000.00),
(9, 9, 7, '2026-05-09 09:30:00', 'Completado', 80000.00),
(10, 10, 7, '2026-05-10 10:15:00', 'Completado', 100000.00),
(11, 11, 11, '2026-05-11 11:00:00', 'Pendiente', 112500.00),
(12, 12, 11, '2026-05-12 12:30:00', 'Pendiente', 21000.00),
(13, 13, 1, '2026-05-13 14:00:00', 'Pendiente', 124000.00),
(14, 14, 1, '2026-05-14 15:00:00', 'Pendiente', 55000.00),
(15, 15, 7, '2026-05-15 16:15:00', 'Pendiente', 54000.00),
(16, 16, 7, '2026-05-16 17:00:00', 'Pendiente', 104000.00),
(17, 17, 11, '2026-05-17 09:00:00', 'Pendiente', 56000.00),
(18, 18, 11, '2026-05-18 10:00:00', 'Pendiente', 24000.00),
(19, 19, 1, '2026-05-19 11:30:00', 'Pendiente', 125000.00),
(20, 20, 1, '2026-05-20 13:00:00', 'Pendiente', 97500.00);
SET IDENTITY_INSERT PedidosCompra OFF;
GO

SET IDENTITY_INSERT DetallePedidoCompra ON;
INSERT INTO DetallePedidoCompra (Id_detalle_pedido, Id_pedido, Id_medicamento, Cantidad, Precio_costo_pactado, Subtotal) VALUES
(1, 1, 1, 100, 850.00, 85000.00),
(2, 2, 2, 150, 600.00, 90000.00),
(3, 3, 3, 20, 1800.00, 36000.00),
(4, 4, 4, 30, 1500.00, 45000.00),
(5, 5, 5, 200, 300.00, 60000.00),
(6, 6, 6, 50, 2500.00, 125000.00),
(7, 7, 7, 80, 1200.00, 96000.00),
(8, 8, 8, 15, 1400.00, 21000.00),
(9, 9, 9, 100, 800.00, 80000.00),
(10, 10, 10, 100, 1000.00, 100000.00),
(11, 11, 11, 150, 750.00, 112500.00),
(12, 12, 12, 10, 2100.00, 21000.00),
(13, 13, 13, 40, 3100.00, 124000.00),
(14, 14, 14, 50, 1100.00, 55000.00),
(15, 15, 15, 60, 900.00, 54000.00),
(16, 16, 16, 80, 1300.00, 104000.00),
(17, 17, 17, 40, 1400.00, 56000.00),
(18, 18, 18, 15, 1600.00, 24000.00),
(19, 19, 19, 100, 1250.00, 125000.00),
(20, 20, 20, 50, 1950.00, 97500.00);
SET IDENTITY_INSERT DetallePedidoCompra OFF;
GO

SET IDENTITY_INSERT Ventas ON;
INSERT INTO Ventas (Id_venta, Id_cliente, Id_empleado, Fecha, Total, Observaciones) VALUES
(1, 1, 3, '2026-05-01 10:30:00', 4350.00, 'Venta regular sin receta'),
(2, 2, 4, '2026-05-02 11:15:00', 5400.00, 'Venta PAMI - Clonazepam'),
(3, 3, 5, '2026-05-03 16:45:00', 3200.00, 'Venta OSECAC - Amoxicilina'),
(4, 4, 3, '2026-05-04 09:00:00', 1100.00, 'Tafirol jubilados'),
(5, 5, 9, '2026-05-05 18:20:00', 4250.00, 'Venta Actron + Aerotina'),
(6, NULL, 12, '2026-05-06 12:05:00', 600.00, 'Aspirineta particular CF'),
(7, 7, 3, '2026-05-07 10:10:00', 9000.00, 'Tratamiento Atorvastatina OSDE'),
(8, 8, 4, '2026-05-08 15:30:00', 4400.00, 'Metformina IOMA'),
(9, NULL, 13, '2026-05-09 11:00:00', 3000.00, 'Enalapril sin descuento CF'),
(10, 10, 15, '2026-05-10 19:40:00', 1850.00, 'Omeprazol particular'),
(11, 11, 3, '2026-05-11 09:30:00', 3800.00, 'Salbutamol jubilado'),
(12, 12, 18, '2026-05-12 11:50:00', 11200.00, 'Sertralina Swiss Medical'),
(13, 13, 3, '2026-05-13 14:15:00', 4200.00, 'Ibupirac infantil x2'),
(14, 14, 4, '2026-05-14 17:30:00', 3400.00, 'Sildenafil receta archivada'),
(15, 15, 9, '2026-05-15 10:45:00', 2400.00, 'Buscapina composite PAMI'),
(16, 16, 3, '2026-05-16 11:00:00', 5100.00, 'Alplax Galeno'),
(17, NULL, 4, '2026-05-17 09:15:00', 2900.00, 'Decadron CF'),
(18, 18, 12, '2026-05-18 10:00:00', 4600.00, 'Tiroxina OSDE x2'),
(19, 19, 13, '2026-05-19 10:45:00', 7000.00, 'Bactrim Forte x2'),
(20, 20, 3, '2026-05-20 11:30:00', 3900.00, 'Mix venta libre'),
(21, NULL, 3, '2026-05-21 11:45:00', 2700.00, 'Rivotril CF'),
(22, 2, 4, '2026-05-22 12:00:00', 1450.00, 'Actron PAMI');
SET IDENTITY_INSERT Ventas OFF;
GO

SET IDENTITY_INSERT DetalleVenta ON;
INSERT INTO DetalleVenta (Id_detalle, Id_venta, Id_medicamento, Cantidad, Precio_unitario, Subtotal) VALUES
(1, 1, 1, 3, 1450.00, 4350.00),
(2, 2, 4, 2, 2700.00, 5400.00),
(3, 3, 3, 1, 3200.00, 3200.00),
(4, 4, 2, 1, 1100.00, 1100.00),
(5, 5, 1, 2, 1450.00, 2900.00),
(6, 5, 11, 1, 1350.00, 1350.00),
(7, 6, 5, 1, 600.00, 600.00),
(8, 7, 6, 2, 4500.00, 9000.00),
(9, 8, 7, 2, 2200.00, 4400.00),
(10, 9, 9, 2, 1500.00, 3000.00),
(11, 10, 10, 1, 1850.00, 1850.00),
(12, 11, 12, 1, 3800.00, 3800.00),
(13, 12, 13, 2, 5600.00, 11200.00),
(14, 13, 14, 2, 2100.00, 4200.00),
(15, 14, 15, 2, 1700.00, 3400.00),
(16, 15, 16, 1, 2400.00, 2400.00),
(17, 16, 17, 2, 2550.00, 5100.00),
(18, 17, 18, 1, 2900.00, 2900.00),
(19, 18, 19, 2, 2300.00, 4600.00),
(20, 19, 20, 2, 3500.00, 7000.00),
(21, 20, 1, 1, 1450.00, 1450.00),
(22, 20, 2, 1, 1100.00, 1100.00),
(23, 20, 11, 1, 1350.00, 1350.00),
(24, 21, 4, 1, 2700.00, 2700.00),
(25, 22, 1, 1, 1450.00, 1450.00);
SET IDENTITY_INSERT DetalleVenta OFF;
GO

SET IDENTITY_INSERT IngresoStock ON;
INSERT INTO IngresoStock (Id_ingreso, Id_pedido, Id_proveedor, Id_medicamento, Cantidad, Fecha_ingreso, Precio_costo) VALUES
(1, 1, 1, 1, 100, '2026-05-02 08:00:00', 850.00),
(2, 2, 2, 2, 150, '2026-05-03 08:30:00', 600.00),
(3, 3, 3, 3, 20, '2026-05-04 09:00:00', 1800.00),
(4, 4, 4, 4, 30, '2026-05-05 09:15:00', 1500.00),
(5, 5, 5, 5, 200, '2026-05-06 10:00:00', 300.00),
(6, 6, 6, 6, 50, '2026-05-07 11:30:00', 2500.00),
(7, 7, 7, 7, 80, '2026-05-08 14:00:00', 1200.00),
(8, 8, 8, 8, 15, '2026-05-09 15:30:00', 1400.00),
(9, 9, 9, 9, 100, '2026-05-10 16:00:00', 800.00),
(10, 10, 10, 10, 100, '2026-05-11 10:45:00', 1000.00),
(11, NULL, 11, 11, 150, '2026-05-12 11:00:00', 750.00),
(12, NULL, 12, 12, 10, '2026-05-13 12:15:00', 2100.00),
(13, NULL, 13, 13, 40, '2026-05-14 14:00:00', 3100.00),
(14, NULL, 14, 14, 50, '2026-05-15 15:30:00', 1100.00),
(15, NULL, 15, 15, 60, '2026-05-16 16:20:00', 900.00),
(16, NULL, 16, 16, 80, '2026-05-17 10:00:00', 1300.00),
(17, NULL, 17, 17, 40, '2026-05-18 11:30:00', 1400.00),
(18, NULL, 18, 18, 15, '2026-05-19 14:15:00', 1600.00),
(19, NULL, 19, 19, 100, '2026-05-20 15:00:00', 1250.00),
(20, NULL, 20, 20, 50, '2026-05-21 16:00:00', 1950.00);
SET IDENTITY_INSERT IngresoStock OFF;
GO

SET IDENTITY_INSERT Recetas ON;
INSERT INTO Recetas (Id_receta, Id_venta, Id_cliente, Medico_prescriptor, Fecha_emision, Observaciones) VALUES
(1, 2, 2, 'Dr. Favaloro (M.N. 12345)', '2026-05-01', 'Receta de Clonazepam'),
(2, 3, 3, 'Dra. Jeanette Chalad (M.P. 4567)', '2026-05-02', 'Receta de Amoxicilina'),
(3, 7, 7, 'Dr. Cormillot (M.N. 9876)', '2026-05-06', 'Atorvastatina cronica'),
(4, 8, 8, 'Dr. Miroli (M.N. 5432)', '2026-05-07', 'Control de diabetes'),
(5, 9, NULL, 'Dra. Cortinez (M.P. 8899)', '2026-05-08', 'Hipertension arterial CF'),
(6, 11, 11, 'Dr. Concaro (M.N. 7766)', '2026-05-10', 'Asma bronquial'),
(7, 12, 12, 'Dra. Rolon (M.N. 3412)', '2026-05-11', 'Tratamiento psiquiatrico'),
(8, 14, 14, 'Dr. Cormillot (M.N. 9876)', '2026-05-13', 'Sildenafil control'),
(9, 16, 16, 'Dra. Rolon (M.N. 3412)', '2026-05-15', 'Ansiedad generalizada'),
(10, 17, NULL, 'Dr. Carrillo (M.N. 1122)', '2026-05-16', 'Corticoide antiinflamatorio CF'),
(11, 18, 18, 'Dra. Lopez (M.P. 9090)', '2026-05-17', 'Levotiroxina de por vida'),
(12, 19, 19, 'Dr. Concaro (M.N. 7766)', '2026-05-18', 'Infeccion bacteriana'),
(13, 21, NULL, 'Dr. Carrillo (M.N. 1122)', '2026-05-20', 'Rivotril adicional CF'),
(14, 2, 2, 'Dra. Gomez (M.N. 8877)', '2026-05-01', 'Receta de respaldo'),
(15, 3, 3, 'Dr. Martinez (M.P. 3322)', '2026-05-02', 'Respaldo antibiotico'),
(16, 7, 7, 'Dr. Fernandez (M.N. 5566)', '2026-05-06', 'Respaldo colesterol'),
(17, 8, 8, 'Dra. Soria (M.P. 4411)', '2026-05-07', 'Respaldo diabetes'),
(18, 9, NULL, 'Dr. Rivas (M.N. 8822)', '2026-05-08', 'Respaldo presion CF'),
(19, 11, 11, 'Dr. Sosa (M.P. 1290)', '2026-05-10', 'Respaldo asma'),
(20, 12, 12, 'Dra. Rolon (M.N. 3412)', '2026-05-11', 'Respaldo psiquiatria');
SET IDENTITY_INSERT Recetas OFF;
GO
