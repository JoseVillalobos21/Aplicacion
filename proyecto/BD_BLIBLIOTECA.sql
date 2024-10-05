CREATE TABLE AUTORES(
	--Comit 1
	CodigoAutor VARCHAR(10) NOT NULL, -- Añadido NOT NULL para asegurar que CodigoAutor no sea nulo
	NombreAutor VARCHAR(30) NOT NULL, -- Añadido NOT NULL para asegurar que NombreAutor no sea nulo
	PRIMARY KEY (CodigoAutor)
);


-- Crear vista TV_AUTORES para seleccionar todos los registros de AUTORES
CREATE VIEW TV_AUTORES AS
SELECT * FROM AUTORES;

-- Insertar autores en la tabla AUTORES
INSERT INTO AUTORES (CodigoAutor, NombreAutor)
VALUES 
	('1000', 'Luis Joyanes Aguilar'), -- Añadido espacio después de la coma para mejor legibilidad
	('2000', 'William A. Granville');

-- Crear vista TV_NombreAutor para seleccionar solo el nombre del autor de AUTORES
CREATE VIEW TV_NombreAutor AS
SELECT NombreAutor
FROM AUTORES;

-- Crear función para obtener el nombre del autor por su código
CREATE OR REPLACE FUNCTION obtener_nombre_autor(codigo VARCHAR)
RETURNS VARCHAR AS $$
DECLARE
	nombre VARCHAR(30);
BEGIN
	SELECT NombreAutor INTO nombre
	FROM AUTORES
	WHERE CodigoAutor = codigo;
	RETURN nombre;
END;
$$ LANGUAGE plpgsql;

-- Crear función para contar el número de autores
CREATE OR REPLACE FUNCTION contar_autores()
RETURNS INTEGER AS $$
DECLARE
	total INTEGER;
BEGIN
	SELECT COUNT(*) INTO total
	FROM AUTORES;
	RETURN total;
END;
$$ LANGUAGE plpgsql;

-- Crear función para actualizar el nombre del autor
CREATE OR REPLACE FUNCTION actualizar_nombre_autor(codigo VARCHAR, nuevo_nombre VARCHAR)
RETURNS VOID AS $$
BEGIN
	UPDATE AUTORES
	SET NombreAutor = nuevo_nombre
	WHERE CodigoAutor = codigo;
END;
$$ LANGUAGE plpgsql;

-- Crear función para eliminar un autor por su código
CREATE OR REPLACE FUNCTION eliminar_autor(codigo VARCHAR)
RETURNS VOID AS $$
BEGIN
	DELETE FROM AUTORES
	WHERE CodigoAutor = codigo;
END;
$$ LANGUAGE plpgsql;

-- Seleccionar todos los registros de la tabla AUTORES
SELECT * FROM AUTORES;

CREATE VIEW TV_AUTORES AS
SELECT * FROM AUTORES;

SELECT * FROM TV_AUTORES;

SELECT NombreAutor
FROM AUTORES;

CREATE VIEW TV_NombreAutor AS
SELECT NombreAutor
FROM AUTORES;

SELECT * FROM TV_NombreAutor;

SELECT CodigoAutor
FROM AUTORES;

/*Indice primario*/
CREATE INDEX idx_CodigoAutor ON AUTORES (CodigoAutor);

CREATE TABLE EDITORIALES(
IdEditorial SERIAL,
NombreEditorial VARCHAR(40)NOT NULL,
PRIMARY KEY (IdEditorial)
);

CREATE TABLE LIBROS(
CodigoLibro VARCHAR (10),
Titulo VARCHAR (100) NOT NULL,
ISBN VARCHAR (13) UNIQUE NOT NULL,
Paginas INT NOT NULL,
IdEditorial INT NOT NULL,
PRIMARY KEY (CodigoLibro),
FOREIGN KEY (IdEditorial) REFERENCES EDITORIALES (IdEditorial)
);

/*Indice unico*/
CREATE UNIQUE INDEX idx_ISBN ON LIBROS (ISBN);

/*Indice primario*/
CREATE INDEX idx_CodigoLibro ON LIBROS (CodigoLibro);

/*Indice primario*/
CREATE INDEX idx_IdEditorial ON EDITORIALES (IdEditorial);

