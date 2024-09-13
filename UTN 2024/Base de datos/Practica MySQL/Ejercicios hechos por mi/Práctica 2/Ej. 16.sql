use afatse;
select ifnull(sup.cuil, ' ') 'Cuil Supervisor', ifnull(sup.nombre, ' ') 'Nombre Supervisor', ifnull(sup.apellido, ' ') 'Apellido Supervisor', ins.nombre 'Nombre Instructor', 
ins.apellido 'Apellido Instructor', insc.nom_plan 'nom_plan', ev.nro_curso 'nro_curso', a.nombre 'nombre Alumno', a.apellido 'apellido Alumno', ev.nro_examen 'nro_examen',
ev.fecha_evaluacion 'fecha_evaluacion', ev.nota 'nota'

/*	
    from instructores ins
	inner join cursos_instructores ci on ins.cuil = ci.cuil
    inner join evaluaciones ev on ci.nom_plan = ev.nom_plan
    inner join examenes ex on ci.nom_plan = ex.nom_plan
    inner join alumnos a on ev.dni = a.dni
    left join instructores sup on ins.cuil_supervisor = sup.cuil
	where ev.fecha_evaluacion > '2014-01-01' and ev.fecha_evaluacion < '2014-12-31'
*/

/*    
    FROM evaluaciones ev
	INNER JOIN inscripciones insc ON (insc.nom_plan = ev.nom_plan AND insc.nro_curso = ev.nro_curso AND insc.dni = ev.dni)
	INNER JOIN alumnos a ON insc.dni = a.dni
	INNER JOIN instructores ins ON ev.cuil = ins.cuil
	LEFT JOIN instructores sup ON sup.cuil = ins.cuil_supervisor
    where year(ev.fecha_evaluacion) = 2014
    order by 'Nombre Supervisor' asc, 'Apellido Supervisor' asc, 'fecha_evaluacion' desc;
*/