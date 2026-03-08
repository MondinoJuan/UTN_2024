# PRÁCTICA N10

# Ejercicio 1 y 2
use afatse;
DELIMITER $$

drop procedure if exists plan_lista_precios_actual $$
create procedure plan_lista_precios_actual(in hoy DATE)
begin

drop temporary table if exists fechaActual;
create temporary table fechaActual as
SELECT 
    nom_plan, MAX(fecha_desde_plan) AS fecha_actual
FROM
    valores_plan
WHERE
    fecha_desde_plan <= hoy
GROUP BY nom_plan
;

SELECT 
    vp.nom_plan, pc.modalidad, vp.valor_plan AS valor_actual
FROM
    valores_plan vp
        INNER JOIN
    plan_capacitacion pc ON vp.nom_plan = pc.nom_plan
        INNER JOIN
    fechaActual fa ON vp.fecha_desde_plan = fa.fecha_actual
        AND vp.nom_plan = fa.nom_plan
ORDER BY vp.nom_plan ASC
;

drop temporary table if exists fechaActual;
end $$
DELIMITER ;

call plan_lista_precios_actual('20140901');

call plan_lista_precios_actual(curdate());

# Ejercicio 4
use afatse;
DELIMITER $$

drop function if exists plan_valor$$
create function plan_valor(nombrePlan varchar(50), fecha date)
returns decimal(10,2)
deterministic
begin

declare v_result decimal(10,2);

drop temporary table if exists fechaActual;
create temporary table fechaActual as
SELECT 
    nom_plan, MAX(fecha_desde_plan) AS fecha_actual
FROM
    valores_plan
WHERE
    fecha_desde_plan <= fecha
GROUP BY nom_plan
;

SELECT 
    vp.valor_plan
INTO v_result FROM
    valores_plan vp
        INNER JOIN
    fechaActual fa ON vp.fecha_desde_plan = fa.fecha_actual
        AND vp.nom_plan = fa.nom_plan
WHERE
    vp.nom_plan = nombrePlan
;

	return ifnull(v_result, 0);
end $$
DELIMITER ;

select plan_valor('Marketing 2', '20140901');

# Ejercicio 5
use afatse;
DELIMITER $$

drop procedure if exists plan_lista_precios_actual5 $$
create procedure plan_lista_precios_actual5(in hoy DATE)
begin

SELECT 
    pc.nom_plan,
    pc.modalidad,
    PLAN_VALOR(pc.nom_plan, hoy) AS valor_actual
FROM
    plan_capacitacion pc
ORDER BY pc.nom_plan
;

end $$
DELIMITER ;

call plan_lista_precios_actual5('20140901');

# Ejercicio 6
use afatse;
DELIMITER $$

drop procedure if exists alumnos_pagos_deudas_a_fecha $$
create procedure alumnos_pagos_deudas_a_fecha(in fecha_limite DATE, in dni_alumno integer(11), out pagado float(9, 3), out cant_adeudado integer(11))
begin

SELECT 
    SUM(c.importe_pagado)
INTO pagado FROM
    cuotas c
WHERE
    c.dni = dni_alumno
        AND c.fecha_emision <= fecha_limite
        AND fecha_pago IS NOT NULL
        AND c.fecha_pago <= fecha_limite
GROUP BY c.dni
;

SELECT 
    IFNULL(COUNT(c.dni), 0)
INTO cant_adeudado FROM
    cuotas c
WHERE
    c.dni = dni_alumno
        AND c.fecha_emision <= fecha_limite
        AND (fecha_pago IS NULL
        OR c.fecha_pago > fecha_limite)
GROUP BY c.dni
; 

end $$
DELIMITER ;

SET @pagado = 0;
SET @cant_adeudado = 0;

CALL alumnos_pagos_deudas_a_fecha('2014-08-04', 10101010, @pagado, @cant_adeudado);

SELECT @pagado, @cant_adeudado;

# Ejercicio 7
use afatse;
DELIMITER $$

drop function if exists alumnos_deudas_a_fecha$$
create function alumnos_deudas_a_fecha(dni_alumno int, fecha date)
returns int
reads sql data
begin

