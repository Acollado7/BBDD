CREATE DATABASE IF NOT EXISTS `tienda` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `tienda`;

-- Tabla de Productos
CREATE TABLE `productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` TEXT,
  `precio` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Tabla de Categorías
CREATE TABLE `categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Tabla de Relación entre Productos y Categorías (Relación uno a muchos)
CREATE TABLE `producto_categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_producto` INT NOT NULL,
  `id_categoria` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_producto_categoria_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  CONSTRAINT `fk_producto_categoria_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`)
);

-- Tabla de Proveedores
CREATE TABLE `proveedores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(200),
  `telefono` VARCHAR(20),
  PRIMARY KEY (`id`)
);

-- Tabla de Relación entre Productos y Proveedores (Relación uno a uno)
CREATE TABLE `producto_proveedor` (
  `id_producto` INT NOT NULL,
  `id_proveedor` INT NOT NULL,
  PRIMARY KEY (`id_producto`),
  CONSTRAINT `fk_producto_proveedor_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  CONSTRAINT `fk_producto_proveedor_proveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id`)
);

-- Inserciones en la tabla `productos`
INSERT INTO `productos` (`nombre`, `descripcion`, `precio`) VALUES
('Teléfono móvil', 'Teléfono inteligente con pantalla táctil', 499.99),
('Portátil', 'Ordenador portátil con procesador i7 y 8GB de RAM', 1299.99),
('Smart TV', 'Televisor de alta definición con conexión a internet', 899.99),
('Tablet', 'Tableta con pantalla de 10 pulgadas y sistema operativo Android', 299.99),
('Cámara digital', 'Cámara compacta de 20 megapíxeles', 199.99),
('Auriculares inalámbricos', 'Auriculares con tecnología Bluetooth', 99.99),
('Altavoz Bluetooth', 'Altavoz portátil con sonido estéreo', 79.99),
('Consola de videojuegos', 'Consola de última generación con capacidad de reproducción en 4K', 499.99),
('Impresora multifunción', 'Impresora que también funciona como escáner y copiadora', 149.99),
('Monitor de computadora', 'Monitor de 27 pulgadas con resolución Full HD', 249.99);

-- Inserciones en la tabla `categorias`
INSERT INTO `categorias` (`nombre`) VALUES
('Teléfonos móviles'),
('Ordenadores'),
('Televisores'),
('Tablets'),
('Cámaras'),
('Accesorios'),
('Electrodomésticos');

-- Inserciones en la tabla `producto_categoria`
INSERT INTO `producto_categoria` (`id_producto`, `id_categoria`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 6),
(8, 6),
(9, 7),
(10, 2);

-- Inserciones en la tabla `proveedores`
INSERT INTO `proveedores` (`nombre`, `direccion`, `telefono`) VALUES
('Juan', 'Calle Principal 123, Ciudad', '1234567890'),
('Pepe', 'Avenida Central 456, Ciudad', '0987654321'),
('Pablo', 'Calle Secundaria 789, Ciudad', '5678901234'),
('Nacho', 'Avenida Principal 456, Ciudad', '4321098765'),
('Alberto', 'Calle Central 789, Ciudad', '6543210987'),
('Mario', 'Avenida Secundaria 123, Ciudad', '7890123456'),
('Belen', 'Calle Principal 456, Ciudad', '2109876543'),
('Laura', 'Avenida Central 789, Ciudad', '5432109876'),
('Cristina', 'Calle Secundaria 123, Ciudad', '8765432109'),
('Marta', 'Avenida Principal 789, Ciudad', '3210987654');

-- Inserciones en la tabla `producto_proveedor`
INSERT INTO `producto_proveedor` (`id_producto`, `id_proveedor`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);
