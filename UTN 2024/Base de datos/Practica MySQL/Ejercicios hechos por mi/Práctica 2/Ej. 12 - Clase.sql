use agencia_personal;
select distinct sol.cuit, emp.razon_social, car.desc_cargo
	from empresas emp
		inner join solicitudes_empresas sol on emp.cuit = sol.cuit
		inner join cargos car on sol.cod_cargo = car.cod_cargo
		left join contratos cont on sol.cod_cargo = cont.cod_cargo
								and sol.fecha_solicitud = cont.fecha_solicitud
								and sol.cuit = cont.cuit
        where cont.nro_contrato is null
        
/*Acostumbrarse a poner las condiciones en el where, no en el left*/