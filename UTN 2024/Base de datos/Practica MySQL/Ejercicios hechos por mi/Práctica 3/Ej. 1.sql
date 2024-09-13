use agencia_personal;
select con.nro_contrato 'Nro Contrato', con.fecha_incorporacion, con.fecha_finalizacion_contrato, adddate(con.fecha_solicitud, interval 30 day) 'fecha_caducidad'
	from contratos con
    where con.fecha_caducidad is null;