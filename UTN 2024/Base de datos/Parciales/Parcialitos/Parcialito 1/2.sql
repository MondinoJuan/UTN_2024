/*
**Actividades y cursos para lanchas y wind surf**
Listar las actividades para los tipos de embarcaciones 'Lancha' y 'Tabla Wind Surf' y, 
si se realizaron cursos desde abril al presente mostrarlos. Indicar numero y nombre de la actividad, nombre del tipo de embarcacion, numero, fecha de inicio y fecha de fin del curso.
*/

use guarderia_gaghiel;
select act.numero nroAct, act.nombre nombreAct, te.nombre nombreTE, cur.numero nroCur, cur.fecha_inicio, cur.fecha_fin from tipo_embarcacion te
	inner join actividad act on te.codigo = act.codigo_tipo_embarcacion
	left join curso cur on act.numero = cur.numero_actividad /*and cur.fecha_inicio < '2024-08-06' and cur.fecha_inicio >= '2024-04-01'*/
	where te.nombre in ('Tabla Wind Surf', 'Lancha');