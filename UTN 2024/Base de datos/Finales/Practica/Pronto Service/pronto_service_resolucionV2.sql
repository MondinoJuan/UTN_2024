-- SQL 1

select *
from maquinarias m
where m.`nro_serie` not in
      (
      select c.`nro_serie_maquina`
      from contratos c
      )

-- Fin SQL 1


-- SQL 2

select p.`nomyape`, c.`nro_contrato`, count(*) cantidad, sum(cuo.`importe`) importe_total
from personas p inner join
     contratos c on p.`cuit`=c.`cuit_cliente` inner join
     cuotas cuo on c.`nro_contrato`=cuo.`nro_contrato`
where cuo.`fecha_pago` is not null
group by p.`cuit`, p.`nomyape`, c.`nro_contrato`

-- Fin SQL 2

-- SQL 3

select p.`nomyape`, c.`nro_contrato`, count(*) cantidad, sum(cuo.`importe`) importe_total
from personas p inner join
     contratos c on p.`cuit`=c.`cuit_cliente` inner join
     cuotas cuo on c.`nro_contrato`=cuo.`nro_contrato`
group by p.`cuit`, p.`nomyape`, c.`nro_contrato`
having importe_total>250
-- Fin SQL 3

-- SQL 4

select gar.*,c.`nro_contrato`,m.`nro_serie`,m.`tipo_maquina`,
c.`fecha_pago_limite`,c.`fecha_inicio_arren`
from personas gar inner join
garante_contrato gc on gar.`cuit`=gc.`cuit_garante` inner join
contratos c on gc.`nro_contrato`=c.`nro_contrato` inner join
maquinarias m on c.`nro_serie_maquina`=m.`nro_serie`
where c.`fecha_pago` is null
-- Fin SQL 4


-- SQL 5

drop temporary table if exists fecha_serv;

create temporary table fecha_serv
(
 select vs.`cod_servicio`, max(vs.`fecha_desde`) fec_aplica
 from valores_servicios vs
 where vs.`fecha_desde`<='20080511'
 group by vs.`cod_servicio`
);

select s.*, vs.`importe`
from servicios s inner join
fecha_serv fs on s.`cod_servicio`=fs.`cod_servicio` inner JOIN
`valores_servicios` vs on vs.`cod_servicio`=fs.`cod_servicio`
                       and vs.`fecha_desde`=fs.fec_aplica;


drop temporary table fecha_serv;

-- Fin SQL 5

-- SQL 6

select cli.`cuit`,cli.`nomyape`,ca.`cod_servicio`,
 s.`descripcion`,c.`nro_contrato`,ca.`horas_contratadas`,
 sum(cons.`horas_consumidas`) total_consumido
from personas cli inner JOIN
contratos c on cli.`cuit`=c.`cuit_cliente` inner join
`contrata_abono` ca on c.`nro_contrato`=ca.`nro_contrato` inner join
consumos cons on ca.`nro_contrato`=cons.`nro_contrato`
              and ca.`cod_servicio`=cons.`cod_servicio` inner join
servicios s on ca.`cod_servicio`=s.`cod_servicio`
group by cli.`cuit`,cli.`nomyape`,ca.`cod_servicio`,
 s.`descripcion`,c.`nro_contrato`,ca.`horas_contratadas`
having total_consumido=ca.`horas_contratadas`

-- Fin SQL 6

-- SQL 7

select cli.`cuit`,cli.`nomyape`, cli.`telefono`, ca.`cod_servicio`, s.`descripcion`,c.`nro_contrato`,
sum(cons.`horas_consumidas`)/ca.`horas_contratadas`*100 porcentaje_consumido
from personas cli inner JOIN
contratos c on cli.`cuit`=c.`cuit_cliente` inner join
`contrata_abono` ca on c.`nro_contrato`=ca.`nro_contrato` inner join
consumos cons on ca.`nro_contrato`=cons.`nro_contrato`
              and ca.`cod_servicio`=cons.`cod_servicio` inner join
servicios s on ca.`cod_servicio`=s.`cod_servicio`
group by cli.`cuit`,cli.`nomyape`,cli.`telefono` ,ca.`cod_servicio`,
 s.`descripcion`,c.`nro_contrato`,ca.`horas_contratadas`
order by porcentaje_consumido desc

-- Fin SQL 7

-- SQL 8

drop temporary table if exists serv_no_abono;

create temporary table serv_no_abono
(
 select *
 from servicios s
 where s.`cod_servicio` not in
 (
  select ca.`cod_servicio`
  from `contrata_abono` ca
 )
);

select cli.*,sna.*,us.`fecha_utilizado`, us.`horas_utilizadas`, us.`fecha_pago`
from serv_no_abono sna inner join
utiliza_servicios us on sna.`cod_servicio`=us.`cod_servicio` inner join
contratos c on us.`nro_contrato`=c.`nro_contrato` inner join
personas cli on c.`cuit_cliente`=cli.`cuit`;

drop temporary table serv_no_abono;




-- Fin SQL 8

-- SQL 9

select cli.`nomyape`, cli.`telefono`, c.`nro_contrato`, c.`fecha_pago_limite`, max(cuo.`fecha_pago`) ultimo_pago
from contratos c inner join
cuotas cuo on c.`nro_contrato`=cuo.`nro_contrato` inner join
personas cli on c.`cuit_cliente`=cli.`cuit`
group by c.`nro_contrato`, c.`fecha_pago_limite`
having c.`fecha_pago_limite`< max(cuo.`fecha_pago`)

-- Fin SQL 9

-- SQL 10

update `contrata_abono` set horas_contratadas=horas_contratadas*1.1
where horas_contratadas>=10;

update `contrata_abono` set horas_contratadas=horas_contratadas*1.3
where horas_contratadas<10;


-- Fin SQL 10

-- SQL 11

select cli.*, gar.*
from contratos c inner join
personas cli on c.`cuit_cliente`=cli.`cuit` inner join
`garante_contrato` gc on gc.`nro_contrato`=c.`nro_contrato` inner join
personas gar on gc.`cuit_garante`=gar.`cuit`

-- Fin SQL 11


-- SQL 12

select p.*
from personas p inner join
     contratos c on p.`cuit`=c.`cuit_cliente` inner join
     contrata_abono ca on ca.`nro_contrato`=c.`nro_contrato`
where p.`cuit` not in
      (
      select per.`cuit`
      from utiliza_servicios us inner join
           contratos con on us.`nro_contrato`=con.`nro_contrato` inner join
           personas per on con.`cuit_cliente`=per.`cuit`
      )

-- Fin SQL 12

-- SQL 13

START TRANSACTION;

insert into `servicios`(`cod_servicio`,`descripcion`,`observacion`)
values(5,'Lavado','ABONO');

insert into `valores_servicios`(`cod_servicio`,`fecha_desde`,`importe`)
values(5,'20080511',13);

COMMIT;

-- Fin SQL 13
