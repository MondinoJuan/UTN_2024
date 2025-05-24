
--SQL 1.
select e.nro_evento, fecha_evento, fecha_recomendacion, descripcion
from eventos e
INNER JOIN `eventos_recomendaciones` er
ON e.nro_evento = er.`nro_evento`
INNER JOIN recomendaciones r
ON er.`cod_recomendacion`= r.`cod_recomendacion`
where `fecha_recomendacion`>='20100101'
and `fecha_recomendacion`<='20101231'

--SQL 2
select count(*) into @total
from `programas_trabajo` where fecha_fin is not null;

select count(*) cantidad, count(*)/@total *100 porcentaje
from `programas_trabajo` p left join resultados r
on p.`cod_resultado`=r.`cod_resultado`
where r.`descripcion`='Exitoso' and year(p.`fecha_fin`)=2011;

--SQL 3.
--obtengo la maxima fecha estado de todos los estados

drop temporary table if exists maxestado;
create temporary table maxestado
(select nro_evento, fecha_comienzo, max(fecha_estado) maxfecha
from `programas_estados`
group by 1,2) ;

-- para las máximas fecha estado, obtengo el estado de solo aquellas que están
--canceladas y no finalizadas.
---HAY QUE PONERLE FECHA_FIN A LOS EVENTOS DEL 500 AL 900
--HAY QUE PONERLE FECHA FIN_IN IS NULL A LOS EVENTOS QUE NO ESTPAN
 --FINALIZADOS DEL 100 AL 400 y sacarle resultado exitoso   LISTO
SELECT pt.nro_evento, pt.descripcion, pt.fecha_comienzo, pe.fecha_estado, e.cod_estado,
 e.descripcion
from  `programas_trabajo` pt
inner join `programas_estados` pe
on pt.nro_evento = pe.nro_evento
and pt.`fecha_comienzo` = pe.`fecha_comienzo`
inner join maxestado me
on pe.nro_evento = me.nro_evento
and pe.`fecha_comienzo` = me.fecha_comienzo
and pe.fecha_estado =me.maxfecha
inner join estados e
on pe.cod_estado = e.cod_estado
where fecha_fin is not NULL and e.descripciOn like "%CANCELADO%";
---

--SQL 4

select e.`nro_evento`, e.`fecha_evento`, count(p.`nro_evento`) cantidad
from `eventos` e inner join
    `programas_trabajo` p on e.`nro_evento`=p.`nro_evento`
where p.`fecha_fin` is null
group by e.`nro_evento`, e.`fecha_evento`

--DATOS: agregar más programas para que algún evento tenga más de 1 programa!!!    LISTO

--SQL 5

-- Seria bueno agregar algunos eventos más con otros tipos

SELECT  descripcion,  COUNT(*)
from `eventos` e
inner join tipo_eventos tp
on e.tipo_evento = tp.`tipo_evento`
group by 1
order by 2 desc, 1 asc
--SQL 6

select e.`nro_evento`, rec.`cod_recomendacion`, rec.`descripcion` desc_rec,
      er.`fecha_recomendacion`, p.`fecha_comienzo`, p.`descripcion` desc_programa
from `eventos` e left join
    `eventos_recomendaciones` er on e.`nro_evento`=er.`nro_evento` left join
    `recomendaciones` rec on er.`cod_recomendacion`=rec.`cod_recomendacion` left join
    `programas_trabajo` p on e.`nro_evento`=p.`nro_evento`;
--DATOS: cada evento tiene una única recomendación, agregar más  LISTO
-- el tipo de evento de unos eventos no coincide con el tipo de evento de sus recomendaciones!!!!!!!!!!!  LISTO

--SQL 7
Hay que agregar niveles de riesgo que no se use en ningún evento. Y más prgramas de trabajo al menos 5 registros LISTO


select count(*) into @cantprog
from `programas_trabajo` ;

select nr.nivel_riesgo, nr.descripcion, count(*) cantidad, count(*)/@cantprog "Porc"
from niveles_riesgo nr
LEFT JOIN eventos e
on e.nivel_riesgo = nr.`nivel_riesgo`
LEFT JOIN `programas_trabajo` pt
on e.`nro_evento` = pt.`nro_evento`
left JOIN  resultados r
on pt.`cod_resultado`=r.`cod_resultado`
where pt.`cod_resultado` <> 1 or pt.`cod_resultado` is null
GROUP BY 1, 2
order by nr.`descripcion` asc,  cantidad DESC

--8
select * from
`eventos_recomendaciones`er
inner JOIN `programas_trabajo` pt on pt.`nro_evento`= er.`nro_evento`
where pt.`fecha_fin` is NULL and cod_motivo = 1

--SQL 9
--Agregar más registros en eventos_recomendaciones, donde la descripcion de nivel de riegos tenga la palaba ALTO   LISTO
 drop temporary table if exists evenivelalto;
create temporary table evenivelalto
( select e.nro_evento, count(*) cantidad
 from eventos e
 inner join `eventos_recomendaciones` er
 on e.nro_evento = er. nro_evento
 inner join niveles_riesgo nr on e.nivel_riesgo = nr.`nivel_riesgo`
  where nr.descripcion like "%ALTO%"
 group by 1
 having  cantidad > 3);

 select e.nro_evento,e.fecha_evento, fecha_recomendacion, r.descripcion recomendacion,
 t.descripcion tipoevento, ni.`descripcion`
 from eventos e
 inner join `eventos_recomendaciones` er
 on e.nro_evento=er.nro_evento
 INNER join `recomendaciones` r
 on er.`cod_recomendacion` = r.cod_recomendacion
 INNER JOIN `tipo_eventos` t ON e.`tipo_evento`=t.`tipo_evento`
 inner join `niveles_riesgo` ni on e.`nivel_riesgo` = ni.`nivel_riesgo`
where e.nro_evento in (select nro_evento from evenivelalto)

--sql 10
select evrec.`cod_recomendacion` from `eventos_recomendaciones` evrec
inner join recomendaciones on
evrec.`cod_recomendacion` = `recomendaciones`.`cod_recomendacion`
where evrec.fecha_recomendacion between "2011-04-01" and "2011-04-31"
rec.`cod_recomendacion` not in (select er.`cod_recomendacion` from `eventos_recomendaciones`er
where er.`fecha_recomendacion` between "2011-3-01" and "2011-03-31")


--SQL 11
update programas_estados set cod_estado = 4
where fecha_estado = "2011-04-15" and
cod_estado = 5

--SQL 13

