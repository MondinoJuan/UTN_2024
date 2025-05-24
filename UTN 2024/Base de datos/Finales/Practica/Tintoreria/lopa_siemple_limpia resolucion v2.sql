/* SQL 1 */

select desc_tratamiento
from `tratamientos_procesos` tp
  inner join tratamientos t on tp.`cod_tratamiento`=t.`cod_tratamiento`
  inner join procesos p on p.`cod_proceso`=tp.`cod_proceso`
where p.`desc_proceso`='lavado'

/* Fin SQL 1 */

/* SQL 2 */

select e.cuil,e.`nom_ape`, count(*) cantidad
from `procesos_realizados` pr inner join empleados e on pr.`cuil_empleado`=e.cuil
where pr.`resultado_proceso`='Insatisfactorio'
group by e.`cuil`, e.`nom_ape`
order by cantidad desc

/* Fin SQL 2 */

/* SQL 3 */

select e.cuil, e.`nom_ape`, count(*)*25 'total a abonar'
from procesos p
  inner join `procesos_realizados` pr on p.`cod_proceso`=pr.`cod_proceso`
  inner join `empleados` e on pr.`cuil_empleado`=e.cuil
where p.`precauciones` like '%mascara para gases%'
      and pr.`fecha_inicio` BETWEEN '20080901' and '20080930'
group by e.`cuil`,e.`nom_ape`

/* Fin SQL 3 */

/* SQL 4 */

select tl.`cod_tratamiento`, t.`desc_tratamiento`, m.`nro_maquina`, m.`desc_maquina`,
 p.`cod_proceso`,p.`desc_proceso`, e.`cuil`, e.`nom_ape`
from tratamiento_limpieza tl
   inner join tratamientos t on tl.`cod_tratamiento`=t.`cod_tratamiento`
   left join `procesos_realizados` pr on  tl.`nro_servicio`=pr.`nro_servicio`
                                      and tl.`orden`=pr.`orden`
   left join `procesos` p on pr.`cod_proceso`=p.`cod_proceso`
   left join `empleados` e on pr.`cuil_empleado`=e.`cuil`
   left join  maquinas m on t.`nro_maquina_utiliza`=m.`nro_maquina`
where tl.nro_servicio = 2

/* Fin SQL 4 */

/* SQL 5 */

select m.`nro_maquina`, m.`desc_maquina`, count(*) usos
from `tratamiento_limpieza` tl
  inner join `tratamientos` t on tl.`cod_tratamiento`=t.`cod_tratamiento`
  right join maquinas m on t.`nro_maquina_utiliza`=m.`nro_maquina`
group by m.`nro_maquina`, m.`desc_maquina`
having usos>4

/* Fin SQL 5 */

/* SQL 6 */

--solución A
select (select count(*) from `servicios_limpieza`) 'Cantidad Total Servicios',
count(*) 'Cantidad Servicios Sin Extra',
count(*)/(select count(*) from `servicios_limpieza`)*100 '% Servicios Sin Extra'
from `servicios_limpieza`
where nro_servicio not in
                         (
                          select distinct tl.`nro_servicio`
                          from `tratamiento_limpieza` tl
                            inner join `tratamientos` t on tl.`cod_tratamiento`=t.`cod_tratamiento`
                            inner join `tratamientos_procesos` tp on tp.`cod_tratamiento`=t.`cod_tratamiento`
                            inner join `procesos` p on p.`cod_proceso`=tp.`cod_proceso`
                          where t.`desc_tratamiento` like '%tintura%'
                                or p.`desc_proceso` in ('limpieza','decoloracion','realzar color')
                         )
                         
--solución B

select @total_servicios:=count(*) from `servicios_limpieza`;

select @total_servicios 'Cantidad Total Servicios',
count(*) 'Cantidad Servicios Sin Extra',
count(*)/@total_servicios*100 '% Servicios Sin Extra'
from `servicios_limpieza`
where nro_servicio not in
                         (
                          select distinct tl.`nro_servicio`
                          from `tratamiento_limpieza` tl
                            inner join `tratamientos` t on tl.`cod_tratamiento`=t.`cod_tratamiento`
                            inner join `tratamientos_procesos` tp on tp.`cod_tratamiento`=t.`cod_tratamiento`
                            inner join `procesos` p on p.`cod_proceso`=tp.`cod_proceso`
                          where t.`desc_tratamiento` like '%tintura%'
                                or p.`desc_proceso` in ('limpieza','decoloracion','realzar color')
                         );
                         
--solucion C

drop temporary table if exists tot_serv;

create temporary table tot_serv
(
 select count(*) total_servicios from `servicios_limpieza`
);

drop temporary table if exists tot_serv2;

create temporary table tot_serv2
(
 select * from tot_serv
);


select (select total_servicios from tot_serv2) 'Cantidad Total Servicios',
count(*) 'Cantidad Servicios Sin Extra',
count(*)/(select total_servicios from tot_serv)*100 '% Servicios Sin Extra'
from `servicios_limpieza`
where nro_servicio not in
                         (
                          select distinct tl.`nro_servicio`
                          from `tratamiento_limpieza` tl
                            inner join `tratamientos` t on tl.`cod_tratamiento`=t.`cod_tratamiento`
                            inner join `tratamientos_procesos` tp on tp.`cod_tratamiento`=t.`cod_tratamiento`
                            inner join `procesos` p on p.`cod_proceso`=tp.`cod_proceso`
                          where t.`desc_tratamiento` like '%tintura%'
                                or p.`desc_proceso` in ('limpieza','decoloracion','realzar color')
                         );

/* Fin SQL 6 */

