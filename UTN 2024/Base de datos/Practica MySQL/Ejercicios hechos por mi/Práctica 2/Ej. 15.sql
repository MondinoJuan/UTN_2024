use afatse;
select ins.cuil 'CUIL instructor', ins.nombre 'Nombre Instructor', ins.apellido 'Apellido Instructor', ifnull(sup.cuil, ' ') 'CUIL Supervisor', ifnull(sup.nombre, ' ') 'Nombre Supervisor', 
ifnull(sup.apellido, ' ') 'Apellido Supervisor' 
	from instructores ins
	left join instructores sup on ins.cuil_supervisor = sup.cuil