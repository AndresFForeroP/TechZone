
1️⃣ Listar los productos con stock menor a 5 unidades.

SELECT * FROM productos
WHERE stock < 5;

2️⃣ Calcular ventas totales de un mes específico.

SELECT v.fecha , SUM(vd.precio_unitario) AS ventas 
FROM ventas_detalle AS vd
JOIN ventas AS v ON v.id = vd.venta_id 
WHERE v.fecha BETWEEN '2025-08-01' AND '2025-8-30'
GROUP BY v.fecha ;

3️⃣ Obtener el cliente con más compras realizadas.

SELECT c.nombre, COUNT(v.id) as compras
FROM clientes as c
JOIN ventas AS v ON v.cliente_id = c.id
GROUP BY c.nombre
ORDER BY compras DESC
LIMIT 1;

4️⃣ Listar los 5 productos más vendidos.

SELECT p.nombre AS producto, COUNT(vd.id) AS ventas
FROM productos AS p
JOIN ventas_detalle AS vd ON vd.producto_id = p.id
GROUP BY producto
ORDER BY ventas DESC
LIMIT 5;

5️⃣ Consultar ventas realizadas en un rango de fechas de tres Días y un Mes.

SELECT v.fecha , SUM(vd.precio_unitario) AS ventas 
FROM ventas_detalle AS vd
JOIN ventas AS v ON v.id = vd.venta_id 
WHERE v.fecha BETWEEN '2025-08-01' AND '2025-9-03'
GROUP BY v.fecha ;

6️⃣ Identificar clientes que no han comprado en los últimos 6 meses.

SELECT c.nombre AS cliente, v.fecha
FROM clientes AS c
JOIN ventas AS v ON c.id = v.cliente_id
WHERE v.fecha <= NOW() - INTERVAL '6 months';