/* SQL 7 */

set @nro_serv:=5;
select @fec_serv:=fecha_entrega from `servicios_limpieza` where nro_servicio=@nro_serv;

drop temporary table if exists val_actual;

create temporary table val_actual
(
 select cod_tratamiento, max(fecha_desde) fecha_aplica
 from `valores_tratamientos`
 where fecha_desde<=@fec_serv
 group by cod_tratamiento
);

select sl.nro_servicio, c.`tipo_doc`, c.`nro_doc`, c.`nom_ape`,t.`desc_tratamiento`,
       vt.`valor`
from `tratamiento_limpieza` tl
  inner join val_actual va on tl.`cod_tratamiento`=va.cod_tratamiento
  inner join `valores_tratamientos` vt on  va.cod_tratamiento=vt.cod_tratamiento
                                       and va.fecha_aplica=vt.`fecha_desde`
  inner join `servicios_limpieza` sl on sl.`nro_servicio`=tl.`nro_servicio`
  inner join clientes c on sl.`tipo_doc`=c.tipo_doc and sl.`nro_doc`=c.nro_doc
  inner join tratamientos t on t.`cod_tratamiento`=tl.`cod_tratamiento`
where tl.`nro_servicio`=@nro_serv;

/* Fin SQL 7 */

/* SQL 8 */

select sl.`nro_servicio`, sl.prenda, sl.`fecha_dev_est`, sl.`tipo_doc`, sl.`nro_doc`, c.`nom_ape`
 from tratamiento_limpieza tl
   inner join tratamientos t on tl.`cod_tratamiento`=t.`cod_tratamiento`
   inner join  maquinas m on t.`nro_maquina_utiliza`=m.`nro_maquina`
   inner join `servicios_limpieza` sl on tl.`nro_servicio`=sl.`nro_servicio`
   inner join `clientes` c on sl.`tipo_doc`=c.`tipo_doc` and sl.`nro_doc`=c.`nro_doc`
where m.`desc_maquina`='lavadora-secadora' and sl.`fecha_dev_real` is null

/* Fin SQL 8 */

/* SQL 9 */

-- Solución A

select @ent_tarde:=count(*)
from `servicios_limpieza` sl
where
sl.`fecha_dev_real`>sl.`fecha_dev_est`;

select (count(*)-@ent_tarde)/count(*)*100 '% entregados a tiempo', @ent_tarde/count(*)*100 '% entregados a tarde'
from `servicios_limpieza`
where fecha_dev_real is not null;

-- Solución B - Propuesta por María Alejandra García

create temporary table serv_tarde
(select 'si' entrega_tarde,sl.nro_servicio
from `servicios_limpieza` sl
where sl.`fecha_dev_real`>sl.`fecha_dev_est`);

select (count(*)-count(serv_tarde.entrega_tarde))/count(*)*100 proporcion_atiempo,
count(serv_tarde.entrega_tarde)/count(*)*100 proporcion_tarde
from `servicios_limpieza` sl
	left join serv_tarde
    	on serv_tarde.nro_servicio=sl.`nro_servicio`
where sl.`fecha_dev_real` is not null;

drop table serv_tarde;

/* Fin SQL 9 */

/* SQL 10 */

select c.`tipo_doc`, c.`nro_doc`, c.`nom_ape`, c.`dir`, c.`tel`
from clientes c inner join `servicios_limpieza` sl on  c.`tipo_doc`=sl.`tipo_doc`
                                                   and c.`nro_doc`=sl.`nro_doc`
group by c.`tipo_doc`, c.`nro_doc`, c.`nom_ape`, c.`dir`, c.`tel`
having count(*)=1

/* Fin SQL 10 */

/* SQL 11 */

update valores_tratamientos set valor=valor*1.1
where fecha_desde='20080930' and valor>=50;

update valores_tratamientos set valor=valor*1.3
where fecha_desde='20080930' and valor<50;

select * from valores_tratamientos where fecha_desde='20080930';

/* Fin SQL 11 */

/* SQL 12 */

start transaction;

insert into tratamientos values(8,'Lavado ropa delicada',null);

insert into valores_tratamientos values (8,'20080923',180);

insert into procesos values(12,'lavado a mano',null);
insert into procesos values(13,'secado al sol',null);

insert into tratamientos_procesos values(8,12,1);
insert into tratamientos_procesos values(8,13,2);


commit;

/* Fin SQL 12 */

/* SQL 13 */

--solución A
drop temporary table if exists cant_proc;

create temporary table cant_proc
(
 select cod_tratamiento, count(*) cant_procesos
 from `tratamientos_procesos`
 group by cod_tratamiento
);

select @promedio:=AVG(cant_procesos) from cant_proc;

select t.`cod_tratamiento`,t.`desc_tratamiento`,cp.cant_procesos
from `tratamientos` t inner join cant_proc cp on t.`cod_tratamiento`=cp.cod_tratamiento
where cp.cant_procesos>@promedio
order by cp.cant_procesos;

--solución B
drop temporary table if exists cant_proc;

create temporary table cant_proc
(
 select cod_tratamiento, count(*) cant_procesos
 from `tratamientos_procesos`
 group by cod_tratamiento
);

drop temporary table if exists prom;

create temporary table prome
(
 select AVG(cant_procesos) promedio from cant_proc
);

select t.`cod_tratamiento`,t.`desc_tratamiento`,cp.cant_procesos
from `tratamientos` t inner join cant_proc cp on t.`cod_tratamiento`=cp.cod_tratamiento, prome
where cp.cant_procesos>promedio
order by cp.cant_procesos;

/* Fin SQL 13 */
