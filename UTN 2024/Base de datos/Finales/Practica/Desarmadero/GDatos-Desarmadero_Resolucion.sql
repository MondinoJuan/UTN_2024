/* sql 1 */

select c.`razon_social`, c.`email`, v.`patente`
from `vehiculos` v
     inner join clientes c on v.`cuil`=c.`cuil`
where v.`patente` not in
                        (
                         select distinct patente
                         from contrata
                        );

/* fin sql 1 */


/* sql 2 */

select avg(ps.`cantidad`) into @prom
from `partes` p inner join `partes_service` ps
              on p.`cod_parte`=ps.`cod_parte`;

select p.`cod_parte`, p.`desc_parte`, sum(ps.`cantidad`)cant_total
from `partes` p inner join `partes_service` ps
              on p.`cod_parte`=ps.`cod_parte`
group by p.`cod_parte`, p.`desc_parte`
having sum(ps.`cantidad`) > @prom
order by sum(ps.`cantidad`) desc, p.`desc_parte` asc;

/* fin sql 2 */

/* sql 3 */

 select s.`cod_plan`, pm.nombre,s.`localidad`, s.`direccion`, avg(s.`hs_hombre`) t_prom, STDDEV(s.`hs_hombre`)
 from service s inner join `planes_matenimiento` pm
                on s.`cod_plan`=pm.`cod_plan`
 where s.`estado` is not null
 group by s.`cod_plan`, pm.`nombre`, s.`localidad`, s.`direccion`
 ORDER by pm.`nombre`, t_prom desc, s.`localidad`, s.`direccion`;


/* fin sql 3 */


/* sql 4 */

select serv.`cod_servicio`, serv.`desc_servicio`, count(sr.`cod_servicio`)
from
servicios serv left join
`servicios_realizados` sr on serv.`cod_servicio`=sr.`cod_servicio`
group by serv.`cod_servicio`, serv.`desc_servicio`;


/* fin sql 4 */



/* sql 5 */

select s.`localidad`,s.`direccion`,count(*) tarde
from service s inner join `vehiculos` v on s.`patente`=v.`patente`
     inner join clientes c on c.`cuil`=v.`cuil`
     inner join `talleres` t on s.`localidad`=t.`localidad`
                             and t.`direccion`=s.`direccion`
where c.`razon_social` like 'sem%' and s.`fecha_hora_fin_real`>s.`fecha_hora_fin_est`
group by s.`localidad`,s.`direccion`;

/* fin sql 5 */

/* sql 6*/

drop temporary table if EXISTS hs_prom;

create temporary table hs_prom
(
 select s.`cod_plan`, avg(s.`hs_hombre`) hs
 from service s
 where s.`fecha_hora_fin_real` is not null
 group by s.`cod_plan`
);

select c.`razon_social`, v.`patente`, pm.`nombre`, s.`hs_hombre`, hs hs_prom
from service s inner join hs_prom on s.`cod_plan`=hs_prom.cod_plan
     inner join `vehiculos` v on s.`patente`=v.`patente`
     inner join `clientes` c on c.`cuil`=v.`cuil`
     inner join `planes_matenimiento` pm on pm.`cod_plan` =s.`cod_plan`
where s.`hs_hombre`>hs;

/* fin sql 6 */

/* sql 7 */

a)

SELECT hs.`valor_hora` INTO @valor_hora FROM precio_hora hs
WHERE hs.`fecha_desde_hora` = (SELECT max(phm.`fecha_desde_hora`)
                                FROM precio_hora phm
                                WHERE phm.`fecha_desde_hora` <= '20111103');


SELECT s.`hs_hombre` * @valor_hora INTO @importe_horas
FROM  service s
WHERE s.`patente` = 'CCC 666'
AND s.`fecha_hora_service` >= '20111103T120000';

b1)

drop temporary table if exists vparte;

create temporary table vparte
(
 select vp.`cod_parte`, max(vp.`fecha_desde_parte`) fec_parte
 from `valores_parte` vp
 where vp.`fecha_desde_parte`<='20111103'
 group by vp.`cod_parte`
);

b2)

select sum(vp.`valor_parte`*ps.`cantidad`) 
from `partes_service` ps inner join vparte on ps.cod_parte=vparte.cod_parte
     inner join `valores_parte` vp on vp.`cod_parte`=vparte.cod_parte and
                                      vp.`fecha_desde_parte`=vparte.fec_parte
     inner join partes p on ps.`cod_parte`=p.`cod_parte`
where ps.`patente`='CCC 666' and ps.`fecha_hora_service` ='20111103T120000';

SELECT @importe_partes, @importe_horas

c) (el nombre de las tablas FACTURAS y PAGOS depende de las que hayan generado)

START TRANSACTION;

       INSERT INTO facturas VALUES(1,'20111103', @importe_partes + @importe_horas);
       INSERT INTO pagos VALUES (1,'20111103', 1000);
       UPDATE servicios
       SET nro_factura = 1
       WHERE ps.`patente`='CCC 666' and ps.`fecha_hora_service` ='20111103T120000';
COMMIT;

       
/* fin sql 7 */



