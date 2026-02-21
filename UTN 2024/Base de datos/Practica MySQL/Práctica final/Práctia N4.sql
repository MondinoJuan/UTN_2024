# PRÁCTICA 4

# Ejercicio 1
use agencia_personal;
SELECT DISTINCT
    e.razon_social, SUM(c.importe_comision)
FROM
    comisiones c
        INNER JOIN
    contratos cont ON c.nro_contrato = cont.nro_contrato
        INNER JOIN
    empresas e ON cont.cuit = e.cuit
WHERE
    c.fecha_pago IS NOT NULL
GROUP BY e.razon_social
HAVING e.razon_social LIKE '%Traigame eso%'
;

# Ejercicio 2
use agencia_personal;
SELECT DISTINCT
    e.razon_social, SUM(c.importe_comision)
FROM
    comisiones c
        INNER JOIN
    contratos cont ON c.nro_contrato = cont.nro_contrato
        INNER JOIN
    empresas e ON cont.cuit = e.cuit
WHERE
    c.fecha_pago IS NOT NULL
GROUP BY e.razon_social
;

# Ejercicio 3
use agencia_personal;
SELECT 
    e.nombre_entrevistador,
    ee.cod_evaluacion,
    AVG(ee.resultado) AS 'Promedio',
    STD(ee.resultado) AS 'Desvío',
    VARIANCE(ee.resultado)
FROM
    entrevistas e
        INNER JOIN
    entrevistas_evaluaciones ee ON e.nro_entrevista = ee.nro_entrevista
GROUP BY ee.cod_evaluacion , e.nombre_entrevistador
ORDER BY 'Promedio' ASC , 'Desvío' DESC
;

# Ejercicio 4
use agencia_personal;
SELECT 
    e.nombre_entrevistador,
    ee.cod_evaluacion,
    AVG(ee.resultado) AS 'Promedio',
    STD(ee.resultado) AS 'Desvío',
    VARIANCE(ee.resultado)
FROM
    entrevistas e
        INNER JOIN
    entrevistas_evaluaciones ee ON e.nro_entrevista = ee.nro_entrevista
WHERE
    e.nombre_entrevistador LIKE '%Angelica Doria%'
GROUP BY ee.cod_evaluacion , e.nombre_entrevistador
HAVING AVG(ee.resultado) > 71
ORDER BY ee.cod_evaluacion ASC
;

# Ejercicio 5
use agencia_personal;
SELECT 
    e.nombre_entrevistador, COUNT(e.nombre_entrevistador)
FROM
    entrevistas e
WHERE
    YEAR(e.fecha_entrevista) = 2014
        AND MONTH(e.fecha_entrevista) = 10
GROUP BY e.nombre_entrevistador
;

# Ejercicio 6
use agencia_personal;
SELECT 
    e.nombre_entrevistador,
    ee.cod_evaluacion,
    COUNT(e.nombre_entrevistador),
    AVG(ee.resultado) AS 'Promedio',
    STD(ee.resultado) AS 'Desvío'
FROM
    entrevistas e
        INNER JOIN
    entrevistas_evaluaciones ee ON e.nro_entrevista = ee.nro_entrevista
GROUP BY ee.cod_evaluacion , e.nombre_entrevistador
HAVING AVG(ee.resultado) > 71
ORDER BY COUNT(e.nombre_entrevistador) ASC
;

# Ejercicio 7
use agencia_personal;
SELECT 
    e.nombre_entrevistador,
    ee.cod_evaluacion,
    COUNT(e.nombre_entrevistador),
    AVG(ee.resultado) AS 'Promedio',
    STD(ee.resultado) AS 'Desvío'
FROM
    entrevistas e
        INNER JOIN
    entrevistas_evaluaciones ee ON e.nro_entrevista = ee.nro_entrevista
GROUP BY ee.cod_evaluacion , e.nombre_entrevistador
HAVING AVG(ee.resultado) > 71
    AND COUNT(e.nombre_entrevistador) > 1
ORDER BY e.nombre_entrevistador DESC , ee.cod_evaluacion ASC
;

# Ejercicio 8
use agencia_personal;
SELECT 
    c.nro_contrato,
    COUNT(*) AS 'Total',
    COUNT(com.fecha_pago) AS 'Pagas',
    (COUNT(*) - COUNT(com.fecha_pago)) AS 'A pagar'
FROM
    contratos c
        INNER JOIN
    comisiones com ON c.nro_contrato = com.nro_contrato
GROUP BY c.nro_contrato
;

# Ejercicio 9
use agencia_personal;
SELECT 
    c.nro_contrato,
    COUNT(*) AS 'Total',
    ((COUNT(com.fecha_pago) / COUNT(*)) * 100) AS 'Pagas',
    (((COUNT(*) - COUNT(com.fecha_pago)) / COUNT(*)) * 100) AS 'A pagar'
FROM
    contratos c
        INNER JOIN
    comisiones com ON c.nro_contrato = com.nro_contrato
GROUP BY c.nro_contrato
;

# Ejercicio 10
use agencia_personal;
SELECT 
    COUNT(DISTINCT se.cuit) AS 'Cantidad Distintas',
    COUNT(se.cuit) - COUNT(DISTINCT se.cuit) AS 'Diferencia',
    COUNT(se.cuit) AS 'Total'
FROM
    solicitudes_empresas se
;

# Ejercicio 11
use agencia_personal;
SELECT 
    se.cuit AS 'CUIT',
    e.razon_social AS 'Nombre',
    COUNT(se.cuit) AS 'Total'
FROM
    solicitudes_empresas se
        INNER JOIN
    empresas e ON se.cuit = e.cuit
GROUP BY se.cuit
;

# Ejercicio 12
use agencia_personal;
SELECT 
    se.cuit AS 'CUIT',
    e.razon_social AS 'Nombre',
    se.cod_cargo,
    COUNT(se.cuit) AS 'Total'
FROM
    solicitudes_empresas se
        INNER JOIN
    empresas e ON se.cuit = e.cuit
GROUP BY se.cuit, se.cod_cargo
;

# Ejercicio 13
use agencia_personal;
SELECT 
    e.cuit, e.razon_social, COUNT(DISTINCT a.dni)
FROM
    empresas e
        LEFT JOIN
    antecedentes a ON e.cuit = a.cuit
GROUP BY e.cuit , e.razon_social
;

# Ejercicio 14
use agencia_personal;
SELECT 
    c.cod_cargo, c.desc_cargo, COUNT(se.cod_cargo)
FROM
    cargos c
        LEFT JOIN
    solicitudes_empresas se ON c.cod_cargo = se.cod_cargo
GROUP BY c.cod_cargo
ORDER BY COUNT(se.cod_cargo) DESC
;

# Ejercicio 15
use agencia_personal;
SELECT 
    c.cod_cargo, c.desc_cargo, COUNT(se.cod_cargo)
FROM
    cargos c
        LEFT JOIN
    solicitudes_empresas se ON c.cod_cargo = se.cod_cargo
GROUP BY c.cod_cargo
HAVING COUNT(se.cod_cargo) < 2
ORDER BY COUNT(se.cod_cargo) DESC
;