/*PROCEDIMIENTOS ALMACENADOS*/
/*BIENVENIDA USUARIOS*/
SELECT * FROM usuarios;
SELECT * FROM roles;

DELIMITER $$
CREATE PROCEDURE bienvenida_usuario (IN id_usuario_sesion INT)
BEGIN
    DECLARE mensaje VARCHAR(100);
    DECLARE es_cliente BOOL;
    /*AQUI CHECO SI ES CELINTE O NO Y LO ALMACENOE N LA VARIABLE*/
    SELECT nombre_rol = 'Cliente' INTO es_cliente
    FROM usuarios
    JOIN roles ON usuarios.id_rol = roles.id_rol
    WHERE usuarios.id_usuario = id_usuario_sesion;

    IF es_cliente THEN
        SELECT CONCAT('Bienvenido ', usuarios.nombre_usuario, ' ', usuarios.apellido_p_usuario) INTO mensaje
        FROM usuarios
        WHERE id_usuario = id_usuario_sesion;
    ELSE
        SELECT CONCAT('Bienvenido ', roles.nombre_rol) INTO mensaje
        FROM roles
        JOIN usuarios ON usuarios.id_rol = roles.id_rol
        WHERE usuarios.id_usuario = id_usuario_sesion;
    END IF;

    SELECT mensaje AS mensaje;
END $$
DELIMITER ;

CALL bienvenida_usuario(4);




/*Validacion y verifacion en stock al hacer un pedido*/
/*Aqui agarre uno de los pedidos que ya estaban, al pasarlo a php, poner el pedido id del usuario correspondiente*/
DELIMITER //
CREATE PROCEDURE pedido_checador_stock(IN pedido_id_ingresado INT, IN cantidad_pedido_solicitada INT)
BEGIN
  DECLARE stock_disponible INT;

  START TRANSACTION;
  SELECT ingreso_stock INTO stock_disponible
  FROM stock_productos
  WHERE id_producto = (SELECT id_producto FROM detalles_pedido WHERE id_pedido = pedido_id_ingresado);

  IF cantidad_pedido_solicitada > 0 AND stock_disponible >= cantidad_pedido_solicitada THEN
    UPDATE stock_productos
    SET ingreso_stock = ingreso_stock - cantidad_pedido_solicitada
    WHERE id_producto = (SELECT id_producto FROM detalles_pedido WHERE id_pedido = pedido_id_ingresado);

    UPDATE detalles_pedido
    SET cantidad_producto = cantidad_producto + cantidad_pedido_solicitada
    WHERE id_pedido = pedido_id_ingresado;
    COMMIT;
    SELECT 'Pedido realizado con éxito.' AS mensaje;

  ELSE
    ROLLBACK;
    SELECT 'No hay suficiente stock para completar el pedido.' AS mensaje;
  END IF;
END //
DELIMITER ;

/*Ejemplos de proalmacenado (pedido_checador_stock)*/
SELECT * FROM pedidos;
SELECT * FROM detalles_pedido;
SELECT * FROM productos;
SELECT * FROM stock_productos;
UPDATE stock_productos SET ingreso_stock=500 WHERE id_stock=1;
CALL pedido_checador_stock(1, 500);

/*Validacion de correo y contrasena*/
DELIMITER //
CREATE PROCEDURE validacion_cuenta_correo_contra(IN correo_ingresado VARCHAR(120), IN contrasena_ingresada VARCHAR(100))
BEGIN
    DECLARE usuario_id INT;
    DECLARE mensaje VARCHAR(255);

    SELECT id_usuario INTO usuario_id
    FROM usuarios
    WHERE email_usuario = correo_ingresado;
    
    IF usuario_id IS NOT NULL THEN
        IF (SELECT COUNT(*)
            FROM usuarios
            WHERE id_usuario = usuario_id AND contrasena_usuario = contrasena_ingresada) > 0 THEN
            SET mensaje = 'Inicio de sesión exitoso';
        ELSE
            SET mensaje = 'Contraseña no válida';
        END IF;
    ELSE
        SET mensaje = 'Correo no válido';
    END IF;

    SELECT mensaje AS resultado;
END //
DELIMITER ;

 CALL validacion_cuenta_correo_contra ('aangelmurv@gmail.com', '1234');
