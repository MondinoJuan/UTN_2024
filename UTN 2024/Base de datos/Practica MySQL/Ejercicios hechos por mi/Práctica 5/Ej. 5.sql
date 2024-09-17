use agencia_personal;

select em.razon_social, avg(com.importe_comision) promComMax
	from empresas em
    inner join contratos con on em.cuit = con.cuit
    inner join comisiones com on con.nro_contrato = com.nro_contrato
    group by em.cuit
    having promComMax = (
		select max(importe_comision) from comisiones
	)
;