use afatse;
select sup.cuil, sup.nombre, sup.apellido, ins.nombre, ins.apellido, plan.nom_plan, eva.nro_curso,
alu.nombre, alu.apellido, eva.nro_examen, eva.fecha_evaluacion, eva.nota

	from instructores ins 
    inner join evaluaciones eva on eva.cuil = ins.cuil
	inner join alumnos alu on alu.dni = eva.dni
	inner join  plan_capacitacion plan on plan.nom_plan = eva.nom_plan
	left join instructores sup on ins.cuil_supervisor = sup.cuil
	where eva.fecha_evaluacion between "2013-12-31" and "2015-01-01"
	order by sup.nombre asc, sup.apellido asc, eva.fecha_evaluacion desc, eva.nota desc;