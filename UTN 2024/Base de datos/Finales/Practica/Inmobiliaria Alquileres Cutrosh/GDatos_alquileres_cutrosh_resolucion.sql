--1
select per.`nombre`, pro.`direccion`, pro.`caracteristicas`,
 proser.`cod_servicio`,ser.`nom_servicio`
from propiedades pro
inner join personas per
on pro.`dni_propietario`= per.`dni`
inner join `propiedades_servicios` proser
on proser.`cod_propiedad` = pro.`cod_propiedad`
inner join `servicios` ser
on ser.`cod_servicio`= proser.`cod_servicio`
where per.`nombre` LIKE "%Tenzi%"

--2
Select ce.`nom_centro`, pe.`apellido`, count(*) from propiedades p
inner join `centro_turistico` ce
on p.`cod_centro` = ce.`cod_centro`
inner join `personas` pe
on ce.`dni_encargado` = pe.`dni`
where fecha_revision is NULL
group by 1,2

--3
drop temporary table if exists val_act;

create temporary table val_act
(
select ps.`cod_propiedad`,ps.`cod_servicio`, max(vs.`fecha_valor`) fecha_max
from `propiedades_servicios` ps inner join
     `valores_servicios` vs on  ps.`cod_propiedad`=vs.`cod_propiedad`
                            and ps.`cod_servicio`=vs.`cod_servicio`
where vs.`fecha_valor`<=CURRENT_DATE
group by ps.`cod_propiedad`,ps.`cod_servicio`
);

select ser.`cod_servicio`, ser.`nom_servicio`,
pro.`cod_propiedad`,pro.`direccion`, pro.`capacidad`,
ps.`cod_servicio`,vs.`valor_servicio`
from servicios ser
LEFT JOIN `propiedades_servicios` ps on ser.`cod_servicio`=ps.`cod_servicio`
LEFT JOIN propiedades pro on ps.`cod_propiedad` = pro.`cod_propiedad`
left join val_act on  ps.`cod_propiedad`=val_act.cod_propiedad
             and ps.`cod_servicio`=val_act.cod_servicio
LEFT join
     `valores_servicios` vs on  vs.`cod_propiedad`=val_act.cod_propiedad
                            and vs.`cod_servicio`=val_act.cod_servicio
                            and vs.`fecha_valor`=val_act.fecha_max
order by ser.`nom_servicio`
--4

select sum(importe_pago) into @total
from pagos
where fecha_pago is null;

select p.cod_propiedad, sum(`importe_pago`), sum(importe_pago)/@total
from pagos p
inner join `propiedades` pro on p.`cod_propiedad`= pro.`cod_propiedad`
where fecha_pago is null
group by 1

--5

select al.`cod_propiedad`, per.`apellido`, pro.`caracteristicas`
from `alquileres` al
inner join `propiedades` pro on al.`cod_propiedad`=pro.`cod_propiedad`
inner join `personas` per on per.`dni` = pro.`dni_propietario`
where al.`fecha_alquiler` >= "2013/01/01" AND
pro.`cod_propiedad` not in
(select propi.`cod_propiedad` from propiedades propi
inner join alquileres alqui on propi.cod_propiedad = alqui.cod_propiedad
where alqui.fecha_alquiler between "2012/01/01" and "2012/12/31")

--6
drop temporary table if exists sumadeuda;
create temporary table sumadeuda
select pagos.`cod_propiedad`, sum(importe_pago) deuda
from pagos
where fecha_pago is null
group by 1;

drop temporary table if exists sumapago;
create temporary table sumapago
select pagos.`cod_propiedad`, sum(importe_pago) pago
from pagos
where fecha_pago is not null
group by 1;

select pa.`cod_propiedad`,
count(fecha_pago) "Fechas Pago" ,
count(*) - count(fecha_pago) "Fechas adedudadas", deuda "Suma deuda",
pago "Suma pagada"
from pagos pa
inner join sumadeuda on pa.`cod_propiedad`=sumadeuda.cod_propiedad
inner join sumapago on pa.`cod_propiedad`=sumapago.cod_propiedad
group by 1

--7
select distinct per.`nombre`, per.`apellido`, per.`email`
from alquileres a inner join
    `personas` per on per.`dni`=a.`dni_cliente`
where a.`fecha_alquiler` BETWEEN "2012/01/01" and "2012/12/31"

--8
select distinct per.`nombre`, per.`apellido`, per.`email`
from `personas` per left join
    alquileres a on per.`dni`=a.`dni_cliente`
    where a.`dni_cliente` is NULL

-- 9
start transaction;

update personas set fecha_verifica =CURRENT_DATE, pendiente_validacion=0,
                    usuario=concat(nombre, apellido), contrasenia=dni
where pendiente_validacion;

commit;

--10
start TRANSACTION;

insert into `propiedades_servicios` values(2,3);
insert into `valores_servicios` values(2,3,'20090801',100);
insert into `valores_servicios` values(2,3,'20090901',150);

commit;

