# PRÁCTICA N11

# Ejercicio 1
use afatse;
CREATE TABLE `alumnos_historico` (
    `dni` INT(11) NOT NULL,
    `fecha_hora_cambio` DATETIME NOT NULL,
    `nombre` VARCHAR(20) DEFAULT NULL,
    `apellido` VARCHAR(20) DEFAULT NULL,
    `tel` VARCHAR(20) DEFAULT NULL,
    `email` VARCHAR(50) DEFAULT NULL,
    `direccion` VARCHAR(50) DEFAULT NULL,
    `usuario_modificacion` VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`dni` , `fecha_hora_cambio`),
    CONSTRAINT `alumnos_historico_alumnos_fk` FOREIGN KEY (`dni`)
        REFERENCES `alumnos` (`dni`)
        ON UPDATE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=UTF8

-- TRIGGERS
DELIMITER $$
drop trigger if exists trg_ingresoNewAlumnoAlHistorico $$
create trigger trg_ingresoNewAlumnoAlHistorico after insert on alumnos for each row
begin
	insert into alumnos_historico(dni, fecha_hora_cambio, nombre, apellido, tel, email, direccion, usuario_modificacion)
		values (new.dni, current_timestamp(), new.nombre, new.apellido, new.tel, new.email, new.direccion, current_user());
end $$

drop trigger if exists trg_actualizoAlumnoAlHistorico $$
create trigger trg_actualizoAlumnoAlHistorico after update on alumnos for each row
begin
	insert into alumnos_historico
		values (new.dni, current_timestamp(), new.nombre, new.apellido, new.tel, new.email, new.direccion, current_user());
end $$

DELIMITER ;

# Ejercicio 2

CREATE TABLE `stock_movimientos` (
	`cod_material` char(6) NOT NULL,
	`fecha_movimiento` timestamp NOT NULL default CURRENT_TIMESTAMP on update
	CURRENT_TIMESTAMP,
	`cantidad_movida` int(11) NOT NULL,
	`cantidad_restante` int(11) NOT NULL,
	`usuario_movimiento` varchar(50) NOT NULL,
	PRIMARY KEY (`cod_material`,`fecha_movimiento`),
	CONSTRAINT `stock_movimientos_fk` FOREIGN KEY (`cod_material`) REFERENCES
	`materiales` (`cod_material`) ON UPDATE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    
-- TRIGGERS
DELIMITER $$
drop trigger if exists trg_ingresoNewMaterialAlHistorico $$
create trigger trg_ingresoNewMaterialAlHistorico after insert on materiales for each row
begin
	if new.cant_disponible is not null then
		insert into stock_movimientos(cod_material, cantidad_movida, cantidad_restante, usuario_movimiento)
			values (new.cod_material, new.cant_disponible, new.cant_disponible, current_user());
	end if;
end $$

drop trigger if exists trg_actualizoMaterialesAlHistorico $$
create trigger trg_actualizoMaterialesAlHistorico after update on materiales for each row
begin
	if new.cant_disponible is not null then
		IF OLD.cant_disponible <> NEW.cant_disponible THEN
			insert into stock_movimientos(cod_material, cantidad_movida, cantidad_restante, usuario_movimiento)
				values (new.cod_material, new.cant_disponible - old.cant_disponible, new.cant_disponible, current_user());
		end if;
	end if;
end $$

DELIMITER ;

# Ejercicio 3
use afatse;
start transaction;

alter table cursos
	add column cant_inscriptos int(11) default null
    ;
    
drop temporary table if exists insc_curso;
create temporary table insc_curso as
select c.`nom_plan`, c.`nro_curso`, count(i.`nro_curso`) cant from cursos c 
left join `inscripciones` i on c.`nom_plan`=i.`nom_plan` and c.`nro_curso`=i.`nro_curso`
group by c.`nom_plan`, c.`nro_curso`;

UPDATE cursos c
        INNER JOIN
    insc_curso ic ON c.`nom_plan` = ic.`nom_plan`
        AND c.`nro_curso` = ic.`nro_curso` 
SET 
    c.`cant_inscriptos` = ic.cant;

alter table cursos
	modify cant_inscriptos int(11) not null;

rollback;

-- TRIGGERS
DELIMITER $$
drop trigger if exists trg_actualizoCantInsc_afterNewInsc $$
create trigger trg_actualizoCantInsc_afterNewInsc after insert on inscripciones for each row
begin
	update cursos
		set cant_inscriptos = cant_inscriptos + 1
        where nom_plan = new.nom_plan and nro_curso = new.nro_curso;
end $$

drop trigger if exists trg_actualizoCantInsc_afterDelInsc $$
create trigger trg_actualizoCantInsc_afterDelInsc after delete on inscripciones for each row
begin
	update cursos
		set cant_inscriptos = cant_inscriptos - 1
        where nom_plan = new.nom_plan and nro_curso = new.nro_curso;
end $$

DELIMITER ;

# Ejercicio 4
use afatse;
alter table `valores_plan` add column usuario_alta varchar(50);

-- TRIGGERS
DELIMITER $$
drop trigger if exists trg_guardoUserNewPrice $$
create trigger trg_guardoUserNewPrice after insert on valores_plan for each row
begin
    set usuario_alta = current_user();
end $$

DELIMITER ;





