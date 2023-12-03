/*
categorias                       1
configs_carusel                  ?
detalles_pedido                  1 //Al pedir algo mayor a lo que hay en stock aparecen negativos 
detalles_pedido_pe               1
detalles_pedido_tipo_cafe        1
empleados                        1
medidas                          1
pedidos                          1 
pedidos_clientes                 1
productos                        1
productos_extra                  1
resenas                          1 
roles                            1
stock_productos                  1
tipos_cafe                       1
usuarios                         1
*/

SELECT * FROM configs_carusel;
SELECT * FROM categorias;
SELECT * FROM medidas;
SELECT * FROM tipos_cafe;
SELECT * FROM productos_extra;
SELECT * FROM roles;
SELECT * FROM productos;
SELECT * FROM usuarios;
SELECT * FROM empleados;
SELECT * FROM stock_productos;
SELECT * FROM resenas;
SELECT * FROM pedidos;
SELECT * FROM pedidos_clientes;
SELECT * FROM detalles_pedido;
SELECT * FROM detalles_pedido_tipo_cafe;
SELECT * FROM detalles_pedido_pe;
DESCRIBE detalles_pedido_pe;
DESCRIBE detalles_pedido_tipo_cafe;
DESCRIBE detalles_pedido;
DESCRIBE pedidos_clientes;
DESCRIBE pedidos;
DESCRIBE resenas;
DESCRIBE stock_productos;
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
INSERT INTO productos (nombre_producto, descripcion_producto, precio_unitario_producto, img_producto, slug_producto, id_categoria, especialidad_producto, medida_producto, id_medida)
            VALUES ("Galletas", "Chispas de chocolate", "15", "galleta.jpg", "galletas", 1, "Postre", 1, 2),
                  ("Pastel de zanahoria", "tiene manzana", "35", "pstlzanria.png", "pastel-de-zanahoria", 1, "Postre", 1, 2),
				  ("Cafe de vainilla", "tiene chocolate", "30", "coffvainilla.png", "cafe-de-vainilla", 2, "Caliente", 430, 1),
                  ("Cafe Americano", "Es de estados Unidos", "35", "cafamer.png", "cafe-americano", 2, "Frio", 430, 1);
INSERT INTO usuarios (nombre_usuario, apellido_p_usuario, apellido_m_usuario, email_usuario, contrasena_usuario, foto_perfil_usuario, telefono_usuario, id_rol) 
			VALUES ('Angel', 'Murillo', 'Verastegui', 'angel@gmail.com', '1234', 'angel.png', '8715123456', 1),
                   ('Frank', 'Flores', 'Meza', 'frank@gmail.com', '1234', 'frank.png', '8715098765', 2),
                   ('Adrian', 'Gotfried', 'Gutierrez', 'adrian@gmail.com', '1234', 'adrian.png', '8715246810', 3),
                   ('Jose Angel', 'Garcia', 'de la Cruz', 'jose@gmail.com', '1234', 'jose.png', '8715135791', 3);
INSERT INTO usuarios (nombre_usuario, apellido_p_usuario, apellido_m_usuario, email_usuario, contrasena_usuario, telefono_usuario) 
			VALUES ('Mariana', 'Carranza', 'Segura', 'mariana@gmail.com', '1234', '8715454545');
INSERT INTO usuarios (nombre_usuario, apellido_p_usuario, apellido_m_usuario, email_usuario, contrasena_usuario, telefono_usuario) 
			VALUES ('Yazmin', 'Sarahi', 'Martinez', 'yazmin@gmail.com', '1234', '871545855');
            INSERT INTO usuarios (nombre_usuario, apellido_p_usuario, apellido_m_usuario, email_usuario, contrasena_usuario, telefono_usuario) 
			VALUES ('Chavo', 'Del', 'Ocho', 'chavo@gmail.com', '1234', '871345855');
INSERT INTO empleados (curp_empleado, rfc_empleado, nss_empleado, salario_mes_empleado, id_usuario)
    VALUES ("PPDRA010101HCLLZGA", "0110011110011", "000000000001", "2500", 2);
INSERT INTO stock_productos (ingreso_stock, id_producto) VALUES (10, 1), (10, 2), (10, 3), (10, 4);
INSERT INTO resenas (comentario_resena, id_usuario)
			VALUES ('Me parecio muy buen servicio', '3'),
                   ('Muy didactica la aplicacion', '4'),
                   ('Me encanto', '3');
