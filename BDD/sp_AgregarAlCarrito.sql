-- Agregar al Carrito - HU3
CREATE PROCEDURE sp_AgregarAlCarrito
    @UsuarioID INT,
    @ProductoID INT,
    @Cantidad INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StockActual INT;
    SELECT @StockActual = StockActual FROM Productos WHERE ProductoID = @ProductoID;

    IF (@StockActual < @Cantidad)
    BEGIN
        RAISERROR('No hay stock suficiente para agregar este producto.', 16, 1);
        RETURN;
    END

    DECLARE @CarritoID INT;

    SELECT @CarritoID = CarritoID 
    FROM Carrito 
    WHERE UsuarioID = @UsuarioID AND Estado = 'A';

    IF (@CarritoID IS NULL)
    BEGIN
        INSERT INTO Carrito (UsuarioID, Estado, FechaCreacion)
        VALUES (@UsuarioID, 'A', GETDATE());
        
        SET @CarritoID = SCOPE_IDENTITY();
    END

    IF EXISTS (SELECT 1 FROM DetalleCarrito WHERE CarritoID = @CarritoID AND ProductoID = @ProductoID)
    BEGIN
        UPDATE DetalleCarrito
        SET Cantidad = Cantidad + @Cantidad,
            FechaAgregado = GETDATE()
        WHERE CarritoID = @CarritoID AND ProductoID = @ProductoID;
    
    END
    ELSE
    BEGIN
        INSERT INTO DetalleCarrito (CarritoID, ProductoID, Cantidad, FechaAgregado)
        VALUES (@CarritoID, @ProductoID, @Cantidad, GETDATE());
    END
    
END;