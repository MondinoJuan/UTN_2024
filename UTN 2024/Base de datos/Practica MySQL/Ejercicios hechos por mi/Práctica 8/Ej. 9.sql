use afatse;

select cuil into @cuilTapia
	from instructores i
    where i.nombre = "Daniel" and i.apellido = "Tapia"
;

start transaction;

UPDATE instructores
	SET cuil_supervisor = null
	WHERE ins.cuil = cuilTapia
;

DELETE FROM instructores WHERE cuil = @cuilTapia;

-- rollback;
-- commit;