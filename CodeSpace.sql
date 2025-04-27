CREATE DATABASE codeSpace;

USE codeSpace;

CREATE TABLE Courses (

    course_id INT AUTO_INCREMENT,

    course_name VARCHAR(100) NOT NULL,

    price DECIMAL(10, 2) NOT NULL,

    duration VARCHAR(50),

    schedule VARCHAR(50),

    difficulty VARCHAR(20),

    PRIMARY KEY (course_id)

);
 
CREATE TABLE Students (

    student_id INT AUTO_INCREMENT,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    dni VARCHAR(20) NOT NULL,

    phone VARCHAR(20),

    email VARCHAR(100),

    date_of_birth DATE,

    PRIMARY KEY (student_id)

);
 
 
CREATE TABLE Enrollments (

    enrollment_id INT AUTO_INCREMENT,

    student_id INT,

    course_id INT,

    year_enrolled INT,

    PRIMARY KEY (enrollment_id),

    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE ON UPDATE CASCADE

);
 
 
INSERT INTO Courses (course_name, price, duration, schedule, difficulty) 

VALUES 

    ('Mathematics', 99.99, '3', 'Morning', 'Intermediate'),

    ('English Grammar', 129.99, '6', 'Afternoon', 'Advanced'),

    ('Computer Science', 149.99, '4', 'Evening', 'Intermediate'),

    ('Art History', 79.99, '2', 'Morning', 'Beginner'),

    ('Physics', 119.99, '5', 'Evening', 'Advanced'),

    ('Chemistry', 109.99, '3', 'Afternoon', 'Intermediate'),

    ('Computer Science', 89.99, '4', 'Morning', 'Beginner'),

    ('Literature', 69.99, '2', 'Evening', 'Intermediate'),

    ('History', 99.99, '6', 'Morning', 'Advanced'),

    ('Cybersecurity', 119.99, '6', 'Morning', 'Advanced'),

    ('Computer Science', 79.99, '5', 'Afternoon', 'Beginner');
 
 
INSERT INTO Students (first_name, last_name, dni, phone, email, date_of_birth) 

VALUES 

    ('John', 'Doe', '123456789A', '555-1234', 'john@example.com', '1998-05-10'),

    ('Jane', 'Smith', '987654321B', '555-5678', 'jane@example.com', '2000-02-15'),

    ('Michael', 'Johnson', '456789012C', '555-2468', 'michael@example.com', '1997-09-22'),

    ('Emma', 'Brown', '789012345D', '555-1357', 'emma@example.com', '1999-11-30'),

    ('Daniel', 'Taylor', '234567890E', '555-9876', 'daniel@example.com', '2001-07-05'),

    ('Olivia', 'Lee', '345678901F', '555-5432', 'olivia@example.com', '1995-04-18'),

    ('William', 'Wilson', '678901234G', '555-7890', 'william@example.com', '1996-12-25'),

    ('Sophia', 'Anderson', '890123456H', '555-4321', 'sophia@example.com', '1994-10-31'),

    ('Matthew', 'Davis', '567890123I', '555-2109', 'matthew@example.com', '2002-08-08'),

      ('IvÃ¡n', 'Moreno Villena', '467890123I', '555-2109', 'ivan@example.com', '2002-08-08'),

    ('Isabella', 'Clark', '012345678J', '555-8765', 'isabella@example.com', '2003-03-17');
 
 
INSERT INTO Enrollments (student_id, course_id, year_enrolled) 

VALUES 

    (1, 2, 2023),

    (2, 1, 2021),

    (3, 3, 2022),

    (4, 4, 2021),

    (5, 5, 2023),

    (6, 6, 2020),

    (7, 7, 2018),

    (8, 8, 2021),

    (9, 9, 2013),

    (10, 10, 2023),

    (1, 3, 2023),

    (2, 4, 2022),

    (3, 5, 2021),

    (4, 6, 2023),

    (5, 7, 2022),

    (6, 8, 2021),

    (7, 9, 2023),

    (8, 10, 2022),

    (9, 1, 2021),

    (10, 2, 2023),

    (5, 3, 2022),

    (8, 6, 2020),

    (10, 4, 2023),

    (3, 8, 2021),

    (6, 9, 2022),

    (2, 5, 2023),

    (7, 7, 2020),

    (9, 2, 2021),

    (1, 10, 2023),

    (4, 1, 2022);

-- Obtener la cantidad de cursos que ha realizado el alumno 'Jhon';
SELECT COUNT(course_id) as cantidad
FROM Students
INNER JOIN Enrollments ON Students.student_id = Enrollments.student_id
WHERE first_name = 'John';

/* 
Obtén el nombre completo en un alias y el correo electrónico de todos los estudiantes 
que hagan un curso de turno de mañana;
*/
SELECT * FROM Enrollments
INNER JOIN Students ON Students.student_id = Enrollments.student_id
INNER JOIN Courses ON Courses.course_id = Enrollments.course_id
WHERE Courses.schedule = 'Morning';

-- Mostrar el nombre del curso y la cantidad de cursos de cada dificultad
SELECT difficulty, COUNT(course_id) as cantidad_cursos FROM Courses
GROUP BY difficulty;

-- Mostrar los cursos en orden ascendente segun su precio
SELECT price as precio_ascendente 
FROM Courses
ORDER BY precio_ascendente ASC;

-- Obten el precio medio (sin decimales) concatenando con el simbolo "$" de todos los cursos

