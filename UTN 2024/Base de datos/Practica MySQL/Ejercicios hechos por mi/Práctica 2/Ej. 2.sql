use agencia_personal;
select per.dni DNI, con.nro_contrato Numero_Contrato, con.fecha_incorporacion Fecha_Incorporacion, se.fecha_solicitud Fecha_Solicitud, 
ifnull(con.fecha_caducidad, 'Sin Fecha') Fecha_Caducidad 
	from personas per
	inner join contratos con on per.dni = con.dni
    inner join solicitudes_empresas se on con.cod_cargo = se.cod_cargo
    inner join empresas emp on se.cuit = emp.cuit
	where emp.razon_social = 'Viejos Amigos' or emp.razon_social like 'Traigame Eso'
    order by Fecha_Solicitud