

/*laboratorio MySQL 22-09-2010*/

/* SQL 1 */
select  r.`id_barco`, b.`nacionalidad`, b. `caracteristicas`, tb. desc_tipo_barco , emp.`razon_social`
 from `registros_entrada` r
 inner join barcos b  on b.id_barco = r.id_barco
 inner join  `tipos_barcos`  tb on b.cod_tipo_barco= tb.cod_tipo_barco
 inner join `empresas_consignatarias` emp on b.`id_empresa` = emp.`id_empresa`
 where r.`fecha_atraque` = 20100922;
/* fin SQL 1 */


/* SQL 2 */
select s.`cod_servicio`, s.`desc_servicio`, count(*) cantidad
from servicios s inner join albaran a
on s.`cod_servicio`=a.`cod_servicio`
group by 1,2
having cantidad>10;
/* fin SQL 2 */


/* SQL 3 */
drop temporary table if exists tt_fechaprecios;
create temporary table tt_fechaprecios
(select p.cod_material, max(p.`fecha`) fec_max
 from `materiales_precios` p
 where p.`fecha`<=20100922
 group by p.`cod_material`);

select sum(am.`cantidad`* valor)'Importe total del mes'
from `albaran` al
inner join `albaran_materiales` am
on al.`id_barco` = am.`id_barco`
and al.`nro_registro` = am.`nro_registro`
and al.`cod_servicio` = am.`cod_servicio`
inner join materiales_precios mp
ON am.`cod_material` = mp.`cod_material`
inner join tt_fechaprecios va
on mp.`cod_material` = va.`cod_material`
and mp.`fecha` = va.fec_max
WHERE (al.fecha_inicio >= 20100901 AND al.fecha_inicio <= 20100921)

/* fin SQL 3 */

/* esto es para revisar la consulta 3 con fecha inicio 21*/
select * from albaran al
inner join `albaran_materiales` am
on al.`id_barco` = am.`id_barco`
and al.`nro_registro` = am.`nro_registro`
and al.`cod_servicio` = am.`cod_servicio`
where al.`fecha_inicio` = 20100921

/* SQL 4 */
drop temporary table if exists totalserxalba;
create temporary table totalserxalba
(select s.`cod_servicio`, count(a.cod_servicio)total
from servicios s
left join albaran a
on s.`cod_servicio` = a.`cod_servicio`
GROUP by 1);

select sum(total)/count(*) into @prom
from totalserxalba;

select s.`cod_servicio`, s.`desc_servicio`, count(a.cod_servicio) cantidad
from servicios s left join albaran a
on s.`cod_servicio`=a.`cod_servicio`
group by 1,2
having cantidad<=@prom;

/* fin SQL 4 */

/* SQL 5 */
select s.cod_servicio,s.`desc_servicio`, IFNULL(a.fecha_inicio,'nunca solicitado')
from servicios s
left join albaran a on s.`cod_servicio`= a.`cod_servicio`;


/* con IF */
select s.cod_servicio,s.`desc_servicio`, IF (a.fecha_inicio is null,'nunca solicitado',a.fecha_inicio)
from servicios s
left join albaran a on s.`cod_servicio`= a.`cod_servicio`;

/* con CASE */
select s.cod_servicio,s.`desc_servicio`, case when a.fecha_inicio is null then 'nunca solicitado' else a.fecha_inicio end
from servicios s
left join albaran a on s.`cod_servicio`= a.`cod_servicio`;


/* fin SQL 5 */

/* SQL 6*/
select count(*) into @entradas
from `registros_entrada`;

select b.`cod_tipo_barco`,tb.`desc_tipo_barco`, count(*), (count(*)/@entradas)*100 pje
from `registros_entrada` r
inner join `barcos`b on b.`id_barco` = r.`id_barco`
inner join `tipos_barcos` tb on tb.`cod_tipo_barco`= b.`cod_tipo_barco`
group by cod_tipo_barco;
/* Fin SQL 6*/


