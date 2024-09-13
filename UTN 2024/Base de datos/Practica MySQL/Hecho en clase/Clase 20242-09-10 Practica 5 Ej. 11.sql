/*
Indicar el valor actual de los planes de Capacitación
*/

use afatse;

select nom_plan, max(fecha_desde_plan)
	from valores_plan
    where fecha_desde_plan < "2013-06-02"
    group by nom_plan
;