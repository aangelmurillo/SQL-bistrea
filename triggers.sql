/**/
/*PEDIDOS*/
/* Cantidad en stock al hacer un pedido que la cantidad viene de detalles_pedido */
DELIMITER //
DROP TRIGGER IF EXISTS cantidad_stock //
CREATE TRIGGER cantidad_stock
AFTER UPDATE ON pedidos
FOR EACH ROW

BEGIN
DECLARE iddeproducto INT;
  DECLARE ccantidadpedida INT;
  DECLARE cantidad_pedida CURSOR FOR  SELECT cantidad_producto, id_producto
  FROM detalles_pedido
  WHERE id_pedido = NEW.id;
  
  DECLARE EXIT HANDLER FOR SQLSTATE '02000' BEGIN END;
  
  OPEN cantidad_pedida;
  BEGIN
 LOOP
	FETCH cantidad_pedida INTO ccantidadpedida, iddeproducto;
  IF NEW.estado_pedido = 'En solicitud' THEN
    UPDATE stock_productos
    SET ingreso_stock = ingreso_stock - ccantidadpedida
    WHERE id_producto = iddeproducto;
  END IF;
  END LOOP;
  END;
  CLOSE cantidad_pedida;
END //
DELIMITER ;

DELIMITER //
DROP TRIGGER IF EXISTS canbtidad_stock_cancelado //
CREATE TRIGGER cantidad_stock_cancelado
AFTER UPDATE ON pedidos
FOR EACH ROW
BEGIN
        DECLARE iddeproducto INT;
        DECLARE ccantidadpedida INT;
        DECLARE cantidad_pedida CURSOR FOR SELECT cantidad_producto, id_producto
            FROM detalles_pedido
            WHERE id_pedido = NEW.id;

        DECLARE EXIT HANDLER FOR SQLSTATE '02000' BEGIN END;

        OPEN cantidad_pedida;
        BEGIN
         LOOP
            FETCH cantidad_pedida INTO ccantidadpedida, iddeproducto;
            IF NEW.estado_pedido = 'Cancelado' THEN

            UPDATE stock_productos
            SET ingreso_stock = ingreso_stock + ccantidadpedida
            WHERE id_producto = iddeproducto;
            END IF;
        END LOOP;
        END;
        CLOSE cantidad_pedida;
END //
DELIMITER ;



/* Actualización de hora_entrega_pedido cuando sea entregado en pedidos */
DELIMITER //
DROP TRIGGER IF EXISTS actualizar_hora_entrega_pedido //
CREATE TRIGGER actualizar_hora_entrega_pedido
BEFORE UPDATE ON pedidos
FOR EACH ROW
BEGIN
    IF NEW.estado_pedido = 'Entregado' THEN
        SET NEW.hora_entrega_pedido = (SELECT NOW() LIMIT 1);
    END IF;
END //
DELIMITER ;


/*STOCK_PRODUCTOS*/
/* Cantidad de stock en productos al insertar*/
DELIMITER //
DROP TRIGGER IF EXISTS actualizar_stock_producto_insertar //
CREATE TRIGGER actualizar_stock_producto_insertar
AFTER INSERT ON stock_productos
FOR EACH ROW
BEGIN
  UPDATE productos
  SET stock_producto = NEW.ingreso_stock
  WHERE id = NEW.id_producto;
END //
DELIMITER ;

/* Cantidad de stock en productos */
DELIMITER //
DROP TRIGGER IF EXISTS actualizar_stock_producto //
CREATE TRIGGER actualizar_stock_producto
AFTER UPDATE ON stock_productos
FOR EACH ROW
BEGIN
  UPDATE productos
  SET stock_producto = NEW.ingreso_stock
  WHERE id = NEW.id_producto;
END //
DELIMITER ;

