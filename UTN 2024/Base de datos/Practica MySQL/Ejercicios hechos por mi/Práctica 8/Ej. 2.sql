use afatse; 

start transaction;

insert into plan_capacitacion /*(nom_plan, desc_plan, hs, modalidad)*/
	values ("Administrador de BD", "Instalación y configuración MySQL. Lenguaje SQL. Usuarios y permisos.", 300, "Presencial")
;

insert into plan_temas /*(nom_plan, titulo, detalle)*/
	values ("Administrador de BD", "Instalación MySQL.", "Distintas configuraciones de instalación."),
		   ("Administrador de BD", "Configuración DBMS.", "Variables de entorno, su uso y configuración."),
		   ("Administrador de BD", "Lenguaje SQL.", "DML, DDL Y TCL."),
		   ("Administrador de BD", "Usuario y permisos.", "Permisos de usuarios y DCL.")
;

INSERT INTO examenes
VALUES ( "Administrador de BD", 1),
	   ( "Administrador de BD", 2),
	   ( "Administrador de BD", 3),
	   ("Administrador de BD", 4)
;

insert into examenes_temas /*(nom_plan, titulo, nro_examen)*/
	values ("Administrador de BD", "Instalación MySQL.", 1),
		   ("Administrador de BD", "Configuración DBMS.", 2),
		   ("Administrador de BD", "Lenguaje SQL.", 3),
	       ("Administrador de BD", "Usuario y permisos.", 4)
;

insert into materiales_plan /*(nom_plan, cod_material, cant_entrega)*/
	values ("Administrador de BD", "UT-001", 0),
		   ("Administrador de BD", "UT-002", 0),
		   ("Administrador de BD", "UT-003", 0),
		   ("Administrador de BD", "UT-004", 0)
;

insert into materiales /*(cod_material, desc_material, url_descarga, autores, tamanio, fecha_creacion)*/
	values ("AP-008", "aaaaaaaaaa", "www.afatse.com.ar/apuntes?AP=008", "Roberto Carlos", 5, "2024-10-07", 0, 0, 0),
		   ("AP-011", "SQL en MySQL,", "www.afatse.com.ar/apuntes?AP=011", "Juan Lopez", 3, "2009-04-01", 0, 0, 0)
;

insert into valores_plan /*(nom_plan, fecha_desde_plan, valor_plan)*/
	values ("Administrador de BD", "2009-02-01", 150)
;

-- commit;

select * from plan_capacitacion;
select * from plan_temas;
select * from examenes;
select * from examenes_temas;
select * from materiales_plan;
select * from materiales;
select * from valores_plan;
