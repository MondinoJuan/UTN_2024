use afatse;

SELECT *
FROM `materiales_plan`
WHERE cod_material IN ( "AP-008", "AP-009");

start transaction;

DELETE FROM materiales WHERE cod_material in ("AP-008", "AP-009");

-- rollback;
-- commit;