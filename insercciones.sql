SELECT * FROM configs_carusel;
SELECT * FROM categorias;
SELECT * FROM medidas;
SELECT * FROM tipos_cafe;
SELECT * FROM productos_extra;
SELECT * FROM roles;
SELECT * FROM usuarios;
SELECT * FROM empleados;
SELECT * FROM productos;
SELECT * FROM stock_productos;
SELECT * FROM pedidos;
SELECT * FROM pedidos_clientes;
SELECT * FROM detalles_pedido;
SELECT * FROM detalles_pedido_pe;
SELECT * FROM resenas;
DESCRIBE resenas;
DESCRIBE detalles_pedido_pe;
DESCRIBE detalles_pedido;
DESCRIBE pedidos_clientes;
DESCRIBE pedidos;
DESCRIBE stock_productos;
DESCRIBE productos;
DESCRIBE empleados;
DESCRIBE usuarios;
DESCRIBE roles;
DESCRIBE productos_extra;
DESCRIBE tipos_cafe;
DESCRIBE medidas;
DESCRIBE categorias;
DESCRIBE configs_carusel;
INSERT INTO categorias (nom_categoria) VALUES ("Postres"), ("Cafes");
INSERT INTO medidas (nom_medida, uni_medida) VALUES ("Mililitros", "mn"), ("Pieza", "pz"), ("Gramos", "grs");
INSERT INTO tipos_cafe (tipo_cafe) VALUES ("Regular"), ("Descafeinado");
INSERT INTO productos_extra (nombre_pe, precio_unitario_pe) VALUES ("Leche entera", 0), ("Leche de almendra", 15), ("Leche de avena", 10);
INSERT INTO roles (nombre_rol) VALUES ("Administrador"), ("Barista"), ("Cliente");
INSERT INTO usuarios (nombre_usuario, apellido_p_usuario, apellido_m_usuario, email_usuario, contrasena_usuario, foto_perfil_usuario, telefono_usuario, status_usuario, id_rol)
	VALUES ("Angel", "Murillo", "Verastegui", "angel@gmail.com", "1234", "angel.png", "8712345678", 1, 1), 
           ("Pedro", "Pica", "Piedra", "pedro@gmail.com", "1234", "pedro.png", "0001101101", 1, 2);
INSERT INTO usuarios (nombre_usuario, apellido_p_usuario, apellido_m_usuario, email_usuario, contrasena_usuario, foto_perfil_usuario, telefono_usuario, status_usuario)
    VALUES ("Frank", "Flores", "Meza", "frank@gmail.com", "1234", "frank.png", "8766655577", 1),
           ("Adrian", "Gotfried", "Gutierrez", "adrian@gmail.com", "1234", "adrian.png", "8714141515", 1),
           ("Pepe", "Chuy", "PepeChuy", "pepe@gmail.com", "1234", "pepe.png", "8716161519", 1);
INSERT INTO empleados (curp_empleado, rfc_empleado, nss_empleado, salario_mes_empleado, id_usuario)
    VALUES ("PPDRA010101HCLLZGA", "0110011110011", "000000000001", "2500", 2);
INSERT INTO productos (nombre_producto, descripcion_producto, precio_unitario_producto, img_producto, slug_producto, id_categoria, especialidad_producto, medida_producto, id_medida)
           VALUES ("Galletas", "Chispas de chocolate", "15", "galleta.jpg", "galletas", 1, "Postre", 1, 2),
                  ("Pastel de zanahoria", "tiene manzana", "35", "pstlzanria.png", "pastel-de-zanahoria", 1, "Postre", 1, 2),
				  ("Cafe de vainilla", "tiene chocolate", "30", "coffvainilla.png", "cafe-de-vainilla", 2, "Caliente", 430, 1),
                  ("Cafe Americano", "Es de estados Unidos", "35", "cafamer.png", "cafe-americano", 2, "Frio", 430, 1);
INSERT INTO stock_productos (ingreso_stock, id_producto) VALUES (10, 1), (10, 2), (10, 3), (10, 4);
INSERT INTO pedidos (info_pedido, op_pedido) VALUES ("Que tenga harina", "Llevar");
INSERT INTO pedidos_clientes (id_pedido, id_usuario) VALUES (1, 4);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (2, 3, 1);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 4, 1);
INSERT INTO detalles_pedido_pe (id_detalle_pedido, id_producto_extra) VALUES (1, 3);
UPDATE pedidos SET estado_pedido="En solicitud" WHERE id=1;
INSERT INTO resenas (comentario_resena, id_usuario) VALUES ("Diego del futuro, pasa integradora porfavor, si no me hago militar", "3");
UPDATE pedidos SET estado_pedido="Entregado" WHERE id=1;
ALTER TABLE resenas MODIFY COLUMN comentario_resena LONGTEXT NOT NULL;
SELECT * from pedidos WHERE id=1;

INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Chichonas", "Llevar", "Frank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 4, 2);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1.2, 4, 2);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1.6, 4, 2);
UPDATE pedidos SET estado_pedido="Entregado" WHERE id=2;

INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Chichonas", "Llevar", "Frank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 4, 3);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1.2, 4, 3);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (4, 4, 3);
UPDATE pedidos SET estado_pedido="Entregado" WHERE id=3;

INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Chichonas", "Llevar", "Frank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 4, 4);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1.2, 4, 4);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (4, 4, 4);
UPDATE pedidos SET estado_pedido="Entregado" WHERE id=4;

INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Chichonas", "Llevar", "Frank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 4, 5);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1.2, 1, 5);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (4, 2, 5);
UPDATE pedidos SET estado_pedido="Entregado" WHERE id=5;


INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Chichonas", "Llevar", "Frank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 4, 6);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1.2, 4, 6);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1.6, 4, 6);
UPDATE pedidos SET estado_pedido="En solicitud" WHERE id=6;
UPDATE stock_productos SET ingreso_stock = 3 WHERE id = 1;

SELECT * FROM pedidos;
SELECT * FROM detalles_pedido;
/*PRUEBA DE TOTALPEDIDO*/
INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Chichonas", "Llevar", "Frank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 4, 7);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 1, 7);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 2, 7);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 3, 7);

INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Chichonas", "Llevar", "Frank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 4, 8);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 3, 8);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 2, 8);

INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Chichonas", "Llevar", "Frank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 4, 9);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 3, 9);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (1, 2, 9);
DELETE FROM detalles_pedido WHERE id=28;
UPDATE detalles_pedido SET cantidad_producto=2 WHERE id=27;
