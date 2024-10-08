use afatse;

start transaction;

insert into `valores_plan`( `nom_plan`, `fecha_desde_plan`, `valor_plan`)
	select val.nom_plan,'20090801', if(val.valor_plan < 90, val.valor_plan*1.2, val.valor_plan*1.12)
		from valores_plan val
		inner join
			(
			select vp.nom_plan, max(vp.fecha_desde_plan) ult_fecha
				from valores_plan vp
				group by vp.nom_plan
			) fechas on val.nom_plan = fechas.nom_plan and val.fecha_desde_plan = fechas.ult_fecha;

-- rollback;
-- commit;