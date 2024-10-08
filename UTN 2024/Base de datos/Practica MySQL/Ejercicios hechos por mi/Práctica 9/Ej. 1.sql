use afatse;

start transaction;

insert into `valores_plan`( `nom_plan`, `fecha_desde_plan`, `valor_plan`)
	select val.nom_plan,'20090601', val.valor_plan*1.2
		from valores_plan val
		inner join
			(
			select vp.nom_plan, max(vp.fecha_desde_plan) ult_fecha
				from valores_plan vp
				group by vp.nom_plan
			) fechas
			on val.nom_plan=fechas.nom_plan
			and val.fecha_desde_plan=fechas.ult_fecha;

-- rollback;
-- commit;