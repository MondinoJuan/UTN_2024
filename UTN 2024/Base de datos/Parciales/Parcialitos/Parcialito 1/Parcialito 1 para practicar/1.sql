/*
-- Salidas recientes y sus datos. Listar las salidas realizadas el mes pasado, la embarcación y el sector al que pertenecen. 
-- Indicando hin y nombre de la embarcación; fecha y hora de salida, regreso tentativo y regreso real; código y nombre del sector
-- donde se la almacena. Ordenar alfabéticamente por nombre de sector y descendente por fecha y hora de salida.
*/

use guarderia_gaghiel;
select sal.hin HIN, emb.nombre nombreEmb, date(sal.fecha_hora_salida) 'fecha salida', time(sal.fecha_hora_salida) 'hora salida', fecha_hora_regreso_tentativo, fecha_hora_regreso_real, sec.codigo, 
sec.nombre nombreSec
	from salida sal
	inner join embarcacion emb on sal.hin = emb.hin
    inner join sector_tipo_embarcacion ste on emb.codigo_tipo_embarcacion = ste.codigo_tipo_embarcacion
    inner join sector sec on ste.codigo_sector = sec.codigo
	where month(sal.fecha_hora_salida) = 6 and year(sal.fecha_hora_salida) = 2024
	order by sec.nombre asc, sal.fecha_hora_salida desc;