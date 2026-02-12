CREATE DATABASE ProyectoTiendaDB;
USE ProyectoTiendaDB;

-- 1. Tabla de Usuarios (Cliente)
CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    NombreCompleto NVARCHAR(100) NOT NULL,
    Correo NVARCHAR(100) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL, 
    FechaRegistro DATETIME DEFAULT GETDATE()
);

-- 2. Tabla de Productos (Catálogo)
CREATE TABLE Productos (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(150) NOT NULL,
    Descripcion NVARCHAR(MAX),
    Precio DECIMAL(10, 2) NOT NULL,
    StockActual INT NOT NULL DEFAULT 0, 
    ImagenURL NVARCHAR(500), 
    EsActivo BIT DEFAULT 1, 
    FechaCreacion DATETIME DEFAULT GETDATE()
);

-- 3. Tabla Encabezado del Carrito
CREATE TABLE Carrito (
    CarritoID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    Estado CHAR(1) DEFAULT 'A', -- 'A': Activo (comprando), 'P': Procesado (pagado), 'C': Cancelado
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FechaActualizacion DATETIME,
    CONSTRAINT FK_Carrito_Usuario FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- 4. Tabla Detalle del Carrito (Items)
CREATE TABLE DetalleCarrito (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    CarritoID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    FechaAgregado DATETIME DEFAULT GETDATE(), -- Controlar los 15 min de reserva
    CONSTRAINT FK_Detalle_Carrito FOREIGN KEY (CarritoID) REFERENCES Carrito(CarritoID),
    CONSTRAINT FK_Detalle_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);