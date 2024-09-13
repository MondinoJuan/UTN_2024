use agencia_personal;
select per.dni dni, per.nombre nombre, per.apellido apellido, tit.desc_titulo desc_titulo from titulos tit
	inner join personas_titulos pt on tit.cod_titulo = pt.cod_titulo
    inner join personas per on pt.dni = per.dni
	where tit.desc_titulo = 'Bachiller' or tit.tipo_titulo = 'Educacion no formal'
    order by per.dni asc;