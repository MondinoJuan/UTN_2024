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
    SELECT 
        CONCAT(a.nombre, ' ', a.apellido) AS nombreCompleto,
        i.nom_plan,
        i.nro_curso,
        a.dni
    FROM
        alumnos a
            INNER JOIN
        inscripciones i ON a.dni = i.dni
;

drop view if exists cuotasImpagas;
CREATE VIEW cuotasImpagas AS
    SELECT 
        c.dni, COUNT(*) AS cantImp
    FROM
        cuotas c
    WHERE
        c.fecha_pago IS NULL
    GROUP BY c.dni
;

drop view if exists promediosAlumno;
CREATE VIEW promediosAlumno AS
    SELECT 
        e.dni, e.nom_plan, e.nro_curso, AVG(e.nota) AS promNota
    FROM
        evaluaciones e
            INNER JOIN
        inscripciones i ON i.dni = e.dni
            AND i.nom_plan = e.nom_plan
            AND i.nro_curso = e.nro_curso
    GROUP BY e.dni , e.nom_plan , e.nro_curso
;

SELECT 
    ai.nombreCompleto,
    ai.nom_plan,
    ai.nro_curso,
    pa.promNota,
    ci.cantImp
FROM
    alumnosInscripciones ai
        INNER JOIN
    promediosAlumno pa ON ai.dni = pa.dni
        AND ai.nom_plan = pa.nom_plan
        AND ai.nro_curso = pa.nro_curso
        LEFT JOIN
    cuotasImpagas ci ON ai.dni = ci.dni
ORDER BY pa.promNota
;

drop view if exists alumnosInscripciones;
drop view if exists cuotasImpagas;
drop view if exists promediosAlumno;

# Ejercicio 5
use afatse;

drop view if exists vw_utiles;
create view vw_utiles as
select cod_material, desc_material, cant_disponible, punto_pedido, cantidad_a_pedir from materiales
where cod_material like '%UT%'
;

drop view if exists vw_apuntes;
create view vw_apuntes as
select cod_material, desc_material, url_descarga, autores, tamanio, fecha_creacion from materiales
where cod_material like '%AP%'
;

select pm.cuit, p.razon_social, p.direccion, p.telefono, pm.cod_material, vwu.desc_material, vwu.cant_disponible, 
vwu.punto_pedido, vwu.cantidad_a_pedir from proveedores_materiales pm
inner join proveedores p on pm.cuit = p.cuit
inner join vw_utiles vwu on pm.cod_material = vwu.cod_material
order by pm.cuit
;

select c.nom_plan, c.nro_curso, c.fecha_ini, c.fecha_fin, c.salon, c.cupo, vwa.* from cursos c
inner join materiales_plan mp on c.nom_plan = mp.nom_plan
inner join vw_apuntes vwa on mp.cod_material = vwa.cod_material
where year(c.fecha_ini) = 2015 or year(c.fecha_fin) = 2015
;