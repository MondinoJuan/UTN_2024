/*
Personas físicas con pocos contratos activos. 
Listar las personas físicas (propietarios con tipo de documento dni) que tengan menos de 2 contratos activos actualmente. Indicar número y 
nombre del socio; cantidad de contratos activos actualmente (si no tienen ninguno debe mostrar 0) y fecha de inicio de su último contrato 
(si no tuvo contratos debe decir 'sin contratos'). 
Ordenar por cantidad de contratos activos descendente.
*/

use guarderia_gaghiel;
SELECT 
    soc.numero,
    soc.nombre,
    COUNT(ec.fecha_hora_contrato) - COUNT(fecha_hora_baja_contrato) CantContActivos,
    IFNULL(MAX(ec.fecha_hora_contrato),
            'Sin contratos') FechaInicioUltCon
FROM
    embarcacion emb
        INNER JOIN
    socio soc ON emb.numero_socio = soc.numero
        AND soc.tipo_doc = 'dni'
        LEFT JOIN
    embarcacion_cama ec ON emb.hin = ec.hin
GROUP BY soc.numero , soc.nombre
HAVING CantContActivos < 2
ORDER BY CantContActivos DESC
;

/*
La condicion del inner era mejor ponerla en el WHERE porque el gestor de base de datos identifica solo cómo es más óptimo 
recuperar tablas.
*/