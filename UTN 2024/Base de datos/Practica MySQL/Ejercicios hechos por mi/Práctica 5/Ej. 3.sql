use agencia_personal;

select em.cuit, em.razon_social, avg(com.importe_comision) PromIC
	from empresas em
    inner join contratos con on em.cuit = con.cuit
    inner join comisiones com on con.nro_contrato = com.nro_contrato
    group by em.cuit, em.razon_social
    having avg(com.importe_comision) > (
		select avg(com.importe_comision)
			from empresas em
			inner join contratos con on em.cuit = con.cuit
			inner join comisiones com on con.nro_contrato = com.nro_contrato
			where em.razon_social like "Tráigame eso"
            group by em.cuit
    )
;