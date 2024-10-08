use afatse;

select cuil into @cuilYanes
	from instructores
    where nombre = "Elias" and apellido = "Yanes"
;

start transaction;

DELETE FROM instructores 
	WHERE cuil_supervisor = @cuilYanes;

-- rollback;
-- commit;