# PRÁCTICA N8

# Ejercicio 1
use afatse;
start transaction;

insert into instructores(cuil, nombre, apellido, tel, email, direccion, cuil_supervisor)
values ('44-44444444-4', 'Daniel', 'Tapia', '444-444444', 'dotapia@gmail.com', 'Ayacucho 4444', null)
;

SELECT 
    *
FROM
    instructores

commit;

# Ejercicio 2
use afatse;
start transaction;

insert into plan_capacitacion(nom_plan, desc_plan, hs, modalidad)
values ('Administrador de BD', 'Instalacion y configuración MySQL. Lenguaje SQL. Usuarios y permisos.', 300, 'Presencial');

insert into plan_temas(nom_plan, titulo, detalle)
values ('Administrador de BD', '1- Instalación MySQL.', 'Distintas configuraciones de instalación.'),
		('Administrador de BD', '2- Configuración DBMS.', 'Variables de entorno, su uso y configuración.'),
		('Administrador de BD', '3- Lenguaje SQL.', 'DML, DDL y TCL.'),
        ('Administrador de BD', '4- Usuarios y permisos.', 'Permisos de usuarios y DCL.')
;

insert into examenes(nom_plan, nro_examen)
values ('Administrador de BD', 1),
		('Administrador de BD', 2),
        ('Administrador de BD', 3),
        ('Administrador de BD', 4)
;

insert into examenes_temas(nom_plan, titulo, nro_examen)
values ('Administrador de BD', '1- Instalación MySQL.', 1),
		('Administrador de BD', '2- Configuración DBMS.', 2),
        ('Administrador de BD', '3- Lenguaje SQL.', 3),
        ('Administrador de BD', '4- Usuarios y permisos.', 4)
;

insert into materiales(cod_material, desc_material, url_descarga, autores, tamanio, fecha_creacion)
values ('AP-010', 'DBA en MySQL', 'www.afatse.com.ar/apuntes?AP=010', 'José Román', 2, '20090301'),
		('AP-011', 'SQL en MySQL', 'www.afatse.com.ar/apuntes?AP=011', 'Juan López', 3, '20090401')
;

insert into materiales_plan(nom_plan, cod_material, cant_entrega)
values ('Administrador de BD', 'AP-010', 0),
		('Administrador de BD', 'AP-011', 0),
        ('Administrador de BD', 'UT-001', 0),
        ('Administrador de BD', 'UT-002', 0),
        ('Administrador de BD', 'UT-003', 0),
        ('Administrador de BD', 'UT-004', 0)
;

insert into valores_plan (nom_plan, fecha_desde_plan, valor_plan)
values ('Administrador de BD', '20090201', 150)
;

rollback;

# Ejercicio 3
use afatse;

start transaction;

-- CTE
drop temporary table if exists cursosPres;
create temporary table cursosPres as
select c.nro_curso from cursos c
inner join plan_capacitacion pc on c.nom_plan = pc.nom_plan
where pc.modalidad like '%Presencial%' or pc.modalidad like '%Semipresencial%'
;

/*
update cursos c
set c.cupo = round(c.cupo * 1.5)
where c.nro_curso in (select * from cursosPres) and c.cupo < 20
;

update cursos c
set c.cupo = round(c.cupo * 1.25)
where c.nro_curso in (select * from cursosPres) and c.cupo >= 20
;
*/
-- Hacer tabla temporal de cursos de menor a 20 y mayor a 20 para que en el where del update quede la PK
UPDATE cursos c
        INNER JOIN
    cursosPres cp ON cp.nro_curso = c.nro_curso 
SET 
    c.cupo = ROUND(c.cupo * 1.5)
WHERE
    c.cupo < 20
        AND c.nro_curso = cp.nro_curso
;

UPDATE cursos c
        INNER JOIN
    cursosPres cp ON cp.nro_curso = c.nro_curso 
SET 
    c.cupo = ROUND(c.cupo * 1.25)
WHERE
    c.cupo >= 20
        AND c.nro_curso = cp.nro_curso
;

use afatse;
SELECT 
    c.nom_plan, c.salon, c.cupo, pc.modalidad
