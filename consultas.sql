/*ADMIN*/
/*HISTORIAL DE VENTAS*/
SELECT * FROM pedidos;
SELECT * FROM detalles_pedido;
SELECT * FROM productos;

SELECT
    pedidos.fecha_realizado_pedido AS Fecha,
    productos.nombre_producto AS Producto,
    productos.precio_unitario_producto AS "Precio Unitario",
    SUM(detalles_pedido.cantidad_producto) AS Piezas,
    SUM(detalles_pedido.cantidad_producto * productos.precio_unitario_producto) AS Total
FROM pedidos
INNER JOIN detalles_pedido ON pedidos.id_pedido = detalles_pedido.id_pedido
INNER JOIN productos ON detalles_pedido.id_producto = productos.id_producto
WHERE pedidos.fecha_realizado_pedido = "2023-10-02"      /*Segun la fecha*/
GROUP BY pedidos.fecha_realizado_pedido, productos.nombre_producto
ORDER BY pedidos.fecha_realizado_pedido;


/*Falta poner columna nss en empleados*/


/*ACTUALIZAR STOCK*/ 
SELECT * FROM stock_productos;

UPDATE stock_productos
SET ingreso_stock = ingreso_stock + 50, /*x Cantidad*/
    fecha_ingreso_stock = NOW()  
WHERE id_producto = 1;


/*VER USUARIOS*/
SELECT * FROM usuarios;
SELECT * FROM pedidos_clientes;
SELECT * FROM pedidos;

SELECT
    CONCAT(usuarios.nombre_usuario, ' ', usuarios.apellido_p_usuario) AS Nombre,
    usuarios.telefono_usuario AS Telefono,
    usuarios.email_usuario AS Email,
    roles.nombre_rol AS Rol,
    COUNT(pedidos_clientes.id_pedido) AS PedidosRealizados
FROM usuarios
INNER JOIN roles ON usuarios.id_rol = roles.id_rol
LEFT JOIN pedidos_clientes ON usuarios.id_usuario = pedidos_clientes.id_usuario
GROUP BY usuarios.id_usuario
ORDER BY Nombre;


/*CORTE DE CAJA*/
SELECT * FROM pedidos;
SELECT * FROM detalles_pedido;
SELECT * FROM productos;

SELECT
    CONCAT(usuarios.nombre_usuario, ' ', usuarios.apellido_p_usuario) AS Nombre,
    usuarios.telefono_usuario AS Telefono,
    productos.nombre_producto AS Producto,
    detalles_pedido.cantidad_producto AS Cantidad,
    detalles_pedido.subtotal_pedido AS Subtotal,
    (SELECT SUM(subtotal_pedido) FROM detalles_pedido WHERE id_pedido = pedidos.id_pedido) AS Total
FROM pedidos_clientes
INNER JOIN pedidos ON pedidos_clientes.id_pedido = pedidos.id_pedido
INNER JOIN detalles_pedido ON pedidos.id_pedido = detalles_pedido.id_pedido
INNER JOIN usuarios ON pedidos_clientes.id_usuario = usuarios.id_usuario
INNER JOIN productos ON detalles_pedido.id_producto = productos.id_producto;


/*CLIENTE*/
/*HISTORIAL DE COMPRAS*/
SELECT * from pedidos;
SELECT * FROM detalles_pedido;
SELECT * FROM pedidos_clientes;

SELECT
    productos.nombre_producto AS Productos,
    detalles_pedido.cantidad_producto AS Cantidad,
    pedidos.info_pedido AS Notas,
    detalles_pedido.subtotal_pedido AS Total
FROM pedidos_clientes
INNER JOIN pedidos ON pedidos_clientes.id_pedido = pedidos.id_pedido
INNER JOIN detalles_pedido ON pedidos.id_pedido = detalles_pedido.id_pedido
INNER JOIN productos ON detalles_pedido.id_producto = productos.id_producto
WHERE pedidos_clientes.id_usuario = 1 /*Aqui remplazo el id_usuario por un id de usuario para que cada uno tenga su historial*/
AND pedidos.fecha_realizado_pedido = '2023-10-02';