/* SQL 7 */
select  distinct r. cod_mercancia, desc_mercancia
from `registros_entrada` r inner join `mercancias`m on m.`cod_mercancia`= r.`cod_mercancia`
where r.fecha_atraque BETWEEN 20100901 and 20100930 and r.cod_mercancia
          not in (select re.`cod_mercancia` from `registros_entrada` re
          where re.fecha_atraque BETWEEN 20100801 and 20100831);
          
/* alternativa para no usar distinct*/
select cod_mercancia, desc_mercancia
from `mercancias`
where cod_mercancia
          not in (select re.`cod_mercancia` from `registros_entrada` re
          where re.fecha_atraque BETWEEN 20100801 and 20100831)
          and cod_mercancia in (select re.`cod_mercancia` from `registros_entrada` re
          where re.fecha_atraque BETWEEN 20100901 and 20100930)
/* fin SQL 7 */

/* SQL 8 */
select b.id_barco, b.`nombre_barco`, a.nro_registro, e.`razon_social`, a.`cod_servicio`, s.`desc_servicio`
from `albaran` a
inner join `barcos` b on b.`id_barco` = a.`id_barco`
inner join `empresas_consignatarias` e on e.`id_empresa`= b.`id_empresa`
inner join servicios s on s.`cod_servicio` = a.`cod_servicio`
WHERE s.desc_servicio = 'grúas'
and a.`fecha_fin`is NULL;

/* fin SQL 8 */

/* SQL 9 */

select DATEDIFF('20100922',fecha_atraque)into @dias
from `registros_entrada`
where id_barco=987 and fecha_atraque = 20100913;

/* como datediff es muy difícil que lo saquen acá esta con la cuenta*/

select ('20100922' - fecha_atraque) into @dias
from `registros_entrada`
where id_barco=987 and fecha_atraque = 20100913;

select max(val.`fecha_desde`) into @fec_max
 from `atraque_diario_valores` val
 where val.`dias_desde` <= @dias
   AND val.`dias_hasta` > @dias
   and val.`fecha_desde` <= '20100922';

select monto*@dias 'Debe Abonar'
from `atraque_diario_valores` val
 where val.`dias_desde` <= @dias
   AND val.`dias_hasta` > @dias
   and val.`fecha_desde` = @fec_max;

/* fin SQL 9 */

/* SQL 10 */
select e.id_empresa, razon_social, count(r.`id_barco`)
from `empresas_consignatarias` e
left join barcos b
on e.`id_empresa`= b.`id_empresa`
left join `registros_entrada` r
on b.`id_barco`= r.`id_barco`
group by 1
order by 3 DESC, 2;

/* fin SQL 10 */

/* Bonus*/
/* SQL 11 */

select re.`id_barco`, b.`nombre_barco`, re.`nro_registro`,
       m.`cod_material`,m.`desc_material`, count(*) cantidad
from `registros_entrada` re inner join
      `barcos` b on re.`id_barco`=b.`id_barco`
      inner join `albaran` a
      on  re.`id_barco`=a.`id_barco`
      and re.`nro_registro`=a.`nro_registro` inner join
      servicios_materiales sm on a.`cod_servicio`=sm.`cod_servicio`
 inner join materiales m on sm.`cod_material`=m.`cod_material`
      left join `albaran_materiales` am
           on  am.`id_barco`=a.`id_barco`
           and am.`nro_registro`=a.`nro_registro`
           and am.`cod_servicio`=a.`cod_servicio`
           and am.`cod_material`=sm.`cod_material`
where am.`cod_material` is null
 group by re.`id_barco`, b.`nombre_barco`, re.`nro_registro`,
       m.`cod_material`,m.`desc_material`

/* fin SQL 11 */

/* SQL 12*/

start transaction;

insert into materiales values(1000, 'anclas tipo 3','Luraschi', 100,50,'11-11111111-1');
insert into `materiales_precios` values(1000, current_date, 150);
insert into `servicios_materiales` values(1000,2);
insert into `servicios_materiales` values(1000,4);

commit;

/* Fin SQL 12*/


/* SQL 13*/

start transaction;

update materiales set punto_pedido=punto_pedido*1.1 where punto_pedido>=50;
update materiales set punto_pedido=punto_pedido*1.3 where punto_pedido<50;

commit;

/* Fin SQL 13*/





