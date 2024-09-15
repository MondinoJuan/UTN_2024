/*
1- ¿Qué personas no fueron contratadas en la mismas empresas que contrataron a Stefanía Lopez?
*/

use agencia_personal;
select distinct per.apellido, per.nombre
	from personas per
    inner join contratos con on per.dni = con.dni
    where con.cuit not in(
		select distinct con.cuit
			from contratos con
			inner join personas per on con.dni = per.dni
			where per.nombre like '%stefan_a' and per.apellido like 'Lopez'
    )
		and per.nombre not like 'Stefan_a'
;