CREATE TABLE AUTORES_ESCRIBE_LIBROS(
CodigoAutor VARCHAR (10),
CodigoLibro VARCHAR (10),
FechaCreacion DATE NOT NULL,
PRIMARY KEY (CodigoAutor, CodigoLibro),
FOREIGN KEY (CodigoAutor) REFERENCES AUTORES (CodigoAutor),
FOREIGN KEY (CodigoLibro) REFERENCES LIBROS (CodigoLibro)
);

CREATE TABLE  EJEMPLARES(
CodigoEjemplar SERIAL,
Localizacion VARCHAR (5) NOT NULL,
CodigoLibro VARCHAR (10) NOT NULL,
PRIMARY KEY (CodigoEjemplar),
FOREIGN KEY (CodigoLibro) REFERENCES LIBROS (CodigoLibro)
);

SELECT *FROM EJEMPLARES

CREATE TABLE USUARIOS(
IdUsuario SERIAL,
Nombre VARCHAR (30) NOT NULL,
ApellidoPaterno VARCHAR (30) NOT NULL,
ApellidoMaterno VARCHAR (30) NULL,
Telefono VARCHAR (10) NOT NULL,
PRIMARY KEY (IdUsuario)
);

CREATE TABLE USUARIO_PRESTAMO_EJEMPLARES (
CodigoEjemplar INT,
IdUsuario INT,
FechaPrestamo DATE NOT NULL,
FechaDevolucion DATE NOT NULL,
PRIMARY KEY (CodigoEjemplar, IdUsuario),
FOREIGN KEY (CodigoEjemplar) REFERENCES EJEMPLARES (CodigoEjemplar),
FOREIGN KEY (IdUsuario) REFERENCES USUARIOS (IdUsuario)
);

/*Crear un indice que me permita buscar los datos personales de los usuarios*/
CREATE INDEX idx_usuario ON USUARIOS (idUsuario);

/*Crear un indice que permita buscar a todos aquellos usuarios que solicitaron dos ejemplares con fecha de 07-05-2024*/
CREATE INDEX idx_FechaPrestamo ON USUARIO_PRESTAMO_EJEMPLARES (fechaPrestamo);

/*Crear un indice que permita la busqueda de un autor especifico*/
CREATE UNIQUE INDEX idx_Autor ON AUTORES (NombreAutor);

/*Crear un indice que permita buscar la localizacion de un ejemplar especifico de libro*/
CREATE INDEX idx_localizacion ON EJEMPLARES (localizacion);

/*Generar un indice que solo realice la busqueda del ISBN de un libro*/
CREATE UNIQUE INDEX idx_ISBN ON LIBROS (ISBN);

/*-------------------------------------------------*/

INSERT INTO AUTORES (CodigoAutor,NombreAutor)
VALUES  ('3000', 'Phillip Ker'),
('4000', 'Dan Brown'),
('5000', 'Alonso Ruiz Verduzco'),
('6000', 'Alberto Balcazar Flores'),
('7000', 'Quinn Kiser'),
('8000', 'Jorge Vasconcelos Santillan'),
('9000', 'Angel Pablo Hinojasa Gutierrez');

INSERT INTO EDITORIALES (NombreEditorial)
VALUES ('AlfaOmega'),
('Schaum'),
('Mc Graw Hill'),
('Limusa'),
('Iberoamericana'),
('Barkers and Jules'),
('Anaya multimedia'),
('ra-ma'),
('Ediciones ENI'),
('Trillas'),
('Altaria'),
('Marcombo');

SELECT *FROM EDITORIALES;

INSERT INTO LIBROS (CodigoLibro, Titulo, ISBN, paginas, IdEditorial)
VALUES('LIB001','Base de datos','1890909018890',456,1);

INSERT INTO LIBROS (CodigoLibro, Titulo, ISBN, paginas, IdEditorial)
VALUES('LIB002','Programacion en python','2880909018790',290,10);

INSERT INTO LIBROS (CodigoLibro, Titulo, ISBN, paginas, IdEditorial)
VALUES('LIB003','Seguridad en redes informaticas','3980909018650',160,3);

INSERT INTO LIBROS (CodigoLibro, Titulo, ISBN, paginas, IdEditorial)
VALUES('LIB004','Bussiness Inteligence','4980909018594',377,5);

INSERT INTO LIBROS (CodigoLibro, Titulo, ISBN, paginas, IdEditorial)
VALUES('LIB005','Ingenieria del software','5990909018450',1089,3);

INSERT INTO LIBROS (CodigoLibro, Titulo, ISBN, paginas, IdEditorial)
VALUES('LIB006','Electricidad II','1020909018090',181,7);

