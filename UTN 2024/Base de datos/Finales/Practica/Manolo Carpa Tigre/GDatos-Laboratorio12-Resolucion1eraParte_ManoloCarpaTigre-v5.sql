# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : serverisi
# Port     : 3306
# Database : manolo_carpa_tigre


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `manolo_carpa_tigre`;

CREATE DATABASE `manolo_carpa_tigre`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `manolo_carpa_tigre`;

#
# Structure for the `choferes` table : 
#

DROP TABLE IF EXISTS `choferes`;

CREATE TABLE `choferes` (
  `cuil` char(20) NOT NULL,
  `carnet` varchar(20) default NULL,
  `fecha_nac` date default NULL,
  `nom_ape` varchar(50) default NULL,
  `telefono` varchar(20) default NULL,
  `direccion` varchar(50) default NULL,
  `email` varchar(50) default NULL,
  PRIMARY KEY  (`cuil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `clientes` table : 
#

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `cuit` char(20) NOT NULL,
  `denominacion` varchar(50) NOT NULL,
  `telefono` varchar(20) default NULL,
  `direccion` varchar(50) default NULL,
  `email` varchar(50) default NULL,
  PRIMARY KEY  (`cuit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `turnos` table : 
#

DROP TABLE IF EXISTS `turnos`;

CREATE TABLE `turnos` (
  `cod_turno` int(11) NOT NULL,
  `desc_turno` varchar(20) default NULL,
  `hora_desde` time default NULL,
  `hora_hasta` time default NULL,
  PRIMARY KEY  (`cod_turno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `conduce_turno` table : 
#

DROP TABLE IF EXISTS `conduce_turno`;

CREATE TABLE `conduce_turno` (
  `cuil` char(20) NOT NULL,
  `cod_turno` int(11) NOT NULL,
  `fecha_turno` date NOT NULL,
  PRIMARY KEY  (`cuil`,`cod_turno`,`fecha_turno`),
  KEY `conduce_turno_turnos_fk` (`cod_turno`),
  CONSTRAINT `conduce_turno_choferes_fk` FOREIGN KEY (`cuil`) REFERENCES `choferes` (`cuil`) ON UPDATE CASCADE,
  CONSTRAINT `conduce_turno_turnos_fk` FOREIGN KEY (`cod_turno`) REFERENCES `turnos` (`cod_turno`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `contratos` table : 
#

DROP TABLE IF EXISTS `contratos`;

CREATE TABLE `contratos` (
  `nro_contrato` int(11) NOT NULL,
  `fecha_contrato` date NOT NULL,
  `observaciones` varchar(200) default NULL,
  `cuit` char(20) NOT NULL,
  PRIMARY KEY  (`nro_contrato`),
  KEY `contratos_fk` (`cuit`),
  CONSTRAINT `contratos_fk` FOREIGN KEY (`cuit`) REFERENCES `clientes` (`cuit`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tipos_viajes` table : 
#

DROP TABLE IF EXISTS `tipos_viajes`;

CREATE TABLE `tipos_viajes` (
  `cod_tipo_viaje` int(11) NOT NULL,
  `desc_tipo_viaje` varchar(50) default NULL,
  PRIMARY KEY  (`cod_tipo_viaje`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `viajes` table : 
#

DROP TABLE IF EXISTS `viajes`;

CREATE TABLE `viajes` (
  `nro_viaje` int(11) NOT NULL auto_increment,
  `fecha_ini` date NOT NULL,
  `hora_ini` time NOT NULL,
  `cant_pasajeros` int(11) default NULL,
  `fecha_fin` date default NULL,
  `hora_fin` time default NULL,
  `destinos` varchar(500) default NULL,
  `fecha_reserva` date default NULL,
  `hora_reserva` time default NULL,
  `duracion_est` float(9,3) default NULL,
  `km_estimados` float(9,3) default NULL,
  `importe` float(9,3) default NULL,
  `estado` varchar(20) default NULL,
  `origen` varchar(50) default NULL,
  `nro_contrato` int(11) default NULL,
  `cuil` char(20) default NULL,
  `cod_turno` int(11) default NULL,
  `fecha_turno` date default NULL,
  `cod_tipo_viaje` int(11) default NULL,
  `fecha_cancelacion` date default NULL,
  PRIMARY KEY  (`nro_viaje`),
  KEY `viajes_fk` (`nro_contrato`),
  KEY `viajes_fk1` (`cuil`,`cod_turno`,`fecha_turno`),
  KEY `viajes_tipos_viajes_fk` (`cod_tipo_viaje`),
  CONSTRAINT `viajes_fk` FOREIGN KEY (`nro_contrato`) REFERENCES `contratos` (`nro_contrato`) ON UPDATE CASCADE,
  CONSTRAINT `viajes_fk1` FOREIGN KEY (`cuil`, `cod_turno`, `fecha_turno`) REFERENCES `conduce_turno` (`cuil`, `cod_turno`, `fecha_turno`) ON UPDATE CASCADE,
  CONSTRAINT `viajes_tipos_viajes_fk` FOREIGN KEY (`cod_tipo_viaje`) REFERENCES `tipos_viajes` (`cod_tipo_viaje`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `cuotas` table : 
#

DROP TABLE IF EXISTS `cuotas`;

CREATE TABLE `cuotas` (
  `nro_viaje` int(11) NOT NULL,
  `fecha_venc` date NOT NULL,
  `fecha_pago` date default NULL,
  `importe` float(9,3) NOT NULL,
  `recargo` float(9,3) NOT NULL,
  PRIMARY KEY  (`nro_viaje`,`fecha_venc`),
  CONSTRAINT `cuotas_fk` FOREIGN KEY (`nro_viaje`) REFERENCES `viajes` (`nro_viaje`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `moviles` table : 
#

DROP TABLE IF EXISTS `moviles`;

CREATE TABLE `moviles` (
  `patente` varchar(7) NOT NULL,
  `marca` varchar(20) default NULL,
  `modelo` varchar(20) default NULL,
  `anio` int(11) default NULL,
  `fecha_ult_service` date default NULL,
  `capacidad` int(11) default NULL,
  `fecha_baja` date default NULL,
  PRIMARY KEY  (`patente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_tipos_viajes` table : 
#

DROP TABLE IF EXISTS `valores_tipos_viajes`;

CREATE TABLE `valores_tipos_viajes` (
  `cod_tipo_viaje` int(11) NOT NULL,
  `fecha_desde` date NOT NULL,
  `valor_km` float(9,3) NOT NULL,
  PRIMARY KEY  (`cod_tipo_viaje`,`fecha_desde`),
  CONSTRAINT `valores_tipos_viajes_tipos_viajes_fk` FOREIGN KEY (`cod_tipo_viaje`) REFERENCES `tipos_viajes` (`cod_tipo_viaje`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `viajes_choferes` table : 
#

DROP TABLE IF EXISTS `viajes_choferes`;

CREATE TABLE `viajes_choferes` (
  `nro_viaje` int(11) NOT NULL,
  `cuil` char(20) NOT NULL,
  PRIMARY KEY  (`nro_viaje`,`cuil`),
  KEY `viajes_choferes_choferes_fk` (`cuil`),
  CONSTRAINT `viajes_choferes_choferes_fk` FOREIGN KEY (`cuil`) REFERENCES `choferes` (`cuil`) ON UPDATE CASCADE,
  CONSTRAINT `viajes_choferes_viajes_fk` FOREIGN KEY (`nro_viaje`) REFERENCES `viajes` (`nro_viaje`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `viajes_moviles` table : 
#

DROP TABLE IF EXISTS `viajes_moviles`;

CREATE TABLE `viajes_moviles` (
  `nro_viaje` int(11) NOT NULL,
  `patente` varchar(7) NOT NULL,
  `km_ini` float(9,3) default NULL,
  `km_fin` float(9,3) default NULL,
  PRIMARY KEY  (`nro_viaje`,`patente`),
  KEY `viajes_moviles_moviles_fk` (`patente`),
  CONSTRAINT `viajes_moviles_moviles_fk` FOREIGN KEY (`patente`) REFERENCES `moviles` (`patente`) ON UPDATE CASCADE,
  CONSTRAINT `viajes_moviles_viajes_fk` FOREIGN KEY (`nro_viaje`) REFERENCES `viajes` (`nro_viaje`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `choferes` table  (LIMIT 0,500)
#

INSERT INTO `choferes` (`cuil`, `carnet`, `fecha_nac`, `nom_ape`, `telefono`, `direccion`, `email`) VALUES 
  ('12-12121212-1','3-12121212-B3','1982-06-01','Helen Keller','121-212121','San Martín 121','helen@kellerfoundation.org'),
  ('13-13131313-1','3-13131313-B3','1988-08-08','Edmund Hillary','131-313131','Cerrito 1313','edhi@gmail.com'),
  ('14-14141414-1','3-14141414-B5','1972-02-03','Marya Saloméa Sktodowska Boguska','141-414141','Francia 141 Bis','radioactivo@gmail.com'),
  ('15-15151515-1','3-15151515-B5','1980-02-29','Blaise Pascal','151-515151','Cordoba 1515',NULL),
  ('16-16161616-1','3-16161616-b5','1976-08-14','Victor Hugo','161-616161','España 1616',NULL);

COMMIT;

#
# Data for the `clientes` table  (LIMIT 0,500)
#

INSERT INTO `clientes` (`cuit`, `denominacion`, `telefono`, `direccion`, `email`) VALUES 
  ('11-11111111-1','Reuniones Improvisadas','111-111111','H. Quintana 1111','contacto@reunionesimprovisadas.com.ar'),
  ('22-22222222-2','Club Viejos Amigos','222-222222','Viedma 2222','compras@clubva.com.ar'),
  ('33-33333333-3','Taller El Desarmadero','333-333333','Grandoli 3333','desarmar@argentina.com.ar'),
  ('44-44444444-4','Avicenna','444-444444','Arijon 444 bis','avicena@gmail.com');

COMMIT;

#
# Data for the `turnos` table  (LIMIT 0,500)
#

INSERT INTO `turnos` (`cod_turno`, `desc_turno`, `hora_desde`, `hora_hasta`) VALUES 
  (1,'Matutino','06:00:00','14:00:00'),
  (2,'Vespertino','14:00:00','22:00:00'),
  (3,'Nocturno','22:00:00','06:00:00');

COMMIT;

#
# Data for the `conduce_turno` table  (LIMIT 0,500)
#

INSERT INTO `conduce_turno` (`cuil`, `cod_turno`, `fecha_turno`) VALUES 
  ('12-12121212-1',1,'2009-07-27'),
  ('12-12121212-1',1,'2009-10-05'),
  ('13-13131313-1',1,'2009-07-22'),
  ('13-13131313-1',1,'2009-09-24'),
  ('14-14141414-1',1,'2009-07-17'),
  ('14-14141414-1',1,'2009-07-24'),
  ('15-15151515-1',1,'2009-07-31'),
  ('15-15151515-1',1,'2009-08-14'),
  ('15-15151515-1',1,'2009-08-22'),
  ('15-15151515-1',1,'2009-08-30'),
  ('15-15151515-1',1,'2009-09-01'),
  ('15-15151515-1',1,'2009-09-04'),
  ('15-15151515-1',1,'2009-09-19'),
  ('15-15151515-1',1,'2009-09-30'),
  ('16-16161616-1',1,'2009-09-30'),
  ('12-12121212-1',2,'2009-08-14'),
  ('12-12121212-1',2,'2009-08-22'),
  ('12-12121212-1',2,'2009-09-04'),
  ('12-12121212-1',2,'2009-09-24'),
  ('13-13131313-1',2,'2009-07-17'),
  ('13-13131313-1',2,'2009-07-31'),
  ('13-13131313-1',2,'2009-09-01'),
  ('13-13131313-1',2,'2009-09-19'),
  ('14-14141414-1',2,'2009-07-22'),
  ('14-14141414-1',2,'2009-07-27'),
  ('14-14141414-1',2,'2009-08-30'),
  ('16-16161616-1',2,'2009-07-24'),
  ('16-16161616-1',2,'2009-09-30'),
  ('12-12121212-1',3,'2009-07-17'),
  ('12-12121212-1',3,'2009-07-24'),
  ('12-12121212-1',3,'2009-09-19'),
  ('13-13131313-1',3,'2009-08-22'),
  ('13-13131313-1',3,'2009-08-30'),
  ('14-14141414-1',3,'2009-07-31'),
  ('14-14141414-1',3,'2009-08-14'),
  ('14-14141414-1',3,'2009-09-24'),
  ('16-16161616-1',3,'2009-07-22'),
  ('16-16161616-1',3,'2009-07-27'),
  ('16-16161616-1',3,'2009-09-01'),
  ('16-16161616-1',3,'2009-09-04');

COMMIT;

#
# Data for the `contratos` table  (LIMIT 0,500)
#

INSERT INTO `contratos` (`nro_contrato`, `fecha_contrato`, `observaciones`, `cuit`) VALUES 
  (1,'2009-07-08',NULL,'22-22222222-2'),
  (2,'2009-07-14',NULL,'44-44444444-4'),
  (3,'2009-07-21',NULL,'11-11111111-1'),
  (4,'2009-08-03',NULL,'22-22222222-2'),
  (5,'2009-08-22','NO quiere que salga tarde el viaje','44-44444444-4'),
  (6,'2009-09-03',NULL,'33-33333333-3'),
  (7,'2009-09-24',NULL,'11-11111111-1'),
  (8,'2009-09-29',NULL,'22-22222222-2');

COMMIT;

#
# Data for the `tipos_viajes` table  (LIMIT 0,500)
#

INSERT INTO `tipos_viajes` (`cod_tipo_viaje`, `desc_tipo_viaje`) VALUES 
  (1,'Urbano'),
  (2,'Corta Distancia'),
  (3,'Media Distancia'),
  (4,'Nacional');

COMMIT;

#
# Data for the `viajes` table  (LIMIT 0,500)
#

INSERT INTO `viajes` (`nro_viaje`, `fecha_ini`, `hora_ini`, `cant_pasajeros`, `fecha_fin`, `hora_fin`, `destinos`, `fecha_reserva`, `hora_reserva`, `duracion_est`, `km_estimados`, `importe`, `estado`, `origen`, `nro_contrato`, `cuil`, `cod_turno`, `fecha_turno`, `cod_tipo_viaje`, `fecha_cancelacion`) VALUES 
  (1,'2009-07-17','15:00:00',3,'2009-07-17','18:00:00','Quilmes',NULL,NULL,3,270,800,'Terminado','Pellegrini 111',NULL,'13-13131313-1',2,'2009-07-17',NULL,NULL),
  (2,'2009-07-22','11:00:00',3,'2009-07-23','06:00:00','Neuquen, Bariloche','2009-07-08','08:00:00',20,1800,15000,'Terminado',NULL,1,NULL,NULL,NULL,NULL,NULL),
  (3,'2009-07-24','03:00:00',1,'2009-07-25','17:00:00','Neuquen, Rosario',NULL,NULL,36,3240,32400,'Terminado','Italia 3333',NULL,'12-12121212-1',3,'2009-07-24',4,NULL),
  (4,'2009-07-24','08:00:00',12,'2009-07-25','02:00:00','Rawson',NULL,NULL,18,1620,16200,'Terminado','Bv. Seguí 4444',NULL,'14-14141414-1',1,'2009-07-24',4,NULL),
  (5,'2009-07-27','08:00:00',1,'2009-07-29','13:00:00','Neuquen, Bariloche, Villa La Angostura, Rosario','2009-07-14','10:00:00',50,4500,40000,'Terminado',NULL,2,NULL,NULL,NULL,NULL,NULL),
  (6,'2009-07-31','12:30:00',6,'2009-08-01','09:40:00','Iguazú, Ciudad del Este','2009-07-21','12:00:00',20,1800,16000,'Terminado',NULL,3,NULL,NULL,NULL,NULL,NULL),
  (7,'2009-08-14','08:00:00',12,'2009-08-16','20:25:00','Neuquen, Mendoza, Rosario','2009-08-03','09:00:00',60,5400,50000,'Terminado',NULL,4,NULL,NULL,NULL,NULL,NULL),
  (8,'2009-08-22','08:30:00',1,'2009-08-22','09:00:00','General Motors','2009-08-22','15:00:00',0.7,28,42,'Terminado',NULL,5,NULL,NULL,NULL,NULL,NULL),
  (9,'2009-08-30','23:00:00',32,'2009-09-01','07:00:00','La Plata, Rosario',NULL,NULL,8,720,3960,'Terminado','España 999',NULL,'13-13131313-1',3,'2009-08-30',3,NULL),
  (10,'2009-09-01','14:00:00',2,'2009-09-03','19:00:00','Zarate, Rosario',NULL,NULL,5.5,495,2722.5,'Terminado','Bs As 1010',NULL,'13-13131313-1',2,'2009-09-01',3,NULL),
  (11,'2009-09-04','12:00:00',2,'2009-09-05','06:45:00','San Martín de los Andes, Bariloche',NULL,NULL,20,1800,27000,'Terminado','Francia 1111',NULL,'15-15151515-1',1,'2009-09-04',4,NULL),
  (12,'2009-09-19','18:00:00',13,'2009-09-19','20:00:00','Villa Gdor Galvez, Roldan',NULL,NULL,2,80,486.4,'Terminado','Tucuman 121',NULL,'13-13131313-1',2,'2009-09-19',2,NULL),
  (13,'2009-09-24','10:00:00',40,'2009-09-25','08:00:00','Mendoza, San Juan, Mendoza, Rosario','2009-09-03','07:00:00',24,2160,22000,'Terminado',NULL,6,NULL,NULL,NULL,NULL,NULL),
  (14,'2009-10-01','12:00:00',2,NULL,NULL,'Bariloche','2009-09-03','07:10:00',18,1620,16000,'Pendiente',NULL,6,NULL,NULL,NULL,NULL,NULL),
  (15,'2009-10-01','08:00:00',1,NULL,NULL,'Roldan','2009-09-24','14:00:00',1,40,60,'Pendiente',NULL,7,NULL,NULL,NULL,NULL,NULL),
  (16,'2009-10-05','08:00:00',1,NULL,NULL,'Roldan','2009-09-29','09:00:00',1,40,60,'Cancelado',NULL,8,NULL,NULL,NULL,NULL,'2009-09-30'),
  (17,'2009-09-30','07:00:00',2,'2009-09-30','15:00:00','Sgo del Estero',NULL,NULL,9,810,NULL,'En Proceso','Arijon 171',NULL,'16-16161616-1',1,'2009-09-30',3,NULL);

COMMIT;

#
# Data for the `cuotas` table  (LIMIT 0,500)
#

INSERT INTO `cuotas` (`nro_viaje`, `fecha_venc`, `fecha_pago`, `importe`, `recargo`) VALUES 
  (2,'2009-07-08','2009-07-04',3000,637.2),
  (2,'2009-08-08','2009-08-13',3000,649.305),
  (2,'2009-09-08','2009-09-09',3000,763.842),
  (2,'2009-10-08',NULL,3000,819.793),
  (2,'2009-11-08',NULL,3000,739.956),
  (5,'2009-08-14','2009-08-19',8000,2177.709),
  (5,'2009-09-14','2009-09-11',8000,1859.544),
  (5,'2009-10-14',NULL,8000,1896.533),
  (5,'2009-11-14',NULL,8000,1947.175),
  (5,'2009-12-14',NULL,8000,1841.558),
  (6,'2009-07-21','2009-07-22',3200,669.51),
  (6,'2009-08-21','2009-08-17',3200,717.259),
  (6,'2009-09-21',NULL,3200,719.644),
  (6,'2009-10-21',NULL,3200,783.635),
  (6,'2009-11-21',NULL,3200,654.951),
  (7,'2009-08-03','2009-08-08',10000,2969.324),
  (7,'2009-09-03','2009-09-04',10000,2088.008),
  (7,'2009-10-03','2009-09-30',10000,2809.005),
  (7,'2009-11-03',NULL,10000,2192.335),
  (7,'2009-12-03',NULL,10000,2982.007),
  (8,'2009-09-22','2009-09-25',8.4,2.099),
  (8,'2009-10-22',NULL,8.4,1.79),
  (8,'2009-11-22',NULL,8.4,2.196),
  (8,'2009-12-22',NULL,8.4,1.88),
  (8,'2010-01-22',NULL,8.4,2.155),
  (13,'2009-09-03','2009-09-03',4400,1070.359),
  (13,'2009-10-03',NULL,4400,1185.298),
  (13,'2009-11-03',NULL,4400,972.389),
  (13,'2009-12-03',NULL,4400,1296.591),
  (13,'2010-01-03',NULL,4400,1177.833),
  (14,'2009-09-03',NULL,3200,939.316),
  (14,'2009-10-03',NULL,3200,860.798),
  (14,'2009-11-03',NULL,3200,899.061),
  (14,'2009-12-03',NULL,3200,786.419),
  (14,'2010-01-03',NULL,3200,871.139),
  (15,'2009-10-24',NULL,12,3.438),
  (15,'2009-11-24',NULL,12,2.99),
  (15,'2009-12-24',NULL,12,2.607),
  (15,'2010-01-24',NULL,12,3.158),
  (15,'2010-02-24',NULL,12,2.766),
  (16,'2009-09-29',NULL,12,2.72),
  (16,'2009-10-29',NULL,12,2.674),
  (16,'2009-11-29',NULL,12,2.473),
  (16,'2009-12-29',NULL,12,2.591),
  (16,'2010-01-29',NULL,12,3.005);

COMMIT;

#
# Data for the `moviles` table  (LIMIT 0,500)
#

INSERT INTO `moviles` (`patente`, `marca`, `modelo`, `anio`, `fecha_ult_service`, `capacidad`, `fecha_baja`) VALUES 
  ('APB 333','Wolksvagen','Gol',1995,'2008-08-04',4,NULL),
  ('FGD 111','Mercedez Benz','Sprinter',2008,'2009-02-09',20,NULL),
  ('HDP 666','Marcopolo Scania','K 380',2009,NULL,60,NULL),
  ('OQL 222','Fiat','Duna',1993,'1993-02-01',3,'1993-02-02'),
  ('TQM 999','Chevrolet','Impala',1972,'1973-02-01',4,NULL),
  ('VSS 777','Marcopolo Scania','K 112',1994,'1998-02-08',30,'1998-02-09');

COMMIT;

#
# Data for the `valores_tipos_viajes` table  (LIMIT 0,500)
#

INSERT INTO `valores_tipos_viajes` (`cod_tipo_viaje`, `fecha_desde`, `valor_km`) VALUES 
  (1,'2009-06-04',1),
  (1,'2009-07-16',1.1),
  (1,'2009-08-19',1.6),
  (1,'2009-09-19',1.9),
  (1,'2009-10-11',2.1),
  (2,'2009-06-04',3.2),
  (2,'2009-07-19',3.52),
  (2,'2009-09-01',5.12),
  (2,'2009-09-15',6.08),
  (3,'2009-07-18',5.5),
  (3,'2009-09-16',7.5),
  (3,'2009-11-19',10),
  (4,'2009-07-01',10),
  (4,'2009-08-15',15);

COMMIT;

#
# Data for the `viajes_choferes` table  (LIMIT 0,500)
#

INSERT INTO `viajes_choferes` (`nro_viaje`, `cuil`) VALUES 
  (6,'12-12121212-1'),
  (14,'12-12121212-1'),
  (5,'13-13131313-1'),
  (7,'13-13131313-1'),
  (15,'13-13131313-1'),
  (8,'14-14141414-1'),
  (16,'14-14141414-1'),
  (2,'15-15151515-1'),
  (5,'15-15151515-1'),
  (13,'15-15151515-1'),
  (7,'16-16161616-1'),
  (13,'16-16161616-1');

COMMIT;

#
# Data for the `viajes_moviles` table  (LIMIT 0,500)
#

INSERT INTO `viajes_moviles` (`nro_viaje`, `patente`, `km_ini`, `km_fin`) VALUES 
  (1,'APB 333',80000,80408),
  (2,'TQM 999',220987,222038),
  (3,'OQL 222',120000,121987),
  (4,'VSS 777',400982,403335),
  (5,'APB 333',80408,82576),
  (6,'FGD 111',0,1237),
  (7,'VSS 777',403335,408879),
  (8,'TQM 999',223000,223012),
  (9,'HDP 666',43987,45087),
  (10,'APB 333',82576,83110),
  (11,'OQL 222',122000,123345),
  (12,'FGD 111',1237,1351),
  (13,'HDP 666',45087,49375),
  (14,'TQM 999',NULL,NULL),
  (15,'APB 333',NULL,NULL),
  (16,'APB 333',NULL,NULL),
  (17,'TQM 999',NULL,NULL);

COMMIT;

