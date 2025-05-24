--19:35
/*
1)

*/
select c.`nro_contrato`,c.`fecha_evento`, sc.`nombre_servicio`
from `contratos_por_eventos` c
     inner join `servicios_contratos` sc
           on c.`nro_contrato`=sc.`nro_contrato`
where c.`fecha_evento`>='2007-09-01' and c.`fecha_evento`<='2007-09-31'

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
2)

*/
select sc.`nombre_servicio`, count(*) cantidad
from `servicios_contratos` sc
group by sc.`nombre_servicio`

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
3)

*/
select p.`idpersona`,p.`apellidoynombre`,c.`nro_contrato`,c.`fecha_evento`,
       rp.nro_recibo, rp.fecha_recibo, rp.valor_abonado
from `contratos_por_eventos` c
     inner join `recibos_pago` rp
           on c.`nro_contrato`=rp.`nro_contrato`
     inner join personas p
           on c.`idpersona`=p.`idpersona`
where c.`nro_contrato`=2


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
4)

*/
select p.`dni`,p.`apellidoynombre`,count(*) cant_eventos
from personas p
     inner join `contratos_por_eventos` c
           on c.`idpersona`=p.`idpersona`
group by p.`dni`,p.`apellidoynombre`
order by cant_eventos desc

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
5)

*/

create temporary table val_serv
       (select pre_ser.`nombre_servicio`, max(pre_ser.`fecha_precio`) fecha_precio
        from `precios_servicios` pre_ser
        where pre_ser.`fecha_precio`<='2007-09-25'
        group by pre_ser.`nombre_servicio`);

select c.`nro_contrato`,sum(ps.`importe`)+c.`valor_serv_pers` total
from `contratos_por_eventos` c
     inner join `servicios_contratos` sc
           on sc.`nro_contrato`=c.`nro_contrato`
     inner join val_serv
           on sc.`nombre_servicio`=val_serv.nombre_servicio
     inner join `precios_servicios` ps
           on ps.`nombre_servicio`=val_serv.`nombre_servicio`
           and ps.`fecha_precio`=val_serv.fecha_precio
where c.`fecha_evento`='2007-09-25'
group by c.`nro_contrato`;
           
drop table val_serv;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
6)

*/
select ve.`dni`,
       sum(rp.`valor_abonado`)*(ve.`porcentaje_comision`/100)+ve.`sueldo_basico`,
       ve.`sueldo_basico`
from `contratos_por_eventos` c
     inner join `valores_empleados` ve
           on c.`dni_empleado`=ve.`dni`
     inner join `recibos_pago` rp
           on c.`nro_contrato`=rp.`nro_contrato`
where ve.`anio_valor`=2007 and ve.`mes_valor`=9
      and c.`fecha_evento`>='2007-09-01' and c.`fecha_evento`<='2007-09-31'
group by ve.`dni`
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
7)

*/
select *
from personas p
where p.`fecha_tentativa`>'2007-11-24'
AND p.dni is null

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
8)

*/
select e.dni,e.`apellidoynombres`,count(*) cant_serv
from empleados e
     inner join `contratos_por_eventos` c
           on e.`dni`=c.`dni_empleado`
     inner join `servicios_contratos` sc
           on c.`nro_contrato`=sc.`nro_contrato`
group by e.dni,e.`apellidoynombres`
order by cant_serv

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
9)

*/

select p.`dni`,p.`apellidoynombre`,e.`dni`, e.`apellidoynombres`,count(*) cant_eventos
from personas p
     inner join `contratos_por_eventos` c
           on p.`idpersona`=c.`idpersona`
     inner join empleados e
           on e.`dni`=c.`dni_empleado`
group by p.`dni`,p.`apellidoynombre`,e.`dni`, e.`apellidoynombres`

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
10

*/
select p.`apellidoynombre`,c.`nro_contrato`,c.`fecha_evento`, count(*) cant_servicios
from personas p
     inner join `contratos_por_eventos` c
           on p.`idpersona`=c.`idpersona`
     inner join `servicios_contratos` sc
           on c.`nro_contrato`=sc.`nro_contrato`
group by p.`apellidoynombre`,c.`nro_contrato`,c.`fecha_evento`
having cant_servicios<3

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
11

*/
select p.*
from personas p
     inner join `contratos_por_eventos` c
           on p.`idpersona`=c.`idpersona`
where c.`salon_ubicacion` is null

/*
12

*/

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

select *
from `personas`
where personas.`idpersona` not in (select p.`idpersona`
                                   from personas p
                                        inner join `contratos_por_eventos` c
                                                   on p.`idpersona`=c.`idpersona`
                                   where c.`salon_ubicacion` is null)
                                   
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
13

*/
update `valores_empleados`
set sueldo_basico=sueldo_basico*1.07
where sueldo_basico>=1000 and anio_valor=2007 and mes_valor=10;

update `valores_empleados`
set sueldo_basico=sueldo_basico*1.1
where sueldo_basico<1000 and anio_valor=2007 and mes_valor=10;
