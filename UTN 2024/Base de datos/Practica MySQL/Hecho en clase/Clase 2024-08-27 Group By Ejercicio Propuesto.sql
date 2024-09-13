/*
Empresas con menos solicitudes: Listar las empresas que realizaron menos de 3 solicitudes.
Indicar cuit de la empresa, razón social de la empresa y cantidad de solicitudes ralizadas.
*/

use agencia_personal;
select emp.cuit CUIT, emp.razon_social RazonSocial, count(se.cuit) CantSolicitudes
	from empresas emp
    left join solicitudes_empresas se on emp.cuit = se.cuit
    group by emp.cuit, emp.razon_social
    having count(se.cuit) < 3
;

/*
En el GROUP BY poner todos los atributos que no sean funcion de agregación.
Se hace con left porque las que la cantidad de solicitudes es 0 tambien las tengo que tener en cuenta.
*/