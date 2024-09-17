use agencia_personal;

select max(importe_comision) into @max_com from comisiones;
select min(importe_comision) into @min_com from comisiones;

select emp.razon_social, avg(com.importe_comision) sueldoprom
	from empresas emp
    inner join contratos con on emp.cuit = con.cuit
    inner join comisiones com on con.nro_contrato = com.nro_contrato
    where com.fecha_pago is null
    group by emp.cuit
    having sueldoprom = @max_com or sueldoprom = @min_com
;

drop temporary table if exists promediosCom;