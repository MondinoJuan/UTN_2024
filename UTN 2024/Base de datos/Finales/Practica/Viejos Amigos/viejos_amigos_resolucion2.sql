/* SQL 1 */

select act.`descripcion`, sa.`anio_incripcion`, sa.`mes_inscripcion`
from socios soc inner join
     `socios_actividades` sa
                on soc.`nro_socio`=sa.`nro_socio`
                inner join
     `actividades` act
                on act.`cod_actividad`=sa.`cod_actividad`
where soc.`apeynom` like 'juan perez';

/* Fin SQL 1 */

/* SQL 2*/

select inst.*
from actividades act inner join
     `instalaciones` inst
                     on act.`cod_instalacion`=inst.`cod_instalaciones`
where act.`descripcion` like 'nataci%'
order by act.`hora_desde`;
/*Fin SQL 2 */

/* SQL 3 */

select s.`apeynom`, max(fecha_pago)
from `liquidaciones` l inner join
     socios s ON
            s.`nro_socio`=l.`nro_socio`
     where l.`fecha_pago` is not null
     group by l.`nro_socio`, s.`apeynom`;
     
/* Fin SQL 3 */

/* SQL 4 */

select * from socios
where nro_socio not in
(
select distinct l.`nro_socio`
from liquidaciones l
where l.`fecha_pago` is not null
);

/* Fin SQL 4 */

/* SQL 5 */

select serv.`cod_servicio`,serv.`desc_servicio`,
         count(*) cantidad_periodos
from socios s inner join
     `socios_serv_inst_mens` ssm
                             on s.`nro_socio`=ssm.`nro_socio`
                             inner join
     `servicios` serv
                             on ssm.`cod_servicio`=serv.`cod_servicio`
where s.`apeynom` like 'maría de los dolores'
group by serv.`cod_servicio`,serv.`desc_servicio`;

/* Fin SQL 5 */

/* SQL 6 */

select s.`apeynom`,l.`fecha_pago`,sum(l.`monto_total`) total
from liquidaciones l inner join
     socios s on
              l.`nro_socio`=s.`nro_socio`
group by s.`nro_socio`, s.`apeynom`,l.`fecha_pago`
having total>120;

/* FIN SQL 6

/* SQL 7 */

--Aceptar con inner join en lugar de left si se dan cuenta pero no les sale

select serv.`desc_servicio`, count(ssu.`fecha_uso`) cant_usos
from `servicios` serv inner join
     `servicios_instalaciones` si ON serv.`cod_servicio`=si.`cod_servicio`
                                  left join
     `socios_serv_inst_uso` ssu ON  ssu.`cod_servicio`=si.`cod_servicio`
                                and ssu.`cod_instalaciones`=si.`cod_instalaciones`
where serv.`tipo_servicio` like '%uso%'
group by si.`cod_servicio`,si.`cod_instalaciones`
order by cant_usos asc, serv.`desc_servicio` desc

/* Fin SQL 7 */

/* SQL 8 */

select a.`descripcion`, a.`dias_semana`, a.`hora_desde`, a.`hora_hasta`, i.`apeynom`
from actividades a inner join
     instructores i ON
                    a.`cuil_instructor`=i.`cuil_instructor`
where a.`descripcion` like '%natación%'

/* FIN SQL 8*/

/* SQL 9 */

select a.`cod_actividad`, a.`descripcion`, sum(va.`monto_actividad`)
from `valores_actividades` va inner join
     `actividades` a on va.`cod_actividad`=a.`cod_actividad`
                     inner join
     `socios_actividades` sa on va.`cod_actividad`=sa.`cod_actividad`
                             and va.`anio_valor`=sa.`anio_incripcion`
                             and va.`mes_valor`=sa.`mes_inscripcion`
where va.`anio_valor`=2007 and va.`mes_valor`=11
group by a.`cod_actividad`, a.`descripcion`

/* Fin SQL 9 */

/* SQL 10 */

select s.*
from socios s inner join
     `socios_serv_inst_mens` ssm
                             on s.`nro_socio`=ssm.`nro_socio`
where ssm.`fecha_fin_vigencia` between '2007-12-01' and '2007-12-31'

/* FIN SQL 10*/

/* SQL 11 */

select * from socios where nro_socio not in
(
select nro_socio
from `liquidaciones` l
where l.`anio_liquidacion`=2008 and l.`mes_liquidacion`=1
and l.fecha_pago is not NULL
)

/* Fin SQL 11 */

/* SQL 12 */

select descripcion, dias_semana, avg(monto_actividad), stddev(monto_actividad)
from actividades a inner join `valores_actividades` va
on a.`cod_actividad`=va.`cod_actividad`
group by a.`cod_actividad`

/* Fin SQL 12 */

/* SQL 13 */

update valores_actividades set monto_actividad=monto_actividad*1.1
where anio_valor=2008 and mes_valor=1 and monto_actividad>=20;

update valores_actividades set monto_actividad=monto_actividad*1.2
where anio_valor=2008 and mes_valor=1 and monto_actividad<20;

/* Fin SQL 13 */

/* SQL 14 */

select s.`nro_socio`,tc.`anio_tarifa`,tc.`mes_tarifa`,tc.`monto_tarifal`,
       ifnull(sum(va.`monto_actividad`),0) monto_actividades,
       tc.`monto_tarifal`+ifnull(sum(va.`monto_actividad`),0) total_mes
from
socios s inner join `tarifas_cuotas` tc left join
`socios_actividades` sa
                on  sa.`nro_socio`=s.`nro_socio`
                and sa.`anio_incripcion`=tc.`anio_tarifa`
                and sa.`mes_inscripcion`=tc.`mes_tarifa`
                left join
`valores_actividades` va
                on  va.`cod_actividad`=sa.`cod_actividad`
                and va.`anio_valor`=sa.`anio_incripcion`
                and va.`mes_valor`=sa.`mes_inscripcion`
group by s.`nro_socio`,tc.`anio_tarifa`,tc.`mes_tarifa`,tc.`monto_tarifal`

 /* Fin SQL 14 */
 
 /* SQL 15 */
 
 insert into `tarifas_cuotas`(anio_tarifa, mes_tarifa, monto_tarifal)
 select 2008,2, tc.`monto_tarifal`*1.3
 from `tarifas_cuotas` tc
 where tc.`anio_tarifa`=2008 and tc.`mes_tarifa`=1
 
 /* SQL 15 */
