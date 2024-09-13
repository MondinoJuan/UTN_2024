use agencia_personal;
select count(distinct se.cuit) CantDistintas, count(se.cuit) - count(distinct se.cuit) Diferencia, count(se.cuit) Total 
into @cantDist, @dif, @cantTotal
	from solicitudes_empresas se
;

select @cantDist, @dif, @cantTotal;

/*
Las variables se utilizan cuando se devuelve un registro, no una tabla.

Subconsulta una columna.
Tablas temporales varias columnas.
*/

/*
Otra forma de guardar valores en una variable.
*/
set @avgSalary = (select avg(salario) from empleados);
select emp.nombre, emp.apellido
	from empleados emp
    where emp.salario > @avgSalary
;