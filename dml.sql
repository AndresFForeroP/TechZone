INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Laptop Lenovo ThinkPad', 'Tecnología', 1200.00, 10),
('Smartphone Samsung Galaxy', 'Tecnología', 850.00, 15),
('Silla Ergonómica', 'Muebles', 250.50, 20),
('Escritorio de Madera', 'Muebles', 450.75, 5),
('Café en Grano Premium', 'Alimentos', 15.20, 100),
('Teclado Mecánico', 'Tecnología', 80.00, 25),
('Monitor LG 27"', 'Tecnología', 320.00, 8),
('Mouse Inalámbrico', 'Tecnología', 25.00, 30),
('Botella de Agua Reusable', 'Hogar', 12.00, 60),
('Lampara LED', 'Hogar', 18.50, 40);

INSERT INTO clientes (nombre, correo, telefono, estado) VALUES
('Ana Martínez', 'ana.martinez@gmail.com', '555-1234', 'activo'),
('Luis Torres', 'luis.torres@hotmail.com', '555-5678', 'activo'),
('Carlos Pérez', 'carlos.perez@yahoo.com', '555-2468', 'inactivo'),
('Laura Gómez', 'laura.gomez@empresa.com', '555-1357', 'activo'),
('Marta Suárez', 'marta.suarez@dominio.com', '555-7890', 'activo');

INSERT INTO proveedores (nombre) VALUES
('TechDistribuciones S.A.'),
('MueblesExpress'),
('Alimentos Selectos'),
('OfiTec Proveedores'),
('Hogar Plus');

INSERT INTO proveedoresproductos (id_producto, id_proveedor, precio) VALUES
(1, 1, 1100.00),
(2, 1, 800.00),
(3, 2, 220.00),
(4, 2, 400.00),
(5, 3, 12.50),
(6, 1, 70.00),
(7, 1, 300.00),
(8, 1, 20.00),
(9, 5, 10.00),
(10, 5, 15.00);

INSERT INTO ventas_detalle (venta_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 1200.00),
(1, 6, 2, 80.00),
(2, 2, 1, 850.00),
(2, 8, 1, 25.00),
(3, 3, 1, 250.50),
(3, 4, 1, 450.75),
(4, 5, 5, 15.20),
(5, 7, 1, 320.00),
(5, 10, 2, 18.50);

INSERT INTO historial_precios (producto_id, precio_anterior, precio_nuevo, cambiado_en) VALUES
(1, 1000.00, 1200.00, '2025-07-01 08:00:00'),
(2, 780.00, 850.00, '2025-07-05 12:00:00'),
(5, 13.00, 15.20, '2025-07-10 09:00:00'),
(7, 280.00, 320.00, '2025-07-15 14:00:00');

INSERT INTO auditoria_ventas (venta_id, usuario, registrado_en) VALUES
(1, 'admin', '2025-08-01 10:01:00'),
(2, 'luis_t', '2025-08-02 14:31:00'),
(3, 'carlos_p', '2025-08-03 16:46:00'),
(4, 'laura_g', '2025-08-04 09:16:00'),
(5, 'ana_m', '2025-08-05 11:01:00');

INSERT INTO alertas_stock (producto_id, nombre_producto, mensaje, generado_en) VALUES
(4, 'Escritorio de Madera', 'Stock bajo: quedan 5 unidades.', '2025-08-06 10:00:00'),
(7, 'Monitor LG 27"', 'Stock crítico: menos de 10 unidades.', '2025-08-07 11:30:00'),
(1, 'Laptop Lenovo ThinkPad', 'Stock bajo: solo 10 unidades.', '2025-08-08 15:00:00');
