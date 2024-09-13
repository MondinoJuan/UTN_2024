use agencia_personal;
select per.nombre nombre, per.apellido apellido, tit.desc_titulo desc_titulo from titulos tit
	inner join personas_titulos pt on tit.cod_titulo = pt.cod_titulo
    inner join personas per on pt.dni = per.dni;