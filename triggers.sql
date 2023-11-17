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


/*nom_cafe segun mi id_tipo_cafe*/
DELIMITER //
CREATE TRIGGER actualizar_nom_cafe
BEFORE INSERT ON detalles_pedido_tipo_cafe
FOR EACH ROW
BEGIN
  DECLARE cafe_nombre VARCHAR(15);
  SELECT tipo_cafe INTO cafe_nombre
  FROM tipos_cafe
  WHERE id_tipo_cafe = NEW.id_tipo_cafe;

  SET NEW.nom_cafe = cafe_nombre;
END //
DELIMITER ;

/*Actualizacion de estado_producto, si en stock hay 0 productos*/
DELIMITER //
CREATE TRIGGER actualizar_estado_producto
AFTER UPDATE ON stock_productos
FOR EACH ROW
BEGIN
  DECLARE nueva_cantidad INT;
  SELECT ingreso_stock INTO nueva_cantidad
  FROM stock_productos
  WHERE id_stock = NEW.id_stock;
  
  IF nueva_cantidad > 0 THEN
    UPDATE productos
    SET estado_producto = 1
    WHERE id_producto = NEW.id_producto;
  ELSE
    UPDATE productos
    SET estado_producto = 0
    WHERE id_producto = NEW.id_producto;
  END IF;
END //
DELIMITER ;

/*Fecha y hora actuales en stock_productos al actualizar*/
DELIMITER //
CREATE TRIGGER actualizar_fecha_stock
BEFORE UPDATE ON stock_productos
FOR EACH ROW
BEGIN
SET NEW.fecha_ingreso_stock = NOW();
END//
DELIMITER ;
/**/
