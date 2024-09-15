use agencia_personal;

select max(con.sueldo) into @maxSueldoVA
	from contratos con
    inner join empresas em on con.cuit = em.cuit
    where em.razon_social like "Viejos Amigos"
;

select per.dni DNI, concat(per.nombre, per.apellido) NombreApellido, con.sueldo sueldo
	from contratos con
    inner join personas per on con.dni = per.dni
    where con.sueldo < @maxSueldoVA
;