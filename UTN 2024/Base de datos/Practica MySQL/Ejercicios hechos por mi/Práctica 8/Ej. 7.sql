use afatse;

start transaction;

DELETE FROM examenes_temas WHERE nom_plan = "Administrador de BD";
DELETE FROM examenes WHERE nom_plan = "Administrador de BD";
DELETE FROM plan_temas WHERE nom_plan = "Administrador de BD";
DELETE FROM materiales_plan WHERE nom_plan = "Administrador de BD";
DELETE FROM valores_plan WHERE nom_plan = "Administrador de BD";
DELETE FROM plan_capacitacion WHERE nom_plan = "Administrador de BD";

-- rollback;
-- commit;