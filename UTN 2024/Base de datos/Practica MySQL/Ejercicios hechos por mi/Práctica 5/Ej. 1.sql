use agencia_personal;

select distinct per1.dni, per1.apellido, per1.nombre
	from personas per1
    inner join contratos con1 on per1.dni = con1.dni
    where con1.cuit in (
		select distinct con.cuit
			from personas per
			inner join contratos con on per.dni = con.dni
			where per.nombre like "Stefanía" and per.apellido like "López"
	)
;