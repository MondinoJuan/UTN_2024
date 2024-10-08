use guarderia_gaghiel;

/*
Actualizo todas las inscripciones que no tienen legajo, a que su legajo sea 99.
*/
start transaction;
update inscripcion set legajo = 99
	where legajo is null;
-- commit;


/*
Se usa la clase empleado usada en parcial de recuperación de AD.
*/
insert into empleado
select id_persona, cuit, nombre, apellido, telefono, email
	from personas
    where tipo = "E";
-- commit;
/*
En parcialito hacer siempre todas las transacciones y al final dejar un solo commit. Lo mismo con start transaction.
Insert con select es útil, por ejemplo para actualizar los precios. Update con inner recontra útil también, se actualiza una de las 
tablas. Pero, Delete de más de una tabla no se usa nunca, por lo que Delete con inner (aunque se puede hacer) no es utilizado porque borras 
más de una tabla.
Si yo quiero borrar un sector por ejemplo, tengo que tener cuidado que una cama no me lo esté usando porque no me va a permitir realizar el 
Delete. 
*/

/*
Insert-select es lo mas sencillo y utilizado, por ejemplo:
*/
insert into valores_plan (nom_plan, fecha_desde_plan, valor_plan)
select val.nom_plan, '20090601', val.valor_plan, '1.2'
	from valores_plan val
    inner join
		(
		select vp.nom_plan, max(vp.fecha_desde_plan), ult_fecha
			from valores_plan vp
			group by vp.nom_plan
		)
;
/*
Tienen que ser unión compatible.
No llegue a ver, por lo que no se si está bien escrito esto.
*/