use afatse;

drop temporary table if exists materialesErica;
create temporary table if not exists materialesErica
select cod_material
	from materiales
    where autores like "%Erica de Forifregoro%"
;

select * from materiales_plan
	where cod_material in (select cod_material from materialesErica)
;

start transaction;

DELETE FROM materiales_plan 
	WHERE cod_material in (select cod_material from materialesErica);

DELETE FROM materiales 
	WHERE cod_material in (select cod_material from materialesErica);

-- rollback;
-- commit;