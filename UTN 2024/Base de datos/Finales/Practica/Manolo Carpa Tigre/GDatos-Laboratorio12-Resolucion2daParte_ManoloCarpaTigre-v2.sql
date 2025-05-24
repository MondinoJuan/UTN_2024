-- SQL 1

select v.`nro_viaje`,v.`fecha_ini`,v.`hora_ini`, v.`nro_contrato`,
c.`observaciones`, cli.`denominacion`
from `viajes` v
inner join contratos c on v.`nro_contrato`=c.`nro_contrato`
inner join clientes cli on c.`cuit`=cli.`cuit`
where v.`fecha_ini`='20091001';

-- Fin SQL 1

-- SQL 2

drop temporary table if exists val_act;
create temporary table val_act
(
 select vtv.`cod_tipo_viaje`, max(vtv.`fecha_desde`) fec_val
 from `valores_tipos_viajes` vtv
 where vtv.`fecha_desde`<=CURRENT_DATE
 group by vtv.`cod_tipo_viaje`
);

select tv.`desc_tipo_viaje`,vtv.`valor_km`
from `tipos_viajes` tv
inner join val_act on tv.`cod_tipo_viaje`=val_act.`cod_tipo_viaje`
inner join `valores_tipos_viajes` vtv on
           vtv.`cod_tipo_viaje`=val_act.`cod_tipo_viaje`
           and vtv.`fecha_desde`=val_act.fec_val;


-- Fin SQL 2

-- SQL 3

select cho.cuil, cho.`nom_ape`
from `conduce_turno` ct
inner join `choferes` cho on ct.cuil=cho.cuil
where ct.`fecha_turno`= '20090930' --current_date
and cod_turno=1
and ct.cuil not in
(
 select cuil
 from viajes where estado= 'En Proceso'
);

-- Fin SQL 3

-- SQL 4

select count(nro_contrato)/count(*) prop_prog, 1-(count(nro_contrato)/count(*)) prop_casu
from `viajes` v;

-- Fin SQL 4

-- SQL 5

select cli.`cuit`,cli.`denominacion`,
count(cuo.`fecha_pago`) pagas, count(*)-count(cuo.`fecha_pago`) impagas
from cuotas cuo
inner join `viajes` v on cuo.`nro_viaje`=v.`nro_viaje`
inner join contratos c on v.`nro_contrato`=c.`nro_contrato`
inner join clientes cli on c.`cuit`=cli.`cuit`
where cuo.`fecha_venc`< '20090930' --CURRENT_DATE
group by cli.`cuit`,cli.`denominacion`;


-- Fin SQL 5

-- SQL 6

select vm.`patente`, m.`marca`,m.`modelo`, sum(vm.`km_fin`-vm.`km_ini`) km_recorridos
from `viajes_moviles` vm
inner join moviles m on vm.`patente`=m.`patente`
where m.`fecha_baja` is null
group by vm.`patente`
having km_recorridos>3000;

-- Fin SQL 6

-- SQL 7

select tv.`desc_tipo_viaje`, count(*)
from viajes v
inner join `tipos_viajes` tv on v.`cod_tipo_viaje`=tv.`cod_tipo_viaje`
group by tv.`cod_tipo_viaje`,tv.`desc_tipo_viaje`
order by count(*) desc, tv.`desc_tipo_viaje` asc;

-- Fin SQL 7

-- SQL 8

select v.`nro_viaje`, v.`fecha_ini`, v.`hora_ini`,v.`cant_pasajeros`
from viajes v
inner join `viajes_moviles` vm on v.`nro_viaje`=vm.`nro_viaje`
where vm.patente='apb 333' and v.`fecha_ini`>CURRENT_DATE
and estado<>'Cancelado';

-- Fin SQL 8

-- SQL 9

select m.`patente`,m.`capacidad`
from moviles m
where m.`patente`
not in
(
select vm.`patente`
from viajes v
inner join `viajes_moviles` vm on v.`nro_viaje`=vm.`nro_viaje`
where v.estado<>'Cancelado' and v.fecha_ini='20091001'
);

-- Fin SQL 9

-- SQL 10

select v.`nro_viaje`,v.`cant_pasajeros`, sum(m.`capacidad`) cap_total
from viajes v
inner join `viajes_moviles` vm on v.`nro_viaje`=vm.`nro_viaje`
inner join moviles m on m.`patente`=vm.`patente`
group by v.`nro_viaje`,v.`cant_pasajeros`
having cap_total>1.5*cant_pasajeros;

-- Fin SQL 10

-- SQL 11

select cli.cuit,cli.`denominacion`, sum(cuo.`importe`) total_a_abonar
from cuotas cuo
inner join viajes v on cuo.`nro_viaje`=v.`nro_viaje`
inner join contratos c on v.`nro_contrato`=c.`nro_contrato`
inner join clientes cli on c.cuit=cli.`cuit`
where cuo.fecha_pago is null
group by cli.cuit,cli.`denominacion`
order by total_a_abonar desc

-- Fin SQL 11

-- SQL 12

start transaction;

insert into choferes
values('54-54545454-5','354545454B5', '19850901', 'Juan Perez','155-555555',
'Paso de los patos 222','jupe1985@gmail.com');

insert into `conduce_turno`
values ('54-54545454-5',1,'20091005');

commit;

-- Fin SQL 12

-- SQL 13

start transaction;

update viajes
set importe=importe*1.5
where fecha_ini>CURRENT_DATE and importe>100;

update viajes
set importe=importe*2
where fecha_ini>CURRENT_DATE and importe<100;

commit;

-- Fin SQL 13

