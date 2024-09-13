use agencia_personal;
select concat(per.apellido, ' ', per.nombre) 'Nombre y Apellido', per.fecha_nacimiento 'Fecha Nacimiento', day(per.fecha_nacimiento) Dia, month(per.fecha_nacimiento) Mes, year(per.fecha_nacimiento) Año
	from personas per