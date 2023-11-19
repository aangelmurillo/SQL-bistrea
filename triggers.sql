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

/*precio_unitario segun precio unitario de productos*/
DELIMITER //
CREATE TRIGGER actualizar_precio_unitario 
BEFORE INSERT ON detalles_pedido
FOR EACH ROW
BEGIN
  DECLARE precio_por_unidad DECIMAL (6,2);
  SELECT precio_unitario_producto INTO precio_por_unidad
  FROM productos WHERE id_producto= NEW.id_producto;
  SET NEW.precio_unitario = precio_por_unidad;
END //
DELIMITER ;

/*Nombre cleinte en pedidos. Se ejecuta cunado en pedidos_clientes se establece a que 
cliente pertenece el pedido*/
DELIMITER //
CREATE TRIGGER nombre_cliente_pedidos
AFTER INSERT ON pedidos_clientes
FOR EACH ROW
BEGIN
    DECLARE primer_nombre VARCHAR(50);
    SELECT SUBSTRING_INDEX(usuarios.nombre_usuario, ' ', 1) INTO primer_nombre
    FROM usuarios
    WHERE usuarios.id_usuario = NEW.id_usuario;

    UPDATE pedidos
    SET nombre_cliente_pedido = primer_nombre
    WHERE id_pedido = NEW.id_pedido;
END //
DELIMITER ;

/*precio_unitario segun precio pe de productos_extra*/
DELIMITER //
CREATE TRIGGER precio_unitario_prod_extra
BEFORE INSERT ON detalles_pedido_pe
FOR EACH ROW
BEGIN
  DECLARE precio_por_unidad DECIMAL (5,2);
  SELECT precio_unitario_pe INTO precio_por_unidad
  FROM productos_extra WHERE id_producto_extra= NEW.id_producto_extra;
  
  SET NEW.precio_pe = precio_por_unidad;
END //
DELIMITER ;

/*Se saca el subtotal_pedido de detallles_pedido*/
DELIMITER //
CREATE TRIGGER subtotal_pedido
BEFORE INSERT ON detalles_pedido
FOR EACH ROW
BEGIN
    SET NEW.subtotal_pedido = NEW.precio_unitario * NEW.cantidad_producto;
END //
DELIMITER ;

/*Se actualiza el subtotal_pedido de detalles_pedido por el prodycto extra*/
DELIMITER //
CREATE TRIGGER actualizar_subtotal_pedido_producto_extra
AFTER UPDATE ON detalles_pedido_pe
FOR EACH ROW
BEGIN
    UPDATE detalles_pedido
    SET subtotal_pedido = (SELECT precio_unitario * cantidad_producto 
                          FROM detalles_pedido 
                          WHERE id_detalle_pedido = NEW.id_detalle_pedido) + NEW.precio_pe
    WHERE id_detalle_pedido = NEW.id_detalle_pedido;
END //
DELIMITER ;

/*Se actualiza (al insertar) el subtotal_pedido de detalles_pedido por el prodycto extra*/
DELIMITER //
CREATE TRIGGER insert_actualizar_subtotal_pedido_producto_extra
AFTER INSERT ON detalles_pedido_pe
FOR EACH ROW
BEGIN
    UPDATE detalles_pedido
    SET subtotal_pedido = (SELECT precio_unitario * cantidad_producto
                          FROM detalles_pedido
                          WHERE id_detalle_pedido = NEW.id_detalle_pedido) + NEW.precio_pe
    WHERE id_detalle_pedido = NEW.id_detalle_pedido;
END //
DELIMITER ;

/*al hacer update en id_producto_extra cambia el precio_pe*/
DELIMITER //
CREATE TRIGGER update_precio_unitario_prod_extra
BEFORE UPDATE ON detalles_pedido_pe
FOR EACH ROW
BEGIN
  DECLARE precio_por_unidad DECIMAL (5,2);
  SELECT precio_unitario_pe INTO precio_por_unidad
  FROM productos_extra WHERE id_producto_extra= NEW.id_producto_extra;

  SET NEW.precio_pe = precio_por_unidad;
END //
DELIMITER ;

/*Actualizacion de hora_entrega_pedido cuando sea entregado en pedidos*/
DELIMITER //
CREATE TRIGGER actualizar_hora_entrega_pedido
BEFORE UPDATE ON pedidos
FOR EACH ROW
BEGIN
    IF NEW.estado_pedido = 'Entregado' THEN
        SET NEW.hora_entrega_pedido = NOW();
    END IF;
END //
DELIMITER ;
