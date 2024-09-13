/*
EJEMPLO 1:
Mostrar nombre y apellido de los empleados cuyo sueldo es mayor al promedio de los sueldos abonados por la empresa.
*/
select emp.nombre, emp.apellido
	from empleados emp
	where salario > (select avg(salario) from empleados)	
    /*Devuelve una tabla de 1x1. Por ello es que puede ser comparada con columnas. Se ejecutará tantas veces como empleados (tuplas) haya.*/
;
/*
SUBCONSULTA: consulta dentro de otra consulta. No se utilizan los ORDER BY.
Se pueden encontrar en un FROM, SELECT, WHERE o HAVING. Nosotros veremos en el caso de los últimos 2.
Si se resuelve con SUBCONSULTA algo que no es necesario esta mal.
*/


/*
EJEMPLO 2:
Mostrar nombre y apellido de los empleados cuyo sueldo es igual al mayor de los sueldos abonados por la empresa.
*/
select concat(emp.nombre, " ", emp.apellido) "Nombre y Apellido"
	from empleados emp
	where salario >= all(select salario from empleados)	
;
/*
Es más lento porque comparo con cada tupla, en vez de encontrar un valor y trabajar con ese. Por eso casi ni se usa.

El ANY no se usa porque es reemplazado con el IN. EL otro que no se sua es el SOME.
IN: está
NOT IN: no está

EXISTS (existe?) no se devuelve tuplas, devuelva verdadero o falso. Es un operador lógico.
La sintaxis siempre empieza con "SELECT * FROM", no se ponen atributos ni nada en el select. La operación contraria es NOT EXISTS.
No me puede faltar, dentro de dicha subconsulta, el WHERE cuya condición referencie a la tabla externa.
*/

/*
EJEMPLO 3:
Listado de clientes que han realizado al menos un pedido.
*/
Select * 
	from clientes cli
    where exists (select * from pedidos ped where cli.nroCli = ped.nroCli)
;
