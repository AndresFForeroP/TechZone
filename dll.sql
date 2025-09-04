DROP DATABASE EXAMEN;
CREATE DATABASE EXAMEN;

CREATE TABLE IF NOT EXISTS productos (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  categoria TEXT NOT NULL,
  precio NUMERIC(12,2) NOT NULL CHECK (precio >= 0),
  stock INTEGER NOT NULL CHECK (stock >= 0)
);

CREATE TABLE IF NOT EXISTS clientes (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  correo TEXT NOT NULL UNIQUE,
  telefono TEXT,
  estado TEXT NOT NULL DEFAULT 'activo' CHECK (estado IN ('activo','inactivo'))
);

CREATE TABLE IF NOT EXISTS proveedores (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS proveedoresproductos (
    id_producto INTEGER,
    id_proveedor INTEGER,
    precio NUMERIC(10,2) NOT NULL,
    PRIMARY KEY(id_producto,id_proveedor)
);
CREATE TABLE IF NOT EXISTS ventas (
  id SERIAL PRIMARY KEY,
  cliente_id INTEGER NOT NULL,
  fecha TIMESTAMP NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS ventas_detalle (
  id SERIAL PRIMARY KEY,
  venta_id INTEGER NOT NULL,
  producto_id INTEGER NOT NULL REFERENCES productos(id),
  cantidad INTEGER NOT NULL CHECK (cantidad > 0),
  precio_unitario NUMERIC(12,2) NOT NULL CHECK (precio_unitario >= 0)
);

-- Tablas de apoyo
CREATE TABLE IF NOT EXISTS historial_precios (
  id BIGSERIAL PRIMARY KEY,
  producto_id INTEGER NOT NULL,
  precio_anterior NUMERIC(12,2) NOT NULL,
  precio_nuevo NUMERIC(12,2) NOT NULL,
  cambiado_en TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS auditoria_ventas (
  id BIGSERIAL PRIMARY KEY,
  venta_id INTEGER NOT NULL,
  usuario TEXT NOT NULL,
  registrado_en TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS alertas_stock (
  id BIGSERIAL PRIMARY KEY,
  producto_id INTEGER NOT NULL,
  nombre_producto TEXT NOT NULL,
  mensaje TEXT NOT NULL,
  generado_en TIMESTAMP NOT NULL DEFAULT NOW()
);

ALTER TABLE proveedoresproducto ADD CONSTRAINT fk_proveedor_productos_producos FOREIGN KEY(id_producto) REFERENCES productos(id);
ALTER TABLE proveedoresproducto ADD CONSTRAINT fk_proveedor_productos_proveedor FOREIGN KEY(id_proveedor) REFERENCES proveedores(id);
ALTER TABLE ventas ADD CONSTRAINT fk_ventas_cliente FOREIGN KEY(cliente_id) REFERENCES clientes(id);
ALTER TABLE ventas_detalle ADD CONSTRAINT fk_ventas_detalle_venta FOREIGN KEY(venta_id) REFERENCES ventas(id);
ALTER TABLE ventas_detalle ADD CONSTRAINT fk_ventas_detalle_producto FOREIGN KEY(producto_id) REFERENCES productos(id);
ALTER TABLE historial_precios ADD CONSTRAINT fk_historial_precios_producto FOREIGN KEY(producto_id) REFERENCES productos(id);
ALTER TABLE audioria_ventas ADD CONSTRAINT fk_auditoria_ventas FOREIGN KEY(venta_id) REFERENCES ventas(id);
ALTER TABLE alertas_stock ADD CONSTRAINT fk_alertas_stock FOREIGN KEY(producto_id) REFERENCES productos(id);
