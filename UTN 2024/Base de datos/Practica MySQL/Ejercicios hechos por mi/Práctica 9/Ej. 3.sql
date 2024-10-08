use afatse;

start transaction;

insert into plan_capacitacion
select 'Marketing 1 Presen', desc_plan, hs,'presencial'
from `plan_capacitacion`
where nom_plan = 'Marketing 1';

insert into plan_temas
select 'Marketing 1 Presen', titulo,detalle
from plan_temas
where nom_plan = 'Marketing 1';

insert into `examenes`
select 'Marketing 1 Presen', nro_examen
from `examenes`
where nom_plan = 'Marketing 1';

insert into `examenes_temas`
select 'Marketing 1 Presen', titulo, nro_examen
from `examenes_temas`
where nom_plan = 'Marketing 1';

insert into `valores_plan`(`nom_plan`, `fecha_desde_plan`, `valor_plan`)
select 'Marketing 1 Presen', fecha_desde_plan, valor_plan * 1.5
from `valores_plan`
where nom_plan = 'Marketing 1' and year(fecha_desde_plan) = 2015;

/*
para realizar esta parte del ejercicio hay que haber realizado los 2 anteriores
*/

-- rollback;
-- commit;