use agencia_personal;

select per.apellido Apellido, per.nombre Nombre
	from personas per
    inner join contratos con on per.dni = con.dni
    where per.dni not in (
		select pt.dni
			from personas_titulos pt
            inner join titulos tit on pt.cod_titulo = tit.cod_titulo
            where tit.tipo_titulo like "Educacion no formal" or tit.tipo_titulo like "Terciario"
    ) and con.fecha_caducidad is null
;