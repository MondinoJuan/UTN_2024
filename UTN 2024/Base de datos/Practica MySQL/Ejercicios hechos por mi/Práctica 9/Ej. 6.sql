use afatse;

drop temporary table if exists promEvDesap;
create temporary table if not exists promEvDesap
select ev.nro_examen, avg(ev.nota) promNota
	from evaluaciones ev
    group by ev.nro_examen
    having promNota < 5.5
; /* nro_examen = 3 */

drop temporary table if exists temasNoBorrar;
create temporary table if not exists temasNoBorrar
select distinct nro_examen
	from examenes_temas et2
    inner join examenes_temas et on et2.titulo = et.titulo
	where et.nro_examen in (select nro_examen from promEvDesap) 
		and et2.nro_examen not in (select nro_examen from promEvDesap)
;

drop temporary table if exists temasAborrar;
create temporary table if not exists temasAborrar
select distinct et.titulo
	from examenes_temas et
    where et.nro_examen in (select nro_examen from promEvDesap)
	and not exists (select nro_examen from temasNoBorrar); 

start transaction;

DELETE FROM evaluaciones 
	WHERE nro_examen in (select nro_examen from promEvDesap); 
    
DELETE FROM examenes_temas
	WHERE nro_examen in (select nro_examen from promEvDesap);
    
DELETE FROM examenes 
	WHERE nro_examen in (select nro_examen from promEvDesap);
    
DELETE FROM plan_temas 
	WHERE titulo in (select titulo from temasAborrar);

-- rollback;
-- commit;