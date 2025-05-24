# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : pronto_service


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `pronto_service`;

CREATE DATABASE `pronto_service`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `pronto_service`;

#
# Structure for the `maquinarias` table : 
#

DROP TABLE IF EXISTS `maquinarias`;

CREATE TABLE `maquinarias` (
  `nro_serie` int(11) NOT NULL,
  `fecha_compra` date NOT NULL,
  `anio_fabricacion` int(11) NOT NULL,
  `tipo_maquina` varchar(20) NOT NULL,
  `precio_compra` float(9,3) NOT NULL,
  `nro_poliza` int(11) default NULL,
  `cia_poliza` varchar(20) default NULL,
  `valor_asegurado` float(9,3) default NULL,
  PRIMARY KEY  (`nro_serie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `personas` table : 
#

DROP TABLE IF EXISTS `personas`;

CREATE TABLE `personas` (
  `cuit` varchar(20) NOT NULL,
  `nomyape` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  PRIMARY KEY  (`cuit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `contratos` table : 
#

DROP TABLE IF EXISTS `contratos`;

CREATE TABLE `contratos` (
  `nro_contrato` int(11) NOT NULL,
  `importe` float(9,3) NOT NULL,
  `fecha` date NOT NULL,
  `fecha_pago_limite` date NOT NULL,
  `fecha_pago` date default NULL,
  `cuit_cliente` varchar(20) NOT NULL,
  `nro_serie_maquina` int(11) NOT NULL,
  `fecha_inicio_arren` date default NULL,
  `fecha_fin_arren` date default NULL,
  PRIMARY KEY  (`nro_contrato`),
  KEY `contrato_maquinaria_fk` (`nro_serie_maquina`),
  KEY `contrato_personas_fk` (`cuit_cliente`),
  CONSTRAINT `contrato_maquinaria_fk` FOREIGN KEY (`nro_serie_maquina`) REFERENCES `maquinarias` (`nro_serie`) ON UPDATE CASCADE,
  CONSTRAINT `contrato_personas_fk` FOREIGN KEY (`cuit_cliente`) REFERENCES `personas` (`cuit`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `servicios` table : 
#

DROP TABLE IF EXISTS `servicios`;

CREATE TABLE `servicios` (
  `cod_servicio` int(11) NOT NULL,
  `descripcion` varchar(20) NOT NULL,
  `observacion` varchar(50) default NULL,
  PRIMARY KEY  (`cod_servicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `contrata_abono` table : 
#

DROP TABLE IF EXISTS `contrata_abono`;

CREATE TABLE `contrata_abono` (
  `nro_contrato` int(11) NOT NULL,
  `cod_servicio` int(11) NOT NULL,
  `horas_contratadas` float(9,3) default NULL,
  PRIMARY KEY  (`nro_contrato`,`cod_servicio`),
  KEY `contrata_abono_servicios_fk` (`cod_servicio`),
  CONSTRAINT `contrata_abono_contrato_fk` FOREIGN KEY (`nro_contrato`) REFERENCES `contratos` (`nro_contrato`) ON UPDATE CASCADE,
  CONSTRAINT `contrata_abono_servicios_fk` FOREIGN KEY (`cod_servicio`) REFERENCES `servicios` (`cod_servicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `consumos` table : 
#

DROP TABLE IF EXISTS `consumos`;

CREATE TABLE `consumos` (
  `nro_contrato` int(11) NOT NULL,
  `cod_servicio` int(11) NOT NULL,
  `fecha_consumo` date NOT NULL,
  `horas_consumidas` float(9,3) NOT NULL,
  PRIMARY KEY  (`nro_contrato`,`cod_servicio`,`fecha_consumo`),
  CONSTRAINT `consumos_contrata_abonofk` FOREIGN KEY (`nro_contrato`, `cod_servicio`) REFERENCES `contrata_abono` (`nro_contrato`, `cod_servicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `cuotas` table : 
#

DROP TABLE IF EXISTS `cuotas`;

CREATE TABLE `cuotas` (
  `nro_contrato` int(11) NOT NULL,
  `cod_servicio` int(11) NOT NULL,
  `anio` int(11) NOT NULL,
  `mes` int(11) NOT NULL,
  `fecha_pago` date default NULL,
  `importe` float(9,3) NOT NULL,
  PRIMARY KEY  (`nro_contrato`,`cod_servicio`,`anio`,`mes`),
  CONSTRAINT `cuotas_contrata_abono_fk` FOREIGN KEY (`nro_contrato`, `cod_servicio`) REFERENCES `contrata_abono` (`nro_contrato`, `cod_servicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `garante_contrato` table : 
#

DROP TABLE IF EXISTS `garante_contrato`;

CREATE TABLE `garante_contrato` (
  `cuit_garante` varchar(20) NOT NULL,
  `nro_contrato` int(11) NOT NULL,
  PRIMARY KEY  (`cuit_garante`,`nro_contrato`),
  KEY `garante_contrato_contrato_fk` (`nro_contrato`),
  CONSTRAINT `garante_contrato_contrato_fk` FOREIGN KEY (`nro_contrato`) REFERENCES `contratos` (`nro_contrato`) ON UPDATE CASCADE,
  CONSTRAINT `garante_contrato_garante_fk` FOREIGN KEY (`cuit_garante`) REFERENCES `personas` (`cuit`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `utiliza_servicios` table : 
#

DROP TABLE IF EXISTS `utiliza_servicios`;

CREATE TABLE `utiliza_servicios` (
  `nro_contrato` int(11) NOT NULL,
  `cod_servicio` int(11) NOT NULL,
  `fecha_utilizado` date NOT NULL,
  `horas_utilizadas` float(9,3) default NULL,
  `fecha_pago` date default NULL,
  PRIMARY KEY  (`nro_contrato`,`cod_servicio`,`fecha_utilizado`),
  KEY `utiliza_servicios_servicios_fk` (`cod_servicio`),
  CONSTRAINT `utiliza_servicios_contrato_fk` FOREIGN KEY (`nro_contrato`) REFERENCES `contratos` (`nro_contrato`) ON UPDATE CASCADE,
  CONSTRAINT `utiliza_servicios_servicios_fk` FOREIGN KEY (`cod_servicio`) REFERENCES `servicios` (`cod_servicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_servicios` table : 
#

DROP TABLE IF EXISTS `valores_servicios`;

CREATE TABLE `valores_servicios` (
  `cod_servicio` int(11) NOT NULL,
  `fecha_desde` date NOT NULL,
  `importe` float(9,3) NOT NULL,
  PRIMARY KEY  (`cod_servicio`,`fecha_desde`),
  CONSTRAINT `valores_servicios_servicios_fk` FOREIGN KEY (`cod_servicio`) REFERENCES `servicios` (`cod_servicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `maquinarias` table  (LIMIT 0,500)
#

INSERT INTO `maquinarias` (`nro_serie`, `fecha_compra`, `anio_fabricacion`, `tipo_maquina`, `precio_compra`, `nro_poliza`, `cia_poliza`, `valor_asegurado`) VALUES 
  (1222,'2004-05-09',2004,'FUMIGADORA',235000,9999,'San Cristóbal',NULL),
  (1233,'2006-01-12',2005,'EXCAVADORA',250000,8888,'San Cristóbal',200000),
  (1234,'2005-01-12',2004,' COSECHADORA',340000,7777,'La Segunda',310000),
  (3456,'2003-09-08',2003,'COSECHADORA',230000,1000,'La Segunda',NULL);

COMMIT;

#
# Data for the `personas` table  (LIMIT 0,500)
#

INSERT INTO `personas` (`cuit`, `nomyape`, `direccion`, `telefono`) VALUES 
  ('26-11111111-0','Marya Saloméa Sktodowska Boguska','Buenos Aires 239 4º C','4956321'),
  ('27-22222222-0','Helen Keller','San Martín 6107','4956321'),
  ('27-33333333-0','Edmund Hillary','Everest 1111','4874962'),
  ('27-44444444-0','Tenzing Norgay','Chomolungma','4885264'),
  ('27-99999999-0','Perez Jose','Dorrego 888','4766889');

COMMIT;

#
# Data for the `contratos` table  (LIMIT 0,500)
#

INSERT INTO `contratos` (`nro_contrato`, `importe`, `fecha`, `fecha_pago_limite`, `fecha_pago`, `cuit_cliente`, `nro_serie_maquina`, `fecha_inicio_arren`, `fecha_fin_arren`) VALUES 
  (1,2000,'2007-10-01','2007-12-01','2007-11-12','27-44444444-0',1234,'2007-10-07','2007-12-31'),
  (2,3000,'2008-03-01','2008-05-01','2008-04-01','27-33333333-0',3456,'2008-03-15','2008-04-30'),
  (3,1500,'2008-03-01','2008-05-01','2008-05-15','27-99999999-0',1233,'2008-04-15','2008-04-30'),
  (4,5000,'2008-03-15','2008-05-10',NULL,'27-33333333-0',1234,'2008-04-01','2008-05-30'),
  (5,1000,'2008-05-12','2008-07-12',NULL,'26-11111111-0',3456,'2008-05-15','2008-08-20');

COMMIT;

#
# Data for the `servicios` table  (LIMIT 0,500)
#

INSERT INTO `servicios` (`cod_servicio`, `descripcion`, `observacion`) VALUES 
  (1,'REPARACION 24x7','ABONO'),
  (2,'REEMPLAZO INMEDIATO','DIRECTO'),
  (3,'MANTEN.PREVENTIVO','ABONO'),
  (4,'PUESTA A PUNTO','ABONO');

COMMIT;

#
# Data for the `contrata_abono` table  (LIMIT 0,500)
#

INSERT INTO `contrata_abono` (`nro_contrato`, `cod_servicio`, `horas_contratadas`) VALUES 
  (1,1,10),
  (1,2,NULL),
  (2,1,15),
  (2,3,10),
  (3,1,10),
  (5,1,9);

COMMIT;

#
# Data for the `consumos` table  (LIMIT 0,500)
#

INSERT INTO `consumos` (`nro_contrato`, `cod_servicio`, `fecha_consumo`, `horas_consumidas`) VALUES 
  (1,1,'2007-10-24',2),
  (1,1,'2007-10-27',3.46),
  (1,1,'2007-10-30',1.7),
  (2,1,'2008-04-01',1.86),
  (2,1,'2008-04-07',2.55),
  (2,3,'2008-04-01',1.24),
  (2,3,'2008-04-04',3.46),
  (2,3,'2008-04-07',1.7),
  (3,1,'2008-04-21',1.44),
  (3,1,'2008-04-24',3.46),
  (3,1,'2008-05-25',5.1),
  (5,1,'2008-06-04',3.114),
  (5,1,'2008-06-07',1.53);

COMMIT;

#
# Data for the `cuotas` table  (LIMIT 0,500)
#

INSERT INTO `cuotas` (`nro_contrato`, `cod_servicio`, `anio`, `mes`, `fecha_pago`, `importe`) VALUES 
  (1,1,2007,10,'2007-10-10',40),
  (1,1,2007,11,'2007-11-10',40),
  (1,1,2007,12,'2007-12-10',40),
  (1,2,2007,10,'2007-10-10',60),
  (1,2,2007,11,'2007-11-10',60),
  (1,2,2007,12,'2007-12-10',60),
  (2,1,2008,3,'2007-03-15',100),
  (2,1,2008,4,NULL,100),
  (2,3,2008,3,'2008-03-15',70),
  (2,3,2008,4,NULL,70),
  (3,1,2008,4,NULL,140),
  (5,1,2008,6,NULL,40),
  (5,1,2008,7,NULL,40);

COMMIT;

#
# Data for the `garante_contrato` table  (LIMIT 0,500)
#

INSERT INTO `garante_contrato` (`cuit_garante`, `nro_contrato`) VALUES 
  ('26-11111111-0',1),
  ('27-22222222-0',2),
  ('27-33333333-0',3),
  ('27-44444444-0',4),
  ('27-33333333-0',5);

COMMIT;

#
# Data for the `utiliza_servicios` table  (LIMIT 0,500)
#

INSERT INTO `utiliza_servicios` (`nro_contrato`, `cod_servicio`, `fecha_utilizado`, `horas_utilizadas`, `fecha_pago`) VALUES 
  (3,2,'2008-04-10',12,NULL),
  (4,1,'2008-04-15',10,NULL),
  (4,4,'2008-04-01',4,'2008-04-08');

COMMIT;

#
# Data for the `valores_servicios` table  (LIMIT 0,500)
#

INSERT INTO `valores_servicios` (`cod_servicio`, `fecha_desde`, `importe`) VALUES 
  (1,'2007-10-01',14),
  (1,'2008-04-01',15),
  (1,'2008-06-01',17),
  (2,'2007-10-01',10),
  (2,'2008-05-01',12),
  (3,'2007-10-01',16),
  (3,'2008-04-15',20),
  (4,'2007-10-01',15),
  (4,'2008-05-10',19),
  (4,'2008-09-17',24);

COMMIT;

