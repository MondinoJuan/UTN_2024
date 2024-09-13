use agencia_personal;
select emp.razon_social, sum(importe_comision)/*, count(*), emp.cuit */from comisiones com
	inner join contratos con on com.nro_contrato = con.nro_contrato
    inner join empresas emp on con.cuit = emp.cuit
	where fecha_pago is not null and emp.razon_social = 'Traigame eso'
    group by emp.cuit, emp.razon_social;