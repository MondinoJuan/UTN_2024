use afatse;

start transaction;

UPDATE instructores i 
	inner join cursos_instructores ci on i.cuil = ci.cuil
	SET cuil_supervisor = ( select cuil from instructores where nombre = "Franz" and apellido = "Kafka" )
	WHERE ci.nom_plan = "Reparac PC Avanzada";

-- rollback;
-- commit;