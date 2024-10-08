use afatse;

SET SQL_SAFE_UPDATES = 0;

select cuil into @cuilTapia
	from instructores i
    where i.nombre = "Daniel" and i.apellido = "Tapia"
;

select cuil into @cuilAmiel
	from instructores i
    where i.nombre = "Henri" and i.apellido = "Amiel"
;

select cuil into @cuilKafka
	from instructores i
    where i.nombre = "Franz" and i.apellido = "Kafka"
;

start transaction;

UPDATE instructores ins
	SET ins.cuil_supervisor = @cuilTapia
	WHERE ins.cuil = @cuilAmiel or ins.cuil = @cuilKafka
;

SET SQL_SAFE_UPDATES = 1;

-- rollback;
-- commit;