# PRÁCTICA 3

# Ejercicio 1
use agencia_personal;
SELECT DISTINCT
    c.nro_contrato,
    c.fecha_incorporacion,
    c.fecha_finalizacion_contrato,
    (ADDDATE(c.fecha_solicitud,
        INTERVAL 30 DAY)) AS 'Fecha Caducidad'
FROM
    contratos c
WHERE
    c.fecha_caducidad IS NULL
;

# Ejercicio 2
use agencia_personal;
SELECT DISTINCT
    c.nro_contrato,
    e.razon_social,
    p.apellido,
    p.nombre,
    c.fecha_incorporacion,
    IFNULL(c.fecha_caducidad, 'Contrato vigente')
FROM
    contratos c
        INNER JOIN
    personas p ON c.dni = p.dni
        INNER JOIN
    empresas e ON c.cuit = e.cuit
;

# Ejercicio 3
use agencia_personal;
SELECT DISTINCT
    *,
    DATEDIFF(c.fecha_finalizacion_contrato,
            c.fecha_caducidad)
FROM
    contratos c
WHERE
    c.fecha_caducidad < c.fecha_finalizacion_contrato
;

# Ejercicio 4
use agencia_personal;
SELECT DISTINCT
    e.cuit,
    e.razon_social,
    e.direccion,
    c.anio_contrato,
    c.mes_contrato,
    c.importe_comision,
    ADDDATE(CURDATE(), INTERVAL 2 MONTH)
FROM
    comisiones c
        INNER JOIN
    contratos cont ON c.nro_contrato = cont.nro_contrato
        INNER JOIN
    empresas e ON cont.cuit = e.cuit
WHERE
    c.fecha_pago IS NULL
ORDER BY e.razon_social DESC
;

# Ejercicio 5
use agencia_personal;
select distinct concat(p.apellido, ', ', p.nombre) as 'Apellido, Nombre', p.fecha_nacimiento, 
day(p.fecha_nacimiento) as 'Día', month(p.fecha_nacimiento) as 'Mes', year(p.fecha_nacimiento) as 'Año' from personas p
;