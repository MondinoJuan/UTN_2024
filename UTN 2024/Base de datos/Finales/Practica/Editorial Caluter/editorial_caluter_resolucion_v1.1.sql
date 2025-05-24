-- SQL 1

select * from revisores
where dni not in
(
select dni
from `propuestas_revisores`
where aprobado
);

-- Fin SQL 1

-- SQL 2

select p.`ISBN`, p.issn, p.`nombre_publicacion`,val.`valor_publicacion`
from `propuestas` p
inner join
(
 select vp.`nro_propuesta`, max(vp.`fecha_valor`) fec
 from `valores_propuesta` vp
 where vp.`fecha_valor`<=CURRENT_DATE
 group by vp.`nro_propuesta`
)val_ac on val_ac.nro_propuesta=p.`nro_propuesta`
inner join `valores_propuesta` val
on val.`nro_propuesta`=val_ac.nro_propuesta and val.`fecha_valor`=val_ac.fec
where p.`fecha_baja` is null or p.`fecha_baja`>CURRENT_DATE
order by p.`nombre_publicacion`;
 --para los que usen este final de práctica reemplazar CURRENT_DATE con '20090424'


-- Fin SQL 2

-- SQL 3

select r.`dni`, r.`nom_ape`, p.`nro_propuesta`,p.`nombre_publicacion`,
p.`fecha_baja`, mb.`desc_motivo`
from `revisores` r
inner join propuestas_revisores pr on r.dni=pr.dni
inner join propuestas p on pr.`nro_propuesta`=p.`nro_propuesta`
inner join `motivos_baja` mb on p.`cod_motivo_baja`=mb.`cod_motivo`
where mb.`desc_motivo` in ('Problemas Legales','Pocas Ganancias')
and pr.`aprobado`;

-- Fin SQL 3

-- SQL 4

select p.`nombre_publicacion`, sum(ifnull(dp.`cantidad`,0)) cant_pedida
from `propuestas` p
left join `detalle_pedidos` dp on p.`nro_propuesta`=dp.`nro_propuesta`
left join `pedidos` ped on dp.`nro_pedido`=ped.`nro_pedido`
where year(ped.`fecha_pedido`)=2009 or fecha_pedido is null
and (p.isbn is not null or p.issn is not null)
group by p.`nro_propuesta`, p.`nombre_publicacion`
order by cant_pedida desc;

-- Fin SQL 4

-- SQL 5

drop temporary table if exists prom_public;
create temporary table prom_public
(
select p.`nro_propuesta`, p.`nombre_publicacion`, sum(ifnull(dp.`cantidad`,0)) cant_pedida
from `propuestas` p
left join `detalle_pedidos` dp on p.`nro_propuesta`=dp.`nro_propuesta`
left join `pedidos` ped on dp.`nro_pedido`=ped.`nro_pedido`
where year(ped.`fecha_pedido`)=2009 or fecha_pedido is null
and (p.isbn is not null or p.issn is not null)
group by p.`nro_propuesta`, p.`nombre_publicacion`
);

select @prom:=avg(cant_pedida) from prom_public;

select nombre_publicacion, cant_pedida
from prom_public
where cant_pedida<@prom
order by cant_pedida asc;

-- Fin SQL 5

-- SQL 6


select c.`razon_social`, c.`direccion`, dp.`nro_propuesta`, p.`nombre_publicacion`,
dp.`nro_pedido`,dp.`orden`, sum(ep.`cant`)-dp.`cantidad` excedente
from `detalle_pedidos` dp
inner join `entrega_pedidos` ep on dp.`nro_pedido`=ep.`nro_pedido` and dp.`orden`=ep.`orden`
inner join propuestas p on dp.`nro_propuesta`= p.`nro_propuesta`
inner join pedidos ped on ped.`nro_pedido`=dp.`nro_pedido`
inner join `clientes` c on c.`cuit`=ped.`cuit_cliente`
group by c.`cuit`, c.`razon_social`, c.`direccion`, dp.`nro_propuesta`,
      p.`nombre_publicacion`,dp.`nro_pedido`,dp.`orden`, dp.`cantidad`
