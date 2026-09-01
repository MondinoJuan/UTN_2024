# FINAL 


-- 1

start transaction;

use saco_roto;
DROP TABLE IF EXISTS `unidades_medida`;
CREATE TABLE `unidades_medida` (
  `cod_unid_med` int(11) auto_increment,
  `desc_unid_med` varchar(20) NOT NULL,
  PRIMARY KEY (`cod_unid_med`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


insert into unidades_medida (desc_unid_med)
	values ('m2'),
			('c/u')
;

alter table materiales
change column unidad unidad_id int,
add constraint desc_unid_med foreign key (unidad_id) references unidades_medida(cod_unid_med);

commit;


select * from materiales;


-- 2

use saco_roto;

select cuil into @cuilTesla from sastres
where apellido like '%Tesla%'
;

#select @cuilTesla;

select s.cuil, s.nombre, s.apellido, ps.tarea, tp.cod_tipo_prenda, tp.desc_tipo_prenda from sastres s
inner join prendas_sastres ps on s.cuil = ps.cuil
inner join tipos_prendas tp on ps.cod_tipo_prenda = tp.cod_tipo_prenda
where s.cuil_jefe = @cuilTesla
;

-- 4

use saco_roto;

select p.nro_persona, p.apellido, p.nombre, tp.desc_tipo_prenda, count(*) as cantidad from pedidos ped
inner join personas p on ped.nro_persona_cliente = p.nro_persona
inner join prendas pren on p.nro_persona = pren.nro_persona
inner join tipos_prendas tp on pren.cod_tipo_prenda = tp.cod_tipo_prenda
group by p.nro_persona, p.apellido, p.nombre, tp.desc_tipo_prenda
having cantidad >= 2
order by cantidad desc, p.apellido asc, p.nombre asc
;


-- 5

use saco_roto;

drop temporary table if exists ultimaFechaSastres;
create temporary table ultimaFechaSastres
select distinct ps.cuil, max(p.fecha_entrega) as maxFecha from prendas p
inner join prendas_sastres ps on ps.nro_persona = p.nro_persona
group by ps.cuil
;

drop temporary table if exists cantPedidos;
create temporary table cantPedidos
select ps.cuil, count(*) as cantidad from pedidos p
inner join prendas_sastres ps on ps.nro_pedido = p.nro_pedido
inner join ultimaFechaSastres ufs on ufs.cuil = ps.cuil
#where p.fecha_hora_pedido in (select maxFecha from ultimaFechaSastres)
group by ps.cuil
;

select jefe.cuil, jefe.nombre, jefe.apellido, jefe.direccion, jefe.cbu, cp.cantidad from sastres jefe
inner join sastres s on jefe.cuil = s.cuil_jefe
# Inner joins con tablas temporales para mostrar
inner join cantPedidos cp on cp.cuil = s.cuil
where s.cuil in (select cuil from ultimaFechaSastres);

-- 6
/*
Desarrollar una función total_pedido que reciba un número de pedido como parámetro y devuelva el monto 
total del mismo según las reglas de negocio. Utilizar la función para mostrar todos los datos de los pedidos y el total.
*/








