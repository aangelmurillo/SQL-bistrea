USE cafeteria;

INSERT INTO roles (nombre_rol) VALUES ("Administrador"), ("Barista"), ("Cliente");

INSERT INTO medidas (nom_medida, uni_medida) VALUES ("Militros", "ml"), ("Pieza", "pz"), ("Gramos", "grs");

INSERT INTO tipos_cafe (tipo_cafe) VALUES ("Regular"), ("Descafeinado");

INSERT INTO productos_extra (nombre_pe, precio_unitario_pe) 
VALUES ("Leche entera", 0.00), ("Leche almendras", 15.00), ("Leche de avena", 10.00);

INSERT INTO categorias (nom_categoria, img_categoria) 
VALUES ("Postres"), ("Cafes");

INSERT INTO usuarios 
(nombre_usuario, apellido_p_usuario, apellido_m_usuario, email_usuario, contrasena_usuario, 
foto_perfil_usuario, telefono_usuario, status_usuario, creado_en_usuario, id_rol) 
VALUES 
("Alfredo", "Gomez", "Gonzalez", "imjuantrc@gmail.com", "1234", "pug.jpg", "+528718451815", 1, NOW(), 3), 
("Antonio", "Salais", "Escamilla", "gamerantonio222s@gmail.com", "1234", "Default.jpg", "+528717102354", 1, NOW(), 2), 
("Jose Angel", "Murillo", "Verastegui", "aangelmurv@gmail.com", "1234", "murillo.jpg", "+528715726548", 1, NOW(), 1), 
("Adrian", "Godttfried", "Gutierrez", "adriangottfried@gmail.com", "1234", "Default.jpg", "+528180919984", 1, NOW(), 1), 
("Jose Angel", "Garcia", "De La Cruz", "joseangelgarciadelacruz5@gmail.com", "1234", "Default.jpg", "+528713714727", 1, NOW(), 3);

INSERT INTO empleados
(curp_empleado, rfc_empleado, salario_mes_empleado, id_usuario)
VALUES
("AAA", "AAA", 1200.00, 2),
("BBB", "BBB", 2500.00, 3),
("CCC", "CCC", 2500.00, 4);

INSERT INTO resenas
(comentario_resena, id_usuario)
VALUES
("Excelente =)", 1),
("Buenos cafes", 5);

INSERT INTO configs_carusel
(img_config_carusel, id_empleado)
VALUES
("img1.jpg", 2),
("img2.jpg", 2),
("img3.jpg", 2),
("img4.jpg", 2);


ALTER TABLE productos MODIFY COLUMN especialidad_producto ENUM("Caliente", "Frío", "Postre", "Frappe") NOT NULL;

INSERT INTO productos 
(nombre_producto, descripcion_producto, precio_unitario_producto, stock_producto, img_producto, slug_producto,
id_categoria, especialidad_producto, estado_producto, medida_producto, id_medida)
VALUES
("Cafe Americano Caliente", "Cafe muy rico", 35.00, 10,"cafe_americano.jpg", "cafe-americano-caliente", 2, "Caliente", 1, 500, 1),
("Chai Frappe", "Chai hecho con ingredientes naturales", 63.00, 10, "chai_frappe.jpg", "chai-frappe", 2, "Frappe", 1, 500, 1),
("Cappuccino Caliente", "Capuccino muy rico", 50.00, 10,"capuccino-caliente.jpg", "capuccino-caliente", 2, "Caliente", 1, 500, 1),
("Cocoa Caliente", "Cocoa caliente", 57.00, 10, "cocoa.jpg", "cocoa", 2, "Caliente",  1, 500, 1),
("Taro Frio", "Taro frío", 59.00, 10, "Taro.jpg", "taro", 2, "Frío", 1, 500,1);

INSERT INTO stock_productos
(ingreso_stock, fecha_ingreso_stock,id_producto) VALUES 
(20, '10/1/2024', 1),
(30, '11/1/2024',2),
(40, '12/1/2024',3),
(50, '13/1/2024',4),
(60, '14/1/2024',5);

INSERT INTO pedidos
(fecha_realizado_pedido,hora_realizado_pedido,hora_entrega_pedido,estado_pedido,
info_pedido,op_pedido,id_empleado,nombre_cliente_pedido,total_pedido) VALUES
 ('2023/10/2','10:04','11:04',"En solicitud", "null" ,"Llevar", 1, "Adrian",130.20),
 ('2023/10/3','11:04','12:14',"En proceso", "Sin azucar","Comer ahí",2,"Angel",65.20),
 ('2023/10/4','12:14','13:24',"Entregado", "sin crema batida","Llevar",3,"Jose",60.50),
 ('2023/10/5','13:24','14:34',"En solicitud", "Con esplenda","Comer ahí",2,"Andrea",40.20),
 ('2023/10/6','14:34','15:34',"En proceso", "Sin hielo","Llevar",1,"Luisa",50.50);
 
 INSERT INTO detalles_pedido 
 (cantidad_producto,precio_unitario,id_producto ,tipo_pago_pedido,
 subtotal_pedido,id_pedido) VALUES 
 (2, 31.00, 1, "Efectivo", 62.00,1),
 (4,36.00,2,"Paypal", 184.00,2),
 (5,59.00,3,"Efectivo", 395.00,3),
 (9,13.00,4,"Paypal", 117.00,4),
 (8,25.00,5,"Efectivo",200.00,5);
 
 INSERT INTO detalles_pedido_pe
 (precio_pe, id_detalle_pedido, id_producto_extra) VALUES
 (10.00,1,1),
 (20.00,2,2),
 (10.00,3,3),
 (15.00,4,1),
 (20.00,5,2);
 
 INSERT INTO detalles_pedido_tipo_cafe
 (nom_cafe, id_detalle_pedido,id_tipo_cafe) VALUES
 ("Regular",1,1),
 ("Descafeinado",2,2),
 ("Regular",3,1),
 ("Descafeinado",4,2),
 ("Regular",5,1);
 
 INSERT INTO pedidos_clientes 
 (id_pedido, id_usuario) VALUES
 (1,1),
 (2,2),
 (3,3),
 (4,4),
 (5,5);
 
 


/*PROBANDO TRIGGER DE ACTUALIZACION STOCK*/

/*pedidos*/
INSERT INTO pedidos (fecha_realizado_pedido, hora_realizado_pedido, hora_entrega_pedido, estado_pedido, info_pedido, op_pedido, id_empleado, nombre_cliente_pedido, total_pedido)
VALUES ('2023-10-09', '09:05:00', '20:04:00', 'En proceso', 'Mucho hielo', 'Llevar', '1', 'Amanda', '905') ;
INSERT INTO pedidos (fecha_realizado_pedido, hora_realizado_pedido, hora_entrega_pedido, estado_pedido, info_pedido, op_pedido, id_empleado, nombre_cliente_pedido, total_pedido)
VALUES ('2023-10-09', '09:05:00', '20:04:00', 'En proceso', 'Mucho hielo', 'Llevar', '1', 'Murillo', '50') ;
/*detalle pedido*/
INSERT INTO detalles_pedido (cantidad_producto, precio_unitario, id_producto, tipo_pago_pedido, subtotal_pedido, id_pedido)
VALUES (20, 31, 1, 'Efectivo', 62, 6);
INSERT INTO detalles_pedido (cantidad_producto, precio_unitario, id_producto, tipo_pago_pedido, subtotal_pedido, id_pedido)
VALUES (50, 31, 1, 'Efectivo', 62, 7);
/*actualizamos estado_pedido*/
UPDATE pedidos SET estado_pedido='En solicitud' WHERE id_pedido=7; 

