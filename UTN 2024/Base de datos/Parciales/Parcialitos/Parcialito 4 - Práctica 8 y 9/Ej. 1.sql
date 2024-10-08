/*
302.6- Reemplazo por sábatico: 
El instructor Yang Wen-li va a tomarse un año sabático a partir del 10 de octubre de 2024, la empresa ha decidido contratar a una 
nueva instructora:

Legajo: 20
Cuil: 20-01234567-9
Nombre y apellido: Frederica Greenhill
Teléfono: 555-0120

Ella puede dictar las mismas actividades que Yang Wen-li y debe reemplazarlo como instructor en sus cursos que inicien posteriormente a la 
fecha indicada.
*/

use guarderia_gaghiel;

select legajo into @legajoYang
	from instructor
    where nombre = "Yang" and apellido = "Wen-li"
;

-- Compruebo si esta en mas tablas.
select numero_actividad from instructor_actividad
	where legajo_instructor = @legajoYang
;

select numero from curso
	where legajo_instructor = @legajoYang
;

start transaction;

insert into instructor value (20, "20-01234567-9", "Federica", "Greenhill", "555-0120");

insert into instructor_actividad
	select 20, numero_actividad
		from instructor_actividad
		where legajo_instructor = @legajoYang;

UPDATE curso
	SET legajo_instructor = 20
	WHERE legajo_instructor = @legajoYang and fecha_inicio >= "2024-10-04"
;

-- commit;

