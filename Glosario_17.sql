-- Comando para crear una base de datos
CREATE DATABASE Ejercicio1_17;

-- Seleccionar la base de datos
USE Ejercicio1_17;

CREATE TABLE Nacionalidades (
    nacionalidad_id INT AUTO_INCREMENT, -- INT es tipo numerico AUTO_INCREMENT se encarga de autoincrementar los ids 
    nombre_nacionalidad VARCHAR(255) NOT NULL,
    PRIMARY KEY (nacionalidad_id)
);

-- Insertar algunos valores de ejemplo en Nacionalidades
INSERT INTO Nacionalidades (nombre_nacionalidad) 
VALUES 
    ('Española'),
    ('Argentina'),
    ('Mexicana'),
    ('Francesa'),
    ('Italiana');
    
    /* 
		CRUD
		C - CREATE
		R - READ 
		U - UPDATE
		D -DELETE 
    */
    
-- Crear la tabla Usuarios con más columnas
CREATE TABLE Usuarios (
    usuario_id INT AUTO_INCREMENT,
    nombre_usuario VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    fecha_nacimiento DATE,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    estado_activacion BOOLEAN DEFAULT TRUE, 
    nacionalidad_id INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY (usuario_id),
    FOREIGN KEY (nacionalidad_id) REFERENCES Nacionalidades(nacionalidad_id)
);

-- Insertar algunos valores de ejemplo en Usuarios
INSERT INTO Usuarios (nombre_usuario, email, fecha_nacimiento, direccion, telefono, estado_activacion, nacionalidad_id) 
VALUES 
    ('Juan Pérez', 'juan.perez@example.com', '1990-05-15', 'Calle Falsa 123, Madrid', null , TRUE, 1),
    ('Carlos García', 'carlos.garcia@example.com', '1985-08-22', 'Avenida Libertador 456, Buenos Aires', '222333444', TRUE, 2),
    ('María Rodríguez', 'maria.rodriguez@example.com', '1992-12-30', 'Calle 10 de Julio 789, Ciudad de México', '333444555', TRUE, 3),
    ('Sophie Dupont', 'sophie.dupont@example.com', '1988-07-10', 'Rue de Paris 22, París', '666888555', FALSE, 4),
    ('Luca Bianchi', 'luca.bianchi@example.com', '1995-03-25', 'Via Roma 101, Roma', '888999555', TRUE, 5);
    
-- SELECT : Especifica qué columa mostrar, si queremos obtener todas las columnas usamos * 
-- FROM: Indica la tabla de la que queremos obtener los datos
-- WHERE: Filtrar los resultados según condición
SELECT * FROM Usuarios WHERE nombre_usuario = 'Juan Pérez';

/*
 CONDICIONALES
	= -> Igual a 
	!= -> Diferente a
	> -> Mayor que
	< -> Menor que
	<= -> Menor o igual
	>= -> Mayor o igual
*/

SELECT * FROM Usuarios WHERE telefono IS NULL;

/*
	IS NOT NULL -> Para obtener los valores que no son NULL
    IS NULL -> Para obtener los valores que son NULL
*/

SELECT * FROM Usuarios WHERE telefono IS NOT NULL;


/*
	LIKE 'Juan%' -> Que empieza por Juan
    LIKE '%Juan' -> Que terminar por Juan
    LIKE '%Juan%' -> Que contiene Juan 
*/

SELECT * FROM Usuarios WHERE nombre_usuario LIKE 'Juan%';


-- Obtened el nombre del usuario que su dirección contiene 'Buenos Aires';
SELECT nombre_usuario FROM Usuarios WHERE direccion LIKE '%Buenos Aires%';

/*
	AND -> Debe de cumplirse las N condiciones 
    0R -> Debe de cumplirse UNA de las N condiciones
*/

-- AS  -> ALIAS
SELECT nombre_usuario AS nombre 
FROM Usuarios 
WHERE nombre_usuario LIKE 'Juan%' OR direccion LIKE '%Buenos Aires%';

/*
	CONCAT -> Concatenar Strings 
*/

SELECT CONCAT(nombre_usuario, ' ' , email) AS nombre_email FROM Usuarios;


-- Obtened la dirección y el telefono concatenados de los usuarios que tienen telefono;
SELECT CONCAT(direccion, ' ' , telefono) AS direccion_telefono 
FROM Usuarios 
WHERE telefono IS NOT NULL;


-- IF
SELECT nombre_usuario,
IF(estado_activacion = 1, 'ACTIVO' , 'NO ACTIVO') AS estado
FROM Usuarios;


/*
	DAY(fecha) -> Para obtener el día de X fecha
    MONTH(fecha) -> Para obtener el mes de X fecha
    YEAR(fecha) -> Para obtener el año de X fecha
*/

SELECT fecha_nacimiento, 
DAY(fecha_nacimiento) AS dia, 
MONTH(fecha_nacimiento) as mes, 
YEAR(fecha_nacimiento) as año
FROM Usuarios;

/*
	COUNT -> Contar los registros devolver
*/

SELECT count(*) as cantidad
FROM Usuarios 
WHERE telefono IS NOT NULL;

-- Obtener la cantidad de usuarios que no tienen telefono O (= A OR) direccion contenga 'Paris';
SELECT COUNT(*) AS cantidad_usuarios FROM Usuarios WHERE telefono IS NULL OR direccion LIKE '%Paris%';