INSERT INTO LIBROS (CodigoLibro, Titulo, ISBN, paginas, IdEditorial)
VALUES('LIB007','Matematicas en la computacion','6990909018610',409,3);

INSERT INTO LIBROS (CodigoLibro, Titulo, ISBN, paginas, IdEditorial)
VALUES('LIB008','Desarrollo de aplicaciones web con HTML','9990909018999',214,8);

INSERT INTO LIBROS (CodigoLibro, Titulo, ISBN, paginas, IdEditorial)
VALUES('LIB009','Programacion en PHP','6990909018190',501,4);

INSERT INTO LIBROS (CodigoLibro, Titulo, ISBN, paginas, IdEditorial)
VALUES('LIB010','Uso de frameworks Web','1990909018199',642,7);

INSERT INTO LIBROS (CodigoLibro, Titulo, ISBN, paginas, IdEditorial)
VALUES('LIB011','Parte Back End','8990909018120',1145,1);

SELECT * FROM LIBROS;
/*Mostrar el codigo del libro ingenieria del software*/

CREATE VIEW TV_CodigoLibro AS
SELECT CodigoLibro
FROM LIBROS
WHERE Titulo='Ingenieria del software';

/*Mostrar el nombre de las editoriales cuyo codigo sea 1 y 4*/

CREATE VIEW TV_NombreEditorial1_4 AS
SELECT NombreEditorial
FROM EDITORIALES
WHERE IdEditorial IN (1,4);

SELECT * FROM TV_NombreEditorial1_4

/*Mostrar unicamente el nombre de los autores*/
CREATE VIEW TV_NombreAutores AS
SELECT NombreAutor
FROM AUTORES;

SELECT * FROM TV_NombreAutores

/*Mostrar el codigo del autor de luis joyanes Aguilar*/

CREATE VIEW TV_CodigoLuis AS
SELECT CodigoAutor
FROM AUTORES
WHERE NombreAutor='Luis Joyanes Aguilar';

SELECT * FROM TV_CodigoLuis

/*Mostrar el nombre de las editoriales en orden descendente*/

CREATE VIEW TV_EditorialDESC AS
SELECT NombreEditorial
FROM EDITORIALES
ORDER BY NombreEditorial DESC;

SELECT * FROM TV_EditorialDESC

/*Mostrar el total de registros de la tabla LIBROS*/

SELECT COUNT (*)
FROM LIBROS

/*Mostrar el nombre de los autores que empiecen con la letra A*/

SELECT NombreAutor
FROM AUTORES
WHERE NombreAutor LIKE 'A%';

/*Mostrar el nombre de los libros que pertenecen a la editorial alfaomega*/

CREATE VIEW TV_EditorialAlfa AS
SELECT l.Titulo, e.NombreEditorial
FROM EDITORIALES e CROSS JOIN LIBROS l
ON e.IdEditorial = l.IdEditorial
WHERE e.NombreEditorial = 'AlfaOmega';

/*USUARIOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOSSSSSSSSSSSSSSSSSSSSSSSSSS*/

INSERT INTO USUARIOS (Nombre, ApellidoPaterno, ApellidoMaterno, Telefono)
VALUES ('Sara', 'Garcia', 'Lopez', '2787890231');

INSERT INTO USUARIOS (Nombre, ApellidoPaterno, ApellidoMaterno, Telefono)
VALUES ('Hector Guillermo', 'Antonio', 'Espinola', '2712367890');

INSERT INTO USUARIOS (Nombre, ApellidoPaterno, ApellidoMaterno, Telefono)
VALUES ('Carlos', 'Romero', 'Dimas', '2781209876');

INSERT INTO USUARIOS (Nombre, ApellidoPaterno, ApellidoMaterno, Telefono)
VALUES ('Maria del Carmen', 'Romero', 'Perez', '2712468108');

SELECT * FROM LIBROS;

/*Mostrar la localizacion de los libros (info) donde se encuentran ubicados base de datos y Uso de frameworks*/
SELECT * FROM EJEMPLARES
INSERT INTO EJEMPLARES (localizacion, CodigoLibro)
VALUES ('info','LIB001');

INSERT INTO EJEMPLARES (localizacion, CodigoLibro)
VALUES ('info','LIB010');


SELECT l.Titulo, ej.Localizacion
FROM LIBROS l INNER JOIN EJEMPLARES ej
ON l.CodigoLibro=ej.CodigoLibro
WHERE l.Titulo='Base de datos' OR l.Titulo ='Uso de frameworks Web' ;

