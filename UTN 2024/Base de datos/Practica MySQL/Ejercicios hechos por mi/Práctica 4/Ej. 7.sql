use agencia_personal;
select ent.nombre_entrevistador Nombre, ee.cod_evaluacion CodEvaluacion, count(*) CantidadEntrevistas, AVG(ee.resultado) Promedio, 
STD(ee.resultado) DesvioEstandar, variance(ee.resultado) Varianza 
	from entrevistas ent
	inner join entrevistas_evaluaciones ee on ent.nro_entrevista = ee.nro_entrevista
    group by ent.nombre_entrevistador, ee.cod_evaluacion
    having Promedio > 71 and CantidadEntrevistas > 1
    order by Nombre desc, CodEvaluacion asc
;