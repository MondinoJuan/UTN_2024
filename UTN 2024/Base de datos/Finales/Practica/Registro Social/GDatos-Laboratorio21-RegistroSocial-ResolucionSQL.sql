/* 
    SQL Manager 2005 Lite for MySQL
    SQL Editor queries
 */

/*  Page 1  */

--1

select sum(i.cantidad_importe) into @importe
from `intervenciones-soluciones` i
where i.`nro_intervencion` = 3
and i.`cod_solucion`=9;

Select @importe Comprometido, sum(s.`cantidad_importe`) entregado,
@importe - sum(s.`cantidad_importe`) adeudado
 from `intervenciones-soluciones` i
inner join seguimiento s on
i.`nro_intervencion`= s.`nro_intervencion` and
i.`cod_solucion`=s.`cod_solucion` and
i.`fecha_compromiso`=s.`fecha_compromiso`
 where i.`nro_intervencion` =3 AND i.`cod_solucion`=9
 
 


--2
select i.`nro_intervencion`, isol.`cod_solucion`, sol.`descr_solucion`
from `intervenciones` i
LEFT join `intervenciones-soluciones` isol on isol.`nro_intervencion` = i.`nro_intervencion`
left join `soluciones` sol on sol.`cod_solucion` = isol.`cod_solucion`
where year(fecha) = 2011 and i.`fecha_baja` is  NULL
 
 
 --3
 drop temporary table if exists importes;
create temporary table importes
(select isol.`nro_intervencion`,isol.`cod_solucion`, isol.`fecha_compromiso`, isol.`cantidad_importe`
from `intervenciones-soluciones` isol
inner join soluciones sol on isol.`cod_solucion` = sol.`cod_solucion`
where sol.`descr_solucion` like "%CHEQUE%");


select seg.`nro_intervencion`, seg.`cod_solucion`, seg.`fecha_compromiso`, sol.`descr_solucion`,
seg.`fecha_entrega`, seg.`cantidad_importe`, imp.cantidad_importe "Cantidad Comprometida",
 ((seg.`cantidad_importe`/imp.cantidad_importe) * 100) Porcentaje
from importes imp
inner JOIN seguimiento seg on imp.nro_intervencion = imp.`nro_intervencion`
and imp.`cod_solucion` = seg.`cod_solucion`
and imp.`fecha_compromiso` = seg.`fecha_compromiso`
inner join soluciones sol on seg.`cod_solucion` = sol.`cod_solucion`

--4
select count(*) into @cantidad
from `entrevistas`
where year(fecha)=2011;

select nombre, apellido, count(nro_entrevista) cantidad, (count(nro_entrevista)/@cantidad) * 100 Porcentaje
from empleados emp
left join entrevistas ent
on emp.nro_legajo = ent.nro_legajo
group by 1,2


--5
SELECT p.tipo_doc, p.nro_doc, nombre, apellido
from personas p
inner join grupo_personas  g on
p.`tipo_doc` = g.`tipo_doc` and
p.`nro_doc` = g.`nro_doc`
inner join `grupo_familiar` gf on
gf.`id_grupo` = g.`id_grupo`
INNER JOIN `intervenciones` inter
ON inter.`id_grupo` = g.`id_grupo`
UNION
SELECT p.tipo_doc, p.`nro_doc`, nombre, apellido
from personas p
inner join `intervenciones_microemprendimientos` im on
p.tipo_doc = im.`tipo_doc` and
p.`nro_doc` = im.`nro_doc`

--6
SELECT t.`cod_tematica`, t.`desc_tematica`
from tematica t inner join
intervenciones i on
t.`cod_tematica` = i.cod_tematica
where YEAR(fecha) = 2010
and t.`cod_tematica`
not in (SELECT t.`cod_tematica`
from tematica t inner join
intervenciones i on
t.`cod_tematica` = i.cod_tematica
where YEAR(fecha) = 2011)


--7
SELECT inter.`nro_intervencion`, fecha, inter.`desc_interv`, inst.`nombre`,
rub.`desc_rubro`, sol.`descr_solucion`,
seg.`fecha_entrega`, seg.`cantidad_importe`, seg.`observacion`
from intervenciones inter
inner join instituciones inst on inter.cuit = inst.cuit
inner join `inst_rubros` ir on inter.cuit = ir.cuit
inner join rubros rub on ir.`cod_rubro`=rub.`cod_rubro`
inner join `intervenciones-soluciones` intersol
on intersol.nro_intervencion = inter.`nro_intervencion`
inner join `seguimiento` seg on intersol.`nro_intervencion` = seg.`nro_intervencion`
and intersol.`cod_solucion`=seg.`cod_solucion`
AND  intersol.`fecha_compromiso` = seg.`fecha_compromiso`
inner join soluciones sol on sol.`cod_solucion`=seg.`cod_solucion`
where inter.cuit is NOT null;




