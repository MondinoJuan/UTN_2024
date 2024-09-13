use agencia_personal;
select con.nro_contrato NroContrato, count(*) Total, 
((count(com.fecha_pago) / count(*)) * 100) PagadasPorc, 
(((count(*) - count(com.fecha_pago)) / count(*)) * 100) ImpagasPorc
	from contratos con
    inner join comisiones com on con.nro_contrato = com.nro_contrato
    group by NroContrato
;