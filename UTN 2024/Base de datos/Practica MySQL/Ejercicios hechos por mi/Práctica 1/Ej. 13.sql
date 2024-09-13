use agencia_personal;
select * from solicitudes_empresas sol_emp 
		where (sol_emp.fecha_solicitud > '2013-09-21' and sol_emp.cod_cargo = 6) or sol_emp.sexo = 'Femenino';