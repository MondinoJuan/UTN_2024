# PRÁCTICA N5

# Ejercicio 1
use agencia_personal;
SELECT DISTINCT
    p.dni, p.apellido, p.nombre
FROM
    personas p
        INNER JOIN
    contratos c ON p.dni = c.dni
WHERE
    c.cuit IN (SELECT 
            con.cuit
        FROM
            contratos con
                INNER JOIN
            personas per ON con.dni = per.dni
        WHERE
            per.apellido LIKE '%Lopez%'
                AND per.nombre LIKE '%Stefania%')
;

# Ejercicio 2
use agencia_personal;
SELECT 
    p.dni,
    CONCAT(p.nombre, ' ', p.apellido) AS 'Nombre Apellido',
    c.sueldo
FROM
    personas p
        INNER JOIN
    contratos c ON p.dni = c.dni
WHERE
    c.sueldo < (SELECT 
            MAX(con.sueldo)
        FROM
            contratos con
                INNER JOIN
            empresas emp ON con.cuit = emp.cuit
        WHERE
            emp.razon_social LIKE '%Viejos Amigos%')
;

# Ejercicio 3
use agencia_personal;
delimiter //
drop function if exists promImpCom_unaEmp//
create function promImpCom_unaEmp(razonSoc varchar(120))
returns decimal(10,2)
reads sql data
begin
	declare vProm decimal(10,2);
    
SELECT 
    AVG(comi.importe_comision)
INTO vProm FROM
    comisiones comi
        INNER JOIN
    contratos con ON comi.nro_contrato = con.nro_contrato
        INNER JOIN
    empresas emp ON con.cuit = emp.cuit
WHERE
    emp.razon_social LIKE CONCAT('%', razonSoc, '%');
    return vProm;
end; //

SELECT 
    e.cuit, e.razon_social, AVG(com.importe_comision)
FROM
    empresas e
        INNER JOIN
    contratos c ON e.cuit = c.cuit
        INNER JOIN
    comisiones com ON c.nro_contrato = com.nro_contrato
GROUP BY e.cuit
HAVING AVG(com.importe_comision) > PROMIMPCOM_UNAEMP('Traigame eso');

# Ejercicio 4
use agencia_personal;
SELECT 
    e.razon_social,
    p.nombre,
    p.apellido,
    com.nro_contrato,
    com.mes_contrato,
    com.anio_contrato,
    com.importe_comision
FROM
    comisiones com
        INNER JOIN
    contratos c ON com.nro_contrato = c.nro_contrato
        INNER JOIN
    empresas e ON c.cuit = e.cuit
        INNER JOIN
    personas p ON c.dni = p.dni
WHERE
    com.fecha_pago IS NOT NULL
        AND com.importe_comision < (SELECT 
            AVG(comi.importe_comision)
        FROM
            comisiones comi)
;

# Ejercicio 5
use agencia_personal;
SELECT 
    e.razon_social, AVG(com.importe_comision) AS 'Promedio'
FROM
    comisiones com
        INNER JOIN
    contratos c ON c.nro_contrato = com.nro_contrato
        INNER JOIN
    empresas e ON c.cuit = e.cuit
GROUP BY e.cuit , e.razon_social
HAVING AVG(com.importe_comision) = (SELECT 
        MAX(prom)
    FROM
        (SELECT 
            AVG(com2.importe_comision) AS prom
        FROM
            contratos c2
        JOIN comisiones com2 ON com2.nro_contrato = c2.nro_contrato
        GROUP BY c2.cuit) t);
        

# Ejercicio 6
use agencia_personal;
SELECT 
    p.apellido, p.nombre
FROM
    personas p
WHERE
    p.dni NOT IN (SELECT 
            per.dni
        FROM
            personas per
                INNER JOIN
            personas_titulos pt ON per.dni = pt.dni
                INNER JOIN
            titulos t ON pt.cod_titulo = t.cod_titulo
        WHERE
            t.tipo_titulo LIKE '%Educacion no formal%'
                OR t.tipo_titulo LIKE '%Terciario%')
;

# Ejercicio 7
use agencia_personal;
with prome as (
select cuit, avg(sueldo) Promedio from contratos
group by cuit
);
SELECT 
    c.cuit, c.dni, c.sueldo, Promedio
