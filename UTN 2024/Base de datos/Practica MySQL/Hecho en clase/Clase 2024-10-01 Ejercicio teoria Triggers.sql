/*
EJERCICIO TEORÍA
Se requiere realizar una tabla de auditoría que registre la trazabilidad de los cambios de la tabla de Proveedores indicando fecha, 
hora y usuario que realizó el cambio.
*/

Create table audi_prove (
	cuit bigint(11) not null,
    fecha_hora_cambio datetime not null,
    razon_social varchar(20) not null,
    direccion varchar(30) not null,
    telefono varchar(20) default null,
    email varchar(25) default null,
    direc_web varchar(20) default null,
    cod_postal int(11) not null,
    usuario_modificacion varchar(50) default null,
    primary key (cuit, fecha_hora_cambio),
    constraint audi_prove_personas_fk foreign key (cuit) references personas (cuit)
    on update cascade) engine = InnoDB default charset = utf8;