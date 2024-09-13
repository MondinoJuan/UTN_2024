use agencia_personal;
select ent.nombre_entrevistador, ee.cod_evaluacion, AVG(ee.resultado) Promedio, STD(ee.resultado) DesvioEstandar, 
variance(ee.resultado) Varianza 
	from entrevistas ent
	inner join entrevistas_evaluaciones ee on ent.nro_entrevista = ee.nro_entrevista
    group by ent.nombre_entrevistador, ee.cod_evaluacion
    order by Promedio asc, DesvioEstandar desc;