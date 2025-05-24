# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : desarmadero


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `desarmadero`;

CREATE DATABASE `desarmadero`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `desarmadero`;

#
# Structure for the `clientes` table : 
#

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `cuil` varchar(20) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(50) default NULL,
  `razon_social` varchar(20) NOT NULL,
  PRIMARY KEY  (`cuil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `planes_matenimiento` table : 
#

DROP TABLE IF EXISTS `planes_matenimiento`;

CREATE TABLE `planes_matenimiento` (
  `cod_plan` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `periodo` int(11) NOT NULL default '1',
  PRIMARY KEY  (`cod_plan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `marcas` table : 
#

DROP TABLE IF EXISTS `marcas`;

CREATE TABLE `marcas` (
  `cod_marca` int(11) NOT NULL,
  `desc_marca` varchar(20) NOT NULL,
  PRIMARY KEY  (`cod_marca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `modelos` table : 
#

DROP TABLE IF EXISTS `modelos`;

CREATE TABLE `modelos` (
  `cod_marca` int(11) NOT NULL,
  `nom_modelo` varchar(20) NOT NULL,
  PRIMARY KEY  (`cod_marca`,`nom_modelo`),
  KEY `cod_marca` (`cod_marca`),
  CONSTRAINT `modelos_marcas_fk` FOREIGN KEY (`cod_marca`) REFERENCES `marcas` (`cod_marca`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `vehiculos` table : 
#

DROP TABLE IF EXISTS `vehiculos`;

CREATE TABLE `vehiculos` (
  `patente` varchar(7) NOT NULL,
  `anio_fabric` int(11) NOT NULL,
  `nro_chasis` varchar(20) NOT NULL,
  `nro_motor` varchar(20) NOT NULL,
  `cuil` varchar(20) NOT NULL,
  `cod_marca` int(11) default NULL,
  `nom_modelo` varchar(20) default NULL,
  PRIMARY KEY  (`patente`),
  KEY `vehiculos_clientes_fk` (`cuil`),
  KEY `vehiculos_modelos_fk` (`cod_marca`,`nom_modelo`),
  CONSTRAINT `vehiculos_clientes_fk` FOREIGN KEY (`cuil`) REFERENCES `clientes` (`cuil`) ON UPDATE CASCADE,
  CONSTRAINT `vehiculos_modelos_fk` FOREIGN KEY (`cod_marca`, `nom_modelo`) REFERENCES `modelos` (`cod_marca`, `nom_modelo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `contrata` table : 
#

DROP TABLE IF EXISTS `contrata`;

CREATE TABLE `contrata` (
  `patente` varchar(7) NOT NULL,
  `cod_plan` int(11) NOT NULL,
  `fecha_desde` date NOT NULL,
  `cantidad_periodos` int(11) NOT NULL,
  `importe_pactado` decimal(11,2) NOT NULL,
  PRIMARY KEY  (`patente`,`cod_plan`,`fecha_desde`),
  KEY `contrata_planes_fk` (`cod_plan`),
  CONSTRAINT `contrata_planes_fk` FOREIGN KEY (`cod_plan`) REFERENCES `planes_matenimiento` (`cod_plan`) ON UPDATE CASCADE,
  CONSTRAINT `contrata_vehículos_fk` FOREIGN KEY (`patente`) REFERENCES `vehiculos` (`patente`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `partes` table : 
#

DROP TABLE IF EXISTS `partes`;

CREATE TABLE `partes` (
  `cod_parte` int(11) NOT NULL,
  `desc_parte` varchar(20) NOT NULL,
  PRIMARY KEY  (`cod_parte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `partes_modelo` table : 
#

DROP TABLE IF EXISTS `partes_modelo`;

CREATE TABLE `partes_modelo` (
  `cod_parte` int(11) NOT NULL,
  `cod_marca` int(11) NOT NULL,
  `nom_modelo` varchar(20) NOT NULL,
  `tipo` varchar(20) default NULL,
  PRIMARY KEY  (`cod_parte`,`cod_marca`,`nom_modelo`),
  KEY `partes_modelo_modelos_fk` (`cod_marca`,`nom_modelo`),
  CONSTRAINT `partes_modelo_modelos_fk` FOREIGN KEY (`cod_marca`, `nom_modelo`) REFERENCES `modelos` (`cod_marca`, `nom_modelo`) ON UPDATE CASCADE,
  CONSTRAINT `partes_modelo_partes_fk` FOREIGN KEY (`cod_parte`) REFERENCES `partes` (`cod_parte`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `service` table : 
#

DROP TABLE IF EXISTS `service`;

CREATE TABLE `service` (
  `patente` varchar(7) NOT NULL,
  `fecha_hora_service` datetime NOT NULL,
  `localidad` varchar(20) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `fecha_hora_fin_est` datetime default NULL,
  `fecha_hora_fin_real` datetime default NULL,
  `fecha_hora_retiro` datetime default NULL,
  `observaciones` varchar(500) default NULL,
  `motivo` varchar(500) default NULL,
  `diagnostico` varchar(500) default NULL,
  `reparaciones` varchar(500) default NULL,
  `hs_hombre` int(11) default NULL,
  `fecha_hora_entrega` datetime default NULL,
  `estado` varchar(50) default NULL,
  `cod_plan` int(11) default NULL,
  PRIMARY KEY  (`patente`,`fecha_hora_service`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `partes_service` table : 
#

DROP TABLE IF EXISTS `partes_service`;

CREATE TABLE `partes_service` (
  `cod_parte` int(11) NOT NULL,
  `patente` varchar(7) NOT NULL,
  `fecha_hora_service` datetime NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY  (`cod_parte`,`patente`,`fecha_hora_service`),
  KEY `partes_service_service_fk` (`patente`,`fecha_hora_service`),
  CONSTRAINT `partes_service_partes_fk` FOREIGN KEY (`cod_parte`) REFERENCES `partes` (`cod_parte`) ON UPDATE CASCADE,
  CONSTRAINT `partes_service_service_fk` FOREIGN KEY (`patente`, `fecha_hora_service`) REFERENCES `service` (`patente`, `fecha_hora_service`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `precio_hora` table : 
#

DROP TABLE IF EXISTS `precio_hora`;

CREATE TABLE `precio_hora` (
  `fecha_desde_hora` date NOT NULL,
  `valor_hora` decimal(11,0) NOT NULL,
  PRIMARY KEY  (`fecha_desde_hora`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `servicios` table : 
#

DROP TABLE IF EXISTS `servicios`;

CREATE TABLE `servicios` (
  `cod_servicio` int(11) NOT NULL,
  `desc_servicio` varchar(100) NOT NULL,
  PRIMARY KEY  (`cod_servicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `servicios_mantenimiento` table : 
#

DROP TABLE IF EXISTS `servicios_mantenimiento`;

CREATE TABLE `servicios_mantenimiento` (
  `cod_plan` int(11) NOT NULL,
  `cod_servicios` int(11) NOT NULL,
  PRIMARY KEY  (`cod_plan`,`cod_servicios`),
  KEY `servicios_mantenimiento_servicios_fk` (`cod_servicios`),
  CONSTRAINT `servicios_mantenimiento_planes_mantenimiento_fk` FOREIGN KEY (`cod_plan`) REFERENCES `planes_matenimiento` (`cod_plan`) ON UPDATE CASCADE,
  CONSTRAINT `servicios_mantenimiento_servicios_fk` FOREIGN KEY (`cod_servicios`) REFERENCES `servicios` (`cod_servicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `servicios_realizados` table : 
#

DROP TABLE IF EXISTS `servicios_realizados`;

CREATE TABLE `servicios_realizados` (
  `patente` varchar(7) NOT NULL,
  `fecha_hora_service` datetime NOT NULL,
  `cod_servicio` int(11) NOT NULL,
  PRIMARY KEY  (`patente`,`fecha_hora_service`,`cod_servicio`),
  KEY `servicios_realizados_servicios_fk` (`cod_servicio`),
  CONSTRAINT `servicios_realizados_service_fk` FOREIGN KEY (`patente`, `fecha_hora_service`) REFERENCES `service` (`patente`, `fecha_hora_service`) ON UPDATE CASCADE,
  CONSTRAINT `servicios_realizados_servicios_fk` FOREIGN KEY (`cod_servicio`) REFERENCES `servicios` (`cod_servicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `talleres` table : 
#

DROP TABLE IF EXISTS `talleres`;

CREATE TABLE `talleres` (
  `localidad` varchar(20) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `nom_encargado` varchar(50) NOT NULL,
  PRIMARY KEY  (`localidad`,`direccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_parte` table : 
#

DROP TABLE IF EXISTS `valores_parte`;

CREATE TABLE `valores_parte` (
  `cod_parte` int(11) NOT NULL,
  `fecha_desde_parte` date NOT NULL,
  `valor_parte` decimal(11,2) NOT NULL,
  PRIMARY KEY  (`cod_parte`,`fecha_desde_parte`),
  CONSTRAINT `valores_parte_parte_fk` FOREIGN KEY (`cod_parte`) REFERENCES `partes` (`cod_parte`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `clientes` table  (LIMIT 0,500)
#

INSERT INTO `clientes` (`cuil`, `direccion`, `telefono`, `email`, `razon_social`) VALUES 
  ('11-11111111-1','Pte. Roca 1576, Rosario','111111111','semtur@rosario.gov.ar','SEMTUR'),
  ('22-22222222-2','Arijon 815, Rosario','222222222','contacto@expresoimpala.com.ar','Expreso el impala'),
  ('33-33333333-3','Sanchez Bustamante 312, Rosario','333333333','directoruta9@arnet.com.ar','Directo ruta 9'),
  ('44-44444444-4','Aeroparque Galpon 7, Bs. As.','444444444','comercial@manueltiendaleon.com.ar','Manuel Tienda Leon'),
  ('55-55555555-5','San Martin 2987, Cordoba','555555555','administracion@sierrasdecordoba.com','Sierras de Cordoba'),
  ('66-66666666-6','Av. las Heras 4908, Bs. As.','666666666','mantenimiento@urquiza.com.ar','Urquiza');

COMMIT;

#
# Data for the `planes_matenimiento` table  (LIMIT 0,500)
#

INSERT INTO `planes_matenimiento` (`cod_plan`, `nombre`, `periodo`) VALUES 
  (1,'Integral Semestral',6),
  (2,'Pack Basico Mensual',1),
  (3,'Frenos + Direccion Mensual',1),
  (4,'Integral Mensual',1),
  (5,'Pack Plus Trimestral',3);

COMMIT;

#
# Data for the `marcas` table  (LIMIT 0,500)
#

INSERT INTO `marcas` (`cod_marca`, `desc_marca`) VALUES 
  (1,'MARCOPOLO SCANIA'),
  (2,'MERCEDEZ BENZ');

COMMIT;

#
# Data for the `modelos` table  (LIMIT 0,500)
#

INSERT INTO `modelos` (`cod_marca`, `nom_modelo`) VALUES 
  (1,'AAAA'),
  (1,'BBBB'),
  (1,'CCCC'),
  (2,'DDDD'),
  (2,'EEEE');

COMMIT;

#
# Data for the `vehiculos` table  (LIMIT 0,500)
#

INSERT INTO `vehiculos` (`patente`, `anio_fabric`, `nro_chasis`, `nro_motor`, `cuil`, `cod_marca`, `nom_modelo`) VALUES 
  ('AAA 333',1995,'22222222222222','222222222222222','22-22222222-2',2,'DDDD'),
  ('BBB 555',1996,'33333333333333','333333333333333','33-33333333-3',2,'DDDD'),
  ('CCC 666',1998,'44444444444444','444444444444444','44-44444444-4',1,'AAAA'),
  ('DDD 777',2001,'55555555555555','555555555555555','55-55555555-5',1,'CCCC'),
  ('EEE 888',2003,'66666666666666','666666666666666','66-66666666-6',2,'DDDD'),
  ('FFF 444',2005,'22222222222233','222222222222233','22-22222222-2',1,'CCCC'),
  ('FFF 999',2004,'66666666666677','666666666666677','66-66666666-6',2,'EEEE'),
  ('GGG 111',2007,'11111111111111','111111111111111','11-11111111-1',1,'AAAA'),
  ('HHH 222',2008,'11111111111122','111111111111122','11-11111111-1',1,'BBBB');

COMMIT;

#
# Data for the `contrata` table  (LIMIT 0,500)
#

INSERT INTO `contrata` (`patente`, `cod_plan`, `fecha_desde`, `cantidad_periodos`, `importe_pactado`) VALUES 
  ('AAA 333',4,'2011-10-01',6,6000),
  ('EEE 888',4,'2011-10-09',12,10000),
  ('FFF 444',3,'2011-10-05',12,4000),
  ('FFF 444',5,'2011-10-08',4,6000),
  ('GGG 111',1,'2011-10-11',3,5000),
  ('GGG 111',2,'2011-10-10',6,3000),
  ('HHH 222',1,'2011-10-02',3,3800),
  ('HHH 222',3,'2011-10-03',12,4000);

COMMIT;

#
# Data for the `partes` table  (LIMIT 0,500)
#

INSERT INTO `partes` (`cod_parte`, `desc_parte`) VALUES 
  (1,'parte I'),
  (2,'parte II'),
  (3,'parte III'),
  (4,'parte IV'),
  (5,'parte V'),
  (6,'parte VI'),
  (7,'parte VII'),
  (8,'parte VIII'),
  (9,'parte IX'),
  (10,'parte X');

COMMIT;

#
# Data for the `partes_modelo` table  (LIMIT 0,500)
#

INSERT INTO `partes_modelo` (`cod_parte`, `cod_marca`, `nom_modelo`, `tipo`) VALUES 
  (1,1,'AAAA','original'),
  (1,1,'BBBB','original'),
  (1,2,'DDDD','compatible'),
  (2,1,'AAAA','compatible'),
  (2,1,'BBBB','compatible'),
  (2,2,'DDDD','original'),
  (3,1,'AAAA','compatible'),
  (3,1,'BBBB','original'),
  (3,2,'DDDD','compatible'),
  (4,1,'AAAA','original'),
  (4,1,'BBBB','original'),
  (4,1,'CCCC','original'),
  (4,2,'DDDD','compatible'),
  (4,2,'EEEE','compatible'),
  (5,1,'CCCC','compatible'),
  (5,2,'DDDD','original'),
  (5,2,'EEEE','original'),
  (6,1,'CCCC','compatible'),
  (6,2,'DDDD','original'),
  (6,2,'EEEE','original'),
  (7,1,'AAAA','original'),
  (7,2,'EEEE','compatible'),
  (8,1,'AAAA','original'),
  (8,2,'EEEE','compatible'),
  (9,1,'AAAA','compatible'),
  (9,2,'EEEE','original'),
  (10,1,'AAAA','compatible'),
  (10,2,'EEEE','compatible');

COMMIT;

#
# Data for the `service` table  (LIMIT 0,500)
#

INSERT INTO `service` (`patente`, `fecha_hora_service`, `localidad`, `direccion`, `fecha_hora_fin_est`, `fecha_hora_fin_real`, `fecha_hora_retiro`, `observaciones`, `motivo`, `diagnostico`, `reparaciones`, `hs_hombre`, `fecha_hora_entrega`, `estado`, `cod_plan`) VALUES 
  ('AAA 333','2011-10-01 08:00:00','rosario','Arijon 461','2011-10-10 08:00:00','2011-10-08 16:00:00','2011-10-09 08:30:00','rayones en los costados. ventanas no cierran','mantenimiento preventivo','filtro obstruido','cambio aceite y filtro',24,'2011-10-03 06:00:00','cumplido con retraso',4),
  ('AAA 333','2011-11-01 08:00:00','rosario','Arijon 461','2011-11-11 08:00:00','2011-11-08 16:00:00','2011-11-09 08:30:00','rayones en los costados. ventanas no cierran','mantenimiento preventivo','perdida de presion sist. hidraulico','reemplazo partes del compresor y mangueras',28,'2011-11-01 06:00:00','cumplido',4),
  ('AAA 333','2011-12-01 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('AAA 333','2012-01-01 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('AAA 333','2012-02-01 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('AAA 333','2012-03-01 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('BBB 555','2011-10-10 08:00:00','rosario','9 de julio 4511','2011-10-25 08:00:00','2011-10-25 08:00:00','2011-10-26 08:00:00','sin observaciones','se para en baja velocidad','chicle de baja tapado','limpiar chicle de baja',1,NULL,NULL,NULL),
  ('CCC 666','2011-11-03 12:00:00','bs as','Tucuman 4299','2011-11-18 12:00:00','2011-11-22 12:00:00','2011-11-23 08:00:00','cubiertas lisas','no frena','cubiertas lisas y sin liquido de freno','cambio de cubiertas, reemplazo manguera liquido de freno y reponer liquido de freno',36,NULL,NULL,NULL),
  ('DDD 777','2011-11-20 11:00:00','cordoba','San Martin 2359','2011-11-27 11:00:00','2011-11-30 11:00:00',NULL,'rallones en el parabrisas','no se ve la calle','parabrisas dañado','cambiar parabrisas',1,NULL,NULL,NULL),
  ('EEE 888','2011-10-09 08:00:00','bs as','Cordoba 5012','2011-10-16 08:00:00','2011-10-16 16:00:00','2011-10-17 08:30:00','falta espejo retrovisor','mantenimiento preventivo','cuesta arrancar','cambio burro de arranque',64,'2011-10-09 06:00:00','cumplido',4),
  ('EEE 888','2011-11-09 08:00:00','bs as','Cordoba 5012','2011-11-16 08:00:00','2011-11-16 16:00:00','2011-11-17 08:30:00','falta espejo retrovisor','mantenimiento preventivo','frena hacia la izquierda','cambio pastillas de freno y balanceo tren delantero',59,'2011-11-09 06:00:00','cumplido',4),
  ('EEE 888','2011-12-09 08:00:00','bs as','Cordoba 5012',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('EEE 888','2012-01-09 08:00:00','bs as','Cordoba 5012',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('EEE 888','2012-02-09 08:00:00','bs as','Cordoba 5012',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('EEE 888','2012-03-09 08:00:00','bs as','Cordoba 5012',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('EEE 888','2012-04-09 08:00:00','bs as','Cordoba 5012',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('EEE 888','2012-05-09 08:00:00','bs as','Cordoba 5012',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('EEE 888','2012-06-09 08:00:00','bs as','Cordoba 5012',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('EEE 888','2012-07-09 08:00:00','bs as','Cordoba 5012',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('EEE 888','2012-08-09 08:00:00','bs as','Cordoba 5012',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('EEE 888','2012-09-09 08:00:00','bs as','Cordoba 5012',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',4),
  ('FFF 444','2011-10-05 08:00:00','rosario','Arijon 461','2011-10-14 08:00:00','2011-10-15 16:00:00','2011-10-16 08:30:00','interior arruinada. 6 asientos rotos','mantenimiento preventivo','cabecea al arrancar','puesta a punto con computadora y ajuste de luz de válvulas',25,'2011-10-06 06:00:00','cumplido con retraso',3),
  ('FFF 444','2011-10-08 08:00:00','rosario','Arijon 461','2011-10-14 08:00:00','2011-10-15 16:00:00','2011-10-16 08:30:00','interior arruinada. 6 asientos rotos','mantenimiento preventivo','cabecea al arrancar','puesta a punto con computadora y ajuste de luz de válvulas',16,'2011-10-06 06:00:00','cumplido',5),
  ('FFF 444','2011-11-05 08:00:00','rosario','Arijon 461','2011-11-14 08:00:00','2011-11-15 16:00:00','2011-11-16 08:30:00','interior arruinada. 6 asientos rotos','mantenimiento preventivo','casi no frena','cambio pastillas de freno y liquido de freno',27,'2011-11-06 06:00:00','cumplido con retraso',3),
  ('FFF 444','2011-11-08 08:00:00','rosario','Arijon 461','2011-11-14 08:00:00','2011-11-15 16:00:00','2011-11-16 08:30:00','interior arruinada. 6 asientos rotos','mantenimiento preventivo','casi no frena','cambio pastillas de freno y liquido de freno',20,'2011-11-06 06:00:00','cumplido',5),
  ('FFF 444','2011-12-05 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('FFF 444','2011-12-08 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',5),
  ('FFF 444','2012-01-05 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('FFF 444','2012-01-08 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',5),
  ('FFF 444','2012-02-05 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('FFF 444','2012-03-05 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('FFF 444','2012-04-05 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('FFF 444','2012-05-05 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('FFF 444','2012-06-05 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('FFF 444','2012-07-05 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('FFF 444','2012-08-05 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('FFF 444','2012-09-05 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('FFF 999','2011-11-23 14:00:00','bs as','Tucuman 4299','2011-12-08 17:00:00',NULL,NULL,'falta limpiaparabrisas','no se ve cuando llueve','flata limpiaparabrisas','poner limpiaparabrisas',1,NULL,NULL,NULL),
  ('GGG 111','2011-10-10 08:00:00','rosario','Arijon 461','2011-10-19 08:00:00','2011-10-18 16:00:00','2011-10-19 08:30:00','sin observaciones','mantenimiento preventivo','problemas en direccion hidraulica','reemplazo partes direccion hidraulica',15,'2011-10-10 06:00:00','cumplido',2),
  ('GGG 111','2011-10-11 08:00:00','rosario','Arijon 461','2011-10-19 08:00:00','2011-10-18 16:00:00','2011-10-19 08:30:00','sin observaciones','mantenimiento preventivo','problemas en direccion hidraulica','reemplazo partes direccion hidraulica',19,'2011-10-11 06:00:00','cumplido',1),
  ('GGG 111','2011-11-10 08:00:00','rosario','Arijon 461','2011-11-19 08:00:00','2011-11-20 16:00:00','2011-11-19 08:30:00','sin observaciones','mantenimiento preventivo','falla en ingnicion','ajuste luz de válvula',22,'2011-11-10 06:00:00','cumplido',2),
  ('GGG 111','2011-11-11 08:00:00','rosario','Arijon 461','2011-11-19 08:00:00','2011-11-20 16:00:00','2011-11-19 08:30:00','sin observaciones','mantenimiento preventivo','falla en ingnicion','ajuste luz de válvula',11,'2011-11-11 06:00:00','cumplido',1),
  ('GGG 111','2011-12-10 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',2),
  ('GGG 111','2011-12-11 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',1),
  ('GGG 111','2012-01-10 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',2),
  ('GGG 111','2012-02-10 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',2),
  ('GGG 111','2012-03-10 08:00:00','rosario','Arijon 461',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',2),
  ('HHH 222','2011-10-02 08:00:00','rosario','9 de julio 4511','2011-10-11 08:00:00','2011-10-11 16:00:00','2011-10-11 08:30:00','sin observaciones','mantenimiento preventivo','desbalanceado a la derecha','balancear tren delantero',36,'2011-10-02 06:00:00','cumplido',1),
  ('HHH 222','2011-10-03 08:00:00','rosario','9 de julio 4511','2011-10-11 08:00:00','2011-10-11 16:00:00','2011-10-11 08:30:00','sin observaciones','mantenimiento preventivo','desbalanceado a la derecha','balancear tren delantero',21,'2011-10-03 06:00:00','cumplido',3),
  ('HHH 222','2011-11-02 08:00:00','rosario','9 de julio 4511','2011-11-11 08:00:00','2011-11-13 16:00:00','2011-11-11 08:30:00','sin observaciones','mantenimiento preventivo','frena poco','cambio disco de freno',33,'2011-11-02 06:00:00','cumplido',1),
  ('HHH 222','2011-11-03 08:00:00','rosario','9 de julio 4511','2011-11-11 08:00:00','2011-11-13 16:00:00','2011-11-11 08:30:00','sin observaciones','mantenimiento preventivo','frena poco','cambio disco de freno',22,'2011-11-03 06:00:00','cumplido',3),
  ('HHH 222','2011-11-29 08:00:00','rosario','9 de julio 4511',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',1),
  ('HHH 222','2011-11-30 08:00:00','rosario','9 de julio 4511',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('HHH 222','2012-01-03 08:00:00','rosario','9 de julio 4511',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('HHH 222','2012-02-03 08:00:00','rosario','9 de julio 4511',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('HHH 222','2012-03-03 08:00:00','rosario','9 de julio 4511',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('HHH 222','2012-04-03 08:00:00','rosario','9 de julio 4511',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('HHH 222','2012-05-03 08:00:00','rosario','9 de julio 4511',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('HHH 222','2012-06-03 08:00:00','rosario','9 de julio 4511',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('HHH 222','2012-07-03 08:00:00','rosario','9 de julio 4511',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('HHH 222','2012-08-03 08:00:00','rosario','9 de julio 4511',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3),
  ('HHH 222','2012-09-03 08:00:00','rosario','9 de julio 4511',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pendiente',3);

COMMIT;

#
# Data for the `partes_service` table  (LIMIT 0,500)
#

INSERT INTO `partes_service` (`cod_parte`, `patente`, `fecha_hora_service`, `cantidad`) VALUES 
  (1,'AAA 333','2011-10-01 08:00:00',2),
  (1,'CCC 666','2011-11-03 12:00:00',2),
  (1,'EEE 888','2011-11-09 08:00:00',2),
  (1,'HHH 222','2011-11-03 08:00:00',2),
  (2,'AAA 333','2011-10-01 08:00:00',1),
  (2,'CCC 666','2011-11-03 12:00:00',1),
  (2,'EEE 888','2011-11-09 08:00:00',1),
  (3,'AAA 333','2011-11-01 08:00:00',4),
  (4,'EEE 888','2011-10-09 08:00:00',3),
  (4,'FFF 444','2011-11-08 08:00:00',3),
  (5,'AAA 333','2011-11-01 08:00:00',1),
  (5,'DDD 777','2011-11-20 11:00:00',1),
  (5,'FFF 444','2011-11-05 08:00:00',1),
  (6,'AAA 333','2011-11-01 08:00:00',2),
  (7,'CCC 666','2011-11-03 12:00:00',3),
  (7,'GGG 111','2011-10-10 08:00:00',7),
  (8,'FFF 999','2011-11-23 14:00:00',1),
  (8,'GGG 111','2011-10-11 08:00:00',4),
  (10,'GGG 111','2011-10-10 08:00:00',2);

COMMIT;

#
# Data for the `precio_hora` table  (LIMIT 0,500)
#

INSERT INTO `precio_hora` (`fecha_desde_hora`, `valor_hora`) VALUES 
  ('2011-10-01',60),
  ('2011-11-01',70),
  ('2011-12-01',85);

COMMIT;

#
# Data for the `servicios` table  (LIMIT 0,500)
#

INSERT INTO `servicios` (`cod_servicio`, `desc_servicio`) VALUES 
  (1,'Frenos'),
  (2,'Direccion hidraulica'),
  (3,'Balanceo'),
  (4,'ajuste valvulas'),
  (5,'Diag. por computadora'),
  (6,'Cambio aceite'),
  (7,'Cambio Filtro'),
  (8,'Revision-Reparacion luces tablero y faros');

COMMIT;

#
# Data for the `servicios_mantenimiento` table  (LIMIT 0,500)
#

INSERT INTO `servicios_mantenimiento` (`cod_plan`, `cod_servicios`) VALUES 
  (1,1),
  (3,1),
  (4,1),
  (5,1),
  (1,2),
  (3,2),
  (4,2),
  (1,3),
  (4,3),
  (1,4),
  (4,4),
  (1,5),
  (2,5),
  (4,5),
  (5,5),
  (1,6),
  (2,6),
  (4,6),
  (5,6),
  (1,7),
  (4,7),
  (5,7),
  (1,8),
  (4,8),
  (5,8);

COMMIT;

#
# Data for the `servicios_realizados` table  (LIMIT 0,500)
#

INSERT INTO `servicios_realizados` (`patente`, `fecha_hora_service`, `cod_servicio`) VALUES 
  ('CCC 666','2011-11-03 12:00:00',1),
  ('CCC 666','2011-11-03 12:00:00',6),
  ('DDD 777','2011-11-20 11:00:00',6),
  ('FFF 999','2011-11-23 14:00:00',6),
  ('CCC 666','2011-11-03 12:00:00',7),
  ('DDD 777','2011-11-20 11:00:00',7),
  ('FFF 999','2011-11-23 14:00:00',7),
  ('DDD 777','2011-11-20 11:00:00',8),
  ('FFF 999','2011-11-23 14:00:00',8);

COMMIT;

#
# Data for the `talleres` table  (LIMIT 0,500)
#

INSERT INTO `talleres` (`localidad`, `direccion`, `telefono`, `nom_encargado`) VALUES 
  ('bs as','Cordoba 5012','6666666','Marcela Iriondo'),
  ('bs as','Tucuman 4299','7777777','Hernan Rubio'),
  ('cordoba','San Martin 2359','5555555','Guillermo Barriena'),
  ('rosario','9 de julio 4511','9999999','Eriberto Masut'),
  ('rosario','Arijon 461','8888888','Mario Paso');

COMMIT;

#
# Data for the `valores_parte` table  (LIMIT 0,500)
#

INSERT INTO `valores_parte` (`cod_parte`, `fecha_desde_parte`, `valor_parte`) VALUES 
  (1,'2011-10-01',10),
  (1,'2011-10-17',11.5),
  (1,'2011-11-16',14.15),
  (1,'2011-12-05',16.97),
  (2,'2011-10-01',14),
  (2,'2011-10-20',16.1),
  (2,'2011-11-16',19.8),
  (2,'2011-12-05',23.76),
  (3,'2011-10-01',38),
  (3,'2011-10-20',43.7),
  (3,'2011-11-16',53.75),
  (3,'2011-12-05',64.5),
  (4,'2011-10-01',22),
  (4,'2011-10-24',25.3),
  (4,'2011-11-16',31.12),
  (4,'2011-12-05',37.34),
  (5,'2011-10-01',285),
  (5,'2011-10-20',327.75),
  (5,'2011-11-16',403.13),
  (5,'2011-12-05',483.76),
  (6,'2011-10-01',109),
  (6,'2011-10-24',125.35),
  (6,'2011-11-16',154.18),
  (6,'2011-12-05',185.02),
  (7,'2011-10-01',570),
  (7,'2011-10-27',655.5),
  (7,'2011-11-16',806.27),
  (7,'2011-12-05',967.52),
  (8,'2011-10-01',320),
  (8,'2011-10-27',368),
  (8,'2011-11-16',452.64),
  (8,'2011-12-05',543.17),
  (9,'2011-10-01',35),
  (9,'2011-10-24',40.25),
  (9,'2011-11-16',49.51),
  (9,'2011-12-05',59.41),
  (10,'2011-10-01',99),
  (10,'2011-10-24',113.85),
  (10,'2011-11-16',140.04),
  (10,'2011-12-05',168.04);

COMMIT;