FROM
    contratos c
        INNER JOIN
    prome p ON c.cuit = p.cuit
WHERE
    c.sueldo > Promedio
;

# Ejercicio 8
use agencia_personal;
SELECT 
    e.razon_social, AVG(com.importe_comision) AS 'Promedio'
FROM
    comisiones com
        INNER JOIN
    contratos c ON c.nro_contrato = com.nro_contrato
        INNER JOIN
    empresas e ON c.cuit = e.cuit
GROUP BY e.cuit , e.razon_social
HAVING AVG(com.importe_comision) = (SELECT 
        MAX(prom)
    FROM
        (SELECT 
            AVG(com2.importe_comision) AS prom
        FROM
            contratos c2
        JOIN comisiones com2 ON com2.nro_contrato = c2.nro_contrato
        GROUP BY c2.cuit) t)
    OR AVG(com.importe_comision) = (SELECT 
        MIN(prom)
    FROM
        (SELECT 
            AVG(com2.importe_comision) AS prom
        FROM
            contratos c2
        JOIN comisiones com2 ON com2.nro_contrato = c2.nro_contrato
        GROUP BY c2.cuit) t)
ORDER BY AVG(com.importe_comision) DESC
;

# Ejercicio 9
use afatse;

SELECT 
    COUNT(*)
INTO @cant FROM
    alumnos al
        INNER JOIN
    inscripciones i ON i.dni = al.dni
WHERE
    al.nombre LIKE '%Antoine de%'
        AND al.apellido LIKE '%Saint-Exupery%'
GROUP BY al.dni
;

SELECT 
    a.dni,
    a.nombre,
    a.apellido,
    a.direccion,
    a.email,
    a.tel,
    COUNT(*),
    (COUNT(*) - @cant)
FROM
    alumnos a
        INNER JOIN
    inscripciones i ON i.dni = a.dni
GROUP BY a.dni
HAVING COUNT(*) > @cant
;

# Ejercicio 10
use afatse;

SELECT 
    COUNT(*)
INTO @total FROM
    inscripciones i
WHERE
    YEAR(i.fecha_inscripcion) = 2014;

SELECT 
    pc.nom_plan,
    COUNT(*),
    ((COUNT(*) / @total) * 100) AS '% Total'
FROM
    inscripciones i
        INNER JOIN
    plan_capacitacion pc ON i.nom_plan = pc.nom_plan
WHERE
    YEAR(i.fecha_inscripcion) = 2014
GROUP BY pc.nom_plan
;

# Ejercicio 11
use afatse;
SELECT 
    vp.nom_plan, vp.fecha_desde_plan, vp.valor_plan
FROM
    valores_plan vp
GROUP BY vp.nom_plan , vp.fecha_desde_plan , vp.valor_plan
HAVING (vp.nom_plan , vp.fecha_desde_plan) IN (SELECT 
        nom_plan, MAX(fecha_desde_plan) AS max_fecha
    FROM
        valores_plan
    GROUP BY nom_plan)
;

# Ejercicio 12
use afatse;
drop temporary table if exists valoresActuales;
create temporary table valoresActuales as    
SELECT 
    vp.nom_plan, vp.fecha_desde_plan, vp.valor_plan
FROM
    valores_plan vp
GROUP BY vp.nom_plan , vp.fecha_desde_plan , vp.valor_plan
HAVING (vp.nom_plan , vp.fecha_desde_plan) IN (SELECT 
        nom_plan, MAX(fecha_desde_plan) AS max_fecha
    FROM
        valores_plan
    GROUP BY nom_plan)
;

SELECT DISTINCT
    pc.nom_plan,
    pc.desc_plan,
    pc.hs,
    pc.modalidad,
    vp.valor_plan
FROM
    plan_capacitacion pc
        INNER JOIN
    valores_plan vp ON pc.nom_plan = vp.nom_plan
WHERE
    vp.valor_plan = (SELECT 
            MIN(valor_plan)
        FROM
            valoresActuales);

drop temporary table if exists valoresActuales;

# Ejercicio 13
use afatse;
drop temporary table if exists instMark2015;
create temporary table instMark2015 as    
SELECT 
    ins.cuil
FROM
    instructores ins
