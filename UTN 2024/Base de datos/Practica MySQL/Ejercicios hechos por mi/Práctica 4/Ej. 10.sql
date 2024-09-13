use agencia_personal;
select count(distinct se.cuit) CantDistintas, count(se.cuit) - count(distinct se.cuit) Diferencia, count(se.cuit) Total 
	from solicitudes_empresas se
;