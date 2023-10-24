USE cafeteria;

INSERT INTO roles (nombre_rol) VALUES ("Administrador"), ("Barista"), ("Cliente");

INSERT INTO medidas (nom_medida, uni_medida) VALUES ("Militros", "ml"), ("Pieza", "pz"), ("Gramos", "grs");

INSERT INTO tipos_cafe (tipo_cafe) VALUES ("Regular"), ("Descafeinado");

INSERT INTO productos_extra (nombre_pe, precio_unitario_pe) 
VALUES ("Leche entera", 0.00), ("Leche almendras", 15.00), ("Leche de avena", 10.00);

INSERT INTO categorias (nom_categoria, img_categoria) 
VALUES ("Postres", "postres.jpg"), ("Cafes", "cafes.jpg");

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
("Taro Frio", "Taro frío", 59.00, 10, "Taro.jpg", "taro", 2, "Frío", 1, 500,1)