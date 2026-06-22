# Sistema de Gestion de Farmacia - BD2-TPI-G43

Trabajo Practico Integrador para la materia Bases de Datos II de la Universidad Tecnologica Nacional - Facultad Regional General Pacheco (UTN FRGP).

## Integrantes

- Guido Juliano Ubaldi
- Dilan Benitez

## Descripcion del Sistema

El sistema brinda soporte al proceso de gestion comercial, control de inventario y facturacion de una farmacia. Resuelve problemas clave del negocio tales como:

- Control de stock fisico en tiempo real y alertas tempranas de reposicion critica.
- Resguardo legal mediante la validacion obligatoria de recetas medicas para la venta de farmacos controlados.
- Aplicacion automatizada de descuentos por Obra Social y calculo de IVA sobre los precios de venta.
- Estadisticas y reportes analiticos para la toma de decisiones gerenciales.

## Arquitectura del Proyecto

La aplicacion esta desarrollada bajo una arquitectura en tres capas utilizando C# .NET y SQL Server como motor de base de datos relacional:

- **Presentacion (AppFarmacia):** Interfaz grafica desarrollada en ASP.NET Web Forms y Bootstrap 5, que incluye un Punto de Venta interactivo, busqueda por autocompletado y un panel de reportes dinamicos.
- **Servicio:** Biblioteca de clases encargada del acceso a datos mediante ADO.NET, abstrayendo las consultas y ejecuciones hacia el motor de base de datos.
- **Dominio:** Biblioteca de clases que define los objetos POCO (Plain Old CLR Objects) representando las entidades del modelo de negocio.

## Estructura de Directorios

- **AppFarmacia/** (Carpeta contenedora de la solucion de software)
  - **AppFarmacia/** (Proyecto Web Forms y archivos de presentacion ASPX/CSS)
  - **Dominio/** (Proyecto de Entidades del negocio)
  - **Servicio/** (Proyecto de Acceso a Datos)
  - **AppFarmacia.sln** (Archivo de solucion de Visual Studio)
  - **.gitignore** (Reglas de exclusion de control de versiones)
- **Creacion de DB/** (Carpeta con scripts SQL para el despliepe del motor)
  - **CREATE_DB.sql** (Creacion de la base de datos, tablas y restricciones de integridad)
  - **VIEWS.sql** (Definicion de las vistas de reporte comercial)
  - **FUNCTION.sql** (Funciones escalares para calculos de IVA y descuentos)
  - **STORE_PROCEDURE.sql** (Procedimientos almacenados transaccionales de busqueda, compra y venta)
  - **Triggers.sql** (Disparadores automaticos de stock y control de recetas)
  - **INSERCION_DATOS.sql** (Set de datos de ejemplo para pruebas de negocio)

## Logica del Negocio en la Base de Datos

### Vistas

- **Vista_TopMedicamentos:** Determina el ranking de los 10 medicamentos con mayor demanda y facturacion total para optimizar las compras.
- **Vista_StockBajo:** Filtra de forma dinamica los medicamentos cuyo stock actual es menor o igual al stock minimo establecido.
- **Vista_VentasMes:** Agrupa e informa la facturacion total y cantidad de ventas de cada empleado segmentado por año y mes.

### Procedimientos Almacenados

- **sp_BuscarMedicamento:** Permite la busqueda parcial y flexible de medicamentos por nombre, laboratorio o principio activo.
- **sp_RegistrarVenta:** Registrar una venta y asociar opcionalmente su receta medica correspondiente si el farmaco lo requiere, de forma dinamica y segura.
- **sp_IngresarStock:** Registra la compra de mercaderia a proveedores, incrementa el inventario fisico, actualiza el precio de costo de compra y marca las alertas criticas asociadas como resueltas.

### Triggers (Disparadores)

- **trg_DescuentoStock:** Resta de forma automatica y en tiempo real las unidades vendidas del stock actual de medicamentos al insertarse una linea en el detalle.
- **trg_AlertaStockMinimo:** Registra una alerta activa en la tabla de alertas apenas el stock del medicamento disminuye por debajo del minimo requerido.
- **trg_ValidarReceta:** Bloquea incondicionalmente (ROLLBACK) cualquier intento de vender un medicamento clasificado como venta bajo receta si no se proveen los datos del profesional prescriptor y fecha en la transaccion.

### Funciones

- **fn_ObtenerDescuentoObraSocial:** Recupera el porcentaje de descuento comercial asociado a la Obra Social del cliente.
- **fn_CalcularPrecioConIva:** Aplica la tasa impositiva estandar del IVA (21%) al precio de costo neto.