/*Mostrar el nombre se los usuarios cuyos apellido empiecen con le letra R*/
SELECT *FROM USUARIOS;

SELECT Nombre
FROM USUARIOS
WHERE ApellidoPaterno LIKE 'R%';

/*Mostrar todos aquellos libros junto con la editorial que pertenece, cuyo numero de paginas tengan entre 500 a 650 paginas*/
SELECT *FROM LIBROS


SELECT l.Titulo, e.NombreEditorial
FROM EDITORIALES e INNER JOIN LIBROS l
ON e.IdEditorial=l.IdEditorial
WHERE l.paginas BETWEEN 500 AND 650;

/*--------------------------------------------------------------------------------*/

INSERT INTO AUTORES_ESCRIBE_LIBROS(CodigoAutor, CodigoLibro,FechaCreacion)
VALUES (3000,'LIB001','2002-09-22');


INSERT INTO AUTORES_ESCRIBE_LIBROS(CodigoAutor, CodigoLibro,FechaCreacion)
VALUES (3000,'LIB005','2007-02-25');


INSERT INTO AUTORES_ESCRIBE_LIBROS(CodigoAutor, CodigoLibro,FechaCreacion)
VALUES (6000,'LIB005','2003-07-06');


INSERT INTO AUTORES_ESCRIBE_LIBROS(CodigoAutor, CodigoLibro,FechaCreacion)
VALUES (4000,'LIB007','1999-10-10');


INSERT INTO AUTORES_ESCRIBE_LIBROS(CodigoAutor, CodigoLibro,FechaCreacion)
VALUES (2000,'LIB002','2022-12-13');


INSERT INTO AUTORES_ESCRIBE_LIBROS(CodigoAutor, CodigoLibro,FechaCreacion)
VALUES (3000,'LIB010','2010-04-30');


INSERT INTO AUTORES_ESCRIBE_LIBROS(CodigoAutor, CodigoLibro,FechaCreacion)
VALUES (6000,'LIB011','2004-06-08');


INSERT INTO AUTORES_ESCRIBE_LIBROS(CodigoAutor, CodigoLibro,FechaCreacion)
VALUES (1000,'LIB002','2002-09-22');


INSERT INTO AUTORES_ESCRIBE_LIBROS(CodigoAutor, CodigoLibro,FechaCreacion)
VALUES (5000,'LIB010','2011-11-04');

/*----------------------------------------------------------*/

INSERT INTO EJEMPLARES(Localizacion,CodigoLibro)
VALUES ('TI','LIB004');


INSERT INTO EJEMPLARES(Localizacion,CodigoLibro)
VALUES ('TI','LIB007');


INSERT INTO EJEMPLARES(Localizacion,CodigoLibro)
VALUES ('CC','LIB005');


INSERT INTO EJEMPLARES(Localizacion,CodigoLibro)
VALUES ('ISW','LIB005');


INSERT INTO EJEMPLARES(Localizacion,CodigoLibro)
VALUES ('ARQSW','LIB011');


INSERT INTO EJEMPLARES(Localizacion,CodigoLibro)
VALUES ('MAT1','LIB006');


INSERT INTO EJEMPLARES(Localizacion,CodigoLibro)
VALUES ('COMPU','LIB007');

SELECT *FROM AUTORES_ESCRIBE_LIBROS;

/*Mostrar el nombre de los libros que fueron creados con fecha de 30 de abril del 2010*/

SELECT l.titulo
FROM LIBROS l INNER JOIN AUTORES_ESCRIBE_LIBROS ae
ON l.CodigoLibro= ae.CodigoLibro
WHERE ae.FechaCreacion='2010-04-30';

/*Mostrar a los autores que hayan escrito un libro en el año 2003*/

SELECT au.NombreAutor
FROM AUTORES au INNER JOIN AUTORES_ESCRIBE_LIBROS ae
ON au.CodigoAutor=ae.CodigoAutor
WHERE ae.FechaCreacion = '2003-07-06';

/*Mostrar todos aquellos ejemplares que se encuentran localizados en el area de TI*/

SELECT l.titulo
FROM LIBROS l INNER JOIN EJEMPLARES ej
ON l.CodigoLibro = ej.CodigoLibro
WHERE ej.localizacion = 'TI';

/*------------------------------------------------*/
INSERT INTO USUARIO_PRESTAMO_EJEMPLARES (CodigoEjemplar, IdUsuario, FechaPrestamo, FechaDevolucion)
VALUES (5,2,'2024-03-21','2024-03-28');

