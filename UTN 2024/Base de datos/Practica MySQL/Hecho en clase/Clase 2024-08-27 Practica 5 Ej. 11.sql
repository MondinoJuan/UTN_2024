use afatse;
with valor_actual as(
	select vp.nom_plan, max(vp.fecha_desde_plan) maxFecha
		from valores_plan vp
		where vp.fecha_desde_plan <= current_date()
		group by vp.nom_plan
)