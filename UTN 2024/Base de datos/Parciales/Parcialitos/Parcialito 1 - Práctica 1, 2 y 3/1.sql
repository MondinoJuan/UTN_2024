/*
**Veleros y Lanchas en almacenamiento**. 
Socios  con las embarcaciones de tipo Velero o Lancha que actualmente se estén guardando (sin fecha y hora de baja de contrato). 
Indicar numero y nombre del socio, hin y nombre de la embarcación, código y nombre de tipo de embarcación. Ordenar alfabéticamente por nombre de tipo de embarcación y 
nombre de la embarcación.
*/


use guarderia_gaghiel;
select soc.numero nroSoc, soc.nombre socNombre, emb.hin HIN, emb.nombre EmbNombre, te.codigo codigoTE, te.nombre nombreTE from embarcacion emb
	inner join tipo_embarcacion te on emb.codigo_tipo_embarcacion = te.codigo
    inner join socio soc on emb.numero_socio = soc.numero
    left join embarcacion_cama ec on emb.hin = ec.hin				/*Aca iba inner*/
	where te.nombre in('Velero', 'Lancha') and ec.fecha_hora_baja_contrato is null
    order by nombreTE asc, EmbNombre asc;
    