use agencia_personal;
select emp.cuit CUIT, emp.razon_social Razon_Social, ifnull(se.fecha_solicitud, 'Sin solicitud') Fecha_Solicitud, ifnull(car.desc_cargo, 'Sin solicitud') Cargo 
	from empresas emp
	left join solicitudes_empresas se on emp.cuit = se.cuit
	left join cargos car on se.cod_cargo = car.cod_cargo
    