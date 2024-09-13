/*Práctica 2 - Ejercicio 16*/

use afatse;
select sup.cuil 'Cuil Supervisor', sup.nombre 'Nombre Supervisor', sup.apellido 'Apellido Supervisor', ins.nombre 'Nombre Instructor',
	ins.apellido 'Apellido Instructor', ev.nom_plan, ev.nro_curso, a.nombre, a.apellido, ev.nro_examen, ev.fecha_evaluacion, ev.nota
		from instructores ins
			left join instructores sup on ins.cuil_supervisor = sup.cuil
            inner join evaluaciones ev on ins.cuil = ev.cuil
            inner join alumnos a on ev.dni = a.dni
            where year(ev.fecha_evaluacion) = 2014
            order by sup.nombre, sup.apellido, ev.fecha_evaluacion