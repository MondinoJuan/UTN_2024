
/*
Viejos Amigos Instalaciones
*/

/* SQL 1 */

select em.`cuil`,em.`nombre`,em.`apellido`
from empleados em inner join
     evento ev on em.`cuil`=ev.`cuil_empleado` inner join
     `tipos_evento` te on ev.`cod_tipo_evento`=te.`cod_tipo_evento`
where te.`desc_tipo_evento`='Fiesta';

/* FIN SQL 1 */

/* SQL 2 */

select distinct i.`tipo_instalacion`,i.`codigo`
from `instalaciones` i inner join
     `contrata` c on c.`codigo_instalacion`=i.`codigo`
where c.`nombre_servicio`='decorado';

/* FIN SQL 2 */

/* SQL 3 */

select * from `organizadores`
where cuit not in
(
select e.`cuit_organizador`
from `evento` e inner join
     `instalaciones_eventos` ie
                     on e.`nro_contrato`=ie.`nro_contrato` inner join
     `instalaciones_servicios` ise
                     on ie.`codigo_instalacion`=ise.`codigo_instalacion`
where ise.`nombre_servicio`='catering'
);

/* FIN SQL 3 */

/* SQL 4 */

--se acepta el sum o el count
select o.`razon_social`, em.`nombre`,em.`apellido`, ev.`representante`,
count(*) 'servicios por eventos', sum(c.`cantidad`)
from `organizadores` o inner join
     `evento` ev
                 on o.`cuit`=ev.`cuit_organizador` inner join
     `empleados` em
                 on ev.`cuil_empleado`=em.`cuil` inner join
     `instalaciones_eventos` ie
                 on ev.`nro_contrato`=ie.`nro_contrato` inner join
     `contrata` c on c.`nro_contrato`=ie.`nro_contrato`
                  and c.`codigo_instalacion`=ie.`codigo_instalacion`
                  and c.`fecha_desde`=ie.`fecha_desde`
                  and c.`hora_desde`=ie.`hora_desde`
group by o.`cuit`, ev.`nro_contrato`,o.`razon_social`, em.`nombre`,em.`apellido`, ev.`representante`;

/* FIN SQL 4 */

/* SQL 5 */

select s.`nombre`,s.`descripcion`,count(c.`codigo_instalacion`) 'recuento de usos'
,sum(c.`cantidad`) 'cantidad usada'
from `evento` ev inner join
     `instalaciones_eventos` ie
                 on ev.`nro_contrato`=ie.`nro_contrato` inner join
     `contrata` c on c.`nro_contrato`=ie.`nro_contrato`
                  and c.`codigo_instalacion`=ie.`codigo_instalacion`
                  and c.`fecha_desde`=ie.`fecha_desde`
                  and c.`hora_desde`=ie.`hora_desde` right join
     servicios s on c.`nombre_servicio`=s.`nombre`
group by s.`nombre`,s.`descripcion`;

/* FIN SQL 5 */

/* SQL 6 */

select s.`nombre`,s.`descripcion`,vals.`fecha_desde`,vals.`valor`
from `servicios` s inner join
(
select vs.`nombre`, max(vs.`fecha_desde`) fecha
from`valores_servicios` vs
where vs.`fecha_desde`<CURRENT_DATE
group by vs.`nombre`
)precios on s.`nombre`=precios.nombre
inner join `valores_servicios` vals on
vals.`fecha_desde`=precios.fecha and vals.`nombre`=s.`nombre`;

/* FIN SQL 6 */

/* SQL 7 */

select @fecha_ev3:=ev.`fecha_contrato`
from `evento` ev
where ev.`nro_contrato`=3;--por ahora se puede buscar a mano la fecha

select 'Total Alq Inst' Concepto, sum(ie.`valor_pactado`) Importe
from `instalaciones_eventos` ie
where ie.`nro_contrato`=3

union all --pueden usar union sin el all. En este caso es sólo una cuestion de performance

select 'Servicios' Concepto, sum(c.`cantidad`*vs.`valor`) Importe
from contrata c inner join
     (
      select vals.`nombre`, max(vals.`fecha_desde`) fecha
      from `valores_servicios` vals
      where vals.`fecha_desde`<@fecha_ev3
      group by vals.`nombre`
     ) prec on c.`nombre_servicio`=prec.nombre inner join
     `valores_servicios` vs on  vs.`nombre`=prec.nombre
                            and vs.`fecha_desde`=prec.fecha

;
/* FIN SQL 7 */

/* SQL 8 */

select em.`cuil`, em.`nombre`, em.`apellido`, count(ev.`nro_contrato`)
from `empleados` em left join
      evento ev on em.`cuil`=ev.`cuil_empleado`
group by em.`cuil`, em.`nombre`, em.`apellido`
order by count(ev.`nro_contrato`) desc, em.`nombre`, em.`apellido`;

/* FIN SQL 8 */

/* SQL 9 */

select ie.`codigo_instalacion`, i.`tipo_instalacion`, sum(ie.`valor_pactado`) gasto_total
from `instalaciones_eventos` ie inner join
     `instalaciones` i on ie.`codigo_instalacion`=i.`codigo`
group by ie.`codigo_instalacion`, i.`tipo_instalacion`
having gasto_total>5000;

/* FIN SQL 9 */

/* SQL 10 */

drop temporary table if exists cant;
create temporary table cant
(SELECT ev.nro_contrato, count(*) cant_serv
from evento ev 
inner join instalaciones_eventos ie
on    ev.`nro_contrato`=ie.`nro_contrato`
inner join contrata c
on ie.nro_contrato=c.nro_contrato and ie.`codigo_instalacion`=c.`codigo_instalacion`
and ie.`fecha_desde`=c.`fecha_desde` and ie.`hora_desde`=c.`hora_desde`
group by ev.`nro_contrato`);

drop temporary table if exists promedio;
create temporary table promedio
(
SELECT  avg(cant_serv) prom from cant);

SELECT nro_contrato, cant_serv from cant
where cant_serv > (SELECT * from promedio)


/* FIN SQL 10 */

/* SQL 11 */

insert into `valores_servicios`(nombre,fecha_desde,valor)
values ('emergencias',CURRENT_DATE,8000);

/* FIN SQL 11 */

/* SQL 12 */

begin;--o start tansaction;

insert into servicios(nombre,descripcion)
values('efectos de luces','espejitos de colores');

insert into `valores_servicios`(nombre,fecha_desde,valor)
values('efectos de luces',CURRENT_DATE,10000);

insert into `instalaciones_servicios`( `codigo_instalacion`, `nombre_servicio`)
values(7,'efectos de luces');

commit;
/* FIN SQL 12 */
/* SQL 13 */
select *
from `instalaciones` i inner join
     `tipos_evento_instalaciones` tei on i.`codigo`=tei.`codigo` inner join
     `tipos_evento` te on tei.`cod_tipo_evento`=te.`cod_tipo_evento`
where i.`codigo` not in
                       (
                        select ie.`codigo_instalacion`
                        from `instalaciones_eventos` ie
                        where ie.`fecha_desde`<='20080717'
                              and ie.`fecha_hasta`>='20080717'
                       )
and te.`desc_tipo_evento`='fiesta';

/* FIN SQL 13 */