declare cant_cuotas_adeuda int;

SELECT 
    COUNT(c.dni)
INTO cant_cuotas_adeuda FROM
    cuotas c
WHERE
    c.dni = dni_alumno
        AND c.fecha_emision <= fecha
        AND (fecha_pago IS NULL
        OR c.fecha_pago > fecha)
GROUP BY c.dni
; 

return ifnull(cant_cuotas_adeuda, 0);
end $$
DELIMITER ;

select alumnos_deudas_a_fecha(10101010, '20140901') as cant_cuotas_adeudadas;

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

# Ejercicio 10
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
        
        if
        (select c.cupo from cursos c where c.nom_plan = plan_nom and c.nro_curso = cur_nro)
        <
        (select count(*) from inscripciones i where i.nom_plan = plan_nom and i.nro_curso = cur_nro /*group by i.dni*/)
        then 
			rollback;
            leave proc;
		end if
        ;
	commit;
end $$
DELIMITER ;

call alumno_inscripcion(42840150, 4, 'Marketing 1');

# Ejercicio 11
use afatse;
DELIMITER $$
drop procedure if exists stock_movimiento $$
create procedure stock_movimiento(IN cod_mat varchar(50), in cant_mat int, out cantActual int)
proc: begin

if cod_mat like 'AP-%' then 
	SELECT 
    cant_disponible
INTO cantActual FROM
    materiales
WHERE
    cod_material = cod_mat;
	leave proc;
end if
;

start transaction;

UPDATE materiales m 
SET 
    m.cant_disponible = m.cant_disponible + cant_mat
WHERE
    m.cod_material = cod_mat
;

SELECT 
    m.cant_disponible
INTO cantActual FROM
    materiales m
WHERE
    m.cod_material = cod_mat;

if cantActual < 0 then
	rollback;
SELECT 
    m.cant_disponible
INTO cantActual FROM
    materiales m
WHERE
    m.cod_material = cod_mat;
	leave proc;
end if
;

commit;
	
end $$

drop procedure if exists stock_ingreso $$
create procedure stock_ingreso(IN cod_mat varchar(50), in cant_mat int, out cantActual int)
proc: begin

if cant_mat <= 0 then
	select cant_disponible into cantActual
        from materiales
        where cod_material = cod_mat;
	leave proc;
end if
;

call stock_movimiento(cod_mat, cant_mat, cantActual);
	
end $$

drop procedure if exists stock_egreso $$
create procedure stock_egreso(IN cod_mat varchar(50), in cant_mat int, out cantActual int)
proc: begin    

declare restarCant int;

if cant_mat <= 0 then
	select cant_disponible into cantActual
        from materiales
        where cod_material = cod_mat;
	leave proc;
end if
;

set restarCant := -cant_mat;

call stock_movimiento(cod_mat, restarCant, cantActual);
    
end $$
DELIMITER ;

set @stock = 0;

call stock_ingreso('UT-002', 1, @stock);
select @stock;

call stock_egreso('UT-002', 10, @stock);
select @stock;

# Ejercicio 12
use afatse;
DELIMITER $$
drop procedure if exists alumno_anula_inscripcion $$
create procedure alumno_anula_inscripcion(IN al_dni int, in cur_nro int, in plan_nom varchar(120))
proc: begin    
    start transaction;
    
    IF 0 != (
		select count(*)
        FROM cuotas c
        WHERE c.nom_plan = plan_nom
          AND c.nro_curso = cur_nro
          AND c.dni = al_dni
          and c.fecha_pago is not null
    ) THEN
        ROLLBACK;
        LEAVE proc;
    END IF;

	DELETE FROM cuotas 
WHERE
    nom_plan = plan_nom
    AND nro_curso = cur_nro
    AND dni = al_dni
    AND fecha_pago IS NULL
	;

	DELETE FROM inscripciones 
WHERE
    nom_plan = plan_nom
    AND nro_curso = cur_nro
    AND dni = al_dni
;
	
    commit;
end $$
DELIMITER ;

call alumno_anula_inscripcion(42840150, 4, 'Marketing 1');