inner join cursos_instructores ci on ins.cuil = ci.cuil
inner join cursos c on ci.nro_curso = c.nro_curso
inner join plan_capacitacion pc on c.nom_plan = pc.nom_plan
where (year(c.fecha_ini) = 2015 or year(c.fecha_fin) = 2015) and pc.nom_plan like '%Marketing 1%'
;

SELECT 
    ins.cuil
FROM
    instructores ins
        INNER JOIN
    cursos_instructores ci ON ins.cuil = ci.cuil
        INNER JOIN
    cursos c ON ci.nro_curso = c.nro_curso
        INNER JOIN
    plan_capacitacion pc ON c.nom_plan = pc.nom_plan
WHERE
    (YEAR(c.fecha_ini) = 2014
        OR YEAR(c.fecha_fin) = 2014)
        AND pc.nom_plan LIKE '%Marketing 1%'
        AND ins.cuil NOT IN (SELECT 
            cuil
        FROM
            instMark2015)
;

drop temporary table if exists instMark2015;

# Ejercicio 14
use afatse;
SELECT 
    *
FROM
    alumnos a
WHERE
    a.dni NOT IN (SELECT 
            c.dni
        FROM
            cuotas c
        WHERE
            c.fecha_pago IS NULL)
;

# Ejercicio 15
use afatse;
-- CTE
with promedioCursos as (
select e.nro_curso, avg(e.nota) prom from evaluaciones e
group by e.nro_curso
)

SELECT 
    a.dni,
    CONCAT(a.nombre, ' ', a.apellido) AS 'Nombre',
    AVG(e.nota),
    pc.prom
FROM
    alumnos a
        INNER JOIN
    evaluaciones e ON a.dni = e.dni
        INNER JOIN
    promedioCursos pc ON e.nro_curso = pc.nro_curso
GROUP BY a.dni , a.nombre , a.apellido , e.nro_curso
HAVING AVG(e.nota) > pc.prom
ORDER BY Nombre ASC
;

# Ejercicio 16
use afatse;
SELECT 
    c.nro_curso,
    c.fecha_ini,
    c.salon,
    c.cupo,
    COUNT(DISTINCT i.dni),
    (c.cupo - COUNT(DISTINCT i.dni))
FROM
    cursos c
        INNER JOIN
    inscripciones i ON c.nro_curso = i.nro_curso
        AND c.nom_plan = i.nom_plan
WHERE
    c.fecha_ini > '20140401'
GROUP BY c.nro_curso , c.fecha_ini , c.salon , c.cupo
HAVING ((((c.cupo - COUNT(DISTINCT i.dni)) / c.cupo) * 100) > 80)
;

# Ejercicio 17
use afatse;
drop temporary table if exists fechaActual;
create temporary table fechaActual as
select vp.nom_plan, max(vp.fecha_desde_plan) as fechaMax from valores_plan vp
group by vp.nom_plan
;

drop temporary table if exists valorActual;
create temporary table valorActual as
select vpl.nom_plan, fa.fechaMax, vpl.valor_plan as valorActual from valores_plan vpl
inner join fechaActual fa on vpl.nom_plan = fa.nom_plan and vpl.fecha_desde_plan = fa.fechaMax
;

drop temporary table if exists fechaAnterior;
create temporary table fechaAnterior as
select vp.nom_plan, max(vp.fecha_desde_plan) as fechaAnt from plan_capacitacion p 
left join valores_plan vp on p.nom_plan = vp.nom_plan and vp.fecha_desde_plan not in (
select fechaMax from fechaActual
where nom_plan = vp.nom_plan
)
group by vp.nom_plan
;

drop temporary table if exists valorAnterior;
create temporary table valorAnterior as
select vpl.nom_plan, fa.fechaAnt as maxFechaAnt, coalesce(vpl.valor_plan, 0) as valorAnterior from valores_plan vpl
right join fechaAnterior fa on vpl.nom_plan = fa.nom_plan and vpl.fecha_desde_plan = fa.fechaAnt
;

select va.nom_plan, va.fechaMax, va.valorActual, vant.maxFechaAnt, coalesce(vant.valorAnterior, 0), (va.valorActual - vant.valorAnterior) from valorAnterior vant
right join valorActual va on va.nom_plan = vant.nom_plan
;

drop temporary table if exists valorActual;
drop temporary table if exists fechaAnterior;
drop temporary table if exists fechaActual;
drop temporary table if exists valorAnterior;





