# PRÁCTICA 2

# Ejercicio 1
use agencia_personal;
SELECT 
    c.dni, p.apellido, p.nombre, c.sueldo
FROM
    contratos AS c
        INNER JOIN
    personas AS p ON c.dni = p.dni
WHERE
    nro_contrato = 5
;

# Ejercicio 2
use agencia_personal;
SELECT 
    c.dni,
    c.nro_contrato,
    c.fecha_incorporacion,
    c.fecha_solicitud,
    IFNULL(c.fecha_caducidad, 'Sin Fecha')
FROM
    contratos AS c
        INNER JOIN
    empresas AS e ON e.cuit = c.cuit
WHERE
    e.razon_social LIKE 'viejos amigos'
        OR e.razon_social LIKE 'traigame eso'
ORDER BY c.fecha_incorporacion ASC , e.razon_social DESC
;

# Ejercicio 3
use agencia_personal;
SELECT 
    e.razon_social,
    e.direccion,
    e.e_mail,
    c.desc_cargo,
    se.anios_experiencia
FROM
    solicitudes_empresas AS se
        INNER JOIN
    empresas AS e ON e.cuit = se.cuit
        INNER JOIN
    cargos AS c ON c.cod_cargo = se.cod_cargo
ORDER BY se.fecha_solicitud ASC , c.desc_cargo ASC
;

# Ejercicio 4
use agencia_personal;
SELECT 
    p.dni, p.nombre, p.apellido, t.desc_titulo
FROM
    personas_titulos pt
        INNER JOIN
    personas p ON pt.dni = p.dni
        INNER JOIN
    titulos t ON pt.cod_titulo = t.cod_titulo
WHERE
    t.tipo_titulo LIKE '%Educacion no formal%'
        OR t.desc_titulo LIKE '%Bachiller%'
;

# Ejercicio 5
use agencia_personal;
SELECT 
    p.nombre, p.apellido, t.desc_titulo
FROM
    personas_titulos pt
        INNER JOIN
    personas p ON pt.dni = p.dni
        INNER JOIN
    titulos t ON pt.cod_titulo = t.cod_titulo
;

# Ejercicio 6
use agencia_personal;
SELECT 
    CONCAT(p.apellido,
            ',',
            p.nombre,
            ' tiene como referencia a ',
            IFNULL(a.persona_contacto, 'nadie'),
            ' y cuando trabajo en ',
            e.razon_social)
FROM
    antecedentes a
        INNER JOIN
    empresas e ON a.cuit = e.cuit
        INNER JOIN
    personas p ON a.dni = p.dni
WHERE
    a.persona_contacto IS NULL
        OR a.persona_contacto IN ('Armando Esteban Quito' , 'Felipe Rojas')
;

# Ejercicio 7
use agencia_personal;
SELECT 
    e.razon_social,
    se.fecha_solicitud,
    c.desc_cargo,
    IFNULL(se.edad_minima, 'sin especificar'),
    IFNULL(se.edad_maxima, 'sin especificar')
FROM
    empresas e
        INNER JOIN
    solicitudes_empresas se ON e.cuit = se.cuit
        INNER JOIN
    cargos c ON se.cod_cargo = c.cod_cargo
WHERE
    e.razon_social LIKE '%Viejos Amigos%'
;

# Ejercicio 8
use agencia_personal;
SELECT DISTINCT
    CONCAT(p.nombre, ' ', p.apellido), c.desc_cargo
FROM
    personas p
        INNER JOIN
    antecedentes a ON p.dni = a.dni
        INNER JOIN
    cargos c ON a.cod_cargo = c.cod_cargo
;

# Ejercicio 9
use agencia_personal;
SELECT DISTINCT
    emp.razon_social AS 'Empresa',
    c.desc_cargo AS 'Cargo',
    ev.desc_evaluacion AS 'Desc Evaluacion',
    ee.resultado AS 'Resultado'
FROM
    empresas emp
        INNER JOIN
    entrevistas e ON emp.cuit = e.cuit
        INNER JOIN
    entrevistas_evaluaciones ee ON e.nro_entrevista = ee.nro_entrevista
        INNER JOIN
    evaluaciones ev ON ee.cod_evaluacion = ev.cod_evaluacion
        INNER JOIN
    cargos c ON e.cod_cargo = c.cod_cargo
ORDER BY emp.razon_social ASC , c.desc_cargo DESC
;

