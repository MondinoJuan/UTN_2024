use agencia_personal;

select em.razon_social, per.nombre, per.apellido, com.nro_contrato, com.mes_contrato, com.anio_contrato, com.importe_comision
	from comisiones com
    inner join contratos con on com.nro_contrato = con.nro_contrato
    inner join empresas em on con.cuit = em.cuit
    inner join personas per on con.dni = per.dni
    where com.fecha_pago is not null and com.importe_comision < (
		select avg(com.importe_comision)
			from contratos con
			inner join empresas emp on emp.cuit = con.cuit
			inner join comisiones com on com.nro_contrato = con.nro_contrato
    )
;
            
/*
	from comisiones com
*/

/*
select emp.razon_social, per.nombre, per.apellido, con.nro_contrato, com.mes_contrato,
com.anio_contrato, com.importe_comision from empresas emp
inner join contratos con on con.cuit = emp.cuit
inner join personas per on per.dni = con.dni
inner join comisiones com on com.nro_contrato = con.nro_contrato
where com.fecha_pago is not null and com.importe_comision < (
select avg(com.importe_comision) from contratos con
inner join empresas emp on emp.cuit = con.cuit
inner join comisiones com on com.nro_contrato = con.nro_contrato
)
*/