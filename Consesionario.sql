CREATE DATABASE Concesionario;
 
USE Concesionario;

CREATE TABLE Marca (

    idMarca INT AUTO_INCREMENT,

    nombre VARCHAR(100) NOT NULL,

    descripcion VARCHAR(200) NOT NULL,

    PRIMARY KEY(idMarca)

);
 
CREATE TABLE Modelo (

    idModelo INT AUTO_INCREMENT,

    nombre VARCHAR(100) NOT NULL,

    descripcion VARCHAR(200) NOT NULL,

    PRIMARY KEY(idModelo)

);
 
CREATE TABLE Coche (

    idCoche INT AUTO_INCREMENT,

    Color VARCHAR(100) NOT NULL,

    Precio DECIMAL(10, 2) NOT NULL,

    Estado VARCHAR(50),

    idMarca INT,

    idModelo INT,

    PRIMARY KEY (idCoche),

    FOREIGN KEY (idMarca) REFERENCES Marca(idMarca) ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo) ON DELETE CASCADE ON UPDATE CASCADE

);
 
CREATE TABLE Clientes (

    idCliente INT AUTO_INCREMENT,

    nombre VARCHAR(100) NOT NULL,

    apellidos VARCHAR(200) NOT NULL,

    email VARCHAR(200) NOT NULL,

    dni VARCHAR(200) NOT NULL,

    PRIMARY KEY(idCliente)

);
 
CREATE TABLE Empleados (

    idEmpleados INT AUTO_INCREMENT,

    nombre VARCHAR(100) NOT NULL,

    apellidos VARCHAR(200) NOT NULL,

    rol VARCHAR(200) NOT NULL,

    PRIMARY KEY(idEmpleados)

);
 
 
CREATE TABLE Ventas (

    idVentas INT AUTO_INCREMENT,

    Fecha DATE NOT NULL,

    idCoche INT,

    idCliente INT,

    idEmpleados INT,

    PRIMARY KEY (idVentas),

    FOREIGN KEY (idCoche) REFERENCES Coche(idCoche) ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente) ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (idEmpleados) REFERENCES Empleados(idEmpleados) ON DELETE CASCADE ON UPDATE CASCADE

);


INSERT INTO Marca (nombre, descripcion) VALUES

('Honda', 'Fabricante japonés conocido por su fiabilidad y vehículos económicos'),

('Audi', 'Marca alemana de automóviles de lujo y alto rendimiento'),

('Mercedes-Benz', 'Fabricante alemán conocido por sus coches de lujo y tecnología avanzada'),

('Chevrolet', 'Fabricante estadounidense con una amplia gama de vehículos desde autos compactos hasta camionetas'),

('Nissan', 'Marca japonesa conocida por sus modelos accesibles y de buena calidad');
 
INSERT INTO Modelo (nombre, descripcion) VALUES

('Civic', 'Modelo compacto de Honda, conocido por su eficiencia de combustible'),

('A4', 'Sedán de lujo de Audi, con alto rendimiento y confort'),

('Clase C', 'Modelo de sedán compacto de lujo de Mercedes-Benz'),

('Cruze', 'Modelo de sedan económico de Chevrolet'),

('Altima', 'Sedán mediano de Nissan, con una buena relación calidad-precio');
 
INSERT INTO Coche (Color, Precio, Estado, idMarca, idModelo) VALUES

('Rojo', 40000.00, 'Nuevo', 4, 4),

('Blanco', 20000.00, 'Nuevo', 4, 4),

('Plata', 30000.00, 'Usado', 5, 5),  

('Verde', 22000.00, 'Nuevo', 1, 1),

('Gris', 35000.00, 'Usado', 2, 2),  

('Azul', 50000.00, 'Nuevo', 3, 3);
 
INSERT INTO Clientes (nombre, apellidos, email, dni) VALUES

('Lucía', 'Ramírez', 'lucia.ramirez@example.com', '45678901D'),

('Pedro', 'Torres', 'pedro.torres@example.com', '56789012E'),

('Laura', 'Jiménez', 'laura.jimenez@example.com', '67890123F'),

('Miguel', 'Fernández', 'miguel.fernandez@example.com', '78901234G'),

('Pepe', 'Fernández', 'pepe.fernandez@example.com', '78901234G'),

('Sofia', 'Mora', 'sofia.mora@example.com', '89012345H');
 
 
INSERT INTO Empleados (nombre, apellidos, rol) VALUES

('Antonio', 'González', 'Vendedor'),

('Elena', 'Pérez', 'Vendedora'),

('Juan Carlos', 'Serrano', 'Director de ventas'),

('Raúl', 'Vázquez', 'Vendedor'),

('Raúl', 'Vázquez', 'Vendedor'),

('Iván', 'Moreno', 'Vendedor'),

('María', 'López', 'Vendedora');
 
INSERT INTO Ventas (Fecha, idCoche, idCliente, idEmpleados) VALUES

('2025-04-04', 4, 4, 1),  

('2025-04-05', 5, 5, 2),  

('2025-04-06', 1, 3, 3),  

('2025-04-07', 2, 2, 4),  

('2025-04-08', 3, 1, 5);

-- Obtener la Marca y el color de los coches
SELECT Marca.nombre, Coche.color 
FROM Coche
INNER JOIN Marca  ON Coche.idMarca = Marca.idMarca;

-- Obtener el modelo y el precio de los coches
SELECT Coche.idModelo, Coche.precio 
FROM Coche
INNER JOIN Modelo  ON Coche.idModelo = Modelo.idModelo;

-- Obtener el modelo y el precio de los coches
SELECT Marca.nombre, Modelo.Nombre, Coche.color
FROM Coche
INNER JOIN Modelo ON Coche.idModelo = Modelo.idModelo
INNER JOIN Marca ON Coche.idMarca = Marca.idMarca
WHERE precio > 22000;

-- Obtener todas las ventas con datos del cliente y del coche
SELECT *
FROM Ventas
INNER JOIN Coche ON Ventas.idCoche = Coche.idCoche
INNER JOIN Clientes ON Ventas.idCliente = Clientes.idCliente;

-- Mostrar coches vendidos con su marca y modelo
SELECT Coche.idMarca, Coche.idModelo
FROM Ventas
RIGHT JOIN Coche ON Ventas.idCoche = Coche.idCoche;

-- Mostrar los clientes que no han comprado coches
SELECT Clientes.*
FROM Ventas
RIGHT JOIN Clientes ON Ventas.idCliente = Clientes.idCliente
WHERE Ventas.idVentas IS NULL;

