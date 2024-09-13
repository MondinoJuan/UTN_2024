use agencia_personal;
select distinct concat(per.apellido, ', ', per.nombre, ' tiene como referencia a ', ifnull(ante.persona_contacto, 'nadie'), 
' de cuando trabajaba en ', emp.razon_social) as ''
	from personas per
	inner join antecedentes ante on per.dni = ante.dni
    inner join empresas emp on ante.cuit = emp.cuit
    where ante.persona_contacto is null or ante.persona_contacto = 'Armando Esteban Quito' or ante.persona_contacto = 'Felipe Rojas';