/* Actualización de estado_producto, si en stock hay 0 productos */
DELIMITER //
DROP TRIGGER IF EXISTS actualizar_estado_producto //
CREATE TRIGGER actualizar_estado_producto
AFTER UPDATE ON stock_productos
FOR EACH ROW
BEGIN
  DECLARE nueva_cantidad INT;
  SELECT ingreso_stock INTO nueva_cantidad
  FROM stock_productos
  WHERE id = NEW.id;

  IF nueva_cantidad > 0 THEN
    UPDATE productos
    SET estado_producto = 1
    WHERE id = NEW.id;
  ELSE
    UPDATE productos
    SET estado_producto = 0
    WHERE id = NEW.id;
  END IF;
END //
DELIMITER ;

/* Fecha y hora actuales en stock_productos al actualizar */
DELIMITER //
DROP TRIGGER IF EXISTS actualizar_fecha_stock //
CREATE TRIGGER actualizar_fecha_stock
BEFORE UPDATE ON stock_productos
FOR EACH ROW
BEGIN
  SET NEW.fecha_ingreso_stock = NOW();
END //
DELIMITER ;


/*DETALLES_PEDIDO_TIPO_CAFE*/
/* nom_cafe según mi id_tipo_cafe */
DELIMITER //
DROP TRIGGER IF EXISTS actualizar_nom_cafe //
CREATE TRIGGER actualizar_nom_cafe
BEFORE INSERT ON detalles_pedido_tipo_cafe
FOR EACH ROW
BEGIN
  DECLARE cafe_nombre VARCHAR(15);
  SELECT tipo_cafe INTO cafe_nombre
  FROM tipos_cafe
  WHERE id = NEW.id_tipo_cafe;

  SET NEW.nom_cafe = cafe_nombre;
END //
DELIMITER ;


/*DETALLES_PEDIDO*/
/* Precio_unitario según precio unitario de productos */
DELIMITER //
DROP TRIGGER IF EXISTS actualizar_precio_unitario //
CREATE TRIGGER actualizar_precio_unitario
BEFORE INSERT ON detalles_pedido
FOR EACH ROW
BEGIN
  DECLARE precio_por_unidad DECIMAL (6,2);
  SELECT precio_unitario_producto INTO precio_por_unidad
  FROM productos WHERE id = NEW.id_producto;
  SET NEW.precio_unitario = precio_por_unidad;
END //
DELIMITER ;

/* Se saca el subtotal_pedido de detalles_pedido */
DELIMITER //
DROP TRIGGER IF EXISTS subtotal_pedido_insert //
CREATE TRIGGER subtotal_pedido_insert
BEFORE INSERT ON detalles_pedido
FOR EACH ROW
BEGIN
    SET NEW.subtotal_pedido = NEW.precio_unitario * NEW.cantidad_producto;
END //
DELIMITER ;

/*TOTAL_PEDIDO SUMA*/
/*Al insertar en detalles_pedido se sumara*/
DELIMITER //
DROP TRIGGER IF EXISTS total_pedido //
CREATE TRIGGER total_pedido
AFTER INSERT ON detalles_pedido
FOR EACH ROW
BEGIN
    DECLARE total_pedido_actual DECIMAL(7, 2);
    SELECT total_pedido INTO total_pedido_actual
    FROM pedidos
    WHERE id = NEW.id_pedido;

    IF total_pedido_actual IS NULL THEN
        SET total_pedido_actual = 0;
    END IF;
    
    UPDATE pedidos
    SET total_pedido = total_pedido_actual + NEW.subtotal_pedido
    WHERE id = NEW.id_pedido;
END //
DELIMITER ;

/*TOTAL_PEDIDO RESTA*/
/*Al eliminar en detalles_pedido se restará*/
DELIMITER //
DROP TRIGGER IF EXISTS resta_total_pedido //
CREATE TRIGGER resta_total_pedido
AFTER DELETE ON detalles_pedido
FOR EACH ROW
BEGIN
    DECLARE total_pedido_actual DECIMAL(7, 2);
    SELECT total_pedido INTO total_pedido_actual
    FROM pedidos
    WHERE id = OLD.id_pedido;

    IF total_pedido_actual IS NULL THEN
        SET total_pedido_actual = 0;
    END IF;

    UPDATE pedidos
    SET total_pedido = total_pedido_actual - OLD.subtotal_pedido
    WHERE id = OLD.id_pedido;
