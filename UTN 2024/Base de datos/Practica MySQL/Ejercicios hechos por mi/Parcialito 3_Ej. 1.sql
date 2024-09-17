use guarderia_gaghiel;

select emb.hin
	from embarcaciones emb
    inner join embarcacion_cama ec on emb.hin = ec.hin
    where 
;

select emb.hin, emb.nombre, emb.descripcion
	from embarcacion emb
    inner join embarcacion_cama ec on emb.hin = ec.hin
    where (year(ec.fecha_hora_contrato) = "2023" or year(ec.fecha_hora_baja_contrato) = "2024")
    order by emb.nombre
;