# Ejercicio 10
use agencia_personal;
SELECT DISTINCT
    e.cuit AS 'cuit',
    e.razon_social,
    IFNULL(se.fecha_solicitud, 'Sin solicitudes'),
    IFNULL(c.desc_cargo, 'Sin solicitudes')
FROM
    empresas e
        LEFT JOIN
    solicitudes_empresas se ON e.cuit = se.cuit
        LEFT JOIN
    cargos c ON se.cod_cargo = c.cod_cargo
;

# Ejercicio 11
use agencia_personal;
SELECT DISTINCT
    se.cuit,
    e.razon_social,
    c.desc_cargo,
    IFNULL(p.dni, 'sin contrato') AS DNI,
    IFNULL(p.nombre, 'sin contrato') AS Nombre,
    IFNULL(p.apellido, 'sin contrato') as Apellido
FROM
    solicitudes_empresas se
        INNER JOIN
    empresas e ON se.cuit = e.cuit
        INNER JOIN
    cargos c ON se.cod_cargo = c.cod_cargo
        LEFT JOIN
    contratos cont ON se.cuit = cont.cuit and c.cod_cargo = cont.cod_cargo and se.fecha_solicitud = cont.fecha_solicitud	# Usar todas las claves primarias de las entidades
        LEFT JOIN
    personas p ON cont.dni = p.dni
;

# Ejercicio 12
use agencia_personal;
SELECT DISTINCT
    e.cuit, e.razon_social, c.desc_cargo
FROM
    solicitudes_empresas se
        INNER JOIN
    empresas e ON se.cuit = e.cuit
        INNER JOIN
    cargos c ON se.cod_cargo = c.cod_cargo
        LEFT JOIN
    contratos cont ON se.cuit = cont.cuit
        AND c.cod_cargo = cont.cod_cargo
        AND se.fecha_solicitud = cont.fecha_solicitud
WHERE
    cont.nro_contrato IS NULL
;

# Ejercicio 13
use agencia_personal;
SELECT DISTINCT
    c.desc_cargo, p.dni, p.apellido, e.razon_social
FROM
    cargos c
        LEFT JOIN
    antecedentes a ON c.cod_cargo = a.cod_cargo
        LEFT JOIN
    personas p ON a.dni = p.dni
        LEFT JOIN
    empresas e ON a.cuit = e.cuit
;

# Ejercicio 14
use afatse;
SELECT DISTINCT
    i.cuil AS Cuil_instructor,
    i.nombre AS 'Nombre Instructor',
    i.apellido AS 'Apellido Instructor',
    ins.cuil AS 'CUIL Sup',
    ins.nombre,
    ins.apellido
FROM
    instructores i
        INNER JOIN
    instructores ins ON i.cuil_supervisor = ins.cuil
;

# Ejercicio 15
use afatse;
SELECT DISTINCT
    i.cuil AS Cuil_instructor,
    i.nombre AS 'Nombre Instructor',
    i.apellido AS 'Apellido Instructor',
    ifnull(ins.cuil, ' '),
    ifnull(ins.nombre, ' '),
    ifnull(ins.apellido, ' ')
FROM
    instructores i
        left JOIN
    instructores ins ON i.cuil_supervisor = ins.cuil
;

# Ejercicio 16
use afatse;
SELECT 
    IFNULL(sup.cuil, ' ') AS 'CUIL Sup',
    IFNULL(sup.nombre, ' ') AS 'Nombre Sup',
    IFNULL(sup.apellido, ' ') AS 'Apellido Sup',
    ins.nombre AS 'Nombre Ins',
    ins.apellido AS 'Apellido Ins',
    ev.nom_plan,
    ev.nro_curso,
    a.nombre AS 'Nombre Alumno',
    a.apellido AS 'Apellido Alumno',
    ev.nro_examen,
    ev.fecha_evaluacion,
    ev.nota
FROM
    instructores ins
        INNER JOIN
    evaluaciones ev ON ins.cuil = ev.cuil
        INNER JOIN
    alumnos a ON ev.dni = a.dni
        LEFT JOIN
    instructores sup ON ins.cuil_supervisor = sup.cuil
WHERE
    ev.fecha_evaluacion > '2013-12-31'
        AND ev.fecha_evaluacion < '2015-01-01'
ORDER BY sup.nombre ASC , sup.apellido ASC , ev.fecha_evaluacion DESC
;





