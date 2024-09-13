/*
TABLAS TEMPORALES
Son tablas que existen temporalmente en memoria, una vez que se cierra sesión o se finaliza la transacción se borra.
Contienen más de una tupla con una o más columnas.
*/
Drop temporary table if exists temp_salarios;
Create temporary table temp_salarios as
	select codDepto, avg(salario) as avgSalario
		from empleados emp
		where codDepto is not null
        group by codDepto;
	select emp.nombre, emp.apellido, emp.salario
		from empleados emp
        inner join temp_salarios tsal on emp.codDepto = tsal.codDepto
        where emp.salario > tsal.avgSalario;
Drop temporary table if exists temp_salarios;

/*
Las tablas constantes son consultas con nombre. Con WITH nombreTabla AS () se obvia el CREATE de la tabla temporal. No se almacena en un
espacio de tabla temporal, sino en uno de consulta. Su uso depende del gusto del programador, es lo mismo.
*/