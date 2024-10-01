/*
 Seleccionar los empleados que no tengan educación no formal o terciario.
*/

use agencia_personal;

SELECT 
    per.dni, per.nombre
FROM
    personas per
WHERE
    per.dni NOT IN (SELECT DISTINCT
            per.dni
        FROM
            personas per
                INNER JOIN
            personas_titulos pt ON per.dni = pt.dni
                INNER JOIN
            titulos ti ON ti.cod_titulo = pt.cod_titulo
        WHERE
            tipo_titulo IN ('educacion no formal' , 'terciario'));
