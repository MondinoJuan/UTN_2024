/*
Embarcaciones sin salidas recientes. 
Listar las embarcaciones que hayan tenido salidas el último año pero no en los últimos 6 meses. Indicar hin, nombre y descripción 
de la embarcación. Ordenar por nombre.
*/

use guarderia_gaghiel;

select /*distinct*/ emb.hin, emb.nombre, emb.descripcion
	from embarcacion emb
    inner join salida sal on emb.hin = sal.hin
    where emb.hin not in (
		select s.hin
			from salida s
            where s.fecha_hora_salida > "2024-03-16" and s.fecha_hora_salida < "2024-09-17"
    ) and year(sal.fecha_hora_salida) = "2024"
    order by emb.nombre
;