/* Práctica 2 - Ejercicio 10*/
/* Listar las empresas solicitantes mostrando la razón social, fecha de cada solicitud y descripción del cargo solicitado. 
Aquellas que tienen contrato indicar nro de contrato.
Mostrar descripción del cargo solicitado.
Si hay empresas que no tengan contrato mostrar leyenda: Sin contrato.
*/

use agencia_personal;
select emp.cuit, emp.razon_social, sol.cuit, sol.cod_cargo, sol.fecha_solicitud, sol.cuit, ifnull(con.cod_cargo, 'Sin contrato') CodCargo, 
ifnull(con.fecha_solicitud, 'Sin fecha de solicitud') FechaSoli, con.nro_contrato, car.desc_cargo CarDesc
	from empresas emp
		inner join solicitudes_empresas sol on emp.cuit = sol.cuit
        inner join cargos car on sol.cod_cargo = car.cod_cargo
        left join contratos con on sol.cuit = con.cuit
									and sol.cod_cargo = con.cod_cargo
									and sol.fecha_solicitud = con.fecha_solicitud
		where sol.cod_cargo = 2;

/*Las condiciones de los inner van todas ordenadas (abajo), las condiciones de los left van inmediatamente en el left (arriba)*/