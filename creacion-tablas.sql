CREATE DATABASE IF NOT EXISTS cafeteria CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE cafeteria;

CREATE TABLE IF NOT EXISTS roles(
    id_rol INT AUTO_INCREMENT NOT NULL UNIQUE,
    nombre_rol VARCHAR(30) NOT NULL UNIQUE,
    PRIMARY KEY(id_rol)
);

CREATE TABLE IF NOT EXISTS medidas(
    id_medida INT AUTO_INCREMENT NOT NULL UNIQUE,
    nom_medida VARCHAR(15) NOT NULL,
    uni_medida VARCHAR(10) NOT NULL,
    PRIMARY KEY(id_medida)
);

CREATE TABLE IF NOT EXISTS tipos_cafe(
    id_tipo_cafe INT AUTO_INCREMENT NOT NULL UNIQUE,
    tipo_cafe VARCHAR(15) NOT NULL UNIQUE,
    PRIMARY KEY(id_tipo_cafe)
);

CREATE TABLE IF NOT EXISTS productos_extra(
    id_producto_extra INT AUTO_INCREMENT NOT NULL UNIQUE,
    nombre_pe VARCHAR(20) NOT NULL UNIQUE,
    precio_unitario_pe DECIMAL(7,2) NOT NULL,
    PRIMARY KEY(id_producto_extra)
);

CREATE TABLE IF NOT EXISTS categorias(
    id_categoria INT AUTO_INCREMENT NOT NULL UNIQUE,
    nom_categoria VARCHAR(25) NOT NULL UNIQUE,
    img_categoria VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY(id_categoria)
);

CREATE TABLE IF NOT EXISTS usuarios(
    id_usuario INT AUTO_INCREMENT NOT NULL UNIQUE,
    nombre_usuario VARCHAR(50) NOT NULL,
    apellido_p_usuario VARCHAR(20) NOT NULL,
    apellido_m_usuario VARCHAR(20),
    email_usuario VARCHAR(120) NOT NULL UNIQUE,
    contrasena_usuario VARCHAR(100) NOT NULL,
    foto_perfil_usuario VARCHAR(255) NOT NULL DEFAULT "foto-usuario.jpg",
    telefono_usuario VARCHAR(25) NOT NULL UNIQUE,
    status_usuario TINYINT DEFAULT 1,
    creado_en_usuario TIMESTAMP NOT NULL,
    id_rol INT NOT NULL,
    PRIMARY KEY(id_usuario),
    FOREIGN KEY(id_rol) REFERENCES roles (id_rol)
);

