/*TRIGGERS*/
/*Cantidad en stock*/
DELIMITER //
DROP TRIGGER IF EXISTS cantidad_stock //
CREATE TRIGGER cantidad_stock
AFTER UPDATE ON pedidos
FOR EACH ROW
BEGIN
  DECLARE cantidad_pedida INT;
  SELECT cantidad_producto INTO cantidad_pedida
  FROM detalles_pedido
  WHERE id_pedido = NEW.id_pedido;
  IF NEW.estado_pedido = 'En solicitud' THEN
    UPDATE stock_productos
    SET ingreso_stock = ingreso_stock - cantidad_pedida    /*Abajito estoy buscando mi pedido id del nuevo en la tabla de detalles*/
    WHERE id_producto = (SELECT id_producto FROM detalles_pedido WHERE id_pedido = NEW.id_pedido);
  END IF;
END //
DELIMITER ;

/*Cantidad de stock en productos*/
DELIMITER //
DROP TRIGGER IF EXISTS actualizar_stock_producto //
CREATE TRIGGER actualizar_stock_producto
AFTER UPDATE ON stock_productos
FOR EACH ROW
BEGIN
  UPDATE productos
  SET stock_producto = NEW.ingreso_stock
  WHERE id_producto = NEW.id_producto;
END //
DELIMITER ;
