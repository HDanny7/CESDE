CREATE DATABASE GestionComercial;
GO
USE GestionComercial;
GO

CREATE TABLE Categorias(
	id_categoria int IDENTITY(1,1) PRIMARY KEY,
	nombre_categoria varchar (100) NOT NULL,
	descripcion_categoria varchar (500)
	);
	GO

CREATE TABLE Proveedores(
	id_proveedor int IDENTITY(1,1) PRIMARY KEY,
	nombre_empresa varchar (100) NOT NULL,
	telefono_proveedor varchar (20),
	correo_proveedor varchar (100),
	ciudad_proveedor varchar (100)
	);
	GO

CREATE TABLE Productos(
	id_producto int IDENTITY(1,1) PRIMARY KEY,
	nombre_producto varchar (150) NOT NULL,
	descripcion_proveedor varchar (500),
	precio DECIMAL (10,2) NOT NULL,
	stock int NOT NULL,
	id_categoria int NOT NULL,
	id_proveedor int NOT NULL,
	
	CONSTRAINT Fk_Productos_Categorias
	FOREIGN KEY (id_categoria)
	REFERENCES Categorias(id_categoria),
	
	CONSTRAINT Fk_Productos_Proveedores
	FOREIGN KEY (id_proveedor)
	REFERENCES Proveedores(id_proveedor)
	);
	GO

CREATE TABLE Clientes(
	id_cliente int IDENTITY(1,1) PRIMARY KEY,
	nombre_cliente varchar (100) NOT NULL,
	apellido_cliente varchar (100) NOT NULL,
	telefono_cliente varchar (20),
	correo_cliente varchar (100)
	);
	GO

CREATE TABLE Empleados(
	id_empleado int IDENTITY(1,1) PRIMARY KEY,
	nombre_empleado varchar (100) NOT NULL,
	cargo varchar (100),
	salario DECIMAL (10,2) NOT NULL,
	fecha_ingreso DATE
	);
	GO

CREATE TABLE Ventas(
	id_venta int IDENTITY(1,1) PRIMARY KEY,
	descripcion_venta varchar (500) NOT NULL,
	fecha_venta DATE,
	total_venta DECIMAL (10,2) NOT NULL,
	id_empleado int NOT NULL,
	id_cliente int NOT NULL,

	CONSTRAINT Fk_Ventas_Empleados
	FOREIGN KEY (id_empleado)
	REFERENCES Empleados(id_empleado),

	CONSTRAINT Fk_Ventas_Clientes
	FOREIGN KEY (id_cliente)
	REFERENCES Clientes(id_cliente)
	);
	GO

CREATE TABLE Detalles_ventas(
	id_detalle int IDENTITY(1,1) PRIMARY KEY,
	id_venta int NOT NULL,
	id_producto int NOT NULL,
	cantidad int NOT NULL,
	precio_total DECIMAL (10,2) NOT NULL,
	subtotal DECIMAL (10,2) NOT NULL,

	CONSTRAINT Fk_Detalles_ventas_Ventas
	FOREIGN KEY (id_venta)
	REFERENCES Ventas(id_venta),

	CONSTRAINT Fk_Detalles_venta_Productos
	FOREIGN KEY (id_producto)
	REFERENCES Productos(id_producto)
	);
	GO







