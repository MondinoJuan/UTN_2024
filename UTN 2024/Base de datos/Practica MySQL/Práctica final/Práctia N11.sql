# PRÁCTICA N11

# Ejercicio 3
use afatse;
start transaction;

alter table cursos
	add column cant_inscriptos int(11) default null
    ;
    
drop temporary table if exists insc_curso;
create temporary table insc_curso
select c.`nom_plan`, c.`nro_curso`, count(i.`nro_curso`) cant from cursos c 
left join `inscripciones` i on c.`nom_plan`=i.`nom_plan` and c.`nro_curso`=i.`nro_curso`
group by c.`nom_plan`, c.`nro_curso`;

update cursos c 
inner join insc_curso ic on c.`nom_plan`=ic.`nom_plan` and c.`nro_curso`=ic.`nro_curso`
set c.`cant_inscriptos`= ic.cant;

alter table cursos
	modify cant_inscriptos int(11) not null;

rollback;

-- TRIGGERS
DELIMITER $$
drop trigger if exists trg_actualizoCantInsc_afterNewInsc $$
create trigger trg_actualizoCantInsc_afterNewInsc after insert on inscripciones for each row
begin
	update cursos
		set cant_inscriptos = cant_inscriptos + 1
        where nom_plan = new.nom_plan and nro_curso = new.nro_curso;
end $$

drop trigger if exists trg_actualizoCantInsc_afterDelInsc $$
create trigger trg_actualizoCantInsc_afterDelInsc after delete on inscripciones for each row
begin
	update cursos
		set cant_inscriptos = cant_inscriptos - 1
        where nom_plan = new.nom_plan and nro_curso = new.nro_curso;
end $$

DELIMITER ;