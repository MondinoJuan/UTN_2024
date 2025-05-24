# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : viejos_amigos


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `viejos_amigos`;

CREATE DATABASE `viejos_amigos`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `viejos_amigos`;

#
# Structure for the `instalaciones` table : 
#

DROP TABLE IF EXISTS `instalaciones`;

CREATE TABLE `instalaciones` (
  `cod_instalaciones` int(11) NOT NULL,
  `nombre_instalaciones` varchar(30) NOT NULL,
  PRIMARY KEY  (`cod_instalaciones`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `instructores` table : 
#

DROP TABLE IF EXISTS `instructores`;

CREATE TABLE `instructores` (
  `cuil_instructor` varchar(20) NOT NULL,
  `apeynom` varchar(50) NOT NULL,
  `telefono` varchar(20) default NULL,
  `direccion` varchar(50) default NULL,
  PRIMARY KEY  (`cuil_instructor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `actividades` table : 
#

DROP TABLE IF EXISTS `actividades`;

CREATE TABLE `actividades` (
  `cod_actividad` int(11) NOT NULL,
  `descripcion` varchar(30) NOT NULL,
  `dias_semana` varchar(60) NOT NULL,
  `hora_desde` time NOT NULL,
  `hora_hasta` time NOT NULL,
  `max_asistentes` int(11) default NULL,
  `cod_instalacion` int(11) NOT NULL,
  `cuil_instructor` varchar(20) default NULL,
  PRIMARY KEY  (`cod_actividad`),
  KEY `actividades_instalacion_fk` (`cod_instalacion`),
  KEY `actividades_instrctores_fk` (`cuil_instructor`),
  CONSTRAINT `actividades_instalacion_fk` FOREIGN KEY (`cod_instalacion`) REFERENCES `instalaciones` (`cod_instalaciones`) ON UPDATE CASCADE,
  CONSTRAINT `actividades_instructores_fk` FOREIGN KEY (`cuil_instructor`) REFERENCES `instructores` (`cuil_instructor`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `socios` table : 
#

DROP TABLE IF EXISTS `socios`;

CREATE TABLE `socios` (
  `nro_socio` int(11) NOT NULL,
  `apeynom` varchar(50) NOT NULL,
  `dni` varchar(20) NOT NULL,
  `telefono` varchar(20) default NULL,
  `fecha_nac` date default NULL,
  `fecha_afiliacion` date NOT NULL,
  PRIMARY KEY  (`nro_socio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `liquidaciones` table : 
#

DROP TABLE IF EXISTS `liquidaciones`;

CREATE TABLE `liquidaciones` (
  `nro_socio` int(11) NOT NULL,
  `anio_liquidacion` int(11) NOT NULL,
  `mes_liquidacion` int(11) NOT NULL,
  `monto_total` float(9,3) default NULL,
  `fecha_pago` date default NULL,
  `nro_recibo` int(11) default NULL,
  PRIMARY KEY  (`nro_socio`,`anio_liquidacion`,`mes_liquidacion`),
  CONSTRAINT `liquidaciones_socios_fk` FOREIGN KEY (`nro_socio`) REFERENCES `socios` (`nro_socio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `servicios` table : 
#

DROP TABLE IF EXISTS `servicios`;

CREATE TABLE `servicios` (
  `cod_servicio` int(11) NOT NULL,
  `desc_servicio` varchar(30) NOT NULL,
  `tipo_servicio` varchar(20) NOT NULL,
  PRIMARY KEY  (`cod_servicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `servicios_instalaciones` table : 
#

DROP TABLE IF EXISTS `servicios_instalaciones`;

CREATE TABLE `servicios_instalaciones` (
  `cod_servicio` int(11) NOT NULL,
  `cod_instalaciones` int(11) NOT NULL,
  PRIMARY KEY  (`cod_servicio`,`cod_instalaciones`),
  KEY `servicios_instalaciones_instalaciones_fk` (`cod_instalaciones`),
  CONSTRAINT `servicios_instalaciones_instalaciones_fk` FOREIGN KEY (`cod_instalaciones`) REFERENCES `instalaciones` (`cod_instalaciones`) ON UPDATE CASCADE,
  CONSTRAINT `servicios_instalaciones_servicios_fk` FOREIGN KEY (`cod_servicio`) REFERENCES `servicios` (`cod_servicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `socios_actividades` table : 
#

DROP TABLE IF EXISTS `socios_actividades`;

CREATE TABLE `socios_actividades` (
  `cod_actividad` int(11) NOT NULL,
  `nro_socio` int(11) NOT NULL,
  `anio_incripcion` int(11) NOT NULL,
  `mes_inscripcion` int(11) NOT NULL,
  `fecha_fin_inscripcion` date default NULL,
  PRIMARY KEY  (`cod_actividad`,`nro_socio`,`anio_incripcion`,`mes_inscripcion`),
  KEY `socios_actividades_socios+fk` (`nro_socio`),
  CONSTRAINT `socios_actividades_actividades_fk` FOREIGN KEY (`cod_actividad`) REFERENCES `actividades` (`cod_actividad`) ON UPDATE CASCADE,
  CONSTRAINT `socios_actividades_socios+fk` FOREIGN KEY (`nro_socio`) REFERENCES `socios` (`nro_socio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `socios_serv_inst_mens` table : 
#

DROP TABLE IF EXISTS `socios_serv_inst_mens`;

CREATE TABLE `socios_serv_inst_mens` (
  `cod_servicio` int(11) NOT NULL,
  `cod_instalaciones` int(11) NOT NULL,
  `nro_socio` int(11) NOT NULL,
  `anio_contrato` int(11) NOT NULL,
  `mes_contrato` int(11) NOT NULL,
  `fecha_fin_vigencia` date NOT NULL,
  PRIMARY KEY  (`cod_servicio`,`cod_instalaciones`,`nro_socio`,`anio_contrato`,`mes_contrato`),
  KEY `socios_serv_inst_mens_fk` (`nro_socio`),
  CONSTRAINT `socios_serv_inst_mens_fk` FOREIGN KEY (`nro_socio`) REFERENCES `socios` (`nro_socio`) ON UPDATE CASCADE,
  CONSTRAINT `socios_serv_inst_mens_serv_inst_fk` FOREIGN KEY (`cod_servicio`, `cod_instalaciones`) REFERENCES `servicios_instalaciones` (`cod_servicio`, `cod_instalaciones`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `socios_serv_inst_uso` table : 
#

DROP TABLE IF EXISTS `socios_serv_inst_uso`;

CREATE TABLE `socios_serv_inst_uso` (
  `cod_servicio` int(11) NOT NULL,
  `cod_instalaciones` int(11) NOT NULL,
  `nro_socio` int(11) NOT NULL,
  `fecha_uso` date NOT NULL,
  `hora_uso` time NOT NULL,
  PRIMARY KEY  (`cod_servicio`,`cod_instalaciones`,`nro_socio`,`fecha_uso`,`hora_uso`),
  KEY `socios_servicios_uso_socios_fk` (`nro_socio`),
  CONSTRAINT `socios_servicios_uso_servicios_instalaciones_fk` FOREIGN KEY (`cod_servicio`, `cod_instalaciones`) REFERENCES `servicios_instalaciones` (`cod_servicio`, `cod_instalaciones`) ON UPDATE CASCADE,
  CONSTRAINT `socios_servicios_uso_socios_fk` FOREIGN KEY (`nro_socio`) REFERENCES `socios` (`nro_socio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tarifas_cuotas` table : 
#

DROP TABLE IF EXISTS `tarifas_cuotas`;

CREATE TABLE `tarifas_cuotas` (
  `anio_tarifa` int(11) NOT NULL,
  `mes_tarifa` int(11) NOT NULL,
  `monto_tarifal` float(9,3) NOT NULL,
  PRIMARY KEY  (`anio_tarifa`,`mes_tarifa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_actividades` table : 
#

DROP TABLE IF EXISTS `valores_actividades`;

CREATE TABLE `valores_actividades` (
  `cod_actividad` int(11) NOT NULL,
  `anio_valor` int(11) NOT NULL,
  `mes_valor` int(11) NOT NULL,
  `monto_actividad` float(9,3) NOT NULL,
  PRIMARY KEY  (`cod_actividad`,`anio_valor`,`mes_valor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_servicios_instalaciones` table : 
#

DROP TABLE IF EXISTS `valores_servicios_instalaciones`;

CREATE TABLE `valores_servicios_instalaciones` (
  `cod_servicio` int(11) NOT NULL,
  `cod_instalacion` int(11) NOT NULL,
  `anio_valor` int(11) NOT NULL,
  `mes_valor` int(11) NOT NULL,
  `monto_servicio_instalacion` float(9,3) NOT NULL,
  PRIMARY KEY  (`cod_servicio`,`cod_instalacion`,`anio_valor`,`mes_valor`),
  CONSTRAINT `valores_servicios_instalaciones_servicios_instalaciones_fk` FOREIGN KEY (`cod_servicio`, `cod_instalacion`) REFERENCES `servicios_instalaciones` (`cod_servicio`, `cod_instalaciones`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `instalaciones` table  (LIMIT 0,500)
#

INSERT INTO `instalaciones` (`cod_instalaciones`, `nombre_instalaciones`) VALUES 
  (1,'vestuario damas'),
  (2,'vestuario caballeros'),
  (3,'caleta'),
  (4,'canchas profesionales'),
  (5,'patio techado'),
  (6,'patio central'),
  (7,'pileta'),
  (8,'playa'),
  (9,'natatorio 1'),
  (10,'pileta olímpica'),
  (11,'cancha 1'),
  (12,'cancha 2'),
  (13,'gimnasio 1'),
  (14,'gimnasio 2');

COMMIT;

#
# Data for the `instructores` table  (LIMIT 0,500)
#

INSERT INTO `instructores` (`cuil_instructor`, `apeynom`, `telefono`, `direccion`) VALUES 
  ('20204398215','Cacho Garay','4986623','San Martin 1865'),
  ('20224586634','Julian Soto','4889525','Arijon 3'),
  ('20256641255','Pedro Gomez','4759633','Buenos Aires 7204 1º G'),
  ('20284115234','Ramiro Terini','4812269','Nansen 865 bis'),
  ('20298454525','Juliana Agnini','4856922','Tupungato 1113'),
  ('20306665414','Emanuel Giorgio','4568711','Cordoba 8545');

COMMIT;

#
# Data for the `actividades` table  (LIMIT 0,500)
#

INSERT INTO `actividades` (`cod_actividad`, `descripcion`, `dias_semana`, `hora_desde`, `hora_hasta`, `max_asistentes`, `cod_instalacion`, `cuil_instructor`) VALUES 
  (1,'natación niños','lunes - miércoles -viernes','09:00:00','10:00:00',10,9,'20298454525'),
  (2,'natación niños','martes - jueves - sábado','08:00:00','09:00:00',10,10,'20284115234'),
  (3,'futbol 5 mayores','lunes -jueves','21:00:00','22:00:00',20,12,'20256641255'),
  (4,'tenis','lunes','08:30:00','10:00:00',3,11,'20306665414'),
  (5,'natación','lunes a viernes','09:00:00','12:00:00',NULL,10,NULL),
  (6,'voley sub 14','lunes - jueves - sabado','19:00:00','09:00:00',20,13,'20224586634'),
  (7,'colonia de vacaciones','lunes a viernes','08:00:00','12:00:00',40,14,'20204398215');

COMMIT;

#
# Data for the `socios` table  (LIMIT 0,500)
#

INSERT INTO `socios` (`nro_socio`, `apeynom`, `dni`, `telefono`, `fecha_nac`, `fecha_afiliacion`) VALUES 
  (1,'Juan Perez','30451269','4815423','1983-02-04','2000-08-01'),
  (2,'Andés Antonini','29874562','4665478','1979-12-09','2000-08-05'),
  (3,'María De los Dolores','27546988','155468741','1977-05-07','2000-10-05'),
  (4,'Valeria Alba','31845698','4625548','1985-02-01','2001-01-06'),
  (5,'Bernabé Gerlo','35896520','4526635','1999-06-01','2007-12-01'),
  (6,'Marcelo Quirga','34546221','4112569','1998-03-09','2007-11-09');

COMMIT;

#
# Data for the `liquidaciones` table  (LIMIT 0,500)
#

INSERT INTO `liquidaciones` (`nro_socio`, `anio_liquidacion`, `mes_liquidacion`, `monto_total`, `fecha_pago`, `nro_recibo`) VALUES 
  (1,2007,11,73,'2007-11-01',1),
  (1,2007,12,86,'2007-11-05',2),
  (1,2008,1,55,'2007-11-09',4),
  (2,2007,11,65,'2007-11-07',3),
  (2,2007,12,74,'2007-11-15',7),
  (2,2008,1,55,NULL,NULL),
  (3,2007,11,103,'2007-11-10',6),
  (3,2007,12,107,'2007-11-10',6),
  (3,2008,1,55,'2007-11-09',5),
  (4,2007,11,50,NULL,NULL),
  (4,2007,12,55,NULL,NULL),
  (4,2008,1,55,NULL,NULL),
  (5,2008,1,55,NULL,NULL),
  (6,2008,1,55,NULL,NULL);

COMMIT;

#
# Data for the `servicios` table  (LIMIT 0,500)
#

INSERT INTO `servicios` (`cod_servicio`, `desc_servicio`, `tipo_servicio`) VALUES 
  (1,'casillero','mensual'),
  (2,'botes','por uso'),
  (3,'cancha de tenis','por uso'),
  (4,'asador','por uso'),
  (5,'sillas','por uso');

COMMIT;

#
# Data for the `servicios_instalaciones` table  (LIMIT 0,500)
#

INSERT INTO `servicios_instalaciones` (`cod_servicio`, `cod_instalaciones`) VALUES 
  (1,1),
  (1,2),
  (2,3),
  (3,4),
  (4,5),
  (4,6),
  (5,7),
  (5,8);

COMMIT;

#
# Data for the `socios_actividades` table  (LIMIT 0,500)
#

INSERT INTO `socios_actividades` (`cod_actividad`, `nro_socio`, `anio_incripcion`, `mes_inscripcion`, `fecha_fin_inscripcion`) VALUES 
  (1,5,2007,11,'2007-12-01'),
  (1,5,2007,12,'2008-01-01'),
  (1,6,2007,11,'2007-12-01'),
  (2,6,2007,12,'2008-01-01'),
  (3,1,2007,11,'2007-12-01'),
  (3,1,2007,12,'2008-01-01'),
  (3,2,2007,11,'2007-12-01'),
  (3,2,2007,12,'2008-01-01'),
  (4,3,2007,11,'2007-12-01'),
  (4,3,2007,12,'2008-01-01'),
  (4,4,2007,11,'2007-12-01'),
  (4,4,2007,12,'2008-01-01'),
  (5,1,2007,11,'2007-12-01'),
  (5,1,2007,12,'2008-01-01'),
  (5,3,2007,11,'2007-12-01'),
  (5,3,2007,12,'2008-01-01'),
  (5,4,2007,12,'2008-01-01'),
  (7,5,2007,11,'2008-03-01'),
  (7,6,2007,11,'2008-03-01');

COMMIT;

#
# Data for the `socios_serv_inst_mens` table  (LIMIT 0,500)
#

INSERT INTO `socios_serv_inst_mens` (`cod_servicio`, `cod_instalaciones`, `nro_socio`, `anio_contrato`, `mes_contrato`, `fecha_fin_vigencia`) VALUES 
  (1,1,3,2007,11,'2007-12-01'),
  (1,1,3,2007,12,'2008-01-01'),
  (1,1,4,2007,11,'2007-12-01'),
  (1,2,1,2007,11,'2007-12-01'),
  (1,2,1,2007,12,'2008-01-01');

COMMIT;

#
# Data for the `socios_serv_inst_uso` table  (LIMIT 0,500)
#

INSERT INTO `socios_serv_inst_uso` (`cod_servicio`, `cod_instalaciones`, `nro_socio`, `fecha_uso`, `hora_uso`) VALUES 
  (4,5,1,'2007-11-05','12:00:00'),
  (4,5,1,'2007-11-19','12:00:00'),
  (4,6,1,'2007-11-12','12:00:00'),
  (4,6,1,'2007-11-26','12:00:00'),
  (3,4,3,'2007-11-08','11:00:00'),
  (3,4,3,'2007-11-15','16:00:00'),
  (5,7,3,'2007-11-15','15:00:00'),
  (5,8,3,'2007-11-25','16:00:00'),
  (3,4,4,'2007-11-11','17:00:00'),
  (3,4,4,'2007-11-21','08:00:00'),
  (5,7,4,'2007-11-15','15:00:00'),
  (5,8,4,'2007-11-25','16:00:00');

COMMIT;

#
# Data for the `tarifas_cuotas` table  (LIMIT 0,500)
#

INSERT INTO `tarifas_cuotas` (`anio_tarifa`, `mes_tarifa`, `monto_tarifal`) VALUES 
  (2007,11,50),
  (2007,12,55),
  (2008,1,55);

COMMIT;

#
# Data for the `valores_actividades` table  (LIMIT 0,500)
#

INSERT INTO `valores_actividades` (`cod_actividad`, `anio_valor`, `mes_valor`, `monto_actividad`) VALUES 
  (1,2007,11,8),
  (1,2007,12,12),
  (1,2008,1,18),
  (2,2007,11,8),
  (2,2007,12,12),
  (2,2008,1,18),
  (3,2007,11,15),
  (3,2007,12,19),
  (3,2008,1,22),
  (4,2007,11,45),
  (4,2007,12,50),
  (4,2008,1,50),
  (5,2007,11,8),
  (5,2007,12,12),
  (5,2008,1,18),
  (6,2007,11,0),
  (6,2007,12,0),
  (6,2008,1,0),
  (7,2007,11,70);

COMMIT;

#
# Data for the `valores_servicios_instalaciones` table  (LIMIT 0,500)
#

INSERT INTO `valores_servicios_instalaciones` (`cod_servicio`, `cod_instalacion`, `anio_valor`, `mes_valor`, `monto_servicio_instalacion`) VALUES 
  (1,1,2007,11,8),
  (1,1,2007,12,10),
  (1,1,2008,1,12),
  (1,2,2007,11,7),
  (1,2,2007,12,8),
  (1,2,2008,1,8.5),
  (2,3,2007,11,1),
  (2,3,2007,12,2),
  (2,3,2008,1,2.5),
  (3,4,2007,11,2),
  (3,4,2007,12,7),
  (3,4,2008,1,10),
  (4,5,2007,11,5),
  (4,5,2007,12,9),
  (4,5,2008,1,11.5),
  (4,6,2007,11,2),
  (4,6,2007,12,5),
  (4,6,2008,1,9),
  (5,7,2007,11,1),
  (5,7,2007,12,8),
  (5,7,2008,1,10),
  (5,8,2007,11,1.5),
  (5,8,2007,12,15),
  (5,8,2008,1,15);

COMMIT;

