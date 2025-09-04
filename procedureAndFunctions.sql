--Un procedimiento almacenado para registrar una venta.
CREATE OR REPLACE PROCEDURE registrar_nueva_venta(
    cliente_id INTEGER,
    p_product_ids INTEGER[],
    p_quantities INTEGER[],
    p_prices FLOAT8[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    new_order_id INTEGER;
BEGIN
    INSERT INTO ventas (cliente_id, fecha)
    VALUES (cliente_id, NOW())
    RETURNING id INTO new_order_id;

    FOR i IN 1..array_length(p_product_ids, 1) LOOP
        INSERT INTO ventas_detalle (venta_id, producto_id, cantidad, precio_unitario)
        VALUES (new_order_id, p_product_ids[i], p_quantities[i], p_prices[i]);
    END LOOP;

    RAISE NOTICE 'Orden creada con ID: %', new_order_id;
END;
$$;

CALL registrar_nueva_venta(
    1,
    ARRAY[1, 2, 3],
    ARRAY[2, 1, 5],
    ARRAY[10.50, 20.00, 5.75]
);

SELECT 
    v.id AS venta_id,
    v.cliente_id,
    v.fecha,
    d.producto_id,
    d.cantidad,
    d.precio_unitario,
    (d.cantidad * d.precio_unitario) AS subtotal
FROM 
    ventas v
JOIN 
    ventas_detalle d ON v.id = d.venta_id
ORDER BY 
    v.id, d.id;

--Validar que el cliente exista.

CREATE OR REPLACE PROCEDURE existencia_cliente(
    cliente_id INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    existe BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM clientes WHERE id = cliente_id
    ) INTO existe;

    IF NOT existe THEN
        RAISE EXCEPTION 'El cliente con ID % no existe', cliente_id;
    ELSE
        RAISE NOTICE 'El cliente con ID % sí existe', cliente_id;
    END IF;
END;
$$;


CALL existencia_cliente(1);

--Verificar que el stock sea suficiente antes de procesar la venta.