INSERT INTO pedidos (info_pedido, op_pedido) VALUES ("Sin comentarios", "Llevar"), ("Que tenga muchos hielos", "Llevar");
INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Ni frio, ni caliente", "Llevar", "Amanda");
INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Ni frio, ni caliente", "Llevar", "Frank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) VALUES (2, 3, 4);
UPDATE pedidos SET estado_pedido="En solicitud" WHERE id=4;
INSERT INTO pedidos_clientes (id_pedido, id_usuario) VALUES (1, 3), (2, 4);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) 
			VALUES ("1", "4", "1"), ("2", "2", "2"), ("2", "1", "3");
UPDATE pedidos SET estado_pedido="En solicitud" WHERE id=1;
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) 
			VALUES ("10", "4", "2"), ("2", "1", "3");
UPDATE pedidos SET estado_pedido="En solicitud" WHERE id=2; /Al pedi algo mas ariiba de lo que hay en stock, aparecen valores ngeativos en stock/
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) 
			VALUES ("1", "3", "3");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido) 
			VALUES ("2", "3", "3");
INSERT INTO detalles_pedido_tipo_cafe (id_detalle_pedido, id_tipo_cafe) VALUES(6, 2);
INSERT INTO detalles_pedido_pe (id_detalle_pedido, id_producto_extra) VALUES (7, 2);
UPDATE pedidos SET estado_pedido="En solicitud" WHERE id=2;
UPDATE pedidos SET estado_pedido="Entregado" WHERE id=3;
UPDATE pedidos SET estado_pedido="Cancelado" WHERE id=2;

DESCRIBE productos;
SELECT * FROM productos;
SELECT * FROM stock_productos;
DESCRIBE stock_productos;
INSERT INTO stock_productos (ingreso_stock, id_producto) VALUES (2, 5);
INSERT INTO productos (nombre_producto, descripcion_producto, precio_unitario_producto, stock_producto, img_producto, slug_producto, id_categoria, especialidad_producto, medida_producto, id_medida)
           VALUES ("manzana", "es roja", "5", "2", "apple.png", "manzana", "1", "Frio", "1", "1");
SELECT * FROM stock_productos;
INSERT INTO stock_productos (ingreso_stock, id_producto) VALUES (5, 7);
INSERT INTO stock_productos (ingreso_stock, id_producto) VALUES (4, 1);

DELETE FROM productos WHERE id=7;
SELECT * FROM productos;
SELECT * FROM usuarios;
SELECT * FROM empleados;
SELECT * FROM detalles_pedido;
SELECT * FROM pedidos;
INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Ni frio, ni caliente", "Llevar", "Frankxx");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido)
		VALUES (5, 9, 5);
UPDATE pedidos SET estado_pedido="En solicitud" WHERE id=5;
INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Ni frio, ni caliente", "Llevar", "Diego");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido)
		VALUES (5, 9, 6);
UPDATE pedidos SET estado_pedido="En solicitud" WHERE id=6;
/*Prueba de cancelado*/
INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Ni frio, ni caliente", "Llevar", "DiegoFrank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido)
		VALUES (2, 9, 7);
        INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido)
		VALUES (2, 9, 7);
UPDATE pedidos SET estado_pedido="En solicitud" WHERE id=7;
INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Ni frio, ni caliente", "Llevar", "DiegoFrank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido)
		VALUES (2, 9, 9);
        INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido)
		VALUES (2, 9, 9);
INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Ni frio, ni caliente", "Llevar", "DiegoFrank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido)
		VALUES (2, 9, 10);
        INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido)
		VALUES (2, 9, 10);
        
        SELECT * FROM pedidos;
        SELECT * FROM detalles_pedido;
        SELECT * FROM productos;
UPDATE productos SET stock_producto=8 WHERE id= '5';
UPDATE pedidos SET estado_pedido='En solicitud' WHERE id= '7';
INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Ni frio, ni caliente", "Llevar", "DiegoFrank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido)
		VALUES (2, 9, 11);
UPDATE pedidos SET estado_pedido='En solicitud' WHERE id= '11';
INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Ni frio, ni caliente", "Llevar", "DiegoFrank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido)
		VALUES (2, 9, 12);
UPDATE pedidos SET estado_pedido='En solicitud' WHERE id= '12';
SELECT * FROM pedidos;
INSERT INTO pedidos (info_pedido, op_pedido, nombre_cliente_pedido) VALUES ("Ni frio, ni caliente", "Llevar", "DiegoFrank");
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido)
		VALUES (2, 9, 13);
INSERT INTO detalles_pedido (cantidad_producto, id_producto, id_pedido)
		VALUES (2, 9, 13);
        

