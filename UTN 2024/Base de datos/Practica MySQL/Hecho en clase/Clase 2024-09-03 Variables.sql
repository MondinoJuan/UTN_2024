use agencia_personal;
select count(*), sum(sueldo) into @cantCont, @totalPagado
	from contratos
;

select @cantCont, @totalPagado
;

/*
Variables son utilizadas cuando estoy seguro que se almacenaría un valor en ellas, NO una tabla.
*/