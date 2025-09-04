-- 1️⃣ primer trigger
CREATE OR REPLACE FUNCTION fc_registro_automatico_ventas()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_ventas (venta_id, usuario)
    VALUES (NEW.id, current_user);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER tr_registro_automatico_ventas
AFTER INSERT ON ventas
FOR EACH ROW
EXECUTE FUNCTION fc_registro_automatico_ventas();
-- estos son inserts de prueba
INSERT INTO clientes (nombre, correo, telefono, estado)
VALUES ('Juan Péresdvz', 'juan.peredfvz@test.com', '555-1234', 'activo');
INSERT INTO ventas (cliente_id)
VALUES (1);
SELECT * FROM auditoria_ventas;



--2️⃣ segundo trigger
CREATE OR REPLACE FUNCTION fc_actualizacion_automatica_stock()
RETURNS TRIGGER AS $$
DECLARE 
    new_stock_actual INT;
BEGIN 
    -- Consultar stock actual del producto
    SELECT stock INTO new_stock_actual
    FROM productos
    WHERE id = NEW.producto_id;

    -- Validar stock suficiente
    IF new_stock_actual < NEW.cantidad THEN
        RAISE EXCEPTION 'Stock insuficiente para el producto %',
            NEW.producto_id;
    END IF;

    -- Actualizar stock
    UPDATE productos
    SET stock = stock - NEW.cantidad
    WHERE id = NEW.producto_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER tr_actualizacion_automatica_stock
BEFORE INSERT ON ventas_detalle
FOR EACH ROW
EXECUTE FUNCTION fc_actualizacion_automatica_stock();
-- insert de prueba que bota la excepcion
INSERT INTO ventas_detalle (venta_id, producto_id, cantidad, precio_unitario)
VALUES (1, 1, 20, 50000);


-- 3️⃣ tercer trigger
CREATE OR REPLACE FUNCTION fc_validar_correo()
RETURNS TRIGGER AS $$
BEGIN
    -- Validar que el correo no esté vacío
    IF NEW.correo IS NULL OR NEW.correo = '' THEN
        RAISE EXCEPTION 'El correo no puede estar vacío';
    END IF;

    -- Validar que el correo no exista ya en la tabla
    IF EXISTS (SELECT 1 FROM clientes WHERE correo = NEW.correo) THEN
        RAISE EXCEPTION 'El correo % ya existe en la base de datos', NEW.correo;
    END IF;

    RETURN NEW;
END; 
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER tr_validar_correo
BEFORE INSERT ON clientes 
FOR EACH ROW 
EXECUTE FUNCTION fc_validar_correo();
-- aca sale la excepcion
INSERT INTO clientes (nombre, correo, telefono, estado)
VALUES ('Cliente Sin Correo', '', '555-0002', 'activo');


-- 4️⃣ cuarto trigger
CREATE OR REPLACE FUNCTION fc_historial_precios()
RETURNS TRIGGER AS $$
BEGIN
    -- hacer condicion para saber si cambio el precio o no
    IF NEW.precio IS DISTINCT FROM OLD.precio THEN
        INSERT INTO historial_precios (producto_id, precio_anterior, precio_nuevo)
        VALUES (OLD.id, OLD.precio, NEW.precio);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER tr_historial_precios
AFTER UPDATE OF precio ON productos
FOR EACH ROW
EXECUTE FUNCTION fc_historial_precios();
-- estos son los inserts de prueba 
INSERT INTO productos (nombre, categoria, precio, stock)
VALUES ('Teclado Gamer', 'Tecnología', 100.00, 20);
UPDATE productos
SET precio = 120.00
WHERE nombre = 'Teclado Gamer';
SELECT * FROM historial_precios;



-- 5️⃣ quinto trigger
CREATE OR REPLACE FUNCTION fc_bloquear_eliminacion_proveedores()
RETURNS TRIGGER AS $$
BEGIN
    -- verificar si el proveedor tiene productos asociados
    IF EXISTS (
        SELECT 1
        FROM proveedoresproductos
        WHERE id_proveedor = OLD.id
    ) THEN
        RAISE EXCEPTION 'No se puede eliminar el proveedor %, aún tiene productos asociados', OLD.id;
    END IF;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER tr_bloquear_eliminacion_proveedores
BEFORE DELETE ON proveedores
FOR EACH ROW
EXECUTE FUNCTION fc_bloquear_eliminacion_proveedores();
-- inserts de prueba para el trigger
INSERT INTO proveedores (nombre) VALUES ('Proveedor Tech');
INSERT INTO productos (nombre, categoria, precio, stock)
VALUES ('Mouse Gamer', 'Tecnología', 50, 10);
DELETE FROM proveedores WHERE id = 1;


-- 6️⃣ sexto trigger
CREATE OR REPLACE FUNCTION fc_control_fechas_ventas()
RETURNS TRIGGER AS $$
BEGIN
    -- validar que la fecha no sea mayor a la fecha actual
    IF NEW.fecha > NOW() THEN
        RAISE EXCEPTION 'La fecha de la venta % no puede ser futura', NEW.fecha;
    END IF;

    RETURN NEW; 
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER tr_control_fechas_ventas
BEFORE INSERT ON ventas
FOR EACH ROW
EXECUTE FUNCTION fc_control_fechas_ventas();
-- este insert de prueba debe de botar error 
INSERT INTO ventas (cliente_id, fecha)
VALUES (1, NOW() + INTERVAL '1 day');


-- 7 septimo trigger
CREATE OR REPLACE FUNCTION fc_reactivar_clientes_inactivos()
RETURNS TRIGGER AS $$
DECLARE
    ultima_compra TIMESTAMP;
BEGIN
        -- Buscar la última compra del cliente
    SELECT MAX(fecha) INTO ultima_compra
    FROM ventas
    WHERE cliente_id = NEW.cliente_id;

    -- si no tiene compras o la ultima fue hace más de 6 meses
    IF ultima_compra IS NULL OR ultima_compra < NOW() - INTERVAL '6 months' THEN
        -- reactivar el cliente si la condicion es verdadera
        UPDATE clientes
        SET estado = 'activo'
        WHERE id = NEW.cliente_id AND estado = 'inactivo';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER tr_reactivar_clientes_inactivos
BEFORE INSERT ON ventas
FOR EACH ROW
EXECUTE FUNCTION fc_reactivar_clientes_inactivos();
-- insertar cliente inactiva
INSERT INTO clientes (nombre, correo, telefono, estado)
VALUES ('Mario Sánchez', 'mario.sanchez@test.com', '555-8888', 'inactivo');
-- Simular venta de hace 1 anio
INSERT INTO ventas (cliente_id, fecha)
VALUES ( (SELECT id FROM clientes WHERE correo = 'mario.sanchez@test.com'),
        NOW() - INTERVAL '1 year');
-- Insertar una nueva venta HOY por lo que se debe de reactivar
INSERT INTO ventas (cliente_id, fecha)
VALUES ( (SELECT id FROM clientes WHERE correo = 'mario.sanchez@test.com'),
        NOW());
-- Verificar estado actualizado
SELECT * FROM clientes WHERE correo = 'mario.sanchez@test.com';