--8
SELECT sol.`cod_solucion`, sol.`descr_solucion`, ifnull(inter.`nro_intervencion`, "sin interv"),
inter.`cod_tematica`,  inter.`fecha`,te.`desc_tematica`
FROM soluciones sol
left join `intervenciones-soluciones` intersol on sol.`cod_solucion`= intersol.`cod_solucion`
left join `intervenciones` inter on intersol.`nro_intervencion` = inter.`nro_intervencion`
left join `tematica` te on inter.`cod_tematica`= te.`cod_tematica`

--9
select tm.`desc_tematica`, count(inter.`nro_intervencion`)
from `tematica` tm
left join `intervenciones` inter on tm.`cod_tematica`=inter.`cod_tematica`
group by 1
order by 1


--10
START TRANSACTION;

      UPDATE `grupo_personas`
      SET grupo_personas.`fecha_hasta` = '20100113'
      WHERE grupo_personas.`id_grupo` = 1
         AND grupo_personas.`tipo_doc` = 'DNI'
         AND grupo_personas.`nro_doc` = 1532636
         and `grupo_personas`.`fecha_desde` = '20100101';
         
      INSERT `grupo_personas` VALUES(2,'DNI',1532636,'20100113',NULL);
COMMIT;
         


--11 no se puede resolver con simple comparacion de fechas.
 -- se puede realizar con una subconsulta como la que está acá
 -- o hacer una tabla temporal

 Select i.`nro_intervencion`,i.cod_tematica, t.`desc_tematica`,
  i.id_grupo, gf.`descripcion`, s.`cod_solucion`, sol.`descr_solucion`,
 gp.`nro_doc`, gp.`tipo_doc`, nombre, apellido
 from `intervenciones` i
 inner join `intervenciones-soluciones` s ON
  i.`nro_intervencion` = s.`nro_intervencion`
 inner join `tematica` t on i.cod_tematica = t.`cod_tematica`
 inner join `soluciones` sol ON s.`cod_solucion` = sol.`cod_solucion`
inner join `grupo_familiar` gf ON i.id_grupo = gf.`id_grupo`
inner join `grupo_personas` gp on i.id_grupo = gp.`id_grupo`
inner join `personas` per on gp.`tipo_doc` = per.`tipo_doc`
and gp.`nro_doc` = per.`nro_doc`
  where i.`nro_intervencion` = 3
  AND gp.fecha_desde = (SELECT MIN(gfp.fecha_desde)
                        FROM `grupo_personas` gfp
                        WHERE gfp.`id_grupo` = gp.`id_grupo`
                          AND gfp.`tipo_doc` = gp.tipo_doc
                          AND gfp.`nro_doc` = gp.nro_doc
                          AND gfp.`fecha_desde` <= i.fecha
                          AND (gfp.`fecha_hasta` >=i.fecha OR
                              gfp.fecha_hasta IS NULL)
                          GROUP BY gfp.`id_grupo`, gfp.`tipo_doc`,
                          gfp.`nro_doc`)

--12
 drop temporary table if exists maxinterven;
create temporary table maxinterven
(select seg.`nro_intervencion`, seg.`cod_solucion`, seg.`fecha_compromiso`, MAX(fecha_entrega) maxifecha
from `seguimiento` seg
group by 1,2,3);

select seg.`nro_intervencion`, seg.`cod_solucion`, seg.`observacion`, maxifecha
from seguimiento seg
inner join maxinterven maxi
on seg.`nro_intervencion` = maxi.nro_intervencion
and seg.cod_solucion = maxi.cod_solucion
and seg.fecha_compromiso = maxi.fecha_compromiso
and seg.`fecha_entrega`= maxi.maxifecha

-- 13

START TRANSACTION;

   UPDATE `intervenciones`
   SET `intervenciones`.`fecha_baja` = '20101231'
   WHERE YEAR(`intervenciones`.`fecha`) = 2010
   AND `intervenciones`.`fecha` is not null
   
COMMIT;


