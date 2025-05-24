/* SQL 1*/
--Solución A
select c.`apeynom`, c.`direccion`,c.`password_web` from clientes c
where nro_tel='4874962'

--Solución B
select c.`apeynom`, c.`direccion`,
       case
       when c.`password_web` is null then
            'Cliente Común'
       else 'Cliente Web'
       end 'Tipo de Cliente'
from clientes c
where nro_tel='4652311'

/* Fin SQL 1*/

/* SQL 2*/

select count(c.`password_web`) 'Cant Clientes Web',
       count(*)-count(c.`password_web`) 'Cant Clientes Comunes'
from clientes c

/* Fin SQL 2*/

/* SQL 3 */ -- MUY DIFICIL


--Solucion A
create temporary table val_del_dia
       (select vali.id_item, max(vali.`fecha_valor`) fecha_valor
                 from `valores_item` vali
                 where vali.`fecha_valor`<='2007-07-01'
                 group by vali.`id_item`);

select ped.`fecha_pedido` ,ped.`id_pedido`,ped.`nro_factura`,
         sum(detp.`cantidad_detalle`* val_item.`valor_item`) total
from            `pedidos` ped
     inner join `detalle_pedido` detp
                                 on ped.`fecha_pedido`=detp.`fecha_pedido`
                                 and ped.`id_pedido`=detp.`id_pedido`
     inner join `items`
                        on detp.`id_item`=items.`id_item`
     inner join val_del_dia
                        on `items`.`id_item`=val_del_dia.id_item
     inner join `valores_item` val_item
                        on `items`.id_item=val_item.`id_item`
                        and val_del_dia.fecha_valor=val_item.`fecha_valor`
where ped.`fecha_pedido`='2007-07-06' and ped.`id_pedido`=5
group by ped.`id_pedido`;

drop table val_del_dia;


--Solución B
select ped.`fecha_pedido` ,ped.`id_pedido`,ped.`nro_factura`,
         sum(detp.`cantidad_detalle`* val_item.`valor_item`) total
from            `pedidos` ped
     inner join `detalle_pedido` detp
                                 on ped.`fecha_pedido`=detp.`fecha_pedido`
                                 and ped.`id_pedido`=detp.`id_pedido`
     inner join `items`
                        on detp.`id_item`=items.`id_item`
     inner join (select vali.id_item, max(vali.`fecha_valor`) fecha_valor
                 from `valores_item` vali
                 where vali.`fecha_valor`<='2007-07-01'
                 group by vali.`id_item`) val_del_dia
                        on `items`.`id_item`=val_del_dia.id_item
     inner join `valores_item` val_item
                        on `items`.id_item=val_item.`id_item`
                        and val_del_dia.fecha_valor=val_item.`fecha_valor`
where ped.`fecha_pedido`='2007-07-06' and ped.`id_pedido`=5
group by ped.`id_pedido`

/* Fin SQL 3 */

/* SQL 4 */

select count(*) pedidos_realizados
from             pedidos ped
     inner join `empleados` emp
                           on ped.`cuil`=emp.`cuil`
where emp.`apeynom`='Juan Perez'and ped.`fecha_pedido`='2007-07-05'

/* FIN SQL 4 */

/* SQL 5 */

select count(*) pedidos_de_junio
from            pedidos ped
     inner join clientes cli
                         on ped.nro_tel=cli.nro_tel
where cli.nro_tel='4552007' and ped.fecha_pedido>='2007-06-01'
      and ped.fecha_pedido<='2007-06-30'

/* FIN SQL 5*/

/*SQL 6*/

select distinct ped.*
from            pedidos ped
     inner join `detalle_pedido` detp
                                 on ped.`fecha_pedido`=detp.`fecha_pedido`
                                 and ped.`id_pedido`=detp.`id_pedido`
where ped.`estado_pedido`='vigente' and detp.`estado_detalle`='listo'

/* FIN SQL 6*/

/* SQL 7 */ -- muy dificil
--Solución A
select items.id_item, items.`descripcion`,vali.`fecha_valor`,vali.`valor_item`
from items
inner join (select val_it.`id_item`, max(val_it.`fecha_valor`) fecha_valor
            from `valores_item` val_it
            GROUP by val_it.`id_item`
           )subc
           on items.`id_item`=subc.id_item
inner join `valores_item` vali
           on items.`id_item`=vali.`id_item`
           and subc.fecha_valor=vali.`fecha_valor`
group by items.id_item,items.descripcion,vali.`fecha_valor`,vali.`valor_item`


--Solución B
create temporary table subc
(select val_it.`id_item`, max(val_it.`fecha_valor`) fecha_valor
            from `valores_item` val_it
            GROUP by val_it.`id_item`);
            
select items.id_item, items.`descripcion`,vali.`fecha_valor`,vali.`valor_item`
from items
inner join subc
           on items.`id_item`=subc.id_item
inner join `valores_item` vali
           on items.`id_item`=vali.`id_item`
           and subc.fecha_valor=vali.`fecha_valor`
group by items.id_item,items.descripcion,vali.`fecha_valor`,vali.`valor_item`;

drop table subc;
/* FIN SQL 7*/

/* SQL 8 */

select items.id_item,items.`descripcion`,sum(cantidad)
from items
inner join `detalle_pedido` detp
      on items.`id_item`=detp.`id_item`
where items.`tiempo_preparacion` is not null
      and detp.`fecha_pedido`>='2007-01-01'
      and detp.`fecha_pedido`<='2007-12-31'
