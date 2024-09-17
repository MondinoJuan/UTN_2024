use guarderia_gaghiel;

drop temporary table if exists almacenadosHoy;
create temporary table if not exists almacenadosHoy
select *
	from embarcaciones emb
    inner join embarcacion_cama ec on emb.hin = ec.hin
;

select emb.hin, emb.nombre, emb.descripcion
	from embarcacion emb
    inner join embarcacion_cama ec on emb.hin = ec.hin
    where (year(ec.fecha_hora_contrato) = "2023" or year(ec.fecha_hora_baja_contrato) = "2024")
;