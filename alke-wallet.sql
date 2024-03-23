CREATE SCHEMA IF NOT EXISTS `alke_wallet` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci ;
USE `alke_wallet`;

CREATE TABLE IF NOT EXISTS usuarios (
user_id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45) NOT NULL,
correo_electronico VARCHAR(45) NOT NULL UNIQUE,
contrasegna VARCHAR(8) NOT NULL,
saldo DECIMAL(10,2) NOT NULL,
fecha_creacion TIMESTAMP
);

CREATE TABLE IF NOT EXISTS monedas (
currency_id INT AUTO_INCREMENT PRIMARY KEY,
currency_name VARCHAR(45) NOT NULL,
currency_symbol VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS transacciones (
transaction_id INT AUTO_INCREMENT PRIMARY KEY,
sender_user_id INT,
receiver_user_id INT,
currency_id INT,
importe DECIMAL(10, 2) NOT NULL,
transaction_date TIMESTAMP,
FOREIGN KEY (sender_user_id) REFERENCES usuarios(user_id) ON DELETE CASCADE,
FOREIGN KEY (receiver_user_id) REFERENCES usuarios(user_id) ON DELETE CASCADE,
FOREIGN KEY (currency_id) REFERENCES monedas(currency_id) ON DELETE CASCADE
);

INSERT INTO usuarios (nombre, correo_electronico,contrasegna,saldo) VALUES 
('Gilbert Lagos','gilbertLagos@gmail.com','12345678', 150.000),
('Clarivel Jeldres', 'cjeldres@gmail.com', '87654321', 250.000),
('Juan Oh', 'joh@gmail.com', '12341234', 300.000),
('Elena Poblete', 'epoblete@gmail.com', '22225555', 250.000),
('Benjamin Rojas', 'brojas@gmail.com', '11223344', 120000),
('Gabriel Atencio', 'gatencio@hotmail.com', '12341234', 200.000);


INSERT INTO monedas (currency_name, currency_symbol) VALUES
('Peso chileno', 'CLP$'),
('Dólar estadounidense', 'US$'),
('Euro', '€'),
('Libra esterlina', '£');

INSERT INTO transacciones (sender_user_id, receiver_user_id, currency_id, importe, transaction_date) VALUES
(1, 4, 4, 50.000, CURRENT_TIMESTAMP),
(2, 5, 2, 60.000, CURRENT_TIMESTAMP),
(3, 6, 1, 25.000, CURRENT_TIMESTAMP),
(4, 3, 3, 15.000, CURRENT_TIMESTAMP),
(5, 1, 2, 10.000, CURRENT_TIMESTAMP),
(6, 2, 4, 20.000, CURRENT_TIMESTAMP);

SELECT * FROM transacciones;
SELECT * FROM monedas;
SELECT * FROM usuarios;

-- Consulta para obtener el nombre de la moneda elegida por un usuario específico
SELECT nombre AS usuario, currency_name AS moneda FROM usuarios
INNER JOIN transacciones t ON t.sender_user_id = usuarios.user_id
INNER JOIN monedas m ON m.currency_id = t.currency_id 
WHERE user_id = 4;

-- Consulta para obtener todas las transacciones registradas
SELECT t.transaction_id,
       u1.nombre AS emisor,
       u2.nombre AS receptor,
       m.currency_name AS moneda,
       t.importe AS monto,
       t.transaction_date AS fecha
FROM transacciones t
INNER JOIN usuarios u1 ON t.sender_user_id = u1.user_id
INNER JOIN usuarios u2 ON t.receiver_user_id = u2.user_id
INNER JOIN monedas m ON t.currency_id = m.currency_id;

-- Consulta para obtener todas las transacciones realizadas por un usuario específico
SELECT t.transaction_id,
       u1.nombre AS emisor,
       u2.nombre AS receptor,
       m.currency_name AS moneda,
       t.importe AS monto,
       t.transaction_date AS fecha
FROM transacciones t
INNER JOIN usuarios u1 ON t.sender_user_id = u1.user_id
INNER JOIN usuarios u2 ON t.receiver_user_id = u2.user_id
INNER JOIN monedas m ON t.currency_id = m.currency_id
WHERE t.sender_user_id = 3;

-- Sentencia DML para modificar el campo correo electrónico de un usuario específico
UPDATE usuarios
SET correo_electronico = 'glagos@hotmail.com'
WHERE user_id = 1;

-- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa)
DELETE FROM transacciones
WHERE transaction_id = 6;

