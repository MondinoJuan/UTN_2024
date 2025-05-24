#----------------------------------------------------------------------------------------------------
#1
select nro_tel, apeynom, direccion, ifnull( password_web,'no esta registrado en la web')
from clientes; 
#----------------------------------------------------------------------------------------------------
#2
select count(password_web) 'cantidad registrada',count(*)-count(password_web) 'cantidad no registrada'
from clientes;
#----------------------------------------------------------------------------------------------------
#3
drop temporary table if exists precio_al_dia;

create temporary table precio_al_dia
select id_item, max(fecha_valor) ult_fecha
from valores_item
where fecha_valor<='2007-07-06'
group by id_item;

select p.fecha_pedido, p.id_pedido ,p.nro_factura 'numero de factura', sum(valor_item * cantidad_detalle) total
from pedidos p
inner join detalle_pedido dp
on p.id_pedido=dp.id_pedido and p.fecha_pedido=dp.fecha_pedido
inner join valores_item vi
on dp.id_item=vi.id_item
inner join precio_al_dia pad
on vi.id_item=pad.id_item and vi.fecha_valor=pad.ult_fecha
where p.fecha_pedido='2007-07-06'
group by p.fecha_pedido, p.id_pedido, p.nro_factura;

#----------------------------------------------------------------------------------------------------

select count(*)-count(p.nro_mesa) pedidos_realizados
from             pedidos p
     inner join `empleados` emp
                           on p.`cuil`=emp.`cuil`
where emp.`apeynom`='Juan Perez'and p.`fecha_pedido`='2007-07-05';

#----------------------------------------------------------------------------------------------------
select count(*) pedidos_de_junio
from            pedidos ped
     inner join clientes cli
                         on ped.nro_tel=cli.nro_tel
where cli.nro_tel='4552007' and ped.fecha_pedido>='2007-06-01'
      and ped.fecha_pedido<='2007-06-30';

#----------------------------------------------------------------------------------------------------
drop temporary table if exists subc;
create temporary table subc
(select val_it.`id_item`, max(val_it.`fecha_valor`) fecha_valor
            from `valores_item` val_it
where val_it.fecha_valor<=current_date 
            GROUP by val_it.`id_item`);
            
select items.id_item, items.`descripcion`,vali.`fecha_valor`,vali.`valor_item`
from items
inner join `valores_item` vali
           on items.`id_item`=vali.`id_item`
inner join subc
           on vali.`id_item`=subc.id_item
           and subc.fecha_valor=vali.`fecha_valor`
group by items.id_item,items.descripcion,vali.`fecha_valor`,vali.`valor_item`;

#----------------------------------------------------------------------------------------------------
select items.id_item,descripcion,sum(cantidad_detalle)
from items
inner join `detalle_pedido` detp
      on items.`id_item`=detp.`id_item`
where items.`tiempo_preparacion` is not null
      and detp.`fecha_pedido`>='2007-01-01'
      and detp.`fecha_pedido`<='2007-12-31'
group by items.`id_item`,descripcion 
order by sum(cantidad_detalle);
#----------------------------------------------------------------------------------------------------
#9

drop temporary table if exists precio_al_dia;

create temporary table precio_al_dia
select id_item, max(fecha_valor) ult_fecha
from valores_item
where fecha_valor<='2007-07-05'
group by id_item;

select p.fecha_pedido, sum(vi.valor_item * dp.cantidad_detalle)
from pedidos p
inner join detalle_pedido dp
on p.fecha_pedido=dp.fecha_pedido and p.id_pedido=dp.id_pedido
inner join items i
on dp.id_item=i.id_item
inner join valores_item vi
on i.id_item=vi.id_item
inner join precio_al_dia pad
on vi.fecha_valor=pad.ult_fecha
and vi.id_item=pad.id_item
where p.fecha_pedido='2007-07-05'
group by p.fecha_pedido;
#----------------------------------------------------------------------------------------------------
drop temporary table if exists precio_al_dia;

create temporary table precio_al_dia
select id_item, max(fecha_valor) ult_fecha
from valores_item
where fecha_valor<='2007-07-05'
group by id_item;

select dp.fecha_pedido, sum(vi.valor_item * dp.cantidad_detalle)
from detalle_pedido dp
inner join valores_item vi
on dp.id_item=vi.id_item
inner join precio_al_dia pad
on vi.fecha_valor=pad.ult_fecha
and vi.id_item=pad.id_item
where dp.fecha_pedido='2007-07-05'
group by dp.fecha_pedido;

#----------------------------------------------------------------------------------------------------


