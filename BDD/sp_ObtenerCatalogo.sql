-- Ver Catalogo - HU1
CREATE PROCEDURE sp_ObetenerCatalogo
AS
BEGIN
	SELECT
		ProductoID, Nombre, Precio, ImagenURL, StockActual,
		CASE WHEN StockActual > 0 THEN 'Disponible' ELSE 'Agotado' 
		END AS Estado
	FROM Productos
	WHERE EsActivo = 1;
END;