/*
-- Actividades y cursos de tipos de embarcación. Listar las actividades que se realizan para los tipos de embarcaciones canoa,
--  kayak, velero y lancha y, si se realizarán cursos que empiezan más adelante indicarlos. Indicar código y nombre del tipo de
-- embarcación; nombre y descripción de la actividad; numero, fecha de inicio y fecha de fin del curso.
*/
use guarderia_gaghiel;
select te.codigo, te.nombre, act.nombre, act.descripcion, cur.numero, cur.fecha_inicio, cur.fecha_fin from tipo_embarcacion te
	inner join actividad act on te.codigo = act.codigo_tipo_embarcacion
	inner join curso cur on act.numero = cur.numero_actividad
	where te.nombre in ('canoa', 'kayak', 'velero', 'lancha');