-- SQL 1

select c.`cod_cliente`,c.`nombre_cliente`, p.`nro_serie`,p.`nombre_producto`, t.*
from `clientes` c
inner join `productos` p
on c.`cod_cliente`=p.`cod_cliente`
inner join `tickets` t
on p.`nro_serie`=t.`nro_serie`
where t.`fecha_hora_resolucion` is null

-- Fin SQL 1

-- SQL 2

select *
from `personal_soporte`
where legajo not in
(
select legajo
from `tickets`
)

-- Fin SQL 2

-- SQL 3

select p.`nro_serie`,p.`nombre_producto`,count(*) cant_tickets
from productos p inner join tickets t on p.`nro_serie`=t.`nro_serie`
group by p.`nro_serie`, p.`nombre_producto`
order by cant_tickets desc, p.nro_serie

-- Fin SQL 3

-- SQL 4

select c.`cod_cliente`, c.`nombre_cliente`, count(*) cantidad
from clientes c inner join productos p
on c.`cod_cliente`= p.`cod_cliente`
group by c.`cod_cliente`, c.`nombre_cliente`
having count(*)>1
-- Fin SQL 4

-- SQL 5

select count(*) into @nr
from reparaciones
where resultado='no resuelto';

select count(*) into @r
from reparaciones
where resultado='resuelto';

select @nr/(@nr+@r) prop_no_resueltas, @r/(@nr+@r) prop_resueltas;

-- Fin SQL 5

-- SQL 6

select p.`nro_serie` nro_serie_producto, p.`nombre_producto` nombre_producto,
prod_comp.`nro_serie` nro_serie_componente, prod_comp.`nombre_producto` nombre_componente
from productos p
inner join componentes comp
on p.`nro_serie`=comp.`nro_serie_principal`
inner join productos prod_comp on comp.`nro_serie_componente`=prod_comp.`nro_serie`
where comp.`fecha_remocion` is null

-- Fin SQL 6

-- SQL 7

select *
from productos
where
cod_cliente is null
and
fecha_baja is null
and
nro_serie not in(
select nro_serie_componente
from componentes
where fecha_remocion is null
)

-- Fin SQL 7

-- SQL 8

drop temporary table if exists contactos;
create temporary table contactos
(
select ps.`legajo`, ps.`nom_ape`, count(t.`nro_ticket`) cantidad
from `personal_soporte` ps left join `tickets` t on t.`legajo`=ps.`legajo`
group by ps.`legajo`, ps.`nom_ape`
);
-- si usan inner tambien está bien

select avg(cantidad) into @prom
from contactos;

select * from contactos
where cantidad>@prom;

-- Fin SQL 8

-- SQL 9

select c.*, p.*
from clientes c inner join productos p on c.`cod_cliente`=p.`cod_cliente`
where p.`nro_serie`
not in(
select nro_serie
from `contratos_productos` cp
inner join contratos con on cp.`nro_contrato`=con.`nro_contrato`
where con.`fecha_fin_soporte`>'20101001'
)

-- Fin SQL 9

-- SQL 10

drop temporary table if exists val_act;
create temporary table val_act
(
 select vts.`cod_tipo_soporte`, max(vts.`fecha_valor`) fec_val
 from `valores_tipos_soporte` vts
 where vts.`fecha_valor`<CURRENT_DATE
 group by vts.`cod_tipo_soporte`
);

select ts.`cod_tipo_soporte`, vts.`valor_soporte`
from `tipos_soporte` ts
inner join val_act
on ts.`cod_tipo_soporte`=val_act.cod_tipo_soporte
inner join `valores_tipos_soporte` vts
on val_act.cod_tipo_soporte=vts.`cod_tipo_soporte`
and val_act.fec_val=vts.`fecha_valor`

-- Fin SQL 10

-- SQL 11

select pt.`nro_ticket`,pt.`fecha_hora_registro`, pt.`cod_problema`
from `problemas_tickets` pt
left join `reparaciones` r on
pt.`nro_ticket`=r.`nro_ticket`
and pt.`fecha_hora_registro`=r.`fecha_hora_registro`
where r.`fecha_hora_registro` is null

-- Fin SQL 11

-- SQL 12

start transaction;

insert into `tipos_soporte`
values(5,'Reemplazo de componentes caros','Reemplazar componentes caros por usados');

insert into `valores_tipos_soporte`
values(5,current_date,1500);

commit;

-- Fin SQL 12

-- SQL 13

start transaction;

update contratos
set valor_pactado=valor_pactado*1.2
where fecha_fin_soporte>current_date
and fecha_rescindido is null
and valor_pactado>=2000;

update contratos
set valor_pactado=valor_pactado*1.5
where fecha_fin_soporte>current_date
and fecha_rescindido is null
and valor_pactado<2000;

commit;

-- Fin SQL 13

