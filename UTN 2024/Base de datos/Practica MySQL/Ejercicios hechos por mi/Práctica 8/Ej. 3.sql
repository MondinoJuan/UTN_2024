use afatse;

start transaction;

SET SQL_SAFE_UPDATES = 0;

drop temporary table if exists cursosApuntados;
create temporary table if not exists cursosApuntados
select nro_curso, nom_plan
	from cursos cu 
    inner join plan_capacitacion pc on cu.nom_plan = pc.nom_plan
    where pc.modalidad = "Presencial" || pc.modalidad = "Semipresencial"
;

UPDATE cursos cur
	SET cur.cupo = cur.cupo * 1.5
	WHERE cur.nro_curso in (select nro_curso from cursosApuntados) and cur.cupo < 20
;

UPDATE cursos cur
	SET cur.cupo = cur.cupo * 1.25
	WHERE cur.nro_curso in (select nro_curso from cursosApuntados) and cur.cupo >= 20
;

SET SQL_SAFE_UPDATES = 1;

-- commit;

/* Hubiera sido mejor:

UPDATE cursos cur
INNER JOIN cursosApuntados ca ON cur.nro_curso = ca.nro_curso AND cur.nom_plan = ca.nom_plan
SET cur.cupo = cur.cupo * 1.5
WHERE cur.cupo < 20;

UPDATE cursos cur
INNER JOIN cursosApuntados ca ON cur.nro_curso = ca.nro_curso AND cur.nom_plan = ca.nom_plan
SET cur.cupo = cur.cupo * 1.25
WHERE cur.cupo >= 20;

*/