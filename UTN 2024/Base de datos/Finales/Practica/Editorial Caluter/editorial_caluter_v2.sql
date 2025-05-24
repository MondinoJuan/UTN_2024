# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : editorial_caluter


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `editorial_caluter`;

CREATE DATABASE `editorial_caluter`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `editorial_caluter`;

#
# Structure for the `autores` table : 
#

DROP TABLE IF EXISTS `autores`;

CREATE TABLE `autores` (
  `dni` int(11) NOT NULL,
  `nom_ape` varchar(50) NOT NULL,
  `telefono` varchar(10) default NULL,
  `direccion` varchar(50) NOT NULL,
  `email` varchar(50) default NULL,
  `fecha_nac` date NOT NULL,
  PRIMARY KEY  (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `clientes` table : 
#

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `cuit` char(20) NOT NULL,
  `razon_social` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` varchar(50) default NULL,
  `email` varchar(50) default NULL,
  PRIMARY KEY  (`cuit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `pedidos` table : 
#

DROP TABLE IF EXISTS `pedidos`;

CREATE TABLE `pedidos` (
  `nro_pedido` int(11) NOT NULL,
  `fecha_pedido` date NOT NULL,
  `cuit_cliente` char(20) NOT NULL,
  PRIMARY KEY  (`nro_pedido`),
  KEY `pedidos_clientes_fk` (`cuit_cliente`),
  CONSTRAINT `pedidos_clientes_fk` FOREIGN KEY (`cuit_cliente`) REFERENCES `clientes` (`cuit`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `motivos_baja` table : 
#

DROP TABLE IF EXISTS `motivos_baja`;

CREATE TABLE `motivos_baja` (
  `cod_motivo` int(11) NOT NULL,
  `desc_motivo` varchar(20) default NULL,
  PRIMARY KEY  (`cod_motivo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `propuestas` table : 
#

DROP TABLE IF EXISTS `propuestas`;

CREATE TABLE `propuestas` (
  `nro_propuesta` int(11) NOT NULL,
  `fecha_recepcion` date NOT NULL,
  `nombre_publicacion` varchar(50) NOT NULL,
  `descripcion` varchar(500) default NULL,
  `ISBN` varchar(13) default NULL,
  `ISSN` varchar(20) default NULL,
  `periodicidad` varchar(50) default NULL,
  `fecha_baja` date default NULL,
  `cod_motivo_baja` int(11) default NULL,
  PRIMARY KEY  (`nro_propuesta`),
  KEY `propuesta_motivos_baja_fk` (`cod_motivo_baja`),
  CONSTRAINT `propuesta_motivos_baja_fk` FOREIGN KEY (`cod_motivo_baja`) REFERENCES `motivos_baja` (`cod_motivo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `detalle_pedidos` table : 
#

DROP TABLE IF EXISTS `detalle_pedidos`;

CREATE TABLE `detalle_pedidos` (
  `nro_pedido` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  `nro_propuesta` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fecha_limite_entrega` date default NULL,
  `cancelado` tinyint(1) default NULL,
  PRIMARY KEY  (`nro_pedido`,`orden`),
  KEY `detalle_pedidos_propuestas_fk` (`nro_propuesta`),
  CONSTRAINT `detalle_pedidos_fk` FOREIGN KEY (`nro_pedido`) REFERENCES `pedidos` (`nro_pedido`) ON UPDATE CASCADE,
  CONSTRAINT `detalle_pedidos_propuestas_fk` FOREIGN KEY (`nro_propuesta`) REFERENCES `propuestas` (`nro_propuesta`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `entregas` table : 
#

DROP TABLE IF EXISTS `entregas`;

CREATE TABLE `entregas` (
  `nro_entrega` int(11) NOT NULL,
  `fecha_entrega` date NOT NULL,
  PRIMARY KEY  (`nro_entrega`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `entrega_pedidos` table : 
#

DROP TABLE IF EXISTS `entrega_pedidos`;

CREATE TABLE `entrega_pedidos` (
  `nro_pedido` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  `nro_entrega` int(11) NOT NULL,
  `cant` int(11) NOT NULL,
  PRIMARY KEY  (`nro_pedido`,`orden`,`nro_entrega`),
  KEY `entrega_pedidos_fk` (`nro_entrega`),
  CONSTRAINT `entrega_pedidos_detalle_pedidos_fk` FOREIGN KEY (`nro_pedido`, `orden`) REFERENCES `detalle_pedidos` (`nro_pedido`, `orden`) ON UPDATE CASCADE,
  CONSTRAINT `entrega_pedidos_fk` FOREIGN KEY (`nro_entrega`) REFERENCES `entregas` (`nro_entrega`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `pagos` table : 
#

DROP TABLE IF EXISTS `pagos`;

CREATE TABLE `pagos` (
  `nro_entrega` int(11) NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `fecha_emision` date NOT NULL,
  `importe_pago` float(9,3) NOT NULL,
  `fecha_pago` date default NULL,
  `recargo` float(9,3) default NULL,
  PRIMARY KEY  (`nro_entrega`,`fecha_vencimiento`),
  CONSTRAINT `pagos_fk` FOREIGN KEY (`nro_entrega`) REFERENCES `entregas` (`nro_entrega`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `propuesta_autores` table : 
#

DROP TABLE IF EXISTS `propuesta_autores`;

CREATE TABLE `propuesta_autores` (
  `dni` int(11) NOT NULL,
  `nro_propuesta` int(11) NOT NULL,
  PRIMARY KEY  (`dni`,`nro_propuesta`),
  KEY `propuesta_autores_propuestas_fk` (`nro_propuesta`),
  CONSTRAINT `propuesta_autores_autores_fk` FOREIGN KEY (`dni`) REFERENCES `autores` (`dni`) ON UPDATE CASCADE,
  CONSTRAINT `propuesta_autores_propuestas_fk` FOREIGN KEY (`nro_propuesta`) REFERENCES `propuestas` (`nro_propuesta`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `revisores` table : 
#

DROP TABLE IF EXISTS `revisores`;

CREATE TABLE `revisores` (
  `dni` int(11) NOT NULL,
  `nom_ape` varchar(50) NOT NULL,
  `telefono` varchar(10) default NULL,
  `direccion` varchar(50) NOT NULL,
  `email` varchar(50) default NULL,
  `fecha_nac` date NOT NULL,
  `fecha_ingreso` date NOT NULL,
  PRIMARY KEY  (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `propuestas_revisores` table : 
#

DROP TABLE IF EXISTS `propuestas_revisores`;

CREATE TABLE `propuestas_revisores` (
  `dni` int(11) NOT NULL,
  `nro_propuesta` int(11) NOT NULL,
  `fecha_asignacion` date NOT NULL,
  `fecha_evaluacion` date default NULL,
  `aprobado` tinyint(1) default NULL,
  `observaciones` varchar(500) default NULL,
  PRIMARY KEY  (`dni`,`nro_propuesta`),
  KEY `propuestas_revisores_propuestas_fk` (`nro_propuesta`),
  CONSTRAINT `propuestas_revisores_propuestas_fk` FOREIGN KEY (`nro_propuesta`) REFERENCES `propuestas` (`nro_propuesta`) ON UPDATE CASCADE,
  CONSTRAINT `propuestas_revisores_revisores_fk` FOREIGN KEY (`dni`) REFERENCES `revisores` (`dni`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_propuesta` table : 
#

DROP TABLE IF EXISTS `valores_propuesta`;

CREATE TABLE `valores_propuesta` (
  `nro_propuesta` int(11) NOT NULL,
  `fecha_valor` date NOT NULL,
  `valor_publicacion` float(9,3) NOT NULL,
  PRIMARY KEY  (`nro_propuesta`,`fecha_valor`),
  CONSTRAINT `valores_propuesta_propuesta_fk` FOREIGN KEY (`nro_propuesta`) REFERENCES `propuestas` (`nro_propuesta`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `autores` table  (LIMIT 0,500)
#

INSERT INTO `autores` (`dni`, `nom_ape`, `telefono`, `direccion`, `email`, `fecha_nac`) VALUES 
  (10101010,'Roger Pressman','410-1010','Caferata 1010','roger@pressman.com.ar','1961-01-01'),
  (11111111,'Craig Larman','411-1111','Urquiza 111','craiglarman@gmail.com','1971-11-11'),
  (12121212,'Roger Masco','412-1212','Lima 1212','rmasco@fecia.unr.edu.ar','1942-12-12'),
  (13131313,'Norma Torrent','413-1313','Rodriguez 131','ntorrent@frro.utn.edu.ar','1953-03-13'),
  (14141414,'Fransisco Mochon','414-1414','Galvez 1414','fmochon@mgh.com','1944-04-14'),
  (15151515,'Victor Beker','415-1515','Regimiento 11 1515','vbeker@mgh.com','1935-05-15'),
  (16161616,'Rodolfo Gioiella','416-1616','Lamadrid 1616',NULL,'0001-01-01');

COMMIT;

#
# Data for the `clientes` table  (LIMIT 0,500)
#

INSERT INTO `clientes` (`cuit`, `razon_social`, `direccion`, `telefono`, `email`) VALUES 
  ('21-21212121-2','UTN FRRo','Zeballos 2121','421-2121','compras@frro.utn.edu.ar'),
  ('22-22222222-2','Libreria Tecnica','Cordoba 222','422-2222','comrpas@libtec.com.ar'),
  ('23-23232323-2','Libreria Ross','Arijón 2323','423-2323','compras@libreriaross.com.ar'),
  ('24-24242424-2','Facultad de Ingenieria y Cs Exactas','Alem 2424','424-2424','compras@fceia.unr.edu.ar'),
  ('25-25252525-2','El Ateneo','Alvear 2525','425-2525','compras@elateneo.com.ar');

COMMIT;

#
# Data for the `pedidos` table  (LIMIT 0,500)
#

INSERT INTO `pedidos` (`nro_pedido`, `fecha_pedido`, `cuit_cliente`) VALUES 
  (1,'2008-10-18','22-22222222-2'),
  (2,'2008-10-20','24-24242424-2'),
  (3,'2008-10-19','25-25252525-2'),
  (4,'2008-11-26','22-22222222-2'),
  (5,'2009-02-04','22-22222222-2'),
  (6,'2009-02-06','23-23232323-2'),
  (7,'2009-02-05','25-25252525-2'),
  (8,'2009-02-17','21-21212121-2'),
  (9,'2009-02-17','22-22222222-2'),
  (10,'2009-02-16','23-23232323-2'),
  (11,'2009-02-18','25-25252525-2'),
  (12,'2009-02-09','22-22222222-2'),
  (13,'2009-02-09','23-23232323-2'),
  (14,'2009-03-02','21-21212121-2'),
  (15,'2009-03-25','21-21212121-2'),
  (16,'2009-03-24','22-22222222-2'),
  (17,'2009-03-26','23-23232323-2'),
  (18,'2009-03-24','24-24242424-2'),
  (19,'2009-03-20','21-21212121-2'),
  (20,'2009-03-21','23-23232323-2'),
  (21,'2009-03-20','24-24242424-2'),
  (22,'2009-03-19','25-25252525-2'),
  (23,'2009-04-11','25-25252525-2'),
  (24,'2009-04-22','21-21212121-2'),
  (25,'2009-04-22','22-22222222-2'),
  (26,'2009-04-21','24-24242424-2');

COMMIT;

#
# Data for the `motivos_baja` table  (LIMIT 0,500)
#

INSERT INTO `motivos_baja` (`cod_motivo`, `desc_motivo`) VALUES 
  (1,'Problemas Legales'),
  (2,'Bajas Ventas'),
  (3,'Pocas Ganancias'),
  (4,'Contenido'),
  (5,'Nueva Edicion'),
  (6,'Nuevo Contrato');

COMMIT;

#
# Data for the `propuestas` table  (LIMIT 0,500)
#

INSERT INTO `propuestas` (`nro_propuesta`, `fecha_recepcion`, `nombre_publicacion`, `descripcion`, `ISBN`, `ISSN`, `periodicidad`, `fecha_baja`, `cod_motivo_baja`) VALUES 
  (1,'2008-09-01','Ingenieria de Software','Ingenieria de Software. Generalidades, ejemplos y buenas practicas',NULL,NULL,NULL,NULL,NULL),
  (2,'2008-10-01','RUP y UML','Tecnicas de AOO y DOO utilizando UML. Introduccion a RUP',NULL,NULL,NULL,NULL,NULL),
  (3,'2008-10-03','Economia','Macro Economia','3333333333333',NULL,NULL,NULL,NULL),
  (4,'2008-11-04','UML y Patrones','Tecnicas de AOO y DOO utilizando UML para documentar utilizando RUP para el desarrollo y para el libro','4444444444444',NULL,NULL,NULL,NULL),
  (5,'2008-11-15','Ingeniería de Software','Ingenieria de Software. Generalidades, ejemplos y buenas practicas','5555555555555',NULL,NULL,NULL,NULL),
  (6,'2008-12-16','Economia','Conceptos básicos de Micro y Macroeconomia',NULL,NULL,'anual',NULL,NULL),
  (7,'2009-01-17','Economia','Conceptos básicos de Micro y Macroeconomia',NULL,'ISSN-7777-7777-7','anual','2009-04-24',3),
  (8,'2009-01-18','Ing. de SW y RUP','Ingeniería de SW aplicando RUP',NULL,'ISSN-8888-8888-8','mensual',NULL,NULL),
  (9,'2009-01-22','Herramientas y tecnicas de UML','Uso de UML, tecnicas y herramientas para el Desarrollo de SW',NULL,'ISSN-9999-9999-9','quincenal',NULL,NULL),
  (10,'2009-02-10','Analisis economicos','Tendencias y tecnicas analisis economicos de bolsa de valores',NULL,NULL,'semanal',NULL,NULL),
  (11,'2009-02-11','Ingenieria de Software','Ingenieria de Software. Generalidades, ejemplos y buenas practicas','1111111111111',NULL,NULL,'2009-04-17',5),
  (12,'2009-02-22','Programacion Lineal','Programacion lineal metodo simplex, dual',NULL,NULL,NULL,NULL,NULL),
  (13,'2009-03-03','Programacion Lineal','Programacion lineal metodo simplex, dual, ejemplos y usos','1313131313131',NULL,NULL,NULL,NULL),
  (14,'2009-03-03','CPM y Pert','CPM y Pert. Usos de las herramienta','1414141414141',NULL,NULL,NULL,NULL),
  (15,'2009-03-03','Gestion de Stock','Tecnicas de Gestión de stock. Metodologías, herramientas y ejemplos',NULL,NULL,NULL,NULL,NULL),
  (16,'2009-03-16','Investigación Operativa Aplicada','Aplicación reales de tecnicas y herramientas de IO',NULL,'ISSN-1616-1616-1','mensual','2009-04-23',1),
  (17,'2009-04-17','Ingenieria de Software','Ingenieria de Software. Generalidades, ejemplos y buenas practicas','1717171717171',NULL,NULL,NULL,NULL);

COMMIT;

#
# Data for the `detalle_pedidos` table  (LIMIT 0,500)
#

INSERT INTO `detalle_pedidos` (`nro_pedido`, `orden`, `nro_propuesta`, `cantidad`, `fecha_limite_entrega`, `cancelado`) VALUES 
  (1,1,3,101,'2008-10-27',NULL),
  (2,1,3,98,'2008-11-05',NULL),
  (3,1,3,39,'2008-11-01',1),
  (4,1,4,167,'2008-12-09',1),
  (5,1,3,138,'2009-02-19',NULL),
  (6,1,4,70,'2009-02-24',NULL),
  (6,2,7,120,'2009-02-20',NULL),
  (7,1,4,35,'2009-02-18',NULL),
  (7,2,7,83,'2009-02-20',NULL),
  (7,3,4,245,'2009-03-15',NULL),
  (8,1,9,131,'2009-03-02',NULL),
  (9,1,3,30,'2009-03-01',NULL),
  (9,2,4,120,'2009-02-26',NULL),
  (9,3,7,117,'2009-02-26',NULL),
  (9,4,9,171,'2009-03-06',NULL),
  (9,5,3,150,'2009-03-22',NULL),
  (10,1,7,76,'2009-03-03',NULL),
  (10,2,8,185,'2009-02-27',NULL),
  (11,1,4,100,'2009-03-03',NULL),
  (11,2,9,170,'2009-03-03',NULL),
  (12,1,3,115,'2009-02-27',NULL),
  (12,2,4,188,'2009-02-23',NULL),
  (12,3,7,95,'2009-02-26',NULL),
  (13,1,7,106,'2009-02-21',1),
  (14,1,9,68,'2009-03-17',NULL),
  (15,1,3,68,'2009-04-08',NULL),
  (15,2,4,125,'2009-04-04',NULL),
  (15,3,7,168,'2009-04-10',NULL),
  (15,4,3,180,'2009-04-19',NULL),
  (16,1,3,149,'2009-04-07',1),
  (16,2,4,162,'2009-04-02',NULL),
  (16,3,7,80,'2009-04-03',1),
  (16,4,8,77,'2009-04-08',NULL),
  (17,1,7,88,'2009-04-05',1),
  (17,2,9,77,'2009-04-10',1),
  (17,3,14,180,'2009-04-09',NULL),
  (18,1,4,122,'2009-04-02',NULL),
  (18,2,7,183,'2009-04-04',NULL),
  (18,3,14,133,'2009-04-09',NULL),
  (19,1,3,104,'2009-04-02',NULL),
  (19,2,4,176,'2009-03-30',NULL),
  (19,3,7,75,'2009-04-05',NULL),
  (20,1,3,50,'2009-04-07',NULL),
  (20,2,4,124,'2009-04-08',1),
  (20,3,7,111,'2009-03-30',NULL),
  (20,4,8,119,'2009-03-31',NULL),
  (20,5,11,126,'2009-04-03',NULL),
  (20,6,14,115,'2009-04-04',NULL),
  (21,1,3,121,'2009-04-05',NULL),
  (21,2,4,191,'2009-03-31',NULL),
  (21,3,8,176,'2009-04-06',1),
  (21,4,9,122,'2009-04-03',NULL),
  (22,1,3,176,'2009-04-06',NULL),
  (22,2,7,196,'2009-04-06',1),
  (22,3,9,97,'2009-03-31',NULL),
  (23,1,3,155,'2009-04-22',NULL),
  (23,2,4,173,'2009-04-27',NULL),
  (23,3,8,63,'2009-04-20',NULL),
  (23,4,13,105,'2009-04-21',NULL),
  (23,5,16,161,'2009-04-28',NULL),
  (24,1,3,129,'2009-05-06',NULL),
  (24,2,4,109,'2009-05-10',NULL),
  (24,3,7,106,'2009-05-06',NULL),
  (24,4,8,88,'2009-05-01',NULL),
  (24,5,9,78,'2009-05-06',NULL),
  (24,6,11,128,'2009-05-06',NULL),
  (24,7,14,138,'2009-05-05',NULL),
  (24,8,16,145,'2009-05-01',NULL),
  (25,1,7,119,'2009-05-02',NULL),
  (25,2,8,76,'2009-05-02',NULL),
  (25,3,11,155,'2009-05-04',NULL),
  (25,4,16,197,'2009-05-06',NULL),
  (26,1,3,78,'2009-05-03',NULL),
  (26,2,4,166,'2009-05-08',NULL),
  (26,3,7,50,'2009-05-01',NULL),
  (26,4,8,65,'2009-05-05',NULL),
  (26,5,9,78,'2009-05-06',NULL),
  (26,6,13,65,'2009-05-06',NULL),
  (26,7,14,160,'2009-05-09',NULL),
  (26,8,16,114,'2009-04-30',NULL),
  (26,9,17,154,'2009-05-02',NULL);

COMMIT;

#
# Data for the `entregas` table  (LIMIT 0,500)
#

INSERT INTO `entregas` (`nro_entrega`, `fecha_entrega`) VALUES 
  (1,'2008-10-22'),
  (2,'2008-10-22'),
  (3,'2008-10-22'),
  (4,'2008-10-29'),
  (5,'2008-10-29'),
  (6,'2008-10-29'),
  (7,'2008-11-04'),
  (8,'2008-11-04'),
  (9,'2008-11-04'),
  (10,'2008-12-02'),
  (11,'2008-12-09'),
  (12,'2008-12-16'),
  (13,'2009-02-10'),
  (14,'2009-02-10'),
  (15,'2009-02-10'),
  (16,'2009-02-17'),
  (17,'2009-02-17'),
  (18,'2009-02-17'),
  (19,'2009-02-24'),
  (20,'2009-02-24'),
  (21,'2009-02-24'),
  (22,'2009-02-24'),
  (23,'2009-03-03'),
  (24,'2009-03-03'),
  (25,'2009-03-03'),
  (26,'2009-03-10'),
  (27,'2009-03-10'),
  (28,'2009-03-10'),
  (29,'2009-03-17'),
  (30,'2009-03-24'),
  (31,'2009-03-24'),
  (32,'2009-03-24'),
  (33,'2009-03-24'),
  (34,'2009-03-31'),
  (35,'2009-03-31'),
  (36,'2009-03-31'),
  (37,'2009-03-31'),
  (38,'2009-03-31'),
  (39,'2009-04-07'),
  (40,'2009-04-07'),
  (41,'2009-04-07'),
  (42,'2009-04-07'),
  (43,'2009-04-07'),
  (44,'2009-04-07'),
  (45,'2009-04-14'),
  (46,'2009-04-14'),
  (47,'2009-04-14'),
  (48,'2009-04-14'),
  (49,'2009-04-14'),
  (50,'2009-04-21'),
  (51,'2009-04-21'),
  (52,'2009-04-21'),
  (53,'2009-04-21'),
  (54,'2009-04-21');

COMMIT;

#
# Data for the `entrega_pedidos` table  (LIMIT 0,500)
#

INSERT INTO `entrega_pedidos` (`nro_pedido`, `orden`, `nro_entrega`, `cant`) VALUES 
  (1,1,1,80),
  (1,1,4,14),
  (1,1,9,7),
  (2,1,2,64),
  (2,1,5,19),
  (2,1,8,15),
  (3,1,3,23),
  (3,1,6,9),
  (4,1,10,120),
  (4,1,11,27),
  (5,1,13,109),
  (5,1,16,15),
  (5,1,21,14),
  (6,1,14,41),
  (6,1,17,26),
  (6,1,20,3),
  (6,2,14,68),
  (6,2,17,42),
  (6,2,20,10),
  (7,1,15,34),
  (7,1,25,1),
  (7,2,15,45),
  (7,2,18,13),
  (7,2,22,25),
  (7,3,15,241),
  (7,3,18,2),
  (7,3,22,2),
  (8,1,19,131),
  (9,1,21,30),
  (9,2,21,120),
  (9,3,21,117),
  (9,4,21,110),
  (9,4,24,39),
  (9,4,27,22),
  (9,5,21,90),
  (9,5,24,42),
  (9,5,27,18),
  (10,1,17,23),
  (10,1,20,53),
  (10,2,17,168),
  (10,2,20,17),
  (11,1,22,100),
  (11,2,22,75),
  (11,2,25,64),
  (11,2,29,31),
  (12,1,13,97),
  (12,1,16,18),
  (12,2,13,158),
  (12,2,16,20),
  (12,2,21,10),
  (12,3,13,65),
  (12,3,16,27),
  (12,3,21,3),
  (13,1,14,85),
  (13,1,17,11),
  (14,1,23,33),
  (14,1,26,32),
  (14,1,28,3),
  (15,1,34,36),
  (15,1,39,32),
  (15,2,34,106),
  (15,2,39,19),
  (15,3,34,158),
  (15,3,39,10),
  (15,4,34,82),
  (15,4,39,65),
  (15,4,45,14),
  (15,4,50,15),
  (16,1,35,110),
  (16,1,40,18),
  (16,2,35,75),
  (16,2,40,43),
  (16,2,46,17),
  (16,2,51,27),
  (16,3,35,40),
  (16,4,35,58),
  (16,4,40,19),
  (17,1,36,55),
  (17,2,36,44),
  (17,2,41,21),
  (17,3,36,116),
  (17,3,41,48),
  (17,3,47,7),
  (18,1,37,115),
  (18,1,42,7),
  (18,2,37,129),
  (18,2,42,54),
  (18,3,37,55),
  (18,3,42,78),
  (19,1,30,71),
  (19,1,34,17),
  (19,1,39,16),
  (19,2,30,111),
  (19,2,34,33),
  (19,2,39,31),
  (19,2,45,12),
  (19,3,30,70),
  (19,3,34,5),
  (20,1,31,18),
  (20,1,36,17),
  (20,1,41,15),
  (20,2,31,97),
  (20,2,36,11),
  (20,2,41,5),
  (20,3,31,48),
  (20,3,36,55),
  (20,3,41,8),
  (20,4,31,112),
  (20,4,36,5),
  (20,4,41,10),
  (20,5,31,100),
  (20,5,36,26),
  (20,6,31,50),
  (20,6,36,50),
  (20,6,41,12),
  (20,6,47,3),
  (21,1,32,38),
  (21,1,37,76),
  (21,1,42,10),
  (21,2,32,126),
  (21,2,37,65),
  (21,3,32,114),
  (21,3,37,44),
  (21,4,32,117),
  (21,4,37,4),
  (21,4,42,7),
  (22,1,33,79),
  (22,1,38,33),
  (22,1,43,30),
  (22,1,44,34),
  (22,2,33,93),
  (22,2,38,32),
  (22,3,33,71),
  (22,3,38,25),
  (22,3,43,9),
  (23,1,49,72),
  (23,1,53,45),
  (23,1,54,28),
  (23,2,49,161),
  (23,2,53,12),
  (23,3,49,63),
  (23,4,49,56),
  (23,4,53,21),
  (23,4,54,12),
  (23,5,49,77),
  (23,5,53,38),
  (23,5,54,37);

COMMIT;

#
# Data for the `pagos` table  (LIMIT 0,500)
#

INSERT INTO `pagos` (`nro_entrega`, `fecha_vencimiento`, `fecha_emision`, `importe_pago`, `fecha_pago`, `recargo`) VALUES 
  (1,'2008-11-22','2008-10-22',6000,'2008-11-19',NULL),
  (1,'2008-12-07','2008-10-22',3000,'2008-12-07',NULL),
  (1,'2008-12-22','2008-10-22',3000,'2008-12-25',300),
  (2,'2008-11-22','2008-10-22',9600,'2008-11-26',960),
  (3,'2008-11-22','2008-10-22',1725,'2008-11-21',NULL),
  (3,'2008-12-22','2008-10-22',1725,'2008-12-24',172.5),
  (4,'2008-11-29','2008-10-29',1050,'2008-11-20',NULL),
  (4,'2008-12-29','2008-10-29',1050,'2008-12-28',NULL),
  (5,'2008-11-29','2008-10-29',2850,'2008-12-03',285),
  (6,'2008-11-29','2008-10-29',675,'2008-11-25',NULL),
  (6,'2008-12-29','2008-10-29',675,NULL,NULL),
  (8,'2008-12-04','2008-11-04',1125,'2008-12-05',112.5),
  (8,'2009-01-04','2008-11-04',1125,'2009-01-01',NULL),
  (9,'2008-12-04','2008-11-04',525,'2008-12-04',NULL),
  (9,'2009-01-04','2008-11-04',525,'2009-01-03',NULL),
  (13,'2009-03-10','2009-02-10',19570,NULL,NULL),
  (13,'2009-04-10','2009-02-10',19570,'2009-04-11',1957),
  (16,'2009-03-17','2009-02-17',6270,NULL,NULL),
  (21,'2009-03-24','2009-02-24',15209,'2009-03-25',1520.9),
  (21,'2009-04-24','2009-02-24',15209,'2009-04-17',NULL),
  (24,'2009-04-03','2009-03-03',4767,'2009-04-06',476.7),
  (24,'2009-05-03','2009-03-03',4767,'2009-05-08',476.7),
  (27,'2009-04-10','2009-03-10',2043,NULL,NULL),
  (27,'2009-05-10','2009-03-10',2043,'2009-05-05',NULL),
  (30,'2009-04-24','2009-03-24',16117,NULL,NULL),
  (31,'2009-04-24','2009-03-24',2043,NULL,NULL),
  (31,'2009-05-24','2009-03-24',2043,'2009-05-23',NULL),
  (32,'2009-04-24','2009-03-24',8626,'2009-04-26',862.6),
  (33,'2009-04-23','2009-03-24',8966.5,NULL,NULL),
  (33,'2009-05-23','2009-03-24',8966.5,NULL,NULL),
  (34,'2009-04-30','2009-03-31',15322.5,NULL,NULL),
  (34,'2009-05-30','2009-03-31',15322.5,NULL,NULL),
  (35,'2009-04-30','2009-03-31',12485,'2009-05-03',1248.5),
  (35,'2009-05-30','2009-03-31',12485,'2009-05-24',NULL),
  (36,'2009-04-30','2009-03-31',1929.5,'2009-05-03',192.95),
  (36,'2009-05-30','2009-03-31',1929.5,NULL,NULL),
  (37,'2009-04-30','2009-03-31',8626,'2009-04-30',NULL),
  (37,'2009-05-30','2009-03-31',8626,'2009-05-23',NULL),
  (38,'2009-04-30','2009-03-31',3745.5,'2009-04-27',NULL),
  (38,'2009-05-30','2009-03-31',3745.5,'2009-06-08',374.55),
  (39,'2009-05-07','2009-04-07',15995,NULL,NULL),
  (39,'2009-06-07','2009-04-07',15995,NULL,NULL),
  (40,'2009-05-07','2009-04-07',2520,'2009-05-11',252),
  (40,'2009-06-07','2009-04-07',2520,'2009-06-06',NULL),
  (41,'2009-05-07','2009-04-07',2240,NULL,NULL),
  (41,'2009-06-07','2009-04-07',2240,'2009-06-03',NULL),
  (42,'2009-05-07','2009-04-07',4690,NULL,NULL),
  (43,'2009-05-07','2009-04-07',4200,'2009-05-07',NULL),
  (43,'2009-06-07','2009-04-07',4200,NULL,NULL),
  (44,'2009-05-07','2009-04-07',4760,'2009-05-08',476),
  (44,'2009-06-07','2009-04-07',4760,NULL,NULL),
  (45,'2009-05-14','2009-04-14',3920,'2009-05-17',392),
  (49,'2009-05-14','2009-04-14',10080,'2009-05-09',NULL),
  (49,'2009-06-14','2009-04-14',10080,NULL,NULL),
  (50,'2009-05-21','2009-04-21',4200,NULL,NULL),
  (53,'2009-05-21','2009-04-21',6300,'2009-05-22',630),
  (53,'2009-06-21','2009-04-21',6300,'2009-06-16',NULL),
  (54,'2009-05-21','2009-04-21',3920,'2009-05-18',NULL),
  (54,'2009-06-21','2009-04-21',3920,'2009-06-17',NULL);

COMMIT;

#
# Data for the `propuesta_autores` table  (LIMIT 0,500)
#

INSERT INTO `propuesta_autores` (`dni`, `nro_propuesta`) VALUES 
  (10101010,1),
  (11111111,2),
  (14141414,3),
  (15151515,3),
  (11111111,4),
  (10101010,5),
  (16161616,6),
  (16161616,7),
  (10101010,8),
  (11111111,8),
  (11111111,9),
  (14141414,10),
  (10101010,11),
  (13131313,12),
  (12121212,13),
  (13131313,13),
  (12121212,14),
  (13131313,15),
  (13131313,16),
  (10101010,17);

COMMIT;

#
# Data for the `revisores` table  (LIMIT 0,500)
#

INSERT INTO `revisores` (`dni`, `nom_ape`, `telefono`, `direccion`, `email`, `fecha_nac`, `fecha_ingreso`) VALUES 
  (30303030,'Roberto Arlt','430-3030','Mendoza 3030','rarlt@caluter.com.ar','1970-03-30','2000-03-30'),
  (31313131,'Antonio Gramsci','431-3131','San Martin 3131','agramsci@caluter.com.ar','1971-01-31','2001-01-31'),
  (32323232,'Rafael Alberti','432-3232','Av. del Rosario 3232','ralberti@caluter.com.ar','1972-02-02','2002-02-02'),
  (33333333,'John Updike','433-3333','Mendoza 3333','jupdike@caluter.com.ar','1973-03-03','2003-03-03'),
  (34343434,'Jose Hernandez','444-4444','Corrientes 3434','jhernandez@caluter.com.ar','1974-04-04','2004-04-04'),
  (35353535,'Antonio Machado','435-3535','Laprida 3535','amachado@caluter.com.ar','1975-05-05','2005-05-05'),
  (36363636,'Maximo Gorki','436-3636','Riobamba 3636','mgorki@caluter.com.ar','1976-06-06','2006-06-06'),
  (37373737,'Elsa Triolet','437-3737','Alem 3737','etriolet@caluter.com.ar','1977-07-07','2007-07-07'),
  (38383838,'Emile Cioran','438-3838','Zeballos 38383','ecioran@caluter.com.ar','1978-08-08','2008-08-08');

COMMIT;

#
# Data for the `propuestas_revisores` table  (LIMIT 0,500)
#

INSERT INTO `propuestas_revisores` (`dni`, `nro_propuesta`, `fecha_asignacion`, `fecha_evaluacion`, `aprobado`, `observaciones`) VALUES 
  (30303030,1,'2008-09-14','2008-09-20',0,'Contenido pobre.Mala redaccion.'),
  (30303030,2,'2008-10-22','2008-10-31',0,'Contenido pobre.Poco Innovador.'),
  (30303030,4,'2008-11-10','2008-11-15',1,'Original.Interesante.'),
  (30303030,5,'2008-11-30','2008-12-08',0,'Contenido pobre.Mala redaccion.'),
  (30303030,8,'2009-02-08','2009-02-16',1,'Sin diferencias con otros textos similares.Original.'),
  (30303030,9,'2009-01-28','2009-02-03',1,'Interesante.Original.'),
  (30303030,11,'2009-02-11','2009-02-14',1,'Sin diferencias con otros textos similares.Original.'),
  (30303030,17,'2009-04-18','2009-04-20',1,'Sin diferencias con otros textos similares.Original.'),
  (31313131,1,'2008-09-23','2008-10-02',0,'Mala redaccion.Poco Innovador.'),
  (31313131,2,'2008-10-04','2008-10-13',0,'Entretenido.Contenido pobre.'),
  (31313131,4,'2008-11-18','2008-11-24',1,'Pedagogico.Original.'),
  (31313131,5,'2008-11-25','2008-11-28',1,'Sin diferencias con otros textos similares.Interesante.'),
  (31313131,8,'2009-02-05','2009-02-11',1,'Pedagogico.Original.'),
  (31313131,9,'2009-01-28','2009-02-02',1,'Sin diferencias con otros textos similares.Interesante.'),
  (31313131,11,'2009-02-21','2009-02-28',1,'Pedagogico.Original.'),
  (31313131,17,'2009-04-18','2009-04-20',1,'Sin diferencias con otros textos similares.Interesante.'),
  (32323232,1,'2008-09-05','2008-09-11',0,'Entretenido.Contenido pobre.'),
  (32323232,2,'2008-10-22','2008-10-31',0,'Entretenido.Mala redaccion.'),
  (32323232,4,'2008-11-11','2008-11-16',0,'Entretenido.Mala redaccion.'),
  (32323232,5,'2008-11-21','2008-11-30',1,'Original.Sin diferencias con otros textos similares.'),
  (32323232,8,'2009-01-25','2009-01-30',1,'Interesante.Original.'),
  (32323232,9,'2009-02-04','2009-02-09',1,'Sin diferencias con otros textos similares.Pedagogico.'),
  (32323232,11,'2009-02-16','2009-02-23',1,'Pedagogico.Sin diferencias con otros textos similares.'),
  (32323232,17,'2009-04-18','2009-04-20',1,'Pedagogico.Interesante.'),
  (33333333,3,'2008-10-07','2008-10-14',1,'Original.Sin diferencias con otros textos similares.'),
  (33333333,6,'2008-12-16','2008-12-19',0,'Mala redaccion.Poco Innovador.'),
  (33333333,7,'2009-01-28','2009-02-04',1,'Pedagogico.Original.'),
  (33333333,10,'2009-02-18','2009-02-25',0,'Poco Innovador.Contenido pobre.'),
  (34343434,3,'2008-10-12','2008-10-18',0,'Mala redaccion.Entretenido.'),
  (34343434,6,'2009-01-06','2009-01-14',0,'Contenido pobre.Poco Innovador.'),
  (34343434,7,'2009-01-29','2009-02-02',0,'Interesante.Original.'),
  (34343434,10,'2009-02-28','2009-03-09',0,'Poco Innovador.Contenido pobre.'),
  (35353535,3,'2008-10-10','2008-10-17',1,'Sin diferencias con otros textos similares.Interesante.'),
  (35353535,6,'2008-12-23','2008-12-28',0,'Entretenido.Mala redaccion.'),
  (35353535,7,'2009-01-29','2009-02-03',1,'Original.Interesante.'),
  (35353535,10,'2009-02-28','2009-03-04',0,'Mala redaccion.Entretenido.'),
  (36363636,12,'2009-03-02','2009-03-07',0,'Mala redaccion.Contenido pobre.'),
  (36363636,13,'2009-03-14','2009-03-23',1,'Interesante.Pedagogico.'),
  (36363636,14,'2009-03-11','2009-03-19',1,'Sin diferencias con otros textos similares.Pedagogico.'),
  (36363636,15,'2009-03-08','2009-03-12',0,'Contenido pobre.Mala redaccion.'),
  (36363636,16,'2009-03-21','2009-03-26',1,'Original.Interesante.'),
  (37373737,12,'2009-03-03','2009-03-08',0,'Entretenido.Mala redaccion.'),
  (37373737,13,'2009-03-09','2009-03-16',0,'Entretenido.Poco Innovador.'),
  (37373737,14,'2009-03-09','2009-03-13',1,'Original.Interesante.'),
  (37373737,15,'2009-03-15','2009-03-24',0,'Entretenido.Poco Innovador.'),
  (37373737,16,'2009-04-06','2009-04-09',0,'Entretenido.Contenido pobre.'),
  (38383838,12,'2009-03-14','2009-03-19',0,'Entretenido.Mala redaccion.'),
  (38383838,13,'2009-03-21','2009-03-24',1,'Interesante.Pedagogico.'),
  (38383838,14,'2009-03-08','2009-03-17',1,'Pedagogico.Interesante.'),
  (38383838,15,'2009-03-20','2009-03-24',0,'Contenido pobre.Poco Innovador.'),
  (38383838,16,'2009-03-17','2009-03-23',1,'Sin diferencias con otros textos similares.Pedagogico.');

COMMIT;

#
# Data for the `valores_propuesta` table  (LIMIT 0,500)
#

INSERT INTO `valores_propuesta` (`nro_propuesta`, `fecha_valor`, `valor_publicacion`) VALUES 
  (3,'2008-10-18',150),
  (3,'2008-12-21',190),
  (3,'2009-02-18',227),
  (3,'2009-04-04',280),
  (4,'2008-11-24',200),
  (4,'2009-02-02',270),
  (4,'2009-03-29',300),
  (7,'2009-02-04',12),
  (7,'2009-04-04',35),
  (7,'2009-04-29',45),
  (8,'2009-02-16',45),
  (8,'2009-04-09',57),
  (9,'2009-02-09',32),
  (9,'2009-04-16',27),
  (11,'2009-02-28',180),
  (11,'2009-03-04',230),
  (11,'2009-03-26',270),
  (13,'2009-03-24',24),
  (13,'2009-05-05',30),
  (14,'2009-03-19',15),
  (16,'2009-04-09',12),
  (17,'2009-04-20',270);

COMMIT;