CREATE TABLE IF NOT EXISTS empleados(
    id_empleado INT AUTO_INCREMENT NOT NULL UNIQUE,
    curp_empleado VARCHAR(18) NOT NULL UNIQUE,
    rfc_empleado VARCHAR(13) NOT NULL UNIQUE,
    salario_mes_empleado DECIMAL(8,2) NOT NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY(id_empleado),
    FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE IF NOT EXISTS resenas(
    id_resena INT AUTO_INCREMENT NOT NULL UNIQUE,
    comentario_resena VARCHAR(255) NOT NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY(id_resena),
    FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE IF NOT EXISTS configs_carusel (
    id_config_carusel INT AUTO_INCREMENT NOT NULL UNIQUE, 
    img_config_carusel VARCHAR(255) NOT NULL,
    id_empleado INT NOT NULL,
    PRIMARY KEY(id_config_carusel),
    FOREIGN KEY(id_empleado) REFERENCES empleados(id_empleado)
);

CREATE TABLE IF NOT EXISTS productos(
    id_producto INT AUTO_INCREMENT NOT NULL UNIQUE,
    nombre_producto VARCHAR(120) NOT NULL,    
    descripcion_producto VARCHAR(200),
    precio_unitario_producto DECIMAL(6,2) NOT NULL,
    stock_producto INT NOT NULL, 
    img_producto VARCHAR(255) NOT NULL, 
    slug_producto VARCHAR(120) NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY(id_categoria) REFERENCES categorias(id_categoria),
    especialidad_producto ENUM("Caliente", "Frío", "Postre") NOT NULL,
    estado_producto TINYINT DEFAULT 1,
    medida_producto INT NOT NULL,
    id_medida INT NOT NULL,
    PRIMARY KEY(id_producto),
    FOREIGN KEY(id_medida) REFERENCES medidas(id_medida)
);

CREATE TABLE IF NOT EXISTS stock_productos(
    id_stock INT AUTO_INCREMENT NOT NULL UNIQUE,
    ingreso_stock INT NOT NULL,
    fecha_ingreso_stock DATETIME NOT NULL,
    id_producto INT NOT NULL,
    PRIMARY KEY(id_stock),
    FOREIGN KEY(id_producto) REFERENCES productos(id_producto)
);
ALTER TABLE stock_productos MODIFY COLUMN fecha_ingreso_stock DATETIME DEFAULT NOW();

CREATE TABLE IF NOT EXISTS pedidos(
    id_pedido INT AUTO_INCREMENT NOT NULL UNIQUE,
    fecha_realizado_pedido DATE NOT NULL,
    hora_realizado_pedido TIME NOT NULL,
    hora_entrega_pedido TIME NOT NULL,
    estado_pedido DEFAULT "En solicitud" ENUM("En solicitud", "En proceso", "Entregado") NOT NULL,
    info_pedido VARCHAR(255),
    op_pedido ENUM("Llevar", "Comer ahí") NOT NULL,
    id_empleado INT NOT NULL,
    FOREIGN KEY(id_empleado) REFERENCES empleados(id_empleado),
    PRIMARY KEY(id_pedido),
    nombre_cliente_pedido VARCHAR(120) NOT NULL,
    total_pedido DECIMAL(7,2) NOT NULL
);

ALTER TABLE pedidos MODIFY COLUMN fecha_realizado_pedido DATE DEFAULT NOW();
ALTER TABLE pedidos MODIFY COLUMN hora_realizado_pedido TIME DEFAULT NOW();

CREATE TABLE IF NOT EXISTS detalles_pedido(
    id_detalle_pedido INT AUTO_INCREMENT NOT NULL UNIQUE,
    cantidad_producto INT NOT NULL,
    precio_unitario DECIMAL(6,2) NOT NULL,
    id_producto INT NOT NULL,
    FOREIGN KEY(id_producto) REFERENCES productos(id_producto),
    tipo_pago_pedido ENUM("Efectivo", "Paypal") NOT NULL,
    subtotal_pedido DECIMAL(6,2) NOT NULL,
    id_pedido INT NOT NULL,
    PRIMARY KEY(id_detalle_pedido),
    FOREIGN KEY(id_pedido) REFERENCES pedidos(id_pedido)
);

CREATE TABLE IF NOT EXISTS detalles_pedido_pe(
    id_detalle_pedido_pe INT AUTO_INCREMENT NOT NULL UNIQUE,
    precio_pe DECIMAL(5,2) NOT NULL,
    id_detalle_pedido INT NOT NULL,
    id_producto_extra INT NOT NULL,
    PRIMARY KEY(id_detalle_pedido_pe),
    FOREIGN KEY(id_detalle_pedido) REFERENCES detalles_pedido(id_detalle_pedido),
    FOREIGN KEY(id_producto_extra) REFERENCES productos_extra(id_producto_extra)
);


CREATE TABLE IF NOT EXISTS detalles_pedido_tipo_cafe(
    id_detalles_pedido_tp INT AUTO_INCREMENT NOT NULL,
    nom_cafe ENUM("Regular", "Descafeinado") NOT NULL,
    id_detalle_pedido INT NOT NULL,
    id_tipo_cafe INT NOT NULL,    
    PRIMARY KEY(id_detalles_pedido_tp),
    FOREIGN KEY(id_detalle_pedido) REFERENCES detalles_pedido(id_detalle_pedido),
    FOREIGN KEY(id_tipo_cafe) REFERENCES tipos_cafe(id_tipo_cafe)
);

CREATE TABLE IF NOT EXISTS pedidos_clientes(
    id_pedido_cliente INT NOT NULL AUTO_INCREMENT UNIQUE,
    id_pedido INT NOT NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY(id_pedido_cliente),
    FOREIGN KEY(id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario)
);
