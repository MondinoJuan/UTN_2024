use guarderia_gaghiel;
select soc.numero, soc.nombre, emb.hin, emb.nombre, emb.descripcion, count(sal.fecha_hora_salida), ifnull(max(sal.fecha_hora_salida), 'Sin salidas registradas') FechaUltSal
	from embarcacion emb
    inner join socio soc on emb.numero_socio = soc.numero and soc.tipo_doc = 'cuit'
    left join salida sal on emb.hin = sal.hin and year(sal.fecha_hora_salida) = '2024' 
    group by soc.numero, soc.nombre, emb.hin, emb.nombre, emb.descripcion
    having count(sal.fecha_hora_salida) < 4
    order by FechaUltSal desc
;