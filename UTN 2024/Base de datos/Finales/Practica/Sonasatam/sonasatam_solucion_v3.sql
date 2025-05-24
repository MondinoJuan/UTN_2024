/********************************************************************
*****************************  ETAPA 1  *****************************
*********************************************************************

Pasos
1) Crear la tabla tratamientos_clientes con: primary key: dni, cod_tratamiento, fecha y hora

2) Agregar las claves foráneas de tratamientos_clientes a
 - clientes por dni
 - recetas por nro_matricula y nro_receta
 - tratamientos por cod_tratamiento

3) Agregar en turnos la clave foranea a tratamientos_clientes por dni, cod_tratamiento, fecha y hora



*********************************************************************
*****************************  ETAPA 2  *****************************
*********************************************************************/


/* SQL 1 */

select c.*
from clientes c inner join
     ventas v on c.dni=v.dni
where v.fecha between '20110101' and '20110131'
and c.dni not in
                (
                 select dni
                 from ventas ven
                 where ven.`fecha` between '20110201' and '20110228'
                )

/* Fin SQL 1 */

/* SQL 2 */

drop temporary table if exists fec_act;

create temporary table fec_act
(
 select pm.`cod_mat`, max(pm.`fecha_desde`) fec_val
 from `precios_materiales` pm
 where pm.`fecha_desde`<=current_date
 group by pm.cod_mat
);

select mat.`cod_mat`, mat.`nom_mat`, pm.`valor_material`
from materiales mat inner join
     fec_act on mat.`cod_mat`=fec_act.cod_mat inner join
     `precios_materiales` pm on  pm.cod_mat=fec_act.cod_mat
                             and pm.`fecha_desde`=fec_act.fec_val;


/* Fin SQL 2 */

/* SQL 3 */

select os.`cod_os`, os.`razon_social`, os.`cuit`,
       t.`cod_tratamiento`, t.`desc_tratamiento`,
       count(*) cant_tratamientos, sum(tc.`cant_sesiones`) cant_sesiones
from tratamientos_clientes tc inner join
     recetas r on  tc.`nro_mat`=r.`nro_mat`
               and tc.`nro_receta`=r.`nro_receta` inner join
     `obras_sociales` os on r.`cod_os`=os.`cod_os` inner join
     tratamientos t on tc.`cod_tratamiento`=t.`cod_tratamiento`
group by os.`cod_os`, os.`razon_social`, os.`cuit`,
       t.`cod_tratamiento`, t.`desc_tratamiento`
order by cant_sesiones desc;

/* Fin SQL 3 */

/* SQL 4 */

-- Puede solucionarse con una tabla temporal también

select m.`cod_mat`, m.`nom_mat`, ifnull(cant_turno,0)+ifnull(cant_vta,0) cantidad
from materiales m left join
     (
      select mt.`cod_mat`, sum(mt.`cantidad`) cant_turno
      from materiales_turnos mt
      group by mt.cod_mat
     ) cant_tur on m.cod_mat=cant_tur.cod_mat left join
     (
      select dv.cod_mat, sum(dv.`cantidad`) cant_vta
      from `detalle_ventas` dv
      group by dv.cod_mat
     ) vendidos on m.`cod_mat`=vendidos.cod_mat
order by m.nom_mat;

/* Fin SQL 4 */

/* SQL 5 */

select e.`cod_eq`, e.`nom_eq`, year(tur.`fecha_turno`) año,
       month(tur.`fecha_turno`) mes, count(*) cantidad
from equipos e inner join
     `equipos_tratamientos` et on e.`cod_eq`=et.`cod_eq` inner join
     turnos tur on et.`cod_tratamiento`=tur.`cod_tratamiento`
where tur.`estado`='cumplido'
group by e.`cod_eq`, e.`nom_eq`, year(tur.`fecha_turno`), month(tur.`fecha_turno`);

/* Fin SQL 5 */

/* SQL 6 */