/*HACER COMPRA*/
SELECT * FROM tipos_cafe;
SELECT * FROM detalles_pedido_tipo_cafe;
SELECT * FROM detalles_pedido;
SELECT * FROM productos;
SELECT * FROM pedidos;
SELECT * FROM productos_extra;

SELECT                            /*va segun mi especialidad_producto lo de parentesis, o podria ser segun el producto_extra*/   
    CONCAT(productos.nombre_producto, ' ', ("("), productos.especialidad_producto, (")")) AS Nombre,
    detalles_pedido.cantidad_producto AS Cantidad,
    pedidos.total_pedido AS Total
FROM pedidos
INNER JOIN detalles_pedido ON pedidos.id_pedido = detalles_pedido.id_pedido
INNER JOIN productos ON detalles_pedido.id_producto = productos.id_producto
WHERE pedidos.estado_pedido = 'En proceso';




/*BARISTA*/
/*PEDIDOS PENDIENTES*/
SELECT * FROM pedidos;
SELECT * FROM pedidos_clientes;
SELECT * FROM detalles_pedido;
SELECT * FROM usuarios;
SELECT * FROM productos_extra;
SELECT
    CONCAT(usuarios.nombre_usuario, ' ', usuarios.apellido_p_usuario) AS Nombre,
    CONCAT(productos.nombre_producto, ' ', detalles_pedido.cantidad_producto)AS Productos, 
    CONCAT(pedidos.hora_entrega_pedido, ' ', pedidos.op_pedido) AS "Hora de Entrega",
    pedidos.info_pedido AS Notas,
    CONCAT(detalles_pedido.tipo_pago_pedido, ' ', detalles_pedido.subtotal_pedido) AS Total
FROM pedidos
INNER JOIN pedidos_clientes ON pedidos.id_pedido = pedidos_clientes.id_pedido
INNER JOIN usuarios ON pedidos_clientes.id_usuario = usuarios.id_usuario
LEFT JOIN detalles_pedido ON pedidos.id_pedido = detalles_pedido.id_pedido
LEFT JOIN productos ON detalles_pedido.id_producto = productos.id_producto
WHERE pedidos.estado_pedido = 'En proceso'
GROUP BY pedidos.id_pedido, Nombre, "Hora de Entrega", Notas, Total
ORDER BY pedidos.fecha_realizado_pedido, pedidos.hora_realizado_pedido;

/*RESUMEN DE PEDIDOS*/
SELECT * FROM pedidos;
SELECT * FROM productos;
SELECT * FROM usuarios;
SELECT * FROM pedidos_clientes;
SELECT * FROM detalles_pedido;
SELECT * FROM productos_extra;
SELECT * FROM tipos_cafe;
SELECT * FROM detalles_pedido_tipo_cafe;

SELECT
    CONCAT(usuarios.nombre_usuario, ' ', usuarios.apellido_p_usuario) AS Nombre,
    CONCAT(productos.nombre_producto, ' ', detalles_pedido.cantidad_producto)AS Productos, 
    CONCAT(pedidos.hora_entrega_pedido, ' ', pedidos.op_pedido) AS "Hora de Entrega",
    pedidos.info_pedido AS Notas,
    CONCAT(detalles_pedido.tipo_pago_pedido, ' ', detalles_pedido.subtotal_pedido) AS Total
FROM pedidos
INNER JOIN pedidos_clientes ON pedidos.id_pedido = pedidos_clientes.id_pedido
INNER JOIN usuarios ON pedidos_clientes.id_usuario = usuarios.id_usuario
LEFT JOIN detalles_pedido ON pedidos.id_pedido = detalles_pedido.id_pedido
LEFT JOIN productos ON detalles_pedido.id_producto = productos.id_producto
WHERE pedidos.estado_pedido = 'Entregado'
GROUP BY pedidos.id_pedido, Nombre, "Hora de Entrega", Notas, Total
ORDER BY pedidos.fecha_realizado_pedido, pedidos.hora_realizado_pedido;

