use agencia_personal;
select e.nombre_entrevistador, count(*) CantidadEntrevistas
	from entrevistas e
    where year(e.fecha_entrevista) = '2014' and month(e.fecha_entrevista) = '10'
    group by e.nombre_entrevistador
    order by CantidadEntrevistas asc, e.nombre_entrevistador asc
;