use agencia_personal;
/*Unir siempre por la clave primaria.*/
select distinct emp.razon_social, sol.cuit, car.desc_cargo, sol.fecha_solicitud, per.dni, per.apellido, per.nombre	
/*No poner nro_contratos con el distinct en este caso. Porque elimina repetidos, en este caso si pones cod_cargo aparecen datos repetidos
porque por código siempre serán diferentes en ese atributo, por más que todo el resto de la tupla sea igual.*/ 
	from empresas emp
		inner join solicitudes_empresas sol on emp.cuit = sol.cuit
		inner join cargos car on sol.cod_cargo = car.cod_cargo
		left join contratos cont on sol.cod_cargo = cont.cod_cargo
								and sol.fecha_solicitud = cont.fecha_solicitud
								and sol.cuit = cont.cuit
		left join personas per on per.dni = cont.dni