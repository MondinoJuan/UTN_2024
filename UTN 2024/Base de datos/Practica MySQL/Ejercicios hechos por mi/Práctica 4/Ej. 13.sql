use agencia_personal;
select e.cuit CUIT, e.razon_social RazonSocial, count(distinct ant.dni) CantPersonas
	from empresas e
    left join antecedentes ant on e.cuit = ant.cuit
    group by CUIT, RazonSocial
;