FROM
    cursos c
        INNER JOIN
    plan_capacitacion pc ON c.nom_plan = pc.nom_plan;

ROLLBACK;

# Ejercicio 4 y 5
use afatse;
start transaction;

SELECT 
    cuil
INTO @cuilHA FROM
    instructores
WHERE
    nombre LIKE '%Henri%'
        AND apellido LIKE '%Amiel%'
;

SELECT 
    cuil
INTO @cuilFK FROM
    instructores
WHERE
    nombre LIKE '%Franz%'
        AND apellido LIKE '%Kafka%'
;

SELECT 
    cuil
INTO @cuilDT FROM
    instructores
WHERE
    nombre LIKE '%Daniel%'
        AND apellido LIKE '%Tapia%'
;

UPDATE instructores 
SET 
    cuil_supervisor = @cuilDT
WHERE
    cuil IN (@cuilFK , @cuilHA)
;

select * from instructores
rollback;

# Ejercicio 6
use afatse;
start transaction;

SELECT 
    dni
INTO @dniVH FROM
    alumnos
WHERE
    nombre LIKE '%Victor%'
        AND apellido LIKE '%Hugo%'
;

update alumnos 
	set tel = '3232323',
		direccion = 'Italia 2323'
where dni = @dniVH
;

select * from alumnos;
rollback;

# Ejercicio 7
use afatse;
start transaction;

DELETE FROM plan_capacitacion 
WHERE
    nom_plan = '%Administrador de BD%';
DELETE FROM materiales_plan 
WHERE
    nom_plan = 'Administrador de BD';
DELETE FROM examenes_temas 
WHERE
    nom_plan = 'Administrador de BD';
DELETE FROM examenes 
WHERE
    nom_plan = 'Administrador de BD';
DELETE FROM plan_temas 
WHERE
    nom_plan = 'Administrador de BD';
DELETE FROM plan_capacitacion 
WHERE
    nom_plan = 'Administrador de BD';

rollback;

# Ejercicio 8
use afatse;

-- Para ver si se estan usando en algun plan.
SELECT 
    *
FROM
    `materiales_plan`
WHERE
    cod_material IN ('AP-008' , 'AP-009')
;

start transaction;

DELETE FROM materiales 
WHERE
    cod_material = 'AP-008'
    OR cod_material = 'AP-009';
# delete from materiales_plan where cod_material = 'AP-010' or cod_material = 'AP-011';

rollback;

# Ejercicio 9
use afatse;

-- Verificar si esta en cursos_instructores o evaluaciones;

SELECT 
    cuil
INTO @cuilDT FROM
    instructores
WHERE
    nombre LIKE '%Daniel%'
        AND apellido LIKE '%Tapia%';

SELECT 
    *
FROM
    cursos_instructores
WHERE
    cuil = @cuilDT
;

SELECT 
    *
FROM
    evaluaciones
WHERE
    cuil = @cuilDT
;

start transaction;

UPDATE instructores 
SET 
    cuil = NULL
WHERE
    cuil_supervisor = @cuilDT;

DELETE FROM instructores 
WHERE
    cuil = @cuilDT;

rollback;

# Ejercicio 10
use afatse;
start transaction;

DELETE FROM inscripciones 
WHERE
    nom_plan = 'Marketing 3'
    AND nro_curso = 1;

rollback;

# Ejercicio 11 y 12
use afatse;
start transaction;

SELECT 
    cuil
INTO @cuilEY FROM
    instructores
WHERE
    nombre LIKE '%Elias%'
        AND apellido LIKE '%Yanes%';

DELETE FROM instructores 
WHERE
    cuil_supervisor = @cuilEY
;

rollback;

# Ejercicio 13
use afatse;
start transaction;

drop temporary table if exists apuntesEdF;
create temporary table if not exists apuntesEdF as
select cod_material from materiales
where cod_material like 'AP-%' and autores like '%Erica de Forifregoro%'
;

DELETE FROM materiales_plan 
WHERE
    cod_material IN (SELECT 
        cod_material
    FROM
        apuntesEdF);

DELETE FROM materiales 
WHERE
    cod_material IN (SELECT 
        cod_material
    FROM
        apuntesEdF)
;

rollback;