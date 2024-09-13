use agencia_personal;
select distinct emp.cuit CUIT, emp.razon_social 'Razon Social', car.desc_cargo 'Cargo' from solicitudes_empresas se
	inner join empresas emp on se.cuit = emp.cuit
    inner join cargos car on se.cod_cargo = car.cod_cargo  /*Asi esta en la resolución*/
	left join contratos cont on emp.cuit = cont.cuit and se.fecha_solicitud = cont.fecha_solicitud and car.cod_cargo = cont.cod_cargo
    /*left join cargos car on se.cod_cargo = car.cod_cargo*/
    where cont.nro_contrato is null