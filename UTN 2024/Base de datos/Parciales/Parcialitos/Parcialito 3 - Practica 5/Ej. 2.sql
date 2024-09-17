/*
Embarcaciones con pocas salidas. 
Listar las embarcaciones que tuvieron menos salidas en 2024 que el promedio de salidas de cada socio en 2024. Se deben tener en cuenta 
en el promedio los socios sin salidas. Indicar hin, nombre y descripción de la embarcación y cantidad de salidas. Ordenar por cantidad 
de salidas descendente.
*/

use guarderia_gaghiel;

drop temporary table if exists cantidadSal;
create temporary table if not exists cantidadSal
select soc.numero, count(sal.fecha_hora_salida) cantidadSalida
	from socio soc
    left join embarcacion emb on soc.numero = emb.numero_socio
    left join salida sal on emb.hin = sal.hin and year(sal.fecha_hora_salida) = "2024"
    group by soc.numero
;

select emb.hin, emb.nombre, emb.descripcion, count(sal.fecha_hora_salida)
	from embarcacion emb
    left join salida sal on emb.hin = sal.hin and year(sal.fecha_hora_salida) = "2024"
    group by emb.hin
    having count(sal.fecha_hora_salida) < (select avg(cantidadSalida) from cantidadSal)
    order by count(sal.fecha_hora_salida) desc
;

/*
use guarderia_gaghiel;

drop temporary table if exists cantidadSal;
create temporary table if not exists cantidadSal
select soc.numero, count(sal.fecha_hora_salida) cantidadSalida
	from socio soc
    left join embarcacion emb on soc.numero = emb.numero_socio
    left join salida sal on emb.hin = sal.hin and year(sal.fecha_hora_salida) = "2024"
    group by soc.numero
;

select emb.hin, emb.nombre, emb.descripcion, count(sal.fecha_hora_salida) cantidad_salidas
	from embarcacion emb
	left join salida sal on emb.hin = sal.hin and year(sal.fecha_hora_salida) = "2024"
	group by emb.hin
	having cantidad_salidas < (select avg(cantidadSalida) from cantidadSal)
	order by cantidad_salidas desc
;
*/