SELECT CONCAT(ROUND(AVG(price), '$')) AS precio_medio_formateado
FROM Courses;

-- Obtener el nombre del curso y su precio que se hayan matriculado en 2022 y tengan horario de mañana

SELECT course_name, price
FROM Courses
INNER JOIN Enrollments ON Enrollments.course_id = Courses.course_id
WHERE year_enrolled = 2022 & schedule = 'Morning';

-- Obtener el numero de inscripciones por año ordenado por el año de manera descendente

SELECT year_enrolled, COUNT(*) AS num_inscrip
FROM Enrollments 
GROUP BY year_enrolled
ORDER BY year_enrolled DESC;

-- Encuentra el numero total de estudiantes matriculados en cada curso ordenados de mayor a menor

SELECT Courses.course_name, COUNT(*) as total_estudiantes
FROM Enrollments 
INNER JOIN Courses ON Courses.course_id = Enrollments.course_id
GROUP BY Enrollments.enrollment_id
ORDER BY total_estudiantes ASC;

-- Obtener el nombre y apellidos de los estudiantes que se han matriculado en algun curso de nivel "Advanced"(El Where debe actuar en la vista)

CREATE VIEW enrollment_Advanced AS
SELECT first_name, last_name, difficulty
FROM Enrollments
INNER JOIN Courses ON Courses.course_id = Enrollments.enrollment_id
INNER JOIN Students ON Enrollments.enrollment_id = Students.student_id;

SELECT first_name, last_name FROM enrollment_Advanced 
WHERE difficulty = 'Advanced'

 -- Crear una funcion de suma
DELIMITER //
CREATE FUNCTION suma(a INT, b INT)
RETURNS INT
deterministic
BEGIN
  RETURN a + b;
END;
//
DELIMITER ;
 
 -- Ejecutarr la funcion que hemos creado
SELECT suma(5,5) AS suma;


-- TIMESTAMPDIFF(YEAR, fecha_1 , fecha_2)
-- TIMESTAMPDIFF(MONTH, fecha_1 , fecha_2)
-- TIMESTAMPDIFF(DAY, fecha_1 , fecha_2)
-- CURDATE() nos devuelve la fecha actual en formato año-mes-fecha
-- SELECT CURDATE();
 
DELIMITER //
CREATE FUNCTION calcular_edad(fecha_nacimiento DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE edad INT;
    SET edad = TIMESTAMPDIFF(YEAR, fecha_nacimiento , CURDATE());
    RETURN edad;
END //
DELIMITER ;

SELECT first_name, last_name, dni, calcular_edad(date_of_birth) as edad FROM Students WHERE calcular_edad(date_of_birth) = 30;


ALTER TABLE Students ADD COLUMN age INT NULL;

DELIMITER //

CREATE PROCEDURE add_student(

    IN p_first_name VARCHAR(50), 

    IN p_last_name VARCHAR(50), 

    IN P_dni VARCHAR(50), 

    IN p_phone VARCHAR(50), 

    IN p_email VARCHAR(50), 

    IN p_date_of_birth DATE

)

DETERMINISTIC

BEGIN

    INSERT INTO Students (first_name, last_name, dni, phone, email, date_of_birth, age) 

    VALUES 

    (p_first_name, p_last_name, P_dni, p_phone, p_email, p_date_of_birth, calcular_edad(date_of_birth));

END //

DELIMITER ;

CALL add_student('Iván 2', 'Moreno 2', '5374293D','644333222','ivanmoren@gmail.com', '1994-10-12');

SELECT * FROM Students;
 
DELIMITER //

CREATE PROCEDURE update_age()

DETERMINISTIC

BEGIN

    UPDATE Students

    SET age = calcular_edad(date_of_birth)

    WHERE age IS NULL;

END //

DELIMITER ;

SET SQL_SAFE_UPDATES = 0;

CALL update_age();

-- FORMATEO DE FECHAS
-- %d    Día con 2 dígitos    01 a 31
-- %m    Mes numérico (2 dígitos)    01 a 12
-- %M    Nombre completo del mes    enero, abril
-- %Y    Año con 4 dígitos    2025
-- %y    Año con 2 dígitos    25
 
SELECT DATE_FORMAT(date_of_birth, '%d %M %Y') FROM Students;


-- Crear una funcion que me devuelva la fecha en dia mes(letras) y año concatenando con la edad

DELIMITER //
CREATE FUNCTION format_date_with_age(date_of_birth DATE)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE format_date VARCHAR(100);
    DECLARE age INT;
    SET age = calcular_edad(date_of_birth);
    SET format_date = CONCAT(DATE_FORMAT(date_of_birth, '%d %m %Y'),  ' ------ ' , calcular_edad(date_of_birth));
    RETURN format_date;
END //
DELIMITER ;
 
 
SELECT COUNT(date_of_birth) FROM Students;

-- precio + (precio * iva / 100);
 
-- Crear una función donde le pasemos el precio del curso y nos sume X cantidad de IVA. CALCULAR IVA -> precio + (precio * iva / 100);

DELIMITER //
CREATE FUNCTION calculate_course_iva(price_course INT, iva INT)
RETURNS INT
DETERMINISTIC
BEGIN
    SET calculate_iva = price_course + (price_course * iva/100);
    
    RETURN calculate_iva;
END //
DELIMITER ;

SELECT calculate_course_iva(10, 2) FROM Courses;