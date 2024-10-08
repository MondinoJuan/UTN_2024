use afatse;

select * from inscripciones
	where nom_plan = "Marketing 3" and nro_curso = 1
;

start transaction;

DELETE FROM inscripciones 
	WHERE nom_plan = "Marketing 3" and nro_curso = 1;

-- commit;
-- rollback;