having excedente>0;

-- Fin SQL 6

-- SQL 7

select @cant_det:=count(*) from `detalle_pedidos`;

select @cant_canc:=count(*) from `detalle_pedidos` where cancelado;

select @cant_canc/@cant_det*100 prop_cancelados, (1-(@cant_canc/@cant_det))*100 prop_no_cacelados;

-- Fin SQL 7

-- SQL 8

select dp.`nro_propuesta`, p.`nombre_publicacion`, sum(ep.`cant`)entregados_tarde
from `entrega_pedidos` ep
inner join `detalle_pedidos` dp on ep.`nro_pedido`=dp.`nro_pedido`
                                and ep.orden=dp.orden
inner join entregas e on ep.`nro_entrega`=e.`nro_entrega`
inner join propuestas p on p.`nro_propuesta`=dp.`nro_propuesta`
where e.`fecha_entrega`>dp.`fecha_limite_entrega`
group by dp.`nro_propuesta`, p.`nombre_publicacion`;

-- Fin SQL 8

-- SQL 9

select p.`nro_propuesta`,p.`nombre_publicacion`,p.`fecha_recepcion`,
 max(pr.`fecha_evaluacion`) fecha_aprobacion_rechazo
from `propuestas` p
inner join `propuestas_revisores` pr on p.`nro_propuesta`=pr.`nro_propuesta`
group by p.`nro_propuesta`,p.`nombre_publicacion`,p.`fecha_recepcion`
having year(fecha_aprobacion_rechazo)=2009;

-- Fin SQL 9

-- SQL 10

select e.`nro_entrega`, e.`fecha_entrega`, count(*) cant_pagos
from entregas e
inner join pagos pag on e.`nro_entrega`=pag.`nro_entrega`
group by e.`nro_entrega`, e.`fecha_entrega`
having cant_pagos>1;

-- Fin SQL 10

-- SQL 11

select e.`nro_entrega`,e.`fecha_entrega`,pag.`fecha_vencimiento`,
sum(pag.`importe_pago`)*1.1
from pagos pag
inner join entregas e on e.`nro_entrega`=pag.`nro_entrega`
where pag.`fecha_pago` is null and pag.`fecha_vencimiento`< current_date
group by e.`nro_entrega`,e.`fecha_entrega`,pag.`fecha_vencimiento`;
--para los que usen este final de práctica reemplazar CURRENT_DATE con '20090424'

-- Fin SQL 11

-- SQL 12

start transaction;

insert into pedidos
values(27, current_date,'21-21212121-2');

insert into `detalle_pedidos`( `nro_pedido`, `orden`, `nro_propuesta`,
                               `cantidad`, `fecha_limite_entrega`)
values(27,1,17,10,adddate(current_date,7));
--para los que usen este final de práctica reemplazar CURRENT_DATE con '20090424'
--o directamente reemplazar el cálculo de la fecha por '20090501'

insert into `detalle_pedidos`( `nro_pedido`, `orden`, `nro_propuesta`,
                               `cantidad`, `fecha_limite_entrega`)
values(27,2,14,3,adddate(current_date,20));
--para los que usen este final de práctica reemplazar CURRENT_DATE con '20090424'
--o directamente reemplazar el cálculo de la fecha por '20090514'

commit;

-- Fin SQL 12

-- SQL 13

--Solución A
start transaction;

update pagos
set fecha_pago=current_date
where nro_entrega=33;
--para los que usen este final de práctica reemplazar CURRENT_DATE con '20090424'

update pagos
set recargo=importe_pago*0.1
where nro_entrega=33 and fecha_vencimiento<fecha_pago;

commit;

--Solución B

start transaction;

update pagos
set fecha_pago= '20090424', --current_date,
     recargo= case
                  when fecha_vencimiento<fecha_pago then importe_pago*0.1
                  else null
              end
where nro_entrega=33;

commit;

-- Fin SQL 13