INSERT INTO USUARIO_PRESTAMO_EJEMPLARES (CodigoEjemplar, IdUsuario, FechaPrestamo, FechaDevolucion)
VALUES (9,2,'2024-03-21','2024-03-28');

INSERT INTO USUARIO_PRESTAMO_EJEMPLARES (CodigoEjemplar, IdUsuario, FechaPrestamo, FechaDevolucion)
VALUES (7,4,'2024-04-16','2024-04-23');

INSERT INTO USUARIO_PRESTAMO_EJEMPLARES (CodigoEjemplar, IdUsuario, FechaPrestamo, FechaDevolucion)
VALUES (8,4,'2024-04-16','2024-04-23');

INSERT INTO USUARIO_PRESTAMO_EJEMPLARES (CodigoEjemplar, IdUsuario, FechaPrestamo, FechaDevolucion)
VALUES (10,1,'2024-02-18','2024-02-20');

INSERT INTO USUARIO_PRESTAMO_EJEMPLARES (CodigoEjemplar, IdUsuario, FechaPrestamo, FechaDevolucion)
VALUES (6,3,'2023-01-09','2024-01-16');

INSERT INTO USUARIO_PRESTAMO_EJEMPLARES (CodigoEjemplar, IdUsuario, FechaPrestamo, FechaDevolucion)
VALUES (11,1,'2020-02-18','2021-02-20');

SELECT *FROM USUARIO_PRESTAMO_EJEMPLARES;

SELECT *FROM EJEMPLARES;

/*Mostrar el nombre de los usuarios cuyo codigo tenge registrado el numero 1*/
SELECT Nombre
FROM USUARIOS 
WHERE IdUsuario= 1;


SELECT *FROM USUARIOS

/*Mostrar todos aquellos usuarios que hayan solicitado un ejemplar con fecha de prestamo del 2024-04-16*/
SELECT u.nombre, u.apellidopaterno, u.apellidomaterno
FROM USUARIOS u INNER JOIN USUARIO_PRESTAMO_EJEMPLARES upe
ON u.IdUsuario = upe.IdUsuario
WHERE upe.FechaPrestamo = '2024-04-16'
GROUP BY u.nombre, u.apellidopaterno, u.apellidomaterno


/*🤣👌👍*/
SELECT *FROM EJEMPLARES

SELECT *FROM EDITORIALES

SELECT *FROM LIBROS

SELECT l.titulo,e.NombreEditorial,ej.CodigoEjemplar
FROM EDITORIALES e INNER JOIN LIBROS l
ON e.IdEditorial = l.IdEditorial
INNER JOIN EJEMPLARES ej
ON l.CodigoLibro = ej.CodigoLibro
WHERE ej.Localizacion = 'ISW';


SELECT l.titulo,e.NombreEditorial
FROM EDITORIALES e RIGHT JOIN LIBROS l
ON e.IdEditorial = l.IdEditorial;


SELECT l.titulo,e.NombreEditorial
FROM EDITORIALES e LEFT JOIN LIBROS l
ON e.IdEditorial = l.IdEditorial;

/*-------------------TRIGGERS------------------------*/

