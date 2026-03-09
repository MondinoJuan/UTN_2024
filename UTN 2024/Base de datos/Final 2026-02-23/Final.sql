# Final SQL

-- 1
/*
PUESTOS SIN PROCESO DE SELECCIÓN
Por un trabajo de monitoreo de datos, nos solicitan un listado de solicitudes de puestos que al 01/01/2017 no se haya realizado 
ningún proceso de selección.  

Mostrar solicitudes de puestos que no hayan sido canceladas. Indicar descripción del área, puestos y fecha de solicitud
*/

use recursos_humanos;

drop temporary table if exists pros_selec_No2017;
create temporary table pros_selec_No2017 as
select ps.cod_puesto, ps.cod_area, ps.fecha_solic from proceso_seleccion ps
where year(ps.fecha_hora) < 2017  
;

select a.denominacion, pdt.descripcion, sp.fecha_solic from solicitudes_puestos sp
inner join areas a on sp.cod_area = a.cod_area
inner join puestos_de_trabajo pdt on sp.cod_puesto = pdt.cod_puesto
where sp.fecha_canc is null and (sp.cod_puesto, sp.cod_area, sp.fecha_solic) not in (select * from pros_selec_No2017)
;

-- 2
use recursos_humanos;
select ps.cod_estado, e.descripcion, count(*) as cantidad from solicitudes_puestos sp
inner join proceso_seleccion ps on sp.cod_puesto = ps.cod_puesto and sp.cod_area = ps.cod_area 
	and sp.fecha_solic = ps.fecha_solic
inner join estados e on ps.cod_estado = e.cod_estado
where e.descripcion not like 'contrato' and e.descripcion not like 'rechazo' and sp.fecha_canc is not null
group by ps.cod_estado
having cantidad > 3
order by e.descripcion asc
;

-- 3
use recursos_humanos;

DELIMITER $$
drop procedure if exists comparativaSal $$
create procedure comparativaSal(IN areaIng varchar(50), in puestoIng varchar(50), in fechaIng date, 
	out salarioFecha decimal(10, 2), out salarioActual decimal(10, 2), out porcentajeAumento decimal(10, 2))
begin
		
        declare codAreaRecibida int;
        declare codPDTRecibida int;
        
		select cod_area into codAreaRecibida from areas
        where denominacion like areaIng;
        
        select cod_puesto into codPDTRecibida from puestos_de_trabajo
        where descripcion like puestoIng;
	
		select s.valor_hora into salarioFecha from salario s
		where s.cod_puesto = codPDTRecibida and s.cod_area = codAreaRecibida
            and s.fecha <= fechaIng
		order by fecha asc
        limit 1
		;        
        
        drop temporary table if exists fechaMax;
        create temporary table fechaMax as
			select cod_area, cod_puesto, max(fecha) as fechaMax from salario
            group by cod_area, cod_puesto
            ;
    
		select s.valor_hora into salarioActual from salario s
        inner join fechaMax fm on fm.cod_area = s.cod_area and fm.cod_puesto = s.cod_puesto and fm.fechaMax = s.fecha
		where s.cod_puesto = codPDTRecibida and s.cod_area = codAreaRecibida 
			and s.fecha < fechaIng
            ;
    
    set porcentajeAumento = ((salarioActual - salarioFecha) / salarioFecha) * 100;
end $$
DELIMITER ;

call comparativaSal('Produccion', 'operario', '20261212', @salarioFecha, @salarioActual, @porcentajeAumento);
select @salarioFecha, @salarioActual, @porcentajeAumento;

-- 4
use recursos_humanos;

start transaction;
 create table Categorias(
	codigo_cat int not null, 
    descripcion varchar(50) not null,
    primary key(codigo_cat) 
    );

	alter table empleados
		add codigo_cat int,
        add constraint codigo_cat foreign key (codigo_cat) reference (Categorias);    
rollback;
