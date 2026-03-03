# PRÁCTICA N9

# Ejercicio 4
use afatse;

start transaction;

select ins.cuil into @cuilFK from instructores ins
where ins.nombre like 'Franz' and ins.apellido like 'Kafka'
;

drop temporary table if exists insRepAv;
create temporary table insRepAv as
select i.cuil from instructores i
inner join cursos_instructores ci on i.cuil = ci.cuil
inner join cursos c on ci.nro_curso = c.nro_curso and ci.nom_plan = c.nom_plan
where c.nom_plan like '%Reparac PC Avanzada%' and (year(c.fecha_ini) = 2015 and year(c.fecha_fin) = 2015)
;

update instructores i
set i.cuil_supervisor = @cuilFK
where i.cuil in (select iav.cuil from insRepAv iav)
;

select i.* from instructores i
inner join insRepAv ira on i.cuil = ira.cuil
;

rollback;