CREATE TABLE compania(
	id			SERIAL PRIMARY KEY NOT NULL,
	nombre		TEXT NOT NULL,
	created_at	TIMESTAMP,
	modified_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE log(
	id			SERIAL PRIMARY KEY NOT NULL,
	table_name	TEXT NOT NULL,
	table_id	TEXT NOT NULL,
	description	TEXT NOT NULL,
	created_at	TIMESTAMP DEFAULT NOW()
);


CREATE OR REPLACE FUNCTION add_created_at_function()
	RETURNS trigger AS $BODY$
BEGIN
	NEW.created_at := NOW();  
	RETURN NEW;
END $BODY$
LANGUAGE plpgsql;

CREATE TRIGGER add_created_at_trigger
BEFORE INSERT
ON compania
FOR EACH ROW
EXECUTE PROCEDURE add_created_at_function();

INSERT INTO compania (nombre) VALUES ('ADO Siempre primera');

INSERT INTO compania (nombre) VALUES ('Enlaces terrestres nacionales');

SELECT * FROM compania;

SELECT * FROM log;

CREATE OR REPLACE FUNCTION add_log_function()
RETURNS trigger AS $BODY$
DECLARE
vDescription TEXT;
vId INT;
vReturn RECORD;
BEGIN
	vDescription := TG_TABLE_NAME || ' ';
IF (TG_OP = 'INSERT') THEN
	vId := NEW.id;
	vDescription := vDescription || 'added. Id: ' || vId;
	vReturn := NEW;
ELSIF (TG_OP = 'UPDATE') THEN
	vId := NEW.id;
	vDescription := vDescription || 'update. Id: ' || vId;
	vReturn := NEW;
ELSIF (TG_OP = 'DELETE') THEN
	vId := OLD.id;
	vDescription := vDescription || 'delete. Id: ' || vId;
	vReturn := OLD;

END IF;

RAISE NOTICE 'TRIGER called on % - Log: %', TG_TABLE_NAME, vDescription;

INSERT INTO log
	(table_name, table_id, description, created_at)
VALUES 
	(TG_TABLE_NAME, vId, vDescription, NOW()); 

	RETURN vReturn;
END $BODY$
	LANGUAGE plpgsql;c 

CREATE TRIGGER add_log_trigger
AFTER INSERT OR UPDATE OR DELETE
ON compania
FOR EACH ROW
EXECUTE PROCEDURE add_log_function();

INSERT INTO compania (nombre) VALUES ('Autobuses unidos');
INSERT INTO compania (nombre) VALUES ('OCC comodidad que te mueve');
INSERT INTO compania (nombre) VALUES ('ADO GL');

SELECT * FROM log;

/*----------------------------------------------------*/
CREATE TABLE USUARIOS2(
	id			SERIAL PRIMARY KEY NOT NULL,
	nombreCompleto	TEXT NOT NULL,
	created_at	TIMESTAMP,
	modified_at TIMESTAMP DEFAULT NOW()
);


CREATE TRIGGER add_created_at_trigger
BEFORE INSERT
ON USUARIOS2
FOR EACH ROW
EXECUTE PROCEDURE add_created_at_function();

CREATE TRIGGER add_log_trigger
AFTER INSERT OR UPDATE OR DELETE
ON USUARIOS2
FOR EACH ROW
EXECUTE PROCEDURE add_log_function();

INSERT INTO USUARIOS2 (nombreCompleto) VALUES ('Jose Manuel Lara Villalobos');
INSERT INTO USUARIOS2 (nombreCompleto) VALUES ('Jose Angel Lopez Rivera');
INSERT INTO USUARIOS2 (nombreCompleto) VALUES ('Tadeo Carrera Rojas');

SELECT *FROM USUARIOS2

/*-----------------------------------------------*/


CREATE TABLE cambios (
timestamp_ TIMESTAMP WITH TIME ZONE default NOW(),
nombre_disparador text,
tipo_disparador text,
nivel_disparador text,
comando text
);


CREATE OR REPLACE FUNCTION grabar_operaciones() RETURNS TRIGGER AS $grabar_operaciones$
	DECLARE
	BEGIN 
	
		INSERT INTO cambios(
					nombre_disparador,
					tipo_disparador,
					nivel_disparador,
					comando)
					
					VALUES(
					TG_NAME,
					TG_WHEN,
					TG_LEVEl,
					TG_OP);
					
		RETURN NULL;
		
		END;
		
	$grabar_operaciones$ LANGUAGE plpgsql;
	
	
	CREATE TRIGGER grabar_operaciones AFTER INSERT OR UPDATE OR DELETE 
		ON USUARIOS2 FOR EACH STATEMENT
		EXECUTE PROCEDURE grabar_operaciones();

INSERT INTO USUARIOS2 (nombreCompleto) VALUES ('Tadeo Carrera Rojas');
SELECT *FROM LOG;
SELECT *FROM USUARIOS2;
SELECT *FROM CAMBIOS;

CREATE OR REPLACE FUNCTION proteger_y_rellenar_datos() RETURNS TRIGGER AS $proteger_y_rellenar_datos$
DECLARE
	BEGIN
	
	IF(TG_OP = 'DELETE') THEN
			RETURN NULL;
			
			END IF;
	END
	$proteger_y_rellenar_datos$ LANGUAGE plpgsql;
	
	
	CREATE TRIGGER proteger_y_rellenar_datos BEFORE INSERT OR UPDATE OR DELETE
	ON usuarios2 FOR EACH ROW 
	EXECUTE PROCEDURE proteger_y_rellenar_datos();
	
	DELETE FROM USUARIOS2
	WHERE id = 2;
	
	SELECT *FROM  USUARIOS2;