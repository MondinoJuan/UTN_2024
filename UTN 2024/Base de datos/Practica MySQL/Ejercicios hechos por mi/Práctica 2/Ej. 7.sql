use agencia_personal;
select emp.razon_social Empresa, se.fecha_solicitud Fecha_Sol, car.desc_cargo Cargo, ifnull(se.edad_minima, 'Sin especificar') 'Edad Minima', ifnull(se.edad_maxima, 'Sin especificar') 'Edad Maxima' 
	from empresas emp
	inner join solicitudes_empresas se on emp.cuit = se.cuit
	inner join cargos car on se.cod_cargo = car.cod_cargo
    where emp.razon_social = 'Viejos amigos';