use agencia_personal;
select emp.razon_social razon_social, emp.direccion direccion, emp.e_mail correo, car.desc_cargo desc_cargo, 
se.anios_experiencia anios_experiencia, se.fecha_solicitud
	from solicitudes_empresas se
	inner join empresas emp on se.cuit = emp.cuit
    inner join cargos car on se.cod_cargo = car.cod_cargo
    order by se.fecha_solicitud asc, car.desc_cargo desc;