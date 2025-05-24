# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : quien_se_llevo_mi_auto


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `quien_se_llevo_mi_auto`;

CREATE DATABASE `quien_se_llevo_mi_auto`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `quien_se_llevo_mi_auto`;

#
# Structure for the `denunciantes` table : 
#

DROP TABLE IF EXISTS `denunciantes`;

CREATE TABLE `denunciantes` (
  `nro_tel` int(11) NOT NULL,
  `nombre` varchar(20) default NULL,
  `apellido` varchar(20) default NULL,
  PRIMARY KEY  (`nro_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `inspectores` table : 
#

DROP TABLE IF EXISTS `inspectores`;

CREATE TABLE `inspectores` (
  `nro_legajo` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `nro_tel` int(11) NOT NULL,
  `domicilio` varchar(50) NOT NULL,
  `fecha_nac` date NOT NULL,
  `fecha_ing` date NOT NULL,
  PRIMARY KEY  (`nro_legajo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `denuncias` table : 
#

DROP TABLE IF EXISTS `denuncias`;

CREATE TABLE `denuncias` (
  `nro_denuncia` int(11) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `motivo` varchar(200) default NULL,
  `direccion` varchar(50) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `nro_denuncia_original` int(11) default NULL,
  `nro_tel` int(11) default NULL,
  `nro_legajo` int(11) default NULL,
  PRIMARY KEY  (`nro_denuncia`),
  KEY `denuncias_denuncia_original_fk` (`nro_denuncia_original`),
  KEY `nro_tel` (`nro_tel`),
  KEY `denuncias_inspectores_fk` (`nro_legajo`),
  CONSTRAINT `denuncias_denuncia_original_fk` FOREIGN KEY (`nro_denuncia_original`) REFERENCES `denuncias` (`nro_denuncia`) ON UPDATE CASCADE,
  CONSTRAINT `denuncias_inspectores_fk` FOREIGN KEY (`nro_legajo`) REFERENCES `inspectores` (`nro_legajo`) ON UPDATE CASCADE,
  CONSTRAINT `denuncias__denunciantes_fk` FOREIGN KEY (`nro_tel`) REFERENCES `denunciantes` (`nro_tel`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `gruas` table : 
#

DROP TABLE IF EXISTS `gruas`;

CREATE TABLE `gruas` (
  `nro_grua` int(11) NOT NULL,
  `patente` varchar(7) NOT NULL,
  `marca` varchar(20) NOT NULL,
  `modelo` varchar(20) NOT NULL,
  `anio_fabrica` int(11) NOT NULL,
  `nro_tel` int(11) NOT NULL,
  PRIMARY KEY  (`nro_grua`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `vehiculos` table : 
#

DROP TABLE IF EXISTS `vehiculos`;

CREATE TABLE `vehiculos` (
  `patente` char(7) NOT NULL,
  `marca` varchar(20) NOT NULL,
  `modelo` varchar(20) NOT NULL,
  `anio_fabrica` int(11) NOT NULL,
  PRIMARY KEY  (`patente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `denuncias_vehiculos` table : 
#

DROP TABLE IF EXISTS `denuncias_vehiculos`;

CREATE TABLE `denuncias_vehiculos` (
  `nro_denuncia` int(11) NOT NULL,
  `patente` char(7) NOT NULL,
  `nro_grua` int(11) default NULL,
  `fecha_hora_asigna` datetime default NULL,
  `fecha_hora_remolca` datetime default NULL,
  `estado` varchar(50) default NULL,
  PRIMARY KEY  (`nro_denuncia`,`patente`),
  KEY `denuncias_vehiculos_vehiculos_fk` (`patente`),
  KEY `denuncias_vehiculos_gruas_fk` (`nro_grua`),
  CONSTRAINT `denuncias_vehiculos_denuncias_fk` FOREIGN KEY (`nro_denuncia`) REFERENCES `denuncias` (`nro_denuncia`) ON UPDATE CASCADE,
  CONSTRAINT `denuncias_vehiculos_gruas_fk` FOREIGN KEY (`nro_grua`) REFERENCES `gruas` (`nro_grua`) ON UPDATE CASCADE,
  CONSTRAINT `denuncias_vehiculos_vehiculos_fk` FOREIGN KEY (`patente`) REFERENCES `vehiculos` (`patente`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `infracciones` table : 
#

DROP TABLE IF EXISTS `infracciones`;

CREATE TABLE `infracciones` (
  `cod_infraccion` int(11) NOT NULL,
  `desc_infraccion` varchar(50) NOT NULL,
  PRIMARY KEY  (`cod_infraccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `multas` table : 
#

DROP TABLE IF EXISTS `multas`;

CREATE TABLE `multas` (
  `nro_multa` int(11) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `patente` char(7) NOT NULL,
  PRIMARY KEY  (`nro_multa`),
  KEY `multas_patente_fk` (`patente`),
  CONSTRAINT `multas_patente_fk` FOREIGN KEY (`patente`) REFERENCES `vehiculos` (`patente`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `infracciones_multas` table : 
#

DROP TABLE IF EXISTS `infracciones_multas`;

CREATE TABLE `infracciones_multas` (
  `nro_multa` int(11) NOT NULL,
  `cod_infraccion` int(11) NOT NULL,
  PRIMARY KEY  (`nro_multa`,`cod_infraccion`),
  KEY `infracciones_multas_infracciones_fk` (`cod_infraccion`),
  CONSTRAINT `infracciones_multas_infracciones_fk` FOREIGN KEY (`cod_infraccion`) REFERENCES `infracciones` (`cod_infraccion`) ON UPDATE CASCADE,
  CONSTRAINT `infracciones_multas_multas_fk` FOREIGN KEY (`nro_multa`) REFERENCES `multas` (`nro_multa`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `pagos` table : 
#

DROP TABLE IF EXISTS `pagos`;

CREATE TABLE `pagos` (
  `nro_multa` int(11) NOT NULL,
  `nro_pago` int(11) NOT NULL,
  `fecha_hora_pactada` datetime NOT NULL,
  `fecha_hora_venc` datetime NOT NULL,
  `fecha_hora_pago` datetime default NULL,
  `importe` float(9,3) default NULL,
  PRIMARY KEY  (`nro_multa`,`nro_pago`),
  CONSTRAINT `pagos_multas_fk` FOREIGN KEY (`nro_multa`) REFERENCES `multas` (`nro_multa`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `personas` table : 
#

DROP TABLE IF EXISTS `personas`;

CREATE TABLE `personas` (
  `dni` varchar(20) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `nro_lic` varchar(20) default NULL,
  `fecha_venc_lic` date default NULL,
  PRIMARY KEY  (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `propietarios` table : 
#

DROP TABLE IF EXISTS `propietarios`;

CREATE TABLE `propietarios` (
  `patente` char(7) NOT NULL,
  `fecha_desde` date NOT NULL,
  `dni` varchar(20) NOT NULL,
  PRIMARY KEY  (`patente`,`fecha_desde`),
  KEY `propietarios_personas_fk` (`dni`),
  CONSTRAINT `propietarios_personas_fk` FOREIGN KEY (`dni`) REFERENCES `personas` (`dni`) ON UPDATE CASCADE,
  CONSTRAINT `propietarios_vehiculos_fk` FOREIGN KEY (`patente`) REFERENCES `vehiculos` (`patente`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `retiros` table : 
#

DROP TABLE IF EXISTS `retiros`;

CREATE TABLE `retiros` (
  `patente` char(7) NOT NULL,
  `fecha_hora_retiro` datetime NOT NULL,
  `dni` varchar(20) NOT NULL,
  PRIMARY KEY  (`patente`,`fecha_hora_retiro`),
  KEY `retiros_personas_fk` (`dni`),
  CONSTRAINT `retiros_personas_fk` FOREIGN KEY (`dni`) REFERENCES `personas` (`dni`) ON UPDATE CASCADE,
  CONSTRAINT `retiros_vehiculos_fk` FOREIGN KEY (`patente`) REFERENCES `vehiculos` (`patente`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_infraccion` table : 
#

DROP TABLE IF EXISTS `valores_infraccion`;

CREATE TABLE `valores_infraccion` (
  `cod_infraccion` int(11) NOT NULL,
  `fecha_desde` date NOT NULL,
  `valor_infraccion` float(9,3) NOT NULL,
  PRIMARY KEY  (`cod_infraccion`,`fecha_desde`),
  CONSTRAINT `valores_infraccion_infracciones_fk` FOREIGN KEY (`cod_infraccion`) REFERENCES `infracciones` (`cod_infraccion`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_remolques` table : 
#

DROP TABLE IF EXISTS `valores_remolques`;

CREATE TABLE `valores_remolques` (
  `fecha_desde` date NOT NULL,
  `valor_remolque` float(9,3) NOT NULL,
  PRIMARY KEY  (`fecha_desde`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `denunciantes` table  (LIMIT 0,500)
#

INSERT INTO `denunciantes` (`nro_tel`, `nombre`, `apellido`) VALUES 
  (101010101,'Robert','Yates'),
  (111111111,'Felix','Hoffman'),
  (121212121,'Karl','Benz'),
  (131313131,'Thomas','Savery'),
  (141414141,'Don','Perignon'),
  (151515151,NULL,NULL),
  (161616161,'Alexis','Dechâteau'),
  (171717171,NULL,NULL),
  (181818181,NULL,NULL),
  (191919191,'Michael','Faraday'),
  (202020202,'Robert','Yates');

COMMIT;

#
# Data for the `inspectores` table  (LIMIT 0,500)
#

INSERT INTO `inspectores` (`nro_legajo`, `nombre`, `apellido`, `nro_tel`, `domicilio`, `fecha_nac`, `fecha_ing`) VALUES 
  (1,'René','Laennec',313131313,'Chacabuco 111','1971-01-01','2001-01-01'),
  (2,'King Camp','Gillette',323232323,'Italia 222','1972-02-02','2002-02-02'),
  (3,'Blaise','Pascal',333333333,'Arijon 333','1983-03-03','2003-03-03');

COMMIT;

#
# Data for the `denuncias` table  (LIMIT 0,500)
#

INSERT INTO `denuncias` (`nro_denuncia`, `fecha_hora`, `motivo`, `direccion`, `estado`, `nro_denuncia_original`, `nro_tel`, `nro_legajo`) VALUES 
  (1,'2009-12-17 14:01:30','Estacionado frente a la salida del HECA','Pellegrini 3295','descartada',NULL,171717171,NULL),
  (2,'2009-12-23 14:25:49','Doble fila','Uriburu 2222','ejecutada',NULL,141414141,2),
  (3,'2010-01-03 03:19:49','Bloquea salida de vehículos','Mitre 333','ejecutada',NULL,141414141,3),
  (4,'2010-01-04 06:49:38','Doble fila','Pte Roca 444','descartada',NULL,202020202,3),
  (5,'2010-01-04 07:26:50','Doble fila','Pte Roca 444','repetida',4,101010101,3),
  (6,'2010-01-05 22:12:03','Doble fila','Zeballos 6666','ejecutada',NULL,131313131,2),
  (7,'2010-01-07 20:09:58','Bloquea salida de vehículos','Mendoza 7777','ejecutada',NULL,131313131,3),
  (8,'2010-01-08 14:09:43',NULL,'Arijon 888','descartada',NULL,NULL,1),
  (9,'2010-01-09 21:26:25','Doble fila','Corrientes 999','ejecutada',NULL,161616161,1),
  (10,'2010-01-12 06:54:07','Doble fila','H.Quintana 101 bis','ejecutada',NULL,191919191,3),
  (11,'2010-01-13 04:25:38','Doble fila','Paraguay 1111','ejecutada',NULL,161616161,1),
  (12,'2010-01-14 20:45:39','Bloquea salida de vehículos','Cochabanba 121','ejecutada',NULL,NULL,2),
  (13,'2010-01-15 05:26:00',NULL,'Lima 1313','ejecutada',NULL,111111111,1),
  (14,'2010-01-16 05:32:50','Doble fila','Pasaje Casablanca 1414','descartada',NULL,171717171,NULL),
  (15,'2010-01-18 05:16:22',NULL,'Bv. Segui 1515','descartada',NULL,NULL,1),
  (16,'2010-01-20 09:05:21','Bloquea salida de vehículos','San Juan 1616','ejecutada',NULL,NULL,2),
  (17,'2010-01-22 07:02:37',NULL,'Mendoza 171','descartada',NULL,101010101,3),
  (18,'2010-01-25 10:08:24','Doble fila','Alvear 18','ejecutada',NULL,NULL,3),
  (19,'2010-01-27 21:38:46','Bloquea salida de vehículos','9 de Julio 191','ejecutada',NULL,161616161,2),
  (20,'2010-01-28 11:33:25','Doble fila','Viamonte 2020','ejecutada',NULL,NULL,3),
  (21,'2010-01-29 04:16:44','Doble fila','San Martin 2121','descartada',NULL,151515151,NULL),
  (22,'2010-01-30 06:39:02',NULL,'Moreno 222','ejecutada',NULL,131313131,2),
  (23,'2010-02-01 03:23:13','Doble fila','Ayolas 2323','ejecutada',NULL,NULL,3),
  (24,'2010-02-01 15:28:16',NULL,'Ayolas 2323','repetida',23,171717171,NULL),
  (25,'2010-02-01 15:31:40',NULL,'Ayolas 2323','repetida',23,161616161,1),
  (26,'2010-02-04 06:32:28','Doble fila','Rioja 262','descartada',NULL,161616161,2),
  (27,'2010-02-06 18:01:45','Doble fila','Salta 2727','ejecutada',NULL,NULL,3),
  (28,'2010-02-09 06:43:47','Doble fila','Entre Rios 2828','ejecutada',NULL,NULL,1),
  (29,'2010-02-12 06:28:02','Bloquea salida de vehículos','La Paz 292','ejecutada',NULL,NULL,3),
  (30,'2010-02-13 05:33:51',NULL,'Necochea 3030','ejecutada',NULL,NULL,1),
  (31,'2010-02-15 22:26:24','Doble fila','Ayacucho 3131','descartada',NULL,171717171,NULL),
  (32,'2010-02-16 22:00:21','Bloquea salida de vehículos','Rodriguez 3232','ejecutada',NULL,NULL,3),
  (33,'2010-02-16 11:28:38',NULL,'Juan Manuel de Rosas 333','descartada',NULL,151515151,NULL),
  (34,'2010-02-16 16:50:49','Doble fila','Regimiento 11 343','descartada',NULL,191919191,2),
  (35,'2010-02-19 09:38:55','Doble fila','Anchorena 3535','ejecutada',NULL,NULL,2),
  (36,'2010-02-25','Bloquea salida de vehículos','Lima 363','ejecutada',NULL,202020202,3),
  (37,'2010-02-25 04:18:46',NULL,'Av. del Rosario 3737','ejecutada',NULL,202020202,3),
  (38,'2010-02-25 07:27:00',NULL,'Rep. de Israel 3838','ejecutada',NULL,NULL,3),
  (39,'2010-02-25 09:31:04','Bloquea salida de vehículos','Lamadrid 393','denunciada',NULL,NULL,NULL),
  (40,'2010-02-25 13:57:25','Bloquea salida de vehículos','España 4040','denunciada',NULL,NULL,NULL);

COMMIT;

#
# Data for the `gruas` table  (LIMIT 0,500)
#

INSERT INTO `gruas` (`nro_grua`, `patente`, `marca`, `modelo`, `anio_fabrica`, `nro_tel`) VALUES 
  (1,'III 111','Nissan','Cabstar',2009,111111111),
  (2,'JJJ 222','Renault','Mascot',2010,222222222),
  (3,'KKK 333','Scania','P94',2010,333333333);

COMMIT;

#
# Data for the `vehiculos` table  (LIMIT 0,500)
#

INSERT INTO `vehiculos` (`patente`, `marca`, `modelo`, `anio_fabrica`) VALUES 
  ('AAA 111','volkswagen','golf',1995),
  ('BBB 222','citroen','xara',1996),
  ('CCC 333','renault','laguna',1997),
  ('DDD 444','mercedez','sprinter',2000),
  ('EEE 555','auidi','a4',2003),
  ('FFF 666','ferrari','testarrosa',2006),
  ('GGG 777','lamborghini','gallardo',2007),
  ('HHH 888','toyota','prius',2008);

COMMIT;

#
# Data for the `denuncias_vehiculos` table  (LIMIT 0,500)
#

INSERT INTO `denuncias_vehiculos` (`nro_denuncia`, `patente`, `nro_grua`, `fecha_hora_asigna`, `fecha_hora_remolca`, `estado`) VALUES 
  (2,'AAA 111',3,'2009-12-23 15:31:49','2009-12-23 16:03:34','no remolcado'),
  (3,'HHH 888',1,'2010-01-03 03:51:00','2010-01-03 04:02:21','incautado'),
  (4,'DDD 444',NULL,NULL,NULL,NULL),
  (5,'DDD 444',NULL,NULL,NULL,NULL),
  (6,'EEE 555',3,'2010-01-05 23:24:12','2010-01-06 00:09:03','incautado'),
  (7,'FFF 666',3,'2010-01-07 20:59:41','2010-01-07 21:37:51','incautado'),
  (7,'GGG 777',3,'2010-01-07 20:59:41','2010-01-07 21:37:51','incautado'),
  (8,'BBB 222',NULL,NULL,NULL,NULL),
  (9,'EEE 555',3,'2010-01-09 22:19:31','2010-01-09 22:47:11','incautado'),
  (10,'BBB 222',2,'2010-01-12 07:56:34','2010-01-12 08:50:49','incautado'),
  (11,'CCC 333',3,'2010-01-13 06:00:42','2010-01-13 06:23:30','incautado'),
  (12,'FFF 666',2,'2010-01-14 22:20:45','2010-01-14 23:08:07','incautado'),
  (13,'AAA 111',3,'2010-01-15 06:16:57','2010-01-15 07:06:46','no remolcado'),
  (15,'EEE 555',NULL,NULL,NULL,NULL),
  (16,'FFF 666',1,'2010-01-20 10:15:02','2010-01-20 10:53:39','incautado'),
  (18,'AAA 111',2,'2010-01-25 11:44:04','2010-01-25 12:34:25','incautado'),
  (19,'HHH 888',3,'2010-01-27 22:43:01','2010-01-27 23:04:11','incautado'),
  (20,'AAA 111',2,'2010-01-28 12:41:40','2010-01-28 12:51:54','no remolcado'),
  (20,'BBB 222',2,'2010-01-28 12:41:40','2010-01-28 12:51:54','incautado'),
  (21,'CCC 333',NULL,NULL,NULL,NULL),
  (22,'FFF 666',3,'2010-01-30 07:30:40','2010-01-30 07:43:49','incautado'),
  (23,'GGG 777',2,'2010-02-01 04:29:05','2010-02-01 05:04:43','no remolcado'),
  (24,'GGG 777',3,'2010-02-01 16:59:18','2010-02-01 17:21:20','no remolcado'),
  (25,'GGG 777',3,'2010-02-01 15:49:44','2010-02-01 16:47:32','incautado'),
  (26,'HHH 888',NULL,NULL,NULL,NULL),
  (27,'DDD 444',3,'2010-02-06 18:49:59','2010-02-06 18:54:22','incautado'),
  (28,'AAA 111',1,'2010-02-09 06:51:11','2010-02-09 07:26:20','incautado'),
  (28,'EEE 555',1,'2010-02-09 06:51:11','2010-02-09 07:26:20','incautado'),
  (29,'FFF 666',3,'2010-02-12 07:18:39','2010-02-12 08:08:10','incautado'),
  (30,'GGG 777',3,'2010-02-13 07:13:45','2010-02-13 07:42:20','incautado'),
  (31,'FFF 666',NULL,NULL,NULL,NULL),
  (32,'FFF 666',2,'2010-02-16 23:15:35','2010-02-16 23:53:11','no remolcado'),
  (33,'FFF 666',NULL,NULL,NULL,NULL),
  (35,'AAA 111',3,'2010-02-19 11:36:17','2010-02-19 12:24:37','incautado'),
  (36,'FFF 666',1,'2010-02-25 00:09:54','2010-02-25 01:04:58','no remolcado'),
  (37,'EEE 555',1,'2010-02-25 05:52:11','2010-02-25 06:18:37','no remolcado'),
  (38,'DDD 444',1,'2010-02-25 09:23:03','2010-02-25 10:17:53','no remolcado');

COMMIT;

#
# Data for the `infracciones` table  (LIMIT 0,500)
#

INSERT INTO `infracciones` (`cod_infraccion`, `desc_infraccion`) VALUES 
  (1,'doble fila'),
  (2,'estacinado en salida de vehículos'),
  (3,'conducir ebrio'),
  (4,'no porta documentación obligatoria'),
  (5,'miro feo al inspector de tránsito'),
  (6,'no quiso sobornar al inspector de tránsito');

COMMIT;

#
# Data for the `multas` table  (LIMIT 0,500)
#

INSERT INTO `multas` (`nro_multa`, `fecha_hora`, `patente`) VALUES 
  (3659,'2010-01-13 06:23:30','CCC 333'),
  (13017,'2010-01-12 08:50:49','BBB 222'),
  (31917,'2010-02-12 08:08:10','FFF 666'),
  (40204,'2010-02-09 07:26:20','AAA 111'),
  (44605,'2010-02-19 12:24:37','AAA 111'),
  (48071,'2010-02-13 07:42:20','GGG 777'),
  (53809,'2010-01-09 22:47:11','EEE 555'),
  (56501,'2010-01-06 00:09:03','EEE 555'),
  (67226,'2010-01-28 12:51:54','BBB 222'),
  (70506,'2010-02-09 07:26:20','EEE 555'),
  (76601,'2010-01-30 07:43:49','FFF 666'),
  (76838,'2010-02-06 18:54:22','DDD 444'),
  (79242,'2010-01-14 23:08:07','FFF 666'),
  (81328,'2010-02-01 16:47:32','GGG 777'),
  (85233,'2010-01-20 10:53:39','FFF 666'),
  (85343,'2010-01-07 21:37:51','GGG 777'),
  (86510,'2010-01-27 23:04:11','HHH 888'),
  (88442,'2010-01-25 12:34:25','AAA 111'),
  (90969,'2010-01-07 21:37:51','FFF 666'),
  (97179,'2010-01-03 04:02:21','HHH 888');

COMMIT;

#
# Data for the `infracciones_multas` table  (LIMIT 0,500)
#

INSERT INTO `infracciones_multas` (`nro_multa`, `cod_infraccion`) VALUES 
  (3659,1),
  (13017,1),
  (40204,1),
  (44605,1),
  (53809,1),
  (56501,1),
  (67226,1),
  (70506,1),
  (76838,1),
  (88442,1),
  (31917,2),
  (79242,2),
  (85233,2),
  (85343,2),
  (86510,2),
  (90969,2),
  (97179,2),
  (44605,5),
  (48071,5),
  (56501,5),
  (76601,5),
  (79242,5),
  (81328,5),
  (86510,5),
  (40204,6),
  (53809,6),
  (67226,6),
  (76838,6),
  (81328,6),
  (88442,6);

COMMIT;

#
# Data for the `pagos` table  (LIMIT 0,500)
#

INSERT INTO `pagos` (`nro_multa`, `nro_pago`, `fecha_hora_pactada`, `fecha_hora_venc`, `fecha_hora_pago`, `importe`) VALUES 
  (3659,1,'2010-01-19 06:23:30','2010-02-16 06:23:30','2010-02-15 06:23:30',160),
  (13017,1,'2010-01-18 08:50:49','2010-03-11 08:50:49','2010-03-07 08:50:49',160),
  (31917,1,'2010-02-18 08:08:10','2010-03-30 08:08:10','2010-03-21 08:08:10',240),
  (40204,1,'2010-02-15 07:26:20','2010-04-01 07:26:20',NULL,1790),
  (44605,1,'2010-02-24 12:24:37','2010-04-06 12:24:37',NULL,1470),
  (48071,1,'2010-02-14 07:42:20','2010-03-20 07:42:20','2010-02-14 12:00:00',1280),
  (53809,1,'2010-01-13 22:47:11','2010-02-27 22:47:11','2010-03-02 22:47:11',1460),
  (56501,1,'2010-01-14 00:09:03','2010-02-19 00:09:03','2010-02-18 00:09:03',1410),
  (67226,1,'2010-02-05 12:51:54','2010-03-15 12:51:54','2010-03-11 12:51:54',1460),
  (70506,1,'2010-02-11 07:26:20','2010-04-01 07:26:20','2010-03-28 07:26:20',190),
  (76601,1,'2010-02-07 07:43:49','2010-03-28 07:43:49','2010-03-30 07:43:49',1280),
  (76838,1,'2010-02-06 18:54:22','2010-03-28 18:54:22','2010-03-21 18:54:22',1760),
  (79242,1,'2010-01-15 23:08:07','2010-03-04 23:08:07','2010-02-23 23:08:07',975),
  (79242,2,'2010-01-15 23:08:07','2010-03-04 23:08:07','2010-03-09 23:08:07',575),
  (81328,1,'2010-02-08 16:47:32','2010-03-04 16:47:32',NULL,1000),
  (81328,2,'2010-02-08 16:47:32','2010-03-04 16:47:32',NULL,1000),
  (81328,3,'2010-02-08 16:47:32','2010-03-04 16:47:32',NULL,580),
  (85233,1,'2010-01-28 10:53:39','2010-02-23 10:53:39','2010-02-22 10:53:39',195),
  (85343,1,'2010-01-09 21:37:51','2010-02-24 21:37:51',NULL,195),
  (86510,1,'2010-02-05 23:04:11','2010-03-14 23:04:11','2010-03-20 23:04:11',1475),
  (88442,1,'2010-02-03 12:34:25','2010-02-23 12:34:25',NULL,1460),
  (90969,1,'2010-01-12 21:37:51','2010-02-17 21:37:51','2010-02-09 21:37:51',195),
  (97179,1,'2010-01-06 04:02:21','2010-02-22 04:02:21','2010-02-14 04:02:21',195);

COMMIT;

#
# Data for the `personas` table  (LIMIT 0,500)
#

INSERT INTO `personas` (`dni`, `nombre`, `apellido`, `nro_lic`, `fecha_venc_lic`) VALUES 
  ('10101010','Agatha','Christie','3101010101','2010-03-04'),
  ('11111111','Honoré de','Balzac','3111111111','2011-03-09'),
  ('12121212','Rubén','Dario','3121212121','2013-04-12'),
  ('13131313','Miguel de','Cervantes','3131313131','2010-04-02'),
  ('14141414','Ernest','Hemingway',NULL,NULL),
  ('15151515','Charles','Dickens',NULL,NULL),
  ('16161616','Samuel','Clemens',NULL,NULL),
  ('17171717','Oscar','Wilde','3171717171','2011-09-03'),
  ('18181818','Pablo','Neruda','5181818181','2010-05-03'),
  ('19191919','León','Tolstói',NULL,NULL);

COMMIT;

#
# Data for the `propietarios` table  (LIMIT 0,500)
#

INSERT INTO `propietarios` (`patente`, `fecha_desde`, `dni`) VALUES 
  ('HHH 888','2010-01-11','10101010'),
  ('FFF 666','2008-11-15','11111111'),
  ('AAA 111','2010-02-12','12121212'),
  ('BBB 222','2010-01-15','12121212'),
  ('DDD 444','2008-08-02','12121212'),
  ('GGG 777','2007-09-06','12121212'),
  ('BBB 222','2008-06-23','13131313'),
  ('HHH 888','2008-06-25','13131313'),
  ('BBB 222','2007-05-02','14141414'),
  ('CCC 333','2007-10-14','14141414'),
  ('CCC 333','2009-08-23','15151515'),
  ('AAA 111','2008-12-01','18181818'),
  ('EEE 555','2009-04-06','18181818');

COMMIT;

#
# Data for the `retiros` table  (LIMIT 0,500)
#

INSERT INTO `retiros` (`patente`, `fecha_hora_retiro`, `dni`) VALUES 
  ('AAA 111','2010-02-03 12:34:25','10101010'),
  ('HHH 888','2010-01-10 04:02:21','10101010'),
  ('HHH 888','2010-02-02 23:04:11','10101010'),
  ('FFF 666','2010-01-09 21:37:51','11111111'),
  ('FFF 666','2010-01-17 23:08:07','11111111'),
  ('FFF 666','2010-01-22 10:53:39','11111111'),
  ('FFF 666','2010-02-12 08:08:10','11111111'),
  ('BBB 222','2010-02-01 12:51:54','12121212'),
  ('DDD 444','2010-02-08 18:54:22','12121212'),
  ('GGG 777','2010-01-11 21:37:51','12121212'),
  ('GGG 777','2010-02-05 16:47:32','12121212'),
  ('BBB 222','2010-01-18 08:50:49','13131313'),
  ('EEE 555','2010-02-13 07:26:20','13131313'),
  ('CCC 333','2010-01-22 06:23:30','15151515'),
  ('AAA 111','2010-02-11 07:26:20','17171717'),
  ('EEE 555','2010-01-06 00:09:03','18181818'),
  ('EEE 555','2010-01-11 22:47:11','18181818'),
  ('FFF 666','2010-02-03 07:43:49','18181818');

COMMIT;

#
# Data for the `valores_infraccion` table  (LIMIT 0,500)
#

INSERT INTO `valores_infraccion` (`cod_infraccion`, `fecha_desde`, `valor_infraccion`) VALUES 
  (1,'2009-09-01',100),
  (1,'2009-10-15',110),
  (1,'2009-11-14',130),
  (1,'2010-01-07',160),
  (1,'2010-02-09',190),
  (2,'2009-09-03',150),
  (2,'2009-10-14',165),
  (2,'2009-12-14',195),
  (2,'2010-01-28',240),
  (2,'2010-03-03',285),
  (3,'2009-08-01',500),
  (3,'2009-08-12',550),
  (3,'2009-10-18',650),
  (3,'2009-10-25',715),
  (3,'2009-12-02',800),
  (3,'2009-12-22',880),
  (3,'2010-01-11',950),
  (3,'2010-01-23',1045),
  (4,'2009-09-15',300),
  (4,'2009-10-09',330),
  (4,'2009-11-28',390),
  (4,'2010-01-16',480),
  (4,'2010-03-02',570),
  (5,'2009-09-01',800),
  (5,'2009-09-28',880),
  (5,'2009-11-28',1040),
  (5,'2009-12-26',1280),
  (5,'2010-03-08',1520),
  (6,'2009-09-01',1000),
  (6,'2009-10-24',1100),
  (6,'2009-11-01',1300),
  (6,'2010-02-02',1600),
  (6,'2010-02-27',1900);

COMMIT;

#
# Data for the `valores_remolques` table  (LIMIT 0,500)
#

INSERT INTO `valores_remolques` (`fecha_desde`, `valor_remolque`) VALUES 
  ('2009-09-03',350),
  ('2009-12-11',500),
  ('2010-02-03',750),
  ('2010-06-03',1500);

COMMIT;

