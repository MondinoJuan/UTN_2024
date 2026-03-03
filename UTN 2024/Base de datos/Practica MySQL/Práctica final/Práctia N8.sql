# PRÁCTICA N8

# Ejercicio 3
use afatse;

start transaction;

-- CTE
drop temporary table if exists cursosPres;
create temporary table cursosPres as
select c.nro_curso from cursos c
inner join plan_capacitacion pc on c.nom_plan = pc.nom_plan
where pc.modalidad like '%Presencial%' or pc.modalidad like '%Semipresencial%'
;

/*
update cursos c
set c.cupo = round(c.cupo * 1.5)
where c.nro_curso in (select * from cursosPres) and c.cupo < 20
;

update cursos c
set c.cupo = round(c.cupo * 1.25)
where c.nro_curso in (select * from cursosPres) and c.cupo >= 20
;
*/
-- Hacer tabla temporal de cursos de menor a 20 y mayor a 20 para que en el where del update quede la PK
update cursos c
inner join cursosPres cp ON cp.nro_curso = c.nro_curso
set c.cupo = round(c.cupo * 1.5)
where c.cupo < 20 and c.nro_curso = cp.nro_curso
;

update cursos c
inner join cursosPres cp ON cp.nro_curso = c.nro_curso
set c.cupo = round(c.cupo * 1.25)
where c.cupo >= 20 and c.nro_curso = cp.nro_curso
;

use afatse;
select c.nom_plan, c.salon, c.cupo, pc.modalidad from cursos c
inner join plan_capacitacion pc on c.nom_plan = pc.nom_plan;

ROLLBACK;