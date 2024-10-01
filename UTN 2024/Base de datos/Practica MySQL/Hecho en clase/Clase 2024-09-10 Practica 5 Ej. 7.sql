/*
Mostrar los empleados cuyo salario supere al promedio de sueldo de la empresa que los contrató.
*/

use agencia_personal;

drop temporary table if exists promedios;
create temporary table promedios(
select cuit, avg(sueldo) prom
from contratos
group by 1);

select * from promedios;

SELECT 
    c.cuit, dni, sueldo, prom
FROM
    contratos c
        INNER JOIN
    promedios p ON c.cuit = p.cuit
WHERE
    sueldo > prom
;

drop temporary table if exists promedios;



/*
-- CTE (Tabla temporal es una foto, CTE esta en el ANSI y los estándares)
with prome as (
select cuit, avg(sueldo) prom
	from contratos
    group by 1)
select c.cuit, dni, sueldo, prom
	from contratos c
    inner join prome p on c.cuit = p.cuit
    where sueldo > prom;
*/