use afatse;

delimiter $$

create definer='root'@'localhost' procedure alumno_inscripcion(in dni_alumno integer, in plan char(20), in curso integer)

begin
	start transaction;

	insert into inscripciones
		values (plan, curso, dni_alumno, current_date);

	insert into cuotas
		values(plan, curso, dni_alumno, 
			year(adddate(current_date, interval 1 month)), 
			month(adddate(current_date, interval 1 month)), 
			current_date, null, null);
			
	commit;

end$$

delimiter ;