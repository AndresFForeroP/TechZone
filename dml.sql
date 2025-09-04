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
('Cargador Portatil Generico', 'Tecnologia', 16, 4),
('Cargador Portatil Lenovo', 'Tecnologia', 50, 3),
('Tableta Gráfica Wacom', 'Tecnología', 250.00, 12),
('Mesa de Centro', 'Muebles', 150.00, 8),
('Libro de Cocina "Recetas Rápidas"', 'Libros', 30.50, 45),
('Aceite de Oliva Extra Virgen', 'Alimentos', 22.00, 70),
('Set de Sartenes Antiadherentes', 'Hogar', 65.00, 18);


INSERT INTO clientes (nombre, correo, telefono, estado) VALUES
('Ana Martínez', 'ana.martinez@gmail.com', '555-1234', 'activo'),
('Luis Torres', 'luis.torres@hotmail.com', '555-5678', 'activo'),
('Carlos Pérez', 'carlos.perez@yahoo.com', '555-2468', 'inactivo'),
('Laura Gómez', 'laura.gomez@empresa.com', '555-1357', 'activo'),
('Marta Suárez', 'marta.suarez@dominio.com', '555-7890', 'activo'),
('Javier Ruiz', 'javier.ruiz@gmail.com', '555-9876', 'activo'),
('Sofía Castro', 'sofia.castro@hotmail.com', '555-4321', 'activo'),
('Ricardo Vidal', 'ricardo.vidal@yahoo.com', '555-8765', 'activo');


INSERT INTO proveedores (nombre) VALUES
('TechDistribuciones S.A.'),
('MueblesExpress'),
('Alimentos Selectos'),
('OfiTec Proveedores'),
('Hogar Plus'),
('TecnoWorld'),
('HomeDecor'),
('Global Food'),
('Librería Digital');

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
(10, 5, 15.00),
(11, 1, 220.00),
(12, 2, 130.00),
(13, 4, 25.00),
(14, 3, 19.50),
(15, 5, 58.00);

INSERT INTO ventas (cliente_id, fecha) VALUES
(1, '2025-08-01 10:00:00'),
(2, '2025-08-02 14:30:00'),
(3, '2025-08-03 16:45:00'),
(4, '2025-08-04 09:15:00'),
(1, '2025-08-05 11:00:00'),
(6, '2025-08-06 13:20:00'),
(7, '2025-08-07 18:05:00'),
(8, '2025-08-08 09:40:00');

INSERT INTO ventas_detalle (venta_id,producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 1200.00),
(1, 6, 2, 80.00),
(2, 2, 1, 850.00),
(2, 8, 1, 25.00),
(3, 3, 1, 250.50),
(3, 4, 1, 450.75),
(4, 5, 5, 15.20),
(5, 7, 1, 320.00),
(5, 10, 2, 18.50),
(6, 11, 1, 250.00),
(7, 13, 2, 30.50),
(8, 14, 3, 22.00),
(8, 9, 1, 12.00);

INSERT INTO historial_precios (producto_id, precio_anterior, precio_nuevo, cambiado_en) VALUES
(1, 1000.00, 1200.00, '2025-07-01 08:00:00'),
(2, 780.00, 850.00, '2025-07-05 12:00:00'),
(5, 13.00, 15.20, '2025-07-10 09:00:00'),
(7, 280.00, 320.00, '2025-07-15 14:00:00'),
(11, 230.00, 250.00, '2025-08-01 10:00:00');

INSERT INTO auditoria_ventas (venta_id, usuario, registrado_en) VALUES
(1, 'admin', '2025-08-01 10:01:00'),
(2, 'luis_t', '2025-08-02 14:31:00'),
(3, 'carlos_p', '2025-08-03 16:46:00'),
(4, 'laura_g', '2025-08-04 09:16:00'),
(5, 'ana_m', '2025-08-05 11:01:00'),
(6, 'javier_r', '2025-08-06 13:21:00'),
(7, 'sofia_c', '2025-08-07 18:06:00'),
(8, 'ricardo_v', '2025-08-08 09:41:00');

INSERT INTO alertas_stock (producto_id, nombre_producto, mensaje, generado_en) VALUES
(4, 'Escritorio de Madera', 'Stock bajo: quedan 5 unidades.', '2025-08-06 10:00:00'),
(7, 'Monitor LG 27"', 'Stock crítico: menos de 10 unidades.', '2025-08-07 11:30:00'),
(1, 'Laptop Lenovo ThinkPad', 'Stock bajo: solo 10 unidades.', '2025-08-08 15:00:00'),
(15, 'Set de Sartenes Antiadherentes', 'Stock bajo: 18 unidades restantes.', '2025-08-09 12:00:00');