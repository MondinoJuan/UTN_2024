use db_prueba;

DELIMITER //

CREATE PROCEDURE sp_guardarVenta(IN venta_xml TEXT)
BEGIN
    DECLARE idVenta_generado INT;
    
    -- Inserción en la tabla venta
    INSERT INTO venta (NroDocumento, RazonSocial, Total)
    SELECT
        ExtractValue(nodo.elemento, '/Venta/NroDocumento') AS NroDocumento,
        ExtractValue(nodo.elemento, '/Venta/RazonSocial') AS RazonSocial,
        ExtractValue(nodo.elemento, '/Venta/Total') AS Total
    FROM
        (SELECT ExtractValue(venta_xml, '//Venta') AS elemento) nodo;

    -- Obtener el ID de la última venta generada
    SET idVenta_generado = LAST_INSERT_ID();
    
    -- Inserción en la tabla detalle_venta
    INSERT INTO detalle_venta (IdVenta, Producto, Precio, Cantidad, Total)
    SELECT
        idVenta_generado AS IdVenta,
        ExtractValue(nodo.elemento, '/Item/Producto') AS Producto,
        ExtractValue(nodo.elemento, '/Item/Precio') AS Precio,
        ExtractValue(nodo.elemento, '/Item/Cantidad') AS Cantidad,
        ExtractValue(nodo.elemento, '/Item/Total') AS Total
    FROM
        (SELECT ExtractValue(venta_xml, '//Venta/DetalleVenta/Item') AS elemento) nodo;

END //

DELIMITER ;