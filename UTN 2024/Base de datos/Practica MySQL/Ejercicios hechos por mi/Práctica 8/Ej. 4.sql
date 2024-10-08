use afatse;

start transaction;

SET SQL_SAFE_UPDATES = 0;

select cuil into @cuilTapia
	from instructores i
    where i.nombre = "Daniel" and i.apellido = "Tapia"
;

UPDATE instructores ins
	SET ins.cuil_supervisor = @cuilTapia
	WHERE concat(ins.nombre, " ", ins.apellido) = "Henri Amiel" or concat(ins.nombre, " ", ins.apellido) = "Franz Kafka"
;

SET SQL_SAFE_UPDATES = 1;

-- rollback;
-- commit;
