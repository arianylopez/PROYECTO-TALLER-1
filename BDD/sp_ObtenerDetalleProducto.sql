-- Detalle de Producto - HU2
CREATE PROCEDURE sp_ObtenerDetalleProducto
	@ProductoID INT
AS BEGIN
	SELECT 
		ProductoID, Nombre, Descripcion, Precio, StockActual, ImagenURL
	FROM Productos
	WHERE ProductoID = @ProductoID;
END;