END //
DELIMITER ;

/*TOTAL_PEDIDO ACTUALIZACIÓN*/
/*Al actualizar en detalles_pedido se  muestra en total_pedido*/
DELIMITER //
DROP TRIGGER IF EXISTS actualiza_total_pedido //
CREATE TRIGGER actualiza_total_pedido
AFTER UPDATE ON detalles_pedido
FOR EACH ROW
BEGIN
    DECLARE total_pedido_actual DECIMAL(7, 2);
    SELECT total_pedido INTO total_pedido_actual
    FROM pedidos
    WHERE id = OLD.id_pedido;

    IF total_pedido_actual IS NULL THEN
        SET total_pedido_actual = 0;
    END IF;
    
    UPDATE pedidos
    SET total_pedido = total_pedido_actual - OLD.subtotal_pedido + NEW.subtotal_pedido
    WHERE id = OLD.id_pedido;
END //
DELIMITER ;


/*PEDIDOS_CLIENTES*/
/* Nombre cliente en pedidos. Se ejecuta cuando en pedidos_clientes se establece a qué cliente pertenece el pedido */
DELIMITER //
DROP TRIGGER IF EXISTS nombre_cliente_pedidos //
CREATE TRIGGER nombre_cliente_pedidos
AFTER INSERT ON pedidos_clientes
FOR EACH ROW
BEGIN
    DECLARE primer_nombre VARCHAR(50);
    SELECT SUBSTRING_INDEX(usuarios.nombre_usuario, ' ', 1) INTO primer_nombre
    FROM usuarios
    WHERE usuarios.id = NEW.id_usuario;

    UPDATE pedidos
    SET nombre_cliente_pedido = primer_nombre
    WHERE id = NEW.id_pedido;
END //
DELIMITER ;


/*DETALLES_PEDIDO_PE*/
/* Precio_unitario según precio pe de productos_extra */
DELIMITER //
DROP TRIGGER IF EXISTS precio_unitario_prod_extra //
CREATE TRIGGER precio_unitario_prod_extra
BEFORE INSERT ON detalles_pedido_pe
FOR EACH ROW
BEGIN
  DECLARE precio_por_unidad DECIMAL (5,2);
  SELECT precio_unitario_pe INTO precio_por_unidad
  FROM productos_extra WHERE id = NEW.id_producto_extra;

  SET NEW.precio_pe = precio_por_unidad;
END //
DELIMITER ;

/*SE SUMA EL PE CON EL SUBTOTAL_PEDIDO* y se multiplica con la cantidad */
DELIMITER //
DROP TRIGGER IF EXISTS insert_actualizar_subtotal_pedido_producto_extra //
CREATE TRIGGER insert_actualizar_subtotal_pedido_producto_extra
AFTER INSERT ON detalles_pedido_pe
FOR EACH ROW
BEGIN

    UPDATE detalles_pedido
    SET subtotal_pedido = subtotal_pedido + (cantidad_producto*NEW.precio_pe)
    WHERE id = NEW.id_detalle_pedido;
END;
//
DELIMITER ;

SELECT * FROM detalles_pedido;

/* Al hacer update en id_producto_extra cambia el precio_pe */
DELIMITER //
DROP TRIGGER IF EXISTS update_precio_unitario_prod_extra //
CREATE TRIGGER update_precio_unitario_prod_extra
BEFORE UPDATE ON detalles_pedido_pe
FOR EACH ROW
BEGIN
  DECLARE precio_por_unidad DECIMAL (5,2);
  SELECT precio_unitario_pe INTO precio_por_unidad
  FROM productos_extra WHERE id = NEW.id_producto_extra;

  SET NEW.precio_pe = precio_por_unidad;
END //
DELIMITER ;

SELECT * FROM usuarios;
