/*
Mostrar para cada contrato cantidad total de las comisiones, cantidad a pagar, cantidad pagadas.
*/

use agencia_personal;
select con.nro_contrato NroCont, count(*) Total, count(com.fecha_pago) Pagas, count(*) - count(com.fecha_pago) Impagas, 
sum(com.importe_comision) SumaImporte
	from contratos con
    inner join comisiones com on con.nro_contrato = com.nro_contrato
    group by con.nro_contrato
;
    