use agencia_personal;
select per.nombre, per.apellido, con.sueldo, per.dni from contratos con 
	inner join personas per on con.dni = per.dni
    where con.nro_contrato = 5; 