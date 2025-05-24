
/* SQL 1 */
select den.`nro_denuncia`,den.`fecha_hora`, motivo, de.nombre, de.`apellido`
from denuncias den
inner join `denunciantes` de on den.`nro_tel`= de.nro_tel
where year(den.`fecha_hora`)=2010 and month(den.`fecha_hora`)=2
union
select den.`nro_denuncia`,den.`fecha_hora`, motivo, ins.nombre, ins.`apellido`
from denuncias den
inner join `inspectores` ins on den.`nro_legajo`=ins.`nro_legajo`
where year(den.`fecha_hora`)=2013 and month(den.`fecha_hora`)=2;

--otra forma


select den.`nro_denuncia`, den.`fecha_hora`, motivo, de.nombre, de.`apellido`,
ins.`apellido`, ins.`nombre`
from denuncias den
LEFT join `denunciantes` de on den.`nro_tel`=de.nro_tel
LEFT join `inspectores` ins on den.`nro_legajo`=ins.`nro_legajo`
where year(den.`fecha_hora`)=2013 and month(den.`fecha_hora`)=2;

/* SQL 2*/

select den.`nro_denuncia`,den.`fecha_hora`, motivo,dv.`patente`, per.`nombre`,per.`apellido`,
IFNULL(gr.`nro_grua`,"Sin Remolque")
from denuncias den
inner join `denuncias_vehiculos` dv on den.`nro_denuncia`=dv.`nro_denuncia`
inner join `propietarios` prop on dv.`patente`=prop.`patente`
inner join `personas` per on prop.`dni`=per.`dni`
left join `gruas` gr on gr.`nro_grua` = dv.`nro_grua`
where year(den.`fecha_hora`)=2013 and month(den.`fecha_hora`)=2;

/* Fin SQL 2*/

/* SQL 3*/

select d.`nro_tel`,d.`nombre`,d.`apellido`, count(*) cant_descartadas
from denuncias den
     inner join denunciantes d on den.`nro_tel`=d.`nro_tel`
where den.`estado`='descartada'
group by d.`nro_tel`,d.`nombre`,d.`apellido`
HAVING COUNT(*) > 1
order by cant_descartadas desc, d.nro_tel asc;

/* Fin SQL 3*/
/*SQL 4*/
SELECT sum(importe) into @total_año
from `pagos`
where year(fecha_hora_pactada) =2013;

SELECT vh.patente, count(*), count(fecha_hora_pago), sum(importe), sum(importe)/@total_año
from vehiculos vh
inner join multas mu on vh.`patente` = mu.`patente`
inner join pagos pa on mu.`nro_multa`= pa.`nro_multa`
where year(fecha_hora_pactada)=2013
group by 1
/* Fin SQL 4*/

/* SQL 5*/
drop temporary table if exists val_act;

create temporary table val_act
(
 select vi.cod_infraccion, max(vi.`fecha_desde`) fec_val
 from valores_infraccion vi
 where vi.`fecha_desde`<=current_date
 group by vi.`cod_infraccion`
);
 
drop temporary table if exists val_ant;
create temporary table val_ant
(
 select vi.cod_infraccion, max(vi.`fecha_desde`) fec_ant
 from valores_infraccion vi
 where vi.`fecha_desde`<="2012/12/31"
 group by vi.`cod_infraccion`
);

drop temporary table if exists valoresactuales;
create temporary table valoresactuales
select inf.*,vi.`valor_infraccion` valor_hoy
from infracciones inf
     inner join val_act
                on inf.`cod_infraccion`=val_act.cod_infraccion
     inner join `valores_infraccion` vi
                on  vi.`cod_infraccion`=val_act.`cod_infraccion`
                and vi.`fecha_desde`=val_act.fec_val;

drop temporary table if exists valoresviejos;
create temporary table valoresviejos
select inf.*,vi.`valor_infraccion` valor_viejo
from infracciones inf
     inner join val_ant
                on inf.`cod_infraccion`=val_ant.cod_infraccion
     inner join `valores_infraccion` vi
                on  vi.`cod_infraccion`=val_ant.`cod_infraccion`
                and vi.`fecha_desde`=val_ant.fec_ant;

select inf.*, valor_hoy, valor_viejo
from infracciones inf
inner join valoresactuales on inf.`cod_infraccion`=valoresactuales.cod_infraccion
inner join valoresviejos on inf.`cod_infraccion` =valoresviejos.cod_infraccion;

/* Fin SQL 5*/

/* SQL 6*/

select v.*
from vehiculos v inner join `multas` m on v.`patente` =m.`patente`
where year(m.`fecha_hora`) = 2013
and v.`patente` not in (select ve.patente
        from `vehiculos` ve inner join multas mu
             on mu.`patente` = ve.patente
        where year(mu.`fecha_hora`) = 2012);

/* Fin SQL 6*/


/* SQL 7*/
select g.`nro_grua`,count(dv.`nro_grua`)
from gruas g
left join `denuncias_vehiculos` dv
on g.`nro_grua` = dv.`nro_grua`
group by 1

/* Fin SQL 7*/
/* SQL 8*/
drop temporary table if exists multas_2013;
create temporary table multa_2013
SELECT ins.`nro_legajo`, count(*) cant2013
from `inspectores` ins inner JOIN `denuncias`
 on ins.`nro_legajo`=denuncias.`nro_legajo`
 where year(fecha_hora)=2013
 group by 1;
 
drop temporary table if exists multas_2012;
create temporary table multa_2012
SELECT ins.`nro_legajo`, count(*) cant2012
from `inspectores` ins inner JOIN `denuncias`
 on ins.`nro_legajo`=denuncias.`nro_legajo`
 where year(fecha_hora)=2012
 group by 1;
 
 select ins.*, cant2013, IFNULL(cant2012,0), IFNULL(cant2013,0)-IFNULL(cant2012,0)
 from `inspectores` ins
 inner join multa_2013 m2013 on ins.`nro_legajo` = m2013.nro_legajo
 left join multa_2012 m2012 on ins.`nro_legajo`=m2012.nro_legajo;
 
 /* Fin SQL 8*/
/

/* SQL 9*/

start transaction;

update denuncias set nro_denuncia_original = 7
where nro_denuncia = 8

commit;

/* Fin SQL 9*/

/* SQL 10*/

start transaction;

insert into `infracciones`(cod_infraccion, desc_infraccion)
values(7,'Luces Apagadas en Ruta');

insert into `valores_infraccion`( cod_infraccion, fecha_desde, valor_infraccion)
values(7,"2011/11/01", 429);

commit;

/* Fin SQL 10*/



