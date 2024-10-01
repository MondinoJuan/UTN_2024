/*
Eliminar los exámenes donde el promedio general de las evaluaciones sea menor a 5.5.
Eliminar también los temas que sólo se evalúan en esos exámenes. Ayuda: Usar una tabla
temporal para determinar el/los exámenes que cumplan en las condiciones y utilizar dichas
tabla para los joins. Tener en cuenta las CF para poder eliminarlos.
*/
use afatse;

start transaction;

drop temporary table if exists exa_elim;
create temporary table exa_elim (
	select ev.nom_plan, ev.nro_examen, AVG(ev.nota) rpomedio
		from evaluaciones ev
        group by ev.nom_plan, ev.nro_examen
        having promedio < 5.5
);

delete ev, et
	from evaluaciones ev
    inner join exa_elim on ev.nom_plan = exa_elim.nom_plan and ev.nro_examen = exa_elim.nro_examen
    inner join examenes_temas et on et.nom_plan = exa_elim.nom_plan and et.nro_examen = exa_elim.nro_examen
;

delete ex
	from exa_elim
    inner join examenes ex on ex.nom_plan = exa_elim.nom_plan and ex.nro_examen = exa_elim.nro_examen;

-- commit;

/*
Van a tratar de que no aparezcan delete-inner de esta forma, y si aparecen ir borrando de a una tabla.
*/