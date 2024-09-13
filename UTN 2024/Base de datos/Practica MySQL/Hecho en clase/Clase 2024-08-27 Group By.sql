/*
a- Mostrar las empresas con sus solicitudes y contratos. (INNER JOIN en contratos)
b- Aquellas que tengan contratos, indicar tambien las solicitudes sin contratos. (LEFT JOIN en contratos)
*/
use agencia_personal;
select emp.cuit, emp.razon_social, se.cuit, se.cod_cargo, se.fecha_solicitud, 
count(*) "cant solicitudes", count(se.cuit) "cant solicitudes", count(con.cuit) "cant contratos", count( distinct se.cod_cargo) "cant soli distintas"
-- con.cuit, con.cod_cargo, con.fecha_solicitud
	from empresas emp
    inner join solicitudes_empresas se on emp.cuit = se.cuit
    left join contratos con on se.cuit = con.cuit 
							and se.cod_cargo = con.cod_cargo
                            and se.fecha_solicitud = con.fecha_solicitud
	/*Uno por todas las claves primarias que comparten.*/
    -- where se.cod_cargo < 5
	group by emp.cuit, emp.razon_social, se.cod_cargo, se.fecha_solicitud
    -- having count(*) < 2
    order by emp.razon_social;
    
/*
En el GROUP BY poner todos los atributos que se encuentran en el select, es buena práctica hacerlo. Si no tengo una función de grupo no pongo
el GROUP BY.
Si no lo hacemos nos bajan puntos.
Si no tengo atributos sueltos, no agrupo por nada.
En el HAVING van siempre funciones de grupo, NO atributos sueltos. Los atributos sueltos van en el WHERE.
COUNT(atributo) cuenta atributos no nulos.
COUNT(*) cuenta registros. Es igual a usar un atributo que no puede ser nulo.
COUNT(DISTINCT atributo) cuanta las entidades con dicho atributo diferentes.
En el COUNT no us el IF NULL.
*/