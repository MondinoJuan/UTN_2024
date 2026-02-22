# PRÁCTICA N7

# Ejercicio 1
use afatse;
drop view if exists vw_instructores;
CREATE VIEW vw_instructores AS
    SELECT 
        CONCAT(i.nombre, ' ', i.apellido) AS 'Nombre y Apellido',
        i.tel,
        i.email
    FROM
        instructores i
    ORDER BY i.tel;

SELECT 
    *
FROM
    vw_instructores;

drop view if exists vw_instructores;

# Ejercicio 2
use afatse;
drop view if exists vw_cursos2015;
CREATE VIEW vw_cursos2015 AS
    SELECT 
        c.nom_plan,
        pc.desc_plan,
        c.nro_curso,
        c.fecha_ini,
        c.fecha_fin,
        c.salon,
        c.cupo,
        COUNT(i.dni) AS 'Cant alumnos'
    FROM
        cursos c
            INNER JOIN
        plan_capacitacion pc ON c.nom_plan = pc.nom_plan
            INNER JOIN
        inscripciones i ON c.nom_plan = i.nom_plan
            AND c.nro_curso = i.nro_curso
    WHERE
        YEAR(c.fecha_ini) = 2015
            OR YEAR(c.fecha_fin) = 2015
    GROUP BY c.nom_plan , pc.desc_plan , c.nro_curso , c.fecha_ini , c.fecha_fin , c.salon , c.cupo
;
/*
SELECT 
    *
FROM
    vw_cursos2015;
*/
# drop view if exists vw_cursos2015;

# Ejercicio 3
use afatse;

drop view if exists vw_fechaActual;
CREATE VIEW vw_fechaActual AS
select vp.nom_plan, max(vp.fecha_desde_plan) as fechaActual from valores_plan vp
group by vp.nom_plan
;

drop view if exists vw_valorActual;
CREATE VIEW vw_valorActual AS
select vp.nom_plan, vp.fecha_desde_plan, vp.valor_plan from valores_plan vp
inner join vw_fechaActual vwfa on vp.nom_plan = vwfa.nom_plan and vp.fecha_desde_plan = vwfa.fechaActual
;

select *, vwva.valor_plan from vw_cursos2015 vwc
inner join vw_valorActual vwva on vwc.nom_plan = vwva.nom_plan 
;


drop view if exists vw_fechaActual;
drop view if exists vw_cursos2015;
drop view if exists vw_valorActual;

# Ejercicio 4
use afatse;
drop view if exists alumnosInscripciones;
CREATE VIEW alumnosInscripciones AS
select concat(a.nombre, ' ', a.apellido) as nombreCompleto, i.nom_plan, i.nro_curso, a.dni from alumnos a
inner join inscripciones i on a.dni = i.dni
;

drop view if exists cuotasImpagas;
CREATE VIEW cuotasImpagas AS
select c.dni/*, c.nom_plan, c.nro_curso*/, count(*) as cantImp from cuotas c
where c.fecha_pago is null
group by c.dni#, c.nom_plan, c.nro_curso 
;

drop view if exists promediosAlumno;
CREATE VIEW promediosAlumno AS
select e.dni, e.nom_plan, e.nro_curso, avg(e.nota) as promNota from evaluaciones e
inner join inscripciones i on i.dni = e.dni and i.nom_plan = e.nom_plan and i.nro_curso = e.nro_curso
group by e.dni, e.nom_plan, e.nro_curso
;

select ai.nombreCompleto, ai.nom_plan, ai.nro_curso, pa.promNota, ci.cantImp from alumnosInscripciones ai
inner join promediosAlumno pa on ai.dni = pa.dni and ai.nom_plan = pa.nom_plan and ai.nro_curso = pa.nro_curso
left join cuotasImpagas ci on ai.dni = ci.dni# and ai.nom_plan = ci.nom_plan and ai.nro_curso = ci.nro_curso
;

drop view if exists alumnosInscripciones;
drop view if exists cuotasImpagas;
drop view if exists promediosAlumno;

