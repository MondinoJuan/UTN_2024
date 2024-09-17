use agencia_personal;

drop temporary table if exists promedios;
create temporary table if not exists promedios
select c.cuit, avg(c.sueldo) sueldoprom
	from contratos c
    group by c.cuit
;

select con.cuit, con.dni, con.sueldo, ps.sueldoprom
	from contratos con
    inner join promedios ps on con.cuit = ps.cuit
    where con.sueldo > ps.sueldoprom
;

drop temporary table if exists promedios;