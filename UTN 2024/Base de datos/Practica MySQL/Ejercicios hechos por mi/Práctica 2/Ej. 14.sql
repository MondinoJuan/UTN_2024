use afatse;
select ins.cuil 'CUIL instructor', ins.nombre 'Nombre Instructor', ins.apellido 'Apellido Instructor', sup.cuil 'CUIL Supervisor', sup.nombre 'Nombre Supervisor', sup.apellido 'Apellido Supervisor' 
	from instructores ins
	inner join instructores sup on ins.cuil_supervisor = sup.cuil