use agencia_personal;
select distinct se.cuit CUIT, emp.razon_social 'Razon Social', car.desc_cargo 'Cargo', ifnull(per.dni, 'Sin contrato') DNI, ifnull(per.apellido, 'Sin contrato') Apellido, 
ifnull(per.nombre, 'Sin contrato') Nombre 
	from solicitudes_empresas se
	inner join empresas emp on se.cuit = emp.cuit
	inner join cargos car on se.cod_cargo = car.cod_cargo
    left join contratos con on con.cod_cargo = car.cod_cargo and con.cuit = emp.cuit and con.fecha_solicitud = se.fecha_solicitud
    left join personas per on con.dni = per.dni
	order by se.cuit;