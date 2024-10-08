use afatse;

start transaction;

UPDATE alumnos al
	SET al.direccion = "Italia 2323", al.tel = "3232323"
	WHERE al.dni = 23232323
;

rollback;
-- commit;