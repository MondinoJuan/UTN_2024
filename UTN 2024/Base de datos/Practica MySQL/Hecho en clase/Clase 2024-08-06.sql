/*Mostrar la suma de las comisiones pagadas de la empresa traigame eso.*/

use agencia_personal;
select emp.cuit, sum(importe_comision), count(*), emp.razon_social from comisiones com
	inner join contratos con on com.nro_contrato = con.nro_contrato
    inner join empresas emp on con.cuit = emp.cuit
	where fecha_pago is not null and emp.razon_social = 'Traigame eso'
    group by emp.cuit, emp.razon_social;
    
/*
El having sirve para filtrar condiciones de grupo. Por ejemplo having count(*) > 8

Funciones de agregación:
	sum() suma los valores de la columna pasada como parámetro.
*/