-- SQL 1 --2

 select v.`cod_video`,v.`nom_video`,v.`path`,sen.`nom_senial`
 from `videos_transmisiones` vt inner join videos v
      on vt.`cod_video`=v.cod_video inner join
      `franjas_horarias` fh on vt.`nro_franja`=fh.`nro_franja`
      inner join seniales sen on vt.`cod_senial`=sen.cod_senial
 where vt.`fecha_transmision`='20100504' and fh.`hora_desde`='21:00:00';
 
-- Fin SQL 1

-- SQL 2 --4

select s.`nom_serie`, v.`nro_episodio`, v.`nom_video`,sen.`nom_senial`,
       vt.`fecha_transmision`,fh.`hora_desde`
from series s inner join videos v
     on s.`cod_serie`=v.cod_serie
     inner join `videos_transmisiones` vt on v.`cod_video`=vt.`cod_video`
     inner join `franjas_horarias` fh on vt.`nro_franja`=fh.`nro_franja`
     inner join seniales sen on sen.`cod_senial`=vt.`cod_senial`
where s.`nom_serie` like 'hou%' and sen.`nom_senial`='Cine Z'
and vt.`fecha_transmision`>'20100504'
and vt.`fecha_transmision`<='20100507'
;

-- Fin SQL 2

-- SQL 3 --2

-- Solución A
select distinct ven.*
from vendedores ven inner join ofertas o
on ven.`cuil`=o.`cuil`
where year(o.`fecha_oferta`)=2010 and ven.`cuil` not in
(
  select cuil
  from ofertas ofe
  where year(ofe.`fecha_oferta`)=2009
);

-- Solución B
select ven.*
from vendedores ven
where ven.`cuil` not in
(
  select cuil
  from ofertas ofe
  where year(ofe.`fecha_oferta`)=2009
)
and ven.cuil in
(
  select cuil
  from ofertas ofe
  where year(ofe.`fecha_oferta`)=2010
);


-- Fin SQL 3

-- SQL 4 --3

select count(*) into @cant_total
from `espacios_publicitarios` ep
where ep.`cod_cliente` is not null;

select c.`razon_social`, count(*)/@cant_total, count(*) cantidad_contratada,
@cant_total cantidad_total, sum(ep.`valor_acordado`) importe
from clientes c inner join `espacios_publicitarios` ep
on c.`cod_cliente`=ep.`cod_cliente`
group by c.`cod_cliente`,c.`razon_social`;

-- Fin SQL 4

-- SQL 5 --2

select sum(o.`importe`) into @imp_nike
from clientes c inner join ofertas o
on c.`cod_cliente`=o.`cod_cliente`
where o.`ganadora` and c.`razon_social`='Nike';


select c.`cod_cliente`,c.`razon_social`,sum(o.`importe`) total
from clientes c inner join ofertas o
on c.`cod_cliente`=o.`cod_cliente`
where o.`ganadora`
group by c.`cod_cliente`,c.`razon_social`
having total > @imp_nike;

-- Fin SQL 5

-- SQL 6 --3

select ven.`cuil`, ven.`nombre_apellido`, sum(o.`importe`) total ,count(*) cantidad
from vendedores ven inner join ofertas o
on ven.`cuil`=o.`cuil`
where o.`ganadora`
group by ven.`cuil`, ven.`nombre_apellido`
order by total desc, cantidad;

-- Fin SQL 6

-- SQL 7 --5

drop temporary table if exists imp_ven;
create temporary table imp_ven
(
select ven.`cuil`, ven.`nombre_apellido`, sum(o.`importe`) total ,count(*) cantidad
from vendedores ven inner join ofertas o
on ven.`cuil`=o.`cuil`
where o.`ganadora`
group by ven.`cuil`, ven.`nombre_apellido`
);

select sum(total)/count(*) into @prom
from imp_ven;

select nombre_apellido, total,@prom promedio, total-@prom diferencia
from imp_ven
where total>@prom;

-- Fin SQL 7

-- SQL 8 --4

select sen.`nom_senial`, ep.`nro_franja`,count(*) cantidad_no_contratada
from `seniales` sen inner join `espacios_publicitarios` ep
on sen.`cod_senial`=ep.`cod_senial`
where ep.`nro_contrato` is null
group by sen.`cod_senial`, sen.`nom_senial`, ep.`nro_franja`
order by cantidad_no_contratada desc,sen.`nom_senial`

-- Fin SQL 8

-- SQL 9 --1

select v.`cod_video`, `nom_video`, count(*) cantidad
from videos v inner join `videos_transmisiones` vt
on v.`cod_video`=vt.`cod_video`
group by v.`cod_video`, `nom_video`
having cantidad>275;

-- Fin SQL 9

-- SQL 10 -5

select sen.`nom_senial`, fh.`dia_semana_desde`, fh.`dia_semana_hasta`,
fh.`hora_desde`,fh.`hora_hasta`,t.`fecha_desde`,t.`fecha_limite_oferta`
from
seniales sen inner join
`transmisiones` t
on t.`cod_senial`=sen.`cod_senial`
inner join `franjas_horarias` fh
on t.`nro_franja`=fh.`nro_franja`
left join ofertas o
on t.`cod_senial`=o.`cod_senial`
and t.`nro_franja`=o.`nro_franja`
and t.fecha_desde=o.`fecha_desde`
where o.`cod_senial` is null
and t.`fecha_desde`>='20100501' and t.`fecha_desde`<'20100601'
and t.`fecha_limite_oferta`<'20100504' and tipo_espacio='alquiler'

-- Fin SQL 10

-- SQL 11 --4

select max(cv.`fecha_desde`) into @fec
from `comisiones_venta` cv
where cv.`fecha_desde`<'20100504';

select cv.`porcentaje_comision` into @porcen
from `comisiones_venta` cv
where cv.`fecha_desde`=@fec;

SELECT ven.`cuil`, ven.`nombre_apellido`, (sum(o.`importe`)*@porcen/100) comision
from vendedores ven inner join ofertas o on
ven.cuil=o.cuil
where o.`fecha_pago_comision` is null and ganadora
group by ven.`cuil`, ven.`nombre_apellido`;

-- Fin SQL 11 -- 2

-- SQL 12

start transaction;

update ofertas set fecha_pago_comision=current_date
where cuil='33-33333333-3' and fecha_pago_comision is null and ganadora;

commit;

-- Fin SQL 12

-- SQL 13 --2

start transaction;

select max(cod_serie)+1 into @serie from series;--8
select max(cod_video)+1 into @video from videos;--31366

insert into series values (@serie,'Lie To Me');
insert into videos( `cod_video`, `nom_video`, `duracion`, `fecha_grabacion`,
                    `tipo`, path, cod_serie, nro_episodio)
values(@video,'LieToMeS01E01', 40,'20080701','propio',
'/www/videos/propios/LieToMeS01E01.rmvb',@serie,1);

insert into videos( `cod_video`, `nom_video`, `duracion`, `fecha_grabacion`,
                    `tipo`, path, cod_serie, nro_episodio)
values(@video+1,'LieToMeS01E02', 40,'20080701','propio',
'/www/videos/propios/LieToMeS01E02.rmvb',@serie,2);

commit;

-- Fin SQL 13

