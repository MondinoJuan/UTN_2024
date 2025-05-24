# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : viejos_amigos_instalaciones


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `viejos_amigos_instalaciones`;

CREATE DATABASE `viejos_amigos_instalaciones`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `viejos_amigos_instalaciones`;

#
# Structure for the `tipos_evento` table : 
#

DROP TABLE IF EXISTS `tipos_evento`;

CREATE TABLE `tipos_evento` (
  `cod_tipo_evento` int(11) NOT NULL,
  `desc_tipo_evento` varchar(20) NOT NULL,
  PRIMARY KEY  (`cod_tipo_evento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `organizadores` table : 
#

DROP TABLE IF EXISTS `organizadores`;

CREATE TABLE `organizadores` (
  `cuit` varchar(20) NOT NULL,
  `razon_social` varchar(50) NOT NULL,
  `telefono` varchar(20) default NULL,
  `email` varchar(50) default NULL,
  `direccion` varchar(50) default NULL,
  PRIMARY KEY  (`cuit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `empleados` table : 
#

DROP TABLE IF EXISTS `empleados`;

CREATE TABLE `empleados` (
  `cuil` varchar(20) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `fecha_nac` date NOT NULL,
  `fecha_ing` date NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` varchar(20) default NULL,
  `email` varchar(50) default NULL,
  PRIMARY KEY  (`cuil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `evento` table : 
#

DROP TABLE IF EXISTS `evento`;

CREATE TABLE `evento` (
  `nro_contrato` int(11) NOT NULL,
  `fecha_contrato` date NOT NULL,
  `representante` varchar(50) NOT NULL,
  `tel_representante` varchar(20) NOT NULL,
  `cod_tipo_evento` int(11) NOT NULL,
  `cuit_organizador` varchar(20) NOT NULL,
  `cuil_empleado` varchar(20) NOT NULL,
  PRIMARY KEY  (`nro_contrato`),
  KEY `evento_fk` (`cod_tipo_evento`),
  KEY `evento_fk1` (`cuit_organizador`),
  KEY `cuil_empleado` (`cuil_empleado`),
  CONSTRAINT `evento_fk` FOREIGN KEY (`cod_tipo_evento`) REFERENCES `tipos_evento` (`cod_tipo_evento`) ON UPDATE CASCADE,
  CONSTRAINT `evento_fk1` FOREIGN KEY (`cuit_organizador`) REFERENCES `organizadores` (`cuit`) ON UPDATE CASCADE,
  CONSTRAINT `evento_fk2` FOREIGN KEY (`cuil_empleado`) REFERENCES `empleados` (`cuil`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `instalaciones` table : 
#

DROP TABLE IF EXISTS `instalaciones`;

CREATE TABLE `instalaciones` (
  `codigo` int(11) NOT NULL,
  `ubicacion` varchar(50) NOT NULL,
  `cant_max_per` int(11) NOT NULL,
  `tipo_instalacion` varchar(20) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `instalaciones_eventos` table : 
#

DROP TABLE IF EXISTS `instalaciones_eventos`;

CREATE TABLE `instalaciones_eventos` (
  `nro_contrato` int(11) NOT NULL,
  `codigo_instalacion` int(11) NOT NULL,
  `fecha_desde` date NOT NULL,
  `hora_desde` time NOT NULL,
  `fecha_hasta` date NOT NULL,
  `hora_hasta` time NOT NULL,
  `cant_personas` int(11) NOT NULL,
  `valor_pactado` float(9,3) NOT NULL,
  PRIMARY KEY  (`nro_contrato`,`codigo_instalacion`,`fecha_desde`,`hora_desde`),
  KEY `utiliza_fk1` (`codigo_instalacion`),
  CONSTRAINT `utiliza_fk` FOREIGN KEY (`nro_contrato`) REFERENCES `evento` (`nro_contrato`) ON UPDATE CASCADE,
  CONSTRAINT `utiliza_fk1` FOREIGN KEY (`codigo_instalacion`) REFERENCES `instalaciones` (`codigo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `servicios` table : 
#

DROP TABLE IF EXISTS `servicios`;

CREATE TABLE `servicios` (
  `nombre` char(20) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY  (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `contrata` table : 
#

DROP TABLE IF EXISTS `contrata`;

CREATE TABLE `contrata` (
  `nro_contrato` int(11) NOT NULL,
  `codigo_instalacion` int(11) NOT NULL,
  `fecha_desde` date NOT NULL,
  `hora_desde` time NOT NULL,
  `nombre_servicio` char(20) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY  (`nro_contrato`,`codigo_instalacion`,`fecha_desde`,`hora_desde`,`nombre_servicio`),
  KEY `contrata_fk1` (`nombre_servicio`),
  CONSTRAINT `contrata_fk` FOREIGN KEY (`nro_contrato`, `codigo_instalacion`, `fecha_desde`, `hora_desde`) REFERENCES `instalaciones_eventos` (`nro_contrato`, `codigo_instalacion`, `fecha_desde`, `hora_desde`) ON UPDATE CASCADE,
  CONSTRAINT `contrata_fk1` FOREIGN KEY (`nombre_servicio`) REFERENCES `servicios` (`nombre`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `instalaciones_servicios` table : 
#

DROP TABLE IF EXISTS `instalaciones_servicios`;

CREATE TABLE `instalaciones_servicios` (
  `codigo_instalacion` int(11) NOT NULL,
  `nombre_servicio` char(20) NOT NULL,
  PRIMARY KEY  (`nombre_servicio`,`codigo_instalacion`),
  KEY `codigo_instalacion` (`codigo_instalacion`),
  CONSTRAINT `instalaciones_servicios_fk` FOREIGN KEY (`codigo_instalacion`) REFERENCES `instalaciones` (`codigo`) ON UPDATE CASCADE,
  CONSTRAINT `instalaciones_servicios_fk1` FOREIGN KEY (`nombre_servicio`) REFERENCES `servicios` (`nombre`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tipos_evento_instalaciones` table : 
#

DROP TABLE IF EXISTS `tipos_evento_instalaciones`;

CREATE TABLE `tipos_evento_instalaciones` (
  `cod_tipo_evento` int(11) NOT NULL,
  `codigo` int(11) NOT NULL,
  PRIMARY KEY  (`cod_tipo_evento`,`codigo`),
  KEY `tipos_evento_instalaciones_fk1` (`codigo`),
  CONSTRAINT `tipos_evento_instalaciones_fk` FOREIGN KEY (`cod_tipo_evento`) REFERENCES `tipos_evento` (`cod_tipo_evento`) ON UPDATE CASCADE,
  CONSTRAINT `tipos_evento_instalaciones_fk1` FOREIGN KEY (`codigo`) REFERENCES `instalaciones` (`codigo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_servicios` table : 
#

DROP TABLE IF EXISTS `valores_servicios`;

CREATE TABLE `valores_servicios` (
  `nombre` char(20) NOT NULL,
  `fecha_desde` date NOT NULL,
  `valor` float(9,3) NOT NULL,
  PRIMARY KEY  (`nombre`,`fecha_desde`),
  CONSTRAINT `valores_servicios_servicios_fk` FOREIGN KEY (`nombre`) REFERENCES `servicios` (`nombre`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `tipos_evento` table  (LIMIT 0,500)
#

INSERT INTO `tipos_evento` (`cod_tipo_evento`, `desc_tipo_evento`) VALUES 
  (1,'Casamiento'),
  (2,'Reunion'),
  (3,'Competencia'),
  (4,'Fiesta'),
  (5,'Recital');

COMMIT;

#
# Data for the `organizadores` table  (LIMIT 0,500)
#

INSERT INTO `organizadores` (`cuit`, `razon_social`, `telefono`, `email`, `direccion`) VALUES 
  ('66-66666666-6','Reuniones Improvisadas','466-666666','contacto@reunionesimprovisadas.com.ar','Mendoza 6666 dpto 6'),
  ('77-77777777-7','Casorio por conveniencia','477-777777','info@reunionesimprovisadas.com.ar','Cordoba 777'),
  ('88-88888888-8','Torneos Ganar o Perder','488-888888','info@torneosgp.com','Lima 888'),
  ('99-99999999-9','Roll & Rock','499-999999','info@rollnrock.com.ar','Valparaiso 999');

COMMIT;

#
# Data for the `empleados` table  (LIMIT 0,500)
#

INSERT INTO `empleados` (`cuil`, `nombre`, `apellido`, `fecha_nac`, `fecha_ing`, `direccion`, `telefono`, `email`) VALUES 
  ('11-11111111-1','Eliseo','Garcia','1971-01-01','2000-01-01','Tucuman 111 piso 1 dpto 1','411-111111','eliseogarcia@gmail.com'),
  ('22-22222222-2','Andres','Tiagio','1972-02-02','2000-02-02','San Juan 2222','422-222222','atiagio@gmail.com'),
  ('33-33333333-3','Aquiles','Ruis','1973-03-03','2000-03-03','Uriburi 3333','433-333333','aqiru@gmail.com'),
  ('44-44444444-4','Gonzalo','Gonzalez','1974-04-04','2002-04-04','Buenos Aires 44','444-444444','gongon@gmail.com'),
  ('55-55555555-5','Bruno','Díaz','1975-05-05','2002-05-05','Laprida 5555','455-555555','batman@gmail.com');

COMMIT;

#
# Data for the `evento` table  (LIMIT 0,500)
#

INSERT INTO `evento` (`nro_contrato`, `fecha_contrato`, `representante`, `tel_representante`, `cod_tipo_evento`, `cuit_organizador`, `cuil_empleado`) VALUES 
  (1,'2008-02-10','Diana Prince','155-111111',1,'77-77777777-7','55-55555555-5'),
  (2,'2008-03-03','James Howlett','155-222222',4,'66-66666666-6','44-44444444-4'),
  (3,'2008-03-21','Barbara Gordon','155-333333',5,'99-99999999-9','33-33333333-3'),
  (4,'2008-04-18','Kurt Wagner','155-444444',4,'66-66666666-6','22-22222222-2'),
  (5,'2008-04-18','Sara Pezzini','155-555555',3,'88-88888888-8','22-22222222-2');

COMMIT;

#
# Data for the `instalaciones` table  (LIMIT 0,500)
#

INSERT INTO `instalaciones` (`codigo`, `ubicacion`, `cant_max_per`, `tipo_instalacion`) VALUES 
  (1,'norte',100,'Carpa'),
  (2,'sureste',150,'Salón'),
  (3,'sur',300,'Pileta'),
  (4,'noreste',50,'Cancha de tenis'),
  (5,'noreste',20,'Cancha de paddle'),
  (6,'oeste',3500,'Cancha de futbol'),
  (7,'este',5000,'Estadio Cubierto'),
  (8,'centro',300,'Carpa'),
  (9,'suroeste',1500,'Salón'),
  (11,'noreste',50,'Cancha de tenis'),
  (12,'noreste',20,'Cancha de paddle'),
  (13,'noreste',50,'Cancha de tenis'),
  (14,'noreste',20,'Cancha de paddle');

COMMIT;

#
# Data for the `instalaciones_eventos` table  (LIMIT 0,500)
#

INSERT INTO `instalaciones_eventos` (`nro_contrato`, `codigo_instalacion`, `fecha_desde`, `hora_desde`, `fecha_hasta`, `hora_hasta`, `cant_personas`, `valor_pactado`) VALUES 
  (1,9,'2008-03-09','21:00:00','2008-03-10','08:00:00',1200,32373),
  (2,1,'2008-05-02','21:00:00','2008-05-03','01:00:00',80,2158),
  (2,2,'2008-05-03','01:00:00','2008-05-03','08:00:00',120,3238),
  (3,7,'2008-05-20','21:00:00','2008-05-21','08:00:00',4000,107910),
  (4,1,'2008-07-17','17:00:00','2008-07-18','1899-12-30',80,2158),
  (4,2,'2008-07-17','17:00:00','2008-07-18','1899-12-30',120,3238),
  (4,8,'2008-07-17','1899-12-30','2008-07-18','08:00:00',240,4905),
  (5,4,'2008-06-17','13:00:00','2008-06-17','17:00:00',40,1080),
  (5,11,'2008-06-17','13:00:00','2008-06-17','19:00:00',40,750),
  (5,13,'2008-06-17','16:00:00','2008-06-17','20:00:00',40,1080);

COMMIT;

#
# Data for the `servicios` table  (LIMIT 0,500)
#

INSERT INTO `servicios` (`nombre`, `descripcion`) VALUES 
  ('arbitro','4 arbitros para partido de futbol'),
  ('ball boy','6 ball bays para canchas'),
  ('bañero','bañero para competencia de natacion'),
  ('catering','mozos, cocineros, alimentos, etc'),
  ('cotillon','disfraces, sombreros y souvenires'),
  ('decorado','decorado salon o carpa'),
  ('emergencias','paramedicos y transporte'),
  ('jueces linea','jueces de linea para tenis'),
  ('juez silla','juez de silla para tenis o paddle'),
  ('mariachis','musica y show'),
  ('musica','dj, equipo de musica y luces'),
  ('seguridad','patovicas');

COMMIT;

#
# Data for the `contrata` table  (LIMIT 0,500)
#

INSERT INTO `contrata` (`nro_contrato`, `codigo_instalacion`, `fecha_desde`, `hora_desde`, `nombre_servicio`, `cantidad`) VALUES 
  (1,9,'2008-03-09','21:00:00','catering',1200),
  (1,9,'2008-03-09','21:00:00','cotillon',1200),
  (1,9,'2008-03-09','21:00:00','decorado',1),
  (1,9,'2008-03-09','21:00:00','mariachis',1),
  (1,9,'2008-03-09','21:00:00','musica',1),
  (2,1,'2008-05-02','21:00:00','catering',80),
  (2,1,'2008-05-02','21:00:00','musica',1),
  (2,2,'2008-05-03','01:00:00','catering',120),
  (2,2,'2008-05-03','01:00:00','cotillon',120),
  (2,2,'2008-05-03','01:00:00','decorado',1),
  (2,2,'2008-05-03','01:00:00','musica',1),
  (3,7,'2008-05-20','21:00:00','emergencias',3),
  (3,7,'2008-05-20','21:00:00','seguridad',150),
  (4,1,'2008-07-17','17:00:00','catering',80),
  (4,1,'2008-07-17','17:00:00','cotillon',80),
  (4,1,'2008-07-17','17:00:00','decorado',1),
  (4,1,'2008-07-17','17:00:00','mariachis',1),
  (4,1,'2008-07-17','17:00:00','musica',1),
  (4,2,'2008-07-17','17:00:00','catering',120),
  (4,2,'2008-07-17','17:00:00','cotillon',120),
  (4,2,'2008-07-17','17:00:00','decorado',1),
  (4,2,'2008-07-17','17:00:00','mariachis',1),
  (4,2,'2008-07-17','17:00:00','musica',1),
  (4,8,'2008-07-17','1899-12-30','catering',240),
  (4,8,'2008-07-17','1899-12-30','cotillon',240),
  (4,8,'2008-07-17','1899-12-30','decorado',1),
  (4,8,'2008-07-17','1899-12-30','mariachis',1),
  (4,8,'2008-07-17','1899-12-30','musica',1),
  (5,4,'2008-06-17','13:00:00','ball boy',1),
  (5,4,'2008-06-17','13:00:00','emergencias',1),
  (5,4,'2008-06-17','13:00:00','jueces linea',1),
  (5,4,'2008-06-17','13:00:00','juez silla',1),
  (5,11,'2008-06-17','13:00:00','ball boy',1),
  (5,11,'2008-06-17','13:00:00','emergencias',1),
  (5,11,'2008-06-17','13:00:00','jueces linea',1),
  (5,11,'2008-06-17','13:00:00','juez silla',1),
  (5,13,'2008-06-17','16:00:00','ball boy',1),
  (5,13,'2008-06-17','16:00:00','emergencias',1),
  (5,13,'2008-06-17','16:00:00','jueces linea',1),
  (5,13,'2008-06-17','16:00:00','juez silla',1);

COMMIT;

#
# Data for the `instalaciones_servicios` table  (LIMIT 0,500)
#

INSERT INTO `instalaciones_servicios` (`codigo_instalacion`, `nombre_servicio`) VALUES 
  (1,'catering'),
  (1,'cotillon'),
  (1,'decorado'),
  (1,'mariachis'),
  (1,'musica'),
  (2,'catering'),
  (2,'cotillon'),
  (2,'decorado'),
  (2,'mariachis'),
  (2,'musica'),
  (3,'bañero'),
  (3,'emergencias'),
  (4,'ball boy'),
  (4,'emergencias'),
  (4,'jueces linea'),
  (4,'juez silla'),
  (5,'ball boy'),
  (5,'emergencias'),
  (5,'juez silla'),
  (6,'arbitro'),
  (6,'emergencias'),
  (7,'emergencias'),
  (7,'seguridad'),
  (8,'catering'),
  (8,'cotillon'),
  (8,'decorado'),
  (8,'mariachis'),
  (8,'musica'),
  (9,'catering'),
  (9,'cotillon'),
  (9,'decorado'),
  (9,'mariachis'),
  (9,'musica'),
  (11,'ball boy'),
  (11,'emergencias'),
  (11,'jueces linea'),
  (11,'juez silla'),
  (12,'ball boy'),
  (12,'emergencias'),
  (12,'juez silla'),
  (13,'ball boy'),
  (13,'emergencias'),
  (13,'jueces linea'),
  (13,'juez silla'),
  (14,'ball boy'),
  (14,'emergencias'),
  (14,'juez silla');

COMMIT;

#
# Data for the `tipos_evento_instalaciones` table  (LIMIT 0,500)
#

INSERT INTO `tipos_evento_instalaciones` (`cod_tipo_evento`, `codigo`) VALUES 
  (1,1),
  (2,1),
  (4,1),
  (1,2),
  (2,2),
  (4,2),
  (3,3),
  (3,4),
  (3,5),
  (3,6),
  (5,7),
  (1,8),
  (2,8),
  (4,8),
  (1,9),
  (2,9),
  (4,9),
  (3,11),
  (3,12),
  (3,13),
  (3,14);

COMMIT;

#
# Data for the `valores_servicios` table  (LIMIT 0,500)
#

INSERT INTO `valores_servicios` (`nombre`, `fecha_desde`, `valor`) VALUES 
  ('arbitro','2008-01-04',800),
  ('arbitro','2008-04-05',984.4),
  ('arbitro','2008-06-12',1191.124),
  ('ball boy','2008-01-04',200),
  ('ball boy','2008-04-05',246.1),
  ('ball boy','2008-06-12',297.781),
  ('bañero','2008-01-04',500),
  ('bañero','2008-04-05',615.25),
  ('bañero','2008-06-12',744.453),
  ('catering','2008-01-04',100),
  ('catering','2008-02-15',115),
  ('catering','2008-06-12',148.891),
  ('cotillon','2008-01-04',65),
  ('cotillon','2008-02-15',74.75),
  ('cotillon','2008-06-12',96.779),
  ('decorado','2008-01-04',10000),
  ('decorado','2008-02-15',11500),
  ('decorado','2008-06-12',14889.05),
  ('emergencias','2008-01-04',5000),
  ('emergencias','2008-04-05',6152.5),
  ('emergencias','2008-06-12',7444.525),
  ('jueces linea','2008-01-04',100),
  ('jueces linea','2008-04-05',123.05),
  ('jueces linea','2008-06-12',148.891),
  ('juez silla','2008-01-04',50),
  ('juez silla','2008-04-05',61.525),
  ('juez silla','2008-06-12',74.445),
  ('mariachis','2008-01-04',1000),
  ('mariachis','2008-02-15',1150),
  ('mariachis','2008-06-12',1488.905),
  ('musica','2008-01-04',2500),
  ('musica','2008-04-05',3076.25),
  ('musica','2008-07-12',3200),
  ('seguridad','2008-01-04',2000),
  ('seguridad','2008-04-05',2461),
  ('seguridad','2008-07-07',2977.81);

COMMIT;

