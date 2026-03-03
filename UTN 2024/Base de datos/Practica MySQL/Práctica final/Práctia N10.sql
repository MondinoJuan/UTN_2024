# PRÁCTICA N10

# Ejercicio 8 y 9
use afatse;
DELIMITER $$
drop procedure if exists alumno_inscripcion $$
create procedure alumno_inscripcion(IN al_dni int, in cur_nro int, in plan_nom varchar(120))
proc: begin
	DECLARE v_hoy DATE;
    DECLARE v_prox_mes DATE;
    SET v_hoy = CURDATE();
    SET v_prox_mes = DATE_ADD(v_hoy, INTERVAL 1 MONTH);
    
    start transaction;
    
    IF EXISTS (
        SELECT 1
        FROM inscripciones i
        WHERE i.nom_plan = plan_nom
          AND i.nro_curso = cur_nro
          AND i.dni = al_dni
    ) THEN
        ROLLBACK;
        LEAVE proc;
    END IF;

	insert into inscripciones(nom_plan, nro_curso, dni, fecha_inscripcion)
		values (plan_nom, cur_nro, al_dni, v_hoy);
	insert into cuotas(nom_plan, nro_curso, dni, anio, mes, fecha_emision, fecha_pago, importe_pagado)
		values(plan_nom, cur_nro, al_dni, year(v_prox_mes), month(v_prox_mes), v_hoy, null, null);    
	commit;
end $$
DELIMITER ;

call alumno_inscripcion(42840150, 4, 'Marketing 1');