use afatse;

-- A-
CREATE TABLE alumnos_historico (
    dni INT NOT NULL,
    fecha_hora_cambio DATETIME NOT NULL,
    nombre VARCHAR(20) DEFAULT NULL,
    apellido VARCHAR(20) DEFAULT NULL,
    tel VARCHAR(20) DEFAULT NULL,
    email VARCHAR(50) DEFAULT NULL,
    direccion VARCHAR(50) DEFAULT NULL,
    usuario_modificacion VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (dni , fecha_hora_cambio),
    CONSTRAINT alumnos_historico_alumnos_fk FOREIGN KEY (dni)
        REFERENCES alumnos (dni)
        ON UPDATE CASCADE
)  ENGINE=INNODB DEFAULT CHARSET=UTF8;

-- B-
create definer = current_user trigger afatse.alumnos_historico_AFTER_INSERT after insert on alumnos_historico for each row
begin
	
end;

