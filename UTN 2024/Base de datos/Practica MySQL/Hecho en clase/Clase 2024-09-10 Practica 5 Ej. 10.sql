/*
En el año 2014, qué cantidad de alumnos se han inscripto a los Planes de Capacitación
indicando para cada Plan de Capacitación la cantidad de alumnos inscriptos y el porcentaje que
representa respecto del total de inscriptos a los Planes de Capacitación dictados en el año
*/

use afatse;

select count(*) into @canti
	from inscripciones
	where fecha_inscripcion
	between '2014-01-01' and '2014-12-31'
;

select nom_plan, count(*), (count(*) / @canti) * 100 "% Total"
	from inscripciones
    where fecha_inscripcion between '2014-01-01' and '2014-12-31'
    group by nom_plan
;