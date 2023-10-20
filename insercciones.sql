USE cafeteria;

INSERT INTO roles (nombre_rol) VALUES ("Administrador"), ("Barista"), ("Cliente");

INSERT INTO medidas (nom_medida, uni_medida) VALUES ("Militros", "ml"), ("Pieza", "pz"), ("Gramos", "grs");

INSERT INTO tipos_cafe (tipo_cafe) VALUES ("Regular"), ("Descafeinado");

INSERT INTO productos_extra (nombre_pe, precio_unitario_pe) VALUES ("Leche entera", 0.00), ("Leche almendras", 15.00), ("Leche de avena", 10.00);

INSERT INTO categorias (nom_categoria, img_categoria) VALUES ("Postres", "postres.jpg"), ("Cafes", "cafes.jpg");

INSERT INTO usuarios (nombre_usuario, apellido_p_usuario, apellido_m_usuario, email_usuario, contrasena_usuario, foto_perfil_usuario, telefono_usuario, status_usuario, creado_en_usuario, id_rol) VALUES ("Alfredo", "Gomez", "Gonzalez", "imjuantrc@gmail.com", "1234", "pug.jpg", "+528718451815", 1, NOW(), 3), ("Antonio", "Salais", "Escamilla", "gamerantonio222s@gmail.com", "1234", "Default.jpg", "+528717102354", 1, NOW(), 2), ("Jose Angel", "Murillo", "Verastegui", "aangelmurv@gmail.com", "1234", "murillo.jpg", "+528715726548", 1, NOW(), 1), ("Adrian", "Godttfried", "Gutierrez", "adriangottfried@gmail.com", "1234", "Default.jpg", "+528180919984", 1, NOW(), 1), ("Jose Angel", "Garcia", "De La Cruz", "joseangelgarciadelacruz5@gmail.com", "1234", "Default.jpg", "+528713714727", 1, NOW(), 3);

/* INSERT INTO empleados (curp_empleado, rfc_empleado, salario_mes_empleado, id_usuario) VALUES ("AAAAAAAAAAAAAAAAAA", "AAAAAAAAAAAAA", 850.20, ), ("AAAAAAAAAAAAAAAAAB", "AAAAAAAAAAAAB", 900, )*/ 