group by items.`id_item`,items.`descripcion`
order by count(*)

/* FIN SQL 8*/

/* SQL 9*/-- muy dificil

select sum(detp.`cantidad_detalle`* val_item.`valor_item`) total
from            `pedidos` ped
     inner join `detalle_pedido` detp
                                 on ped.`fecha_pedido`=detp.`fecha_pedido`
                                 and ped.`id_pedido`=detp.`id_pedido`
     inner join `items`
                        on detp.`id_item`=items.`id_item`
     inner join (select vali.id_item, max(vali.`fecha_valor`) fecha_valor
                 from `valores_item` vali
                 where vali.`fecha_valor`<='2007-07-01'
                 group by vali.`id_item`) val_del_dia
                        on `items`.`id_item`=val_del_dia.id_item
     inner join `valores_item` val_item
                        on `items`.id_item=val_item.`id_item`
                        and val_del_dia.fecha_valor=val_item.`fecha_valor`
where ped.`fecha_pedido`='2007-07-05'

/*FIN SQL 9*/

select sum(detp.`cantidad_detalle`* val_item.`valor_item`) total
from            `pedidos` ped
     inner join `detalle_pedido` detp
                                 on ped.`fecha_pedido`=detp.`fecha_pedido`
                                 and ped.`id_pedido`=detp.`id_pedido`
     inner join `items`
                        on detp.`id_item`=items.`id_item`
     inner join (select vali.id_item, max(vali.`fecha_valor`) fecha_valor
                 from `valores_item` vali
                 where vali.`fecha_valor`<='2007-07-01'
                 group by vali.`id_item`) val_del_dia
                        on `items`.`id_item`=val_del_dia.id_item
     inner join `valores_item` val_item
                        on `items`.id_item=val_item.`id_item`
                        and val_del_dia.fecha_valor=val_item.`fecha_valor`
where ped.`fecha_pedido`='2007-07-05'

/*SQL 10*/ --muy dificil

select ped.id_pedido,ped.`nro_factura`,emp.`apeynom` Mozo,sum(cantidad_detalle) cant_items,
       sum(detp.`cantidad_detalle`* val_item.`valor_item`) total,
       sum(detp.`cantidad_detalle`* val_item.`valor_item`*val_item.`comision`) comision
from            `pedidos` ped
     inner join `detalle_pedido` detp
                                 on ped.`fecha_pedido`=detp.`fecha_pedido`
                                 and ped.`id_pedido`=detp.`id_pedido`
     inner join `items`
                        on detp.`id_item`=items.`id_item`
     inner join (select vali.id_item, max(vali.`fecha_valor`) fecha_valor
                 from `valores_item` vali
                 where vali.`fecha_valor`<='2007-07-01'
                 group by vali.`id_item`) val_del_dia
                        on `items`.`id_item`=val_del_dia.id_item
     inner join `valores_item` val_item
                        on `items`.id_item=val_item.`id_item`
                        and val_del_dia.fecha_valor=val_item.`fecha_valor`
     inner join `empleados` emp
                        on emp.`cuil`=ped.`cuil`
where ped.`fecha_pedido`='2007-07-05'
      and ped.`nro_mesa` is not NULL
group by ped.id_pedido,ped.`nro_factura`,emp.cuil,emp.`apeynom`
order by sum(detp.`cantidad_detalle`* val_item.`valor_item`) desc,
         sum(detp.`cantidad_detalle`* val_item.`valor_item`*val_item.`comision`) asc

/*FIN SQL 10*/

/* SQL 11*/

select * from clientes
where clientes.`nro_tel` not in
      (select distinct ped.`nro_tel`
       from items
            inner join `detalle_pedido` detp
                  on items.`id_item`=detp.`id_item`
            inner join `pedidos` ped
                  on  ped.`fecha_pedido`=detp.`fecha_pedido`
                  and ped.`id_pedido`=detp.`id_pedido`
       where items.`descripcion`='Tarta de Carne' and ped.`nro_tel` is not null)

/*FIN SQL 11*/

/* SQL 12 */

create temporary table ped_dia
(select ped.`fecha_pedido`,count(ped.`nro_mesa`) 'Pedidos Bar',count(*)-count(ped.`nro_mesa`) 'Pedidos Web'
from pedidos ped
where ped.`fecha_pedido`>='2007-07-01' and ped.`fecha_pedido`<='2007-07-31'
group by ped.`fecha_pedido`);

create temporary table items_dia
(select detp.`fecha_pedido`,items.`descripcion` item,sum(cantidad_detalle)'Cant Item'
from `detalle_pedido` detp
inner join items
      on detp.`id_item`=items.`id_item`
where detp.`fecha_pedido`>='2007-07-01' and detp.`fecha_pedido`<='2007-07-31'
group by detp.`fecha_pedido`,items.`id_item`,items.`descripcion`);

select *
from ped_dia
     inner join items_dia
           on ped_dia.fecha_pedido=items_dia.fecha_pedido;

drop table ped_dia;
drop table items_dia;



/* FIN SQL 12*/


/*SQL 13*/

update  sueldos_basicos set sueldo_basico=sueldo_basico*1.07
where fecha_valor='2007-08-01' and sueldo_basico>=1000

update  sueldos_basicos set sueldo_basico=sueldo_basico*1.1
where fecha_valor='2007-08-01' and sueldo_basico<1000

/*FIN SQL 13*/