select c.`dni`,c.`nombre`,c.`apellido`,count(*) cantidad
from clientes c inner join
     turnos tur on c.`dni`=tur.`dni`
where year(tur.`fecha_turno`)=2011
and tur.estado='cumplido'
group by c.`dni`,c.`nombre`,c.`apellido`
having cantidad>10
order by cantidad desc, c.nombre, c.apellido;

/* Fin SQL 6 */

/* SQL 7 */

select max(pt.`fecha_desde`) into @fec_val
from tratamientos t inner join
     precios_tratamientos pt on t.`cod_tratamiento`=pt.`cod_tratamiento`
where t.`desc_tratamiento`='ejercitación rehabilitación espalda'
and pt.`fecha_desde`<=current_date;


select t.`precauciones`, t.`duracion`, pt.`valor_tratamiento`*10 costo_total
from tratamientos t inner join
     `precios_tratamientos` pt on t.`cod_tratamiento`=pt.`cod_tratamiento`
                               and pt.`fecha_desde`=@fec_val
where t.`desc_tratamiento`='ejercitación rehabilitación espalda';
 

/* Fin SQL 7 */

/* SQL 8 */

select mat.`cod_mat`, mat.`nom_mat`, mat.`cant_disp`, sum(dv.`cantidad`) cant_vendida,
       mat.cant_disp-sum(dv.`cantidad`) diferencia
from materiales mat inner join
     `detalle_ventas` dv on mat.`cod_mat`=dv.cod_mat inner join
     ventas v on dv.`nro_venta`=v.`nro_venta`
where v.`fecha` between '20110101' and '20110131'
group by mat.`cod_mat`, mat.`nom_mat`, mat.`cant_disp`
having cant_vendida>cant_disp;

/* Fin SQL 8 */

/* SQL 9 */

select tur.`fecha_turno`, tur.`hora_turno`, k.`nombre`, k.`apellido`,
       t.`desc_tratamiento`, estado
from turnos tur inner join
     clientes c on tur.`dni`=c.dni inner join
     `kinesiologos` k on tur.`matricula`=k.`matricula` inner join
     tratamientos t on tur.`cod_tratamiento`=t.`cod_tratamiento`
where c.`nombre`='Jane' and c.`apellido`='Addams'
and tur.`fecha_turno`>current_date and tur.estado='reservado';

/* Fin SQL 9 */

/* SQL 10 */

drop temporary table if exists tur_kin;

create temporary table tur_kin
(
 select k.`matricula`, k.`nombre`, k.`apellido`, count(*) cant
 from turnos tur left join
      `kinesiologos` k on tur.`matricula`=k.`matricula`
 where tur.estado='cumplido'
 group by k.`matricula`, k.`nombre`, k.`apellido`
);

select avg(cant) into @prom
from tur_kin;

select tur_kin.*, @prom
from tur_kin
where cant>@prom;


/* Fin SQL 10 */

/* SQL 11 */

select a.`matricula`, k.`nombre`, k.`apellido`, max(a.`fecha_desde`) fecha_desde,
       a.`hora_desde`, a.`hora_hasta`
from agendas a inner join
     kinesiologos k on a.`matricula`=k.`matricula`
where a.`fecha_desde`<='20110308' and a.`dia_semana`=3
      and hora_desde<='150000' and hora_hasta>'150000'
group by a.`matricula`, a.`dia_semana`, a.`hora_desde`, a.`hora_hasta`;

/* Fin SQL 11 */

/* SQL 12 */

start transaction;

insert into `kinesiologos`(`matricula`, `nombre`, `apellido`, `telefono`)
values (2424, 'Jean Henri', 'Dunant','4242424');

insert into agendas
values (2424, current_date+1, 2, '150000','200000');

insert into agendas
values (2424, current_date+1, 5, '150000','200000');

commit;

/* Fin SQL 12 */

/* SQL 13 */

start transaction;

update tratamientos set duracion=duracion*1.15 where duracion>=30;

update tratamientos set duracion=duracion*1.25 where duracion<30;

commit;

/* Fin SQL 13 */

