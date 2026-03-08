# PRÁCTICA N9

# Ejercicio 1
use afatse;
start transaction;

drop temporary table if exists valoresFechaMax;
create temporary table valoresFechaMax as
select nom_plan, max(fecha_desde_plan) from valores_plan
group by nom_plan
;

insert into valores_plan(nom_plan, fecha_desde_plan, valor_plan)
select vp.nom_plan, '20090601', vp.valor_plan * 1.20 from valores_plan vp
where (vp.nom_plan, vp.fecha_desde_plan) in (select * from valoresPlanAntesJunio)
;

SELECT 
    *
FROM
    valores_plan
WHERE
    fecha_desde_plan = '20090601';

rollback;

# Ejercicio 2
use afatse;
start transaction;

drop temporary table if exists valoresFechaMax;
create temporary table valoresFechaMax as
select nom_plan, max(fecha_desde_plan) fechaMax from valores_plan
group by nom_plan
;

insert into valores_plan(nom_plan, fecha_desde_plan, valor_plan)
select vp.nom_plan, '20090801', vp.valor_plan * 1.12 from valores_plan vp
inner join valoresFechaMax vfm on vp.nom_plan = vfm.nom_plan and vp.fecha_desde_plan = vfm.fechaMax
where vp.valor_plan >= 90
;

insert into valores_plan(nom_plan, fecha_desde_plan, valor_plan)
select vp.nom_plan, '20090801', vp.valor_plan * 1.20 from valores_plan vp
inner join valoresFechaMax vfm on vp.nom_plan = vfm.nom_plan and vp.fecha_desde_plan = vfm.fechaMax
where vp.valor_plan < 90
;

SELECT 
    *
FROM
    valores_plan
WHERE
    fecha_desde_plan = '20090801';

rollback;

# Ejercicio 3
use afatse;
start transaction;

insert into plan_capacitacion(nom_plan, desc_plan, hs, modalidad)
	select 'Marketing 1 Presencial', desc_plan, hs, 'presencial' from plan_capacitacion
	where nom_plan = 'Marketing 1'
	;

insert into plan_temas(nom_plan, titulo, detalle)
	select 'Marketing 1 Presencial', titulo, detalle from plan_temas
	where nom_plan = 'Marketing 1'
	;

insert into materiales_plan(nom_plan, cod_material, cant_entrega)
	select 'Marketing 1 Presencial', cod_material, cant_entrega from materiales_plan
	where nom_plan = 'Marketing 1'
	;
    
insert into examenes(nom_plan, nro_examen)
	select 'Marketing 1 Presencial', nro_examen from examenes
	where nom_plan = 'Marketing 1'
	;
    
insert into examenes_temas(nom_plan, titulo, nro_examen)
	select 'Marketing 1 Presencial', titulo, nro_examen from examenes_temas
	where nom_plan = 'Marketing 1'
	;

insert into valores_plan(nom_plan, fecha_desde_plan, valores_plan)
	select 'Marketing 1 Presencial', fecha_desde_plan, valores_plan * 1.5 from valores_plan
	where nom_plan = 'Marketing 1' and year(fecha_desde_plan) = 2015
	;

rollback;

# Ejercicio 4
use afatse;

start transaction;

SELECT 
    ins.cuil
INTO @cuilFK FROM
    instructores ins
WHERE
    ins.nombre LIKE 'Franz'
        AND ins.apellido LIKE 'Kafka';

drop temporary table if exists insRepAv;
create temporary table insRepAv as
select i.cuil from instructores i
inner join cursos_instructores ci on i.cuil = ci.cuil
inner join cursos c on ci.nro_curso = c.nro_curso and ci.nom_plan = c.nom_plan
where c.nom_plan like '%Reparac PC Avanzada%' and (year(c.fecha_ini) = 2015 and year(c.fecha_fin) = 2015)
;

UPDATE instructores i 
SET 
    i.cuil_supervisor = @cuilFK
WHERE
    i.cuil IN (SELECT 
            iav.cuil
        FROM
            insRepAv iav);

SELECT 
    i.*
FROM
    instructores i
        INNER JOIN
    insRepAv ira ON i.cuil = ira.cuil;

rollback;

# Ejercicio 5
use afatse;
start transaction;

SELECT 
    ins.cuil
INTO @cuilFK FROM
    instructores ins
WHERE
    ins.nombre LIKE 'Franz'
        AND ins.apellido LIKE 'Kafka';

drop temporary table if exists cursDictFK;
create temporary table cursDictFK as
select ci.nom_plan, ci.nro_curso from cursos_instructores ci
inner join cursos c on ci.nom_plan = c.nom_plan and ci.nro_curso = c.nro_curso
inner join cursos_horarios ch on ci.nom_plan = ch.nom_plan and ci.nro_curso = ch.nro_curso
where ch.hora_inicio = '160000' and (year(c.fecha_ini) = 2015 and year(c.fecha_fin) = 2015) and ci.cuil = @cuilFK
;

UPDATE cursos_horarios ch
        INNER JOIN
    cursDictFK cdfk ON cdfk.nom_plan = ch.nom_plan
        AND cdfk.nro_curso = ch.nro_curso 
SET 
    ch.hora_inicio = SUBTIME(ch.hora_inicio, 010000);

rollback;

# Ejercicio 6
use afatse;
start transaction;

drop temporary table if exists evalPromMenor5;
create temporary table if not exists evalPromMenor5 as
select nro_examen, nom_plan from evaluaciones
group by nro_examen, nom_plan
having avg(nota) < 5.5
;

DELETE FROM evaluaciones 
WHERE
    (nro_examen , nom_plan) IN (SELECT 
        nro_examen, nom_plan
    FROM
        evalPromMenor5);

DELETE FROM examenes_temas 
WHERE
    (nro_examen , nom_plan) IN (SELECT 
        nro_examen, nom_plan
    FROM
        evalPromMenor5);

DELETE FROM examenes 
WHERE
    (nro_examen , nom_plan) IN (SELECT 
        nro_examen, nom_plan
    FROM
        evalPromMenor5);

rollback;

# Ejercicio 7
use afatse;
start transaction;

drop table if exists cuotasImpagas;
CREATE TABLE IF NOT EXISTS cuotasImpagas AS SELECT dni FROM
    cuotas
WHERE
    fecha_pago IS NULL AND anio = 2014;

DELETE i FROM inscripciones i 
WHERE
    YEAR(i.fecha_inscripcion) = 2015
    AND dni IN (SELECT 
        dni
    FROM
        cuotasImpagas);

rollback;










