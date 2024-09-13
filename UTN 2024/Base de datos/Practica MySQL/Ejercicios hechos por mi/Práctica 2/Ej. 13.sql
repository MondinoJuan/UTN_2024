use agencia_personal;
select car.desc_cargo Cargo, ifnull(per.dni, 'Sin antecedentes') DNI, ifnull(per.apellido, 'Sin antecedentes') Apellido, emp.razon_social RazonSocial 
	from cargos car
	left join antecedentes ant on car.cod_cargo = ant.cod_cargo
    left join personas per on ant.dni = per.dni
    left join empresas emp on ant.cuit = emp.cuit