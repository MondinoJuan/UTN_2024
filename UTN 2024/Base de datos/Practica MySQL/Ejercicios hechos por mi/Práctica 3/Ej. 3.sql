use agencia_personal;
select con.nro_contrato, con.fecha_incorporacion, con.fecha_finalizacion_contrato, con.fecha_caducidad, con.sueldo, con.porcentaje_comision, con.dni, con.cuit, con.cod_cargo,
con.fecha_solicitud, datediff(con.fecha_finalizacion_contrato, con.fecha_caducidad) 'dias restantes'
	from contratos con
    where con.fecha_caducidad < con.fecha_finalizacion_contrato
    order by con.nro_contrato desc;