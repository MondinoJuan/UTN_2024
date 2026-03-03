-- Ej 1
drop temporary table if exists cant_inscriptos;
create temporary table if not exists cant_inscriptos
select te.codigo, act.numero numero_act, cur.numero numero_cur, count(ins.numero_socio) Inscriptos
from tipo_embarcacion te
inner join actividad act
	on act.codigo_tipo_embarcacion = te.codigo
inner join curso cur
	on cur.numero_actividad = act.numero
inner join inscripcion ins
	on ins.numero_curso = cur.numero
group by te.codigo, act.numero, cur.numero;

drop temporary table if exists max_inscriptos;
create temporary table if not exists max_inscriptos 
select codigo, max(inscriptos) may_inscriptos
from cant_inscriptos
group by codigo;


select te.codigo, te.nombre, act.numero, act.nombre, act.descripcion, cur.numero, datediff(current_date(),cur.fecha_inicio), count(ins.numero_socio), count(emb.hin)
from tipo_embarcacion te
left join embarcacion emb
	on emb.codigo_tipo_embarcacion = te.codigo
left join actividad act
	on act.codigo_tipo_embarcacion = te.codigo
left join curso cur
	on cur.numero_actividad = act.numero
left join inscripcion ins
	on ins.numero_curso = cur.numero
group by te.codigo, te.nombre, act.numero, act.nombre, act.descripcion, cur.numero
having count(ins.numero_socio) >= (select may_inscriptos
									from max_inscriptos
                                    where te.codigo = max_inscriptos.codigo);

drop temporary table if exists max_inscriptos;
drop temporary table if exists cant_inscriptos;

-- Ej 2
ALTER TABLE `guarderia_gaghiel`.`embarcacion` 
ADD COLUMN `almacenada` INT NULL AFTER `numero_socio`;

start transaction;

drop temporary table if exists ultimos_regresos;
create temporary table if not exists ultimos_regresos
select sal.hin, max(fecha_hora_salida) ult_salida, max(sal.fecha_hora_regreso_real) ult_regreso
from salida
group by sal.hin;



update embarcacion emb
left join salida sal
	on sal.hin = emb.hin
left join ulimos_regresos ult
	on ult.hin = emb.hin
set almacenada = 1
where (ult.ult_regreso > sal.fecha_hora_regreso_real and ult.ult_salida < ult.ult_regreso) or (ult.ult_regreso is null);

update embarcacion emb
left join ulimos_regresos ult
	on ult.hin = emb.hin
set almacenada = 0
where  ult.ult_salida > ult.ult_regreso;

drop temporary table if exists ultimos_regresos;

commit;

DROP TRIGGER IF EXISTS `guarderia_gaghiel`.`salida_AFTER_INSERT`;

DELIMITER $$
USE `guarderia_gaghiel`$$
CREATE DEFINER = CURRENT_USER TRIGGER `guarderia_gaghiel`.`salida_AFTER_INSERT` AFTER INSERT ON `salida` FOR EACH ROW
BEGIN
update embarcacion
set almacenada = 0
where emb.hin = new.hin;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `guarderia_gaghiel`.`salida_AFTER_UPDATE`;

DELIMITER $$
USE `guarderia_gaghiel`$$
CREATE DEFINER = CURRENT_USER TRIGGER `guarderia_gaghiel`.`salida_AFTER_UPDATE` AFTER UPDATE ON `salida` FOR EACH ROW
BEGIN
update embarcacion emb
set almacenada = 1
where new.hin = emb.hin and new.fecha_hora_regreso_real is not null and new.fecha_hora_regreso_real != old.fecha_hora_regreso_real;
END$$
DELIMITER ;

