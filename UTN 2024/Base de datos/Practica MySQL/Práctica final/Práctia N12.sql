# PRÁCTICA N12

# Ejercicio 2
use afatse;
start transaction;

insert into alumnos(dni, nombre, apellido, tel, email, direccion)
values (42840150, 'juan cruz', 'mondino', 3364592427, 'juancm.2000@hotmail.com', 'Montevideo 1255')
;

insert into inscripciones(nom_plan, nro_curso, dni, fecha_inscripcion)
values ('Marketing 3', 1, 42840150, curdate())
;

rollback;

# Ejercicio 3, 6, 7 y 11
use afatse;
start transaction;

delete from alumnos
where dni = 42840150;

delete from inscripciones
where dni = 42840150;

rollback;

# Ejercicio 4 y 5
start transaction;

insert into alumnos(dni, nombre, apellido, tel, email, direccion)
	value(42840150, 'juan cruz', 'mondino', 9876543, 'juancm.2000@hotmail.com', 'pellegrini 2341');

insert into instrucciones(nom_plan, nro_curso, dni, fecha_inscripcion)
	value('Maketing 3', 1, 42840150, curdate());

rollback;


# Ejercicio 9 y 10
USE afatse;

START TRANSACTION;

INSERT INTO alumnos(dni, nombre, apellido, tel, email, direccion)
VALUES (42840150, 'Juan Cruz', 'Mondino', '3364592427', 'juancm.2000@hotmail.com', 'Montevideo 1255');

SAVEPOINT alumno;

INSERT INTO inscripciones(nom_plan, nro_curso, dni, fecha_inscripcion)
VALUES ('Marketing 3', 1, 42840150, CURDATE());

-- e) Desde la misma conexión
SELECT *
FROM alumnos
WHERE dni = 42840150;

SELECT *
FROM inscripciones
WHERE dni = 42840150;

-- g)
ROLLBACK TO alumno;

-- h) Desde la misma conexión
SELECT *
FROM alumnos
WHERE dni = 42840150;

SELECT *
FROM inscripciones
WHERE dni = 42840150;

rollback;

# Ejercicio 12 y 13
/*
Hace rollback a toda la transaccion en vez de a un savepoint.
*/