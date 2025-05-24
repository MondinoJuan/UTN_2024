# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : puerto


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `puerto`;

CREATE DATABASE `puerto`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `puerto`;

#
# Structure for the `empresas_consignatarias` table : 
#

DROP TABLE IF EXISTS `empresas_consignatarias`;

CREATE TABLE `empresas_consignatarias` (
  `id_empresa` int(11) NOT NULL,
  `cuit` char(13) NOT NULL,
  `razon_social` varchar(50) NOT NULL,
  `pais` varchar(50) NOT NULL,
  PRIMARY KEY  (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tipos_barcos` table : 
#

DROP TABLE IF EXISTS `tipos_barcos`;

CREATE TABLE `tipos_barcos` (
  `cod_tipo_barco` int(11) NOT NULL,
  `desc_tipo_barco` varchar(50) NOT NULL,
  PRIMARY KEY  (`cod_tipo_barco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `barcos` table : 
#

DROP TABLE IF EXISTS `barcos`;

CREATE TABLE `barcos` (
  `id_barco` int(11) NOT NULL,
  `caracteristicas` varchar(80) default NULL,
  `nombre_barco` varchar(50) NOT NULL,
  `nomapellcapitan` varchar(50) NOT NULL,
  `nacionalidad` varchar(50) default NULL,
  `id_empresa` int(11) NOT NULL,
  `cod_tipo_barco` int(11) NOT NULL,
  PRIMARY KEY  (`id_barco`),
  KEY `empresas_barco_fk` (`id_empresa`),
  KEY `barcos_tipo_barcos_fk` (`cod_tipo_barco`),
  CONSTRAINT `barcos_empresas_fk` FOREIGN KEY (`id_empresa`) REFERENCES `empresas_consignatarias` (`id_empresa`) ON UPDATE CASCADE,
  CONSTRAINT `barcos_tipos_barcos_fk` FOREIGN KEY (`cod_tipo_barco`) REFERENCES `tipos_barcos` (`cod_tipo_barco`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `mercancias` table : 
#

DROP TABLE IF EXISTS `mercancias`;

CREATE TABLE `mercancias` (
  `cod_mercancia` int(11) NOT NULL,
  `desc_mercancia` varchar(70) NOT NULL,
  PRIMARY KEY  (`cod_mercancia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `registros_entrada` table : 
#

DROP TABLE IF EXISTS `registros_entrada`;

CREATE TABLE `registros_entrada` (
  `nro_registro` int(11) NOT NULL,
  `id_barco` int(11) NOT NULL,
  `fecha_atraque` date NOT NULL,
  `hora_atraque` time NOT NULL,
  `dias_permanencia` int(2) default NULL,
  `cod_mercancia` int(11) NOT NULL,
  `responsable` varchar(30) NOT NULL,
  `fecha_retiro` date default NULL,
  PRIMARY KEY  (`id_barco`,`nro_registro`),
  KEY `registros_entrada_barco_fk` (`id_barco`),
  KEY `registros_entrada_mercancia_fk` (`cod_mercancia`),
  CONSTRAINT `registros_entrada_barco_fk` FOREIGN KEY (`id_barco`) REFERENCES `barcos` (`id_barco`) ON UPDATE CASCADE,
  CONSTRAINT `registros_entrada_mercancia_fk` FOREIGN KEY (`cod_mercancia`) REFERENCES `mercancias` (`cod_mercancia`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `servicios` table : 
#

DROP TABLE IF EXISTS `servicios`;

CREATE TABLE `servicios` (
  `cod_servicio` int(11) NOT NULL,
  `desc_servicio` varchar(20) NOT NULL,
  PRIMARY KEY  (`cod_servicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `albaran` table : 
#

DROP TABLE IF EXISTS `albaran`;

CREATE TABLE `albaran` (
  `id_barco` int(11) NOT NULL,
  `nro_registro` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date default NULL,
  `tiempo_estimado` int(3) default NULL,
  `cod_servicio` int(11) NOT NULL,
  PRIMARY KEY  (`id_barco`,`nro_registro`,`cod_servicio`),
  KEY `albaran_registros_entrada_fk` (`id_barco`,`nro_registro`),
  KEY `albaran_servicios_fk` (`cod_servicio`),
  CONSTRAINT ` albaran_registro_entrada_fk ` FOREIGN KEY (`id_barco`, `nro_registro`) REFERENCES `registros_entrada` (`id_barco`, `nro_registro`) ON UPDATE CASCADE,
  CONSTRAINT `albaran_servicios_fk` FOREIGN KEY (`cod_servicio`) REFERENCES `servicios` (`cod_servicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `proveedores` table : 
#

DROP TABLE IF EXISTS `proveedores`;

CREATE TABLE `proveedores` (
  `cuit_proveedor` varchar(13) NOT NULL,
  `razon_social` varchar(50) NOT NULL,
  `nacionalidad` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` varchar(20) default NULL,
  `mail` varchar(50) NOT NULL,
  `url` varchar(50) NOT NULL,
  PRIMARY KEY  (`cuit_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `materiales` table : 
#

DROP TABLE IF EXISTS `materiales`;

CREATE TABLE `materiales` (
  `cod_material` int(11) NOT NULL,
  `desc_material` varchar(50) NOT NULL,
  `fabricante` varchar(50) NOT NULL,
  `stock` int(11) default NULL,
  `punto_pedido` int(11) default NULL,
  `cuit_proveedor` varchar(13) NOT NULL,
  PRIMARY KEY  (`cod_material`),
  KEY `materiales_proveedor_fk` (`cuit_proveedor`),
  CONSTRAINT `materiales_proveedor_fk` FOREIGN KEY (`cuit_proveedor`) REFERENCES `proveedores` (`cuit_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `albaran_materiales` table : 
#

DROP TABLE IF EXISTS `albaran_materiales`;

CREATE TABLE `albaran_materiales` (
  `id_barco` int(11) NOT NULL,
  `nro_registro` int(11) NOT NULL,
  `cod_servicio` int(11) NOT NULL,
  `cod_material` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY  (`id_barco`,`nro_registro`,`cod_servicio`,`cod_material`),
  KEY `albaran_materiales_albaran_fk` (`id_barco`,`nro_registro`,`cod_servicio`,`cod_material`),
  KEY `albaran_materiales_materiales_fk` (`cod_material`),
  KEY `id_barco` (`id_barco`,`nro_registro`,`cod_servicio`),
  CONSTRAINT `albaran_materiales_albaran_fk` FOREIGN KEY (`id_barco`, `nro_registro`, `cod_servicio`) REFERENCES `albaran` (`id_barco`, `nro_registro`, `cod_servicio`) ON UPDATE CASCADE,
  CONSTRAINT `albaran_materiales_materiales_fk` FOREIGN KEY (`cod_material`) REFERENCES `materiales` (`cod_material`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `atraque_diario_valores` table : 
#

DROP TABLE IF EXISTS `atraque_diario_valores`;

CREATE TABLE `atraque_diario_valores` (
  `fecha_desde` date NOT NULL,
  `dias_desde` int(2) NOT NULL,
  `dias_hasta` int(2) default NULL,
  `monto` decimal(9,3) NOT NULL,
  PRIMARY KEY  (`fecha_desde`,`dias_desde`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `materiales_precios` table : 
#

DROP TABLE IF EXISTS `materiales_precios`;

CREATE TABLE `materiales_precios` (
  `cod_material` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `valor` decimal(9,3) NOT NULL,
  PRIMARY KEY  (`cod_material`,`fecha`),
  KEY `precios_materiales_fk` (`cod_material`),
  CONSTRAINT `precios_materiales_fk` FOREIGN KEY (`cod_material`) REFERENCES `materiales` (`cod_material`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `servicios_materiales` table : 
#

DROP TABLE IF EXISTS `servicios_materiales`;

CREATE TABLE `servicios_materiales` (
  `cod_material` int(11) NOT NULL,
  `cod_servicio` int(11) NOT NULL,
  PRIMARY KEY  (`cod_material`,`cod_servicio`),
  KEY `servicios_materiales_materiales_fk` (`cod_material`),
  KEY `servicios_materiales_servicios_fk` (`cod_servicio`),
  CONSTRAINT `servicios_materiales_materiales_fk` FOREIGN KEY (`cod_material`) REFERENCES `materiales` (`cod_material`) ON UPDATE CASCADE,
  CONSTRAINT `servicios_materiales_servicios_fk` FOREIGN KEY (`cod_servicio`) REFERENCES `servicios` (`cod_servicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `empresas_consignatarias` table  (LIMIT 0,500)
#

INSERT INTO `empresas_consignatarias` (`id_empresa`, `cuit`, `razon_social`, `pais`) VALUES 
  (10,'19-19191919-1','Agencia Marítima Blazquez','Argentina'),
  (100,'39-39393939-3','Agencia Marítima Finisterre S.A. ','España'),
  (111,'31-31313131-3','Agemexa','Mexico'),
  (200,'46-46464646-4','Agencia Marítima Miquel S.L.','Francia'),
  (222,'67-66767676-7','Adensa S.A. ','Argentina'),
  (300,'90-90909090-0','Agencia Marítima Portillo S.A.','Argentina'),
  (333,'98-98989898-9','Acoesport','Suiza'),
  (400,'26-26262626-2','Transhispánica','Brasil'),
  (444,'22-34234234-4','ABX Logistics','España'),
  (555,'97-87978978-9','Boat Transport','EEUU'),
  (666,'72-89173921-9','Perez y Cía','Argentina'),
  (777,'38-79832748-7','Molina Cadiz S.L.','Colombia'),
  (888,'36-42627453-8','Hartrodt','España'),
  (999,'98-36473638-2','Acopiapesca S.A.','Corea');

COMMIT;

#
# Data for the `tipos_barcos` table  (LIMIT 0,500)
#

INSERT INTO `tipos_barcos` (`cod_tipo_barco`, `desc_tipo_barco`) VALUES 
  (1,'buque granelero'),
  (2,'buque centollero'),
  (3,'buque petrolero'),
  (4,'barcaza para contenedores'),
  (5,'buque pesquero'),
  (6,'barcaza para transporte hidrocarburos'),
  (7,'transporte de pasajeros'),
  (8,'buque carga refrigerada'),
  (9,'buque carga de vehículos'),
  (10,'buque cisterna o tanque');

COMMIT;

#
# Data for the `barcos` table  (LIMIT 0,500)
#

INSERT INTO `barcos` (`id_barco`, `caracteristicas`, `nombre_barco`, `nomapellcapitan`, `nacionalidad`, `id_empresa`, `cod_tipo_barco`) VALUES 
  (123,'con bahía de carga totalmente refrigerada para el transporte de perecederos','Kimahuyi','Joan Po Hong','Coreano',999,8),
  (234,'con bahía adicional de carga para transporte de secos o líquidos','Argencord','Raul Sanchez','argentino',666,1),
  (456,'cubierta sin apertura o escotillas superiores','Salerni IV','Rogelio Rojas','Mexicano',111,6),
  (567,'con refrigeración completa','Langostyn','Vicente Martinez','Español',444,5),
  (666,'gran titanic cinco estrellas','Titanic','Nestor Kirchner','Argentino',222,7),
  (789,'con escotillas superiores','kalami II','Richard Philips','EEUU',555,4),
  (890,'con explanada para vehículos','ToyoHonda','Juan Li Shimp','Coreano',999,9),
  (987,'sin caracteristicas particulares','El Buquecito ','Pedro Zamora','Chileno',333,10);

COMMIT;

#
# Data for the `mercancias` table  (LIMIT 0,500)
#

INSERT INTO `mercancias` (`cod_mercancia`, `desc_mercancia`) VALUES 
  (10,'repuestos para vehículos , productos eléctricos, electrónicos '),
  (11,'Bobinas de papel o cartón'),
  (20,'personas'),
  (22,'Sacos con maíz, fréjol, semillas, café en grano, leche, malta, ajonjol'),
  (30,'productos de mar'),
  (33,'Atados de productos metálicos, pulpa de madera, madera aserrada, mader'),
  (40,'acienda'),
  (44,'Atados o lingotes de hierro'),
  (55,'Productos metálicos, plásticos y textiles'),
  (66,'Sacos con plaguicidas, fibras, plásticos, productos químicos, farmacéu'),
  (77,'papel, productos de papel, algodón en borra , textiles, prendas de ves'),
  (88,'Troncos de árboles, productos de madera, caucho, metálicos, eléctricos'),
  (99,'VEHÍCULOS AUTOMOTRES y lanchas en barcos convencionales');

COMMIT;

#
# Data for the `registros_entrada` table  (LIMIT 0,500)
#

INSERT INTO `registros_entrada` (`nro_registro`, `id_barco`, `fecha_atraque`, `hora_atraque`, `dias_permanencia`, `cod_mercancia`, `responsable`, `fecha_retiro`) VALUES 
  (1,123,'2010-09-19','02:00:00',0,10,'Santiago Alvarez',NULL),
  (2,123,'2010-09-19','02:00:00',NULL,10,'Raúl Zamponi',NULL),
  (1,234,'2010-09-21','12:00:00',0,30,'Santiago Alvarez',NULL),
  (1,456,'2009-11-24','20:00:00',20,33,'Juan Francisco Lemos','2009-12-09'),
  (2,456,'2010-01-06','15:00:00',26,40,'Santiago Zamponi','2010-02-01'),
  (3,456,'2010-08-09','02:00:00',0,40,'Arturo Bonin',NULL),
  (1,567,'2010-01-03','02:00:00',45,99,'Santiago Alvarez','2010-02-17'),
  (2,567,'2010-06-15','05:00:00',10,99,'Arturo Bonin','2010-06-25'),
  (3,567,'2010-08-27','10:00:00',5,55,'Raúl Zamponi','2010-09-01'),
  (4,567,'2010-09-22','04:00:00',0,55,'Juan Francisco Lemos',NULL),
  (1,666,'2010-07-20','04:00:00',10,20,'Raúl Zamponi','2010-07-30'),
  (2,666,'2010-09-13','22:30:00',5,20,'Santiago Alvarez','2010-09-18'),
  (3,666,'2010-09-22','10:00:00',0,20,'Santiago Alvarez',NULL),
  (1,789,'2010-02-01','20:00:00',30,77,'Arturo Bonin','2010-03-02'),
  (2,789,'2010-05-03','15:00:00',5,33,'Raúl Zamponi','2010-05-10'),
  (3,789,'2010-09-13','01:00:00',0,55,'Arturo Bonin',NULL),
  (1,890,'2010-09-17','10:00:00',3,77,'Raúl Zamponi','2010-09-20'),
  (1,987,'2010-09-13','05:00:00',0,44,'Raúl zamponi','0000-00-00');

COMMIT;

#
# Data for the `servicios` table  (LIMIT 0,500)
#

INSERT INTO `servicios` (`cod_servicio`, `desc_servicio`) VALUES 
  (1,'carga'),
  (2,'descarga'),
  (3,'almacenamiento'),
  (4,'grúas'),
  (5,'contenedores'),
  (6,'atraque'),
  (7,'estiba'),
  (8,'desestiba'),
  (9,'fondeo'),
  (10,'transporte');

COMMIT;

#
# Data for the `albaran` table  (LIMIT 0,500)
#

INSERT INTO `albaran` (`id_barco`, `nro_registro`, `fecha_inicio`, `fecha_fin`, `tiempo_estimado`, `cod_servicio`) VALUES 
  (123,1,'2010-09-19','2010-09-19',1,2),
  (123,2,'2010-09-19',NULL,NULL,4),
  (234,1,'2010-09-21','2010-09-23',3,2),
  (234,1,'2010-09-20','2010-09-22',2,7),
  (234,1,'2010-09-22','2010-09-22',1,9),
  (234,1,'2010-09-21','2010-09-22',2,10),
  (456,1,'2009-11-26','2009-11-28',3,4),
  (456,1,'2009-11-24','2010-10-08',8,10),
  (456,2,'2010-01-31','2010-02-02',2,8),
  (456,2,'2010-01-06','2010-10-08',2,9),
  (456,2,'2010-01-09','2010-01-14',6,10),
  (456,3,'2010-09-08','2010-09-10',2,2),
  (456,3,'2010-09-08','2010-09-28',20,3),
  (456,3,'2010-09-08','2010-09-08',1,9),
  (456,3,'2010-09-08','2010-09-18',10,10),
  (567,1,'2010-02-09','2010-02-12',3,3),
  (567,1,'2010-01-04','2010-01-14',10,5),
  (567,1,'2010-01-03','2010-01-04',1,9),
  (567,2,'2009-11-24','2009-11-30',5,2),
  (567,2,'2010-06-15','2010-06-25',8,3),
  (567,2,'2010-06-15','2010-09-20',5,4),
  (567,2,'2010-06-19','2010-06-25',6,5),
  (567,2,'2010-06-15','2010-06-19',4,9),
  (567,3,'2010-08-27','2010-08-31',4,7),
  (567,3,'2010-09-01','2010-09-02',1,8),
  (567,3,'2010-08-27','2010-08-29',2,9),
  (567,4,'2010-09-22','2010-09-22',1,2),
  (567,4,'2010-09-23','2010-09-24',2,4),
  (567,4,'2010-09-23','2010-09-24',1,8),
  (567,4,'2010-09-22','2010-09-22',1,9),
  (666,1,'2010-07-20','2010-07-30',10,7),
  (666,1,'2010-07-20','2010-07-21',2,9),
  (666,1,'2010-07-20','2010-07-20',1,10),
  (666,2,'2010-09-13','2010-09-15',3,7),
  (666,2,'2010-09-13','2010-09-16',3,8),
  (666,2,'2010-09-13','2010-09-13',1,9),
  (666,3,'2010-09-22','2010-09-22',1,9),
  (666,3,'2010-09-22','2010-09-24',2,10),
  (789,1,'2010-02-01','2010-02-10',9,2),
  (789,1,'2010-02-04','2010-02-17',12,3),
  (789,1,'2010-02-03','2010-02-11',6,4),
  (789,1,'2010-02-01','2010-02-02',1,9),
  (789,2,'2010-05-03','2010-09-13',12,2),
  (789,2,'2010-05-06','2010-05-06',3,8),
  (789,2,'2010-05-03','2010-05-07',4,9),
  (789,3,'2010-09-15','2010-09-25',8,2),
  (789,3,'2010-09-13',NULL,0,4),
  (789,3,'2010-09-13','2010-09-13',1,9),
  (890,1,'2010-09-19','2010-09-20',1,2),
  (890,1,'2010-09-17','2010-09-20',2,8),
  (890,1,'2010-09-17','2010-09-18',1,9),
  (987,1,'2010-05-13','2010-05-15',2,2),
  (987,1,'2010-05-14','2010-05-15',2,8);

COMMIT;

#
# Data for the `proveedores` table  (LIMIT 0,500)
#

INSERT INTO `proveedores` (`cuit_proveedor`, `razon_social`, `nacionalidad`, `direccion`, `telefono`, `mail`, `url`) VALUES 
  ('11-11111111-1','CO.FA.RI. SOC. COOP. ','italiana',' V. Bacci 48123 RAVENNA (RA) ','39 0544452 861 ','cofari@cofari.it ','http://www.cofari.it/'),
  ('22-22222222-2','SHIPWINDS PLC ','Reino Unido','Montpellier Street, 4, SW7 1 EE LONDON ','44 87 15 27 47 08 ','franceinfo@williamgroup.org.uk','http://www.williamgroup.org.uk/'),
  ('33-33333333-3','IBAIA TRAVAUX SOUS MARINS ','Francia','Avenue du Docteur Gaudeul 64100 Bayonne','33 5 59 55 89 25 ','ibaia@ibaia.fr','http://www.ibaia-tsm.com/'),
  ('44-44444444-4','DOMPRA SRL SERVICIOS PORTUARIOS ','Argentina','L Sáenz Peña 1678','4304 9834','gerencia@dompra.com.ar','http://www.dompra.com.ar/'),
  ('55-55555555-5','TOBICH SERVICIOS INTEGRALES SA','Argentina','Aldecoa 610 Barrio Avellaneda - Buenos Aires','011 37474 3833','tobich@servicios.com.ar','http://www.tobichser.com.ar'),
  ('66-66666666-6','SERVICIOS PORTUARIOS PATAGONIA NORTE SA','Argentina','Puerto San Antonio Este - Río Negro','02934 73635','serpatagoni@sanantonoo.com.ar','http://www.patagonia-norte.com.ar/'),
  ('77-77777777-7','DEFIBA SERVICIOS PORTUARIOS SA','Argentina','F Frías 221 Barrio Bahía Blanca Ciudad Bahía Blanc','0291 83736','defiba@servicios.com.ar','http://www.defiba.com/');

COMMIT;

#
# Data for the `materiales` table  (LIMIT 0,500)
#

INSERT INTO `materiales` (`cod_material`, `desc_material`, `fabricante`, `stock`, `punto_pedido`, `cuit_proveedor`) VALUES 
  (100,'defensas de muelles de atraque','Gimenez S.A',2000,300,'11-11111111-1'),
  (101,'anclas tipo 2','Heis S.A',300,30,'55-55555555-5'),
  (200,'ganchos de escape rápido','Luraschi ',1003900,5000,'22-22222222-2'),
  (300,'boyas de amarre','Gimenez S.A',5001,350,'22-22222222-2'),
  (400,'redes de protección','Gimenez S.A',1000,45,'77-77777777-7'),
  (500,'carros varaderos','Luraschi',50,3,'77-77777777-7'),
  (600,'contebedores','Heis S.A',1500,50,'55-55555555-5'),
  (700,'ganchos de grúa','Heis S.A',4777,777,'55-55555555-5'),
  (800,'pasarelas telescópicas','Heis S.A',500,30,'55-55555555-5'),
  (900,'anclas tipo 1','Luraschi',200,20,'33-33333333-3');

COMMIT;

#
# Data for the `albaran_materiales` table  (LIMIT 0,500)
#

INSERT INTO `albaran_materiales` (`id_barco`, `nro_registro`, `cod_servicio`, `cod_material`, `cantidad`) VALUES 
  (234,1,2,100,12),
  (234,1,2,101,34),
  (234,1,7,400,20),
  (234,1,7,800,5),
  (234,1,9,600,10),
  (234,1,10,800,5),
  (456,1,4,100,10),
  (456,1,4,101,39),
  (456,1,10,700,34),
  (456,2,8,500,24),
  (456,2,9,600,45),
  (456,2,9,800,235),
  (456,2,10,700,34),
  (456,2,10,800,45),
  (456,3,2,100,20),
  (456,3,2,101,34),
  (456,3,3,400,234),
  (456,3,9,800,25),
  (456,3,10,700,34),
  (456,3,10,800,12),
  (567,1,3,400,12),
  (567,1,3,600,37),
  (567,1,9,600,5),
  (567,1,9,700,5),
  (567,1,9,800,35),
  (567,2,3,400,56),
  (567,2,3,600,55),
  (567,2,4,101,67),
  (567,2,4,500,50),
  (567,2,4,900,23),
  (567,2,5,200,20),
  (567,2,5,300,30),
  (567,2,9,600,20),
  (567,2,9,800,35),
  (567,3,7,400,40),
  (567,3,8,500,43),
  (567,3,9,600,65),
  (567,3,9,800,35),
  (567,4,2,100,10),
  (567,4,2,101,11),
  (567,4,2,900,90),
  (567,4,4,100,10),
  (567,4,4,900,9),
  (567,4,8,500,28),
  (567,4,9,600,66),
  (567,4,9,800,23),
  (666,1,7,400,27),
  (666,1,9,600,234),
  (666,1,9,800,26),
  (666,1,10,700,26),
  (666,1,10,800,14),
  (666,2,7,400,45),
  (666,2,7,800,245),
  (666,2,9,600,26),
  (666,2,9,800,25),
  (666,3,9,600,75),
  (666,3,9,800,75),
  (666,3,10,700,876),
  (666,3,10,800,754),
  (789,1,2,100,12),
  (789,1,2,800,88),
  (789,1,4,101,23),
  (789,1,4,400,4),
  (789,1,4,500,5),
  (789,1,9,600,23),
  (789,1,9,800,5),
  (789,2,2,100,10),
  (789,2,2,101,25),
  (789,2,8,500,55),
  (789,2,9,600,60),
  (789,2,9,800,8),
  (789,3,2,100,12),
  (789,3,4,500,32),
  (789,3,4,900,90),
  (789,3,9,600,43),
  (890,1,8,500,765),
  (890,1,9,600,60),
  (890,1,9,800,654),
  (987,1,2,100,87),
  (987,1,2,101,78),
  (987,1,2,700,65),
  (987,1,8,500,76);

COMMIT;

#
# Data for the `atraque_diario_valores` table  (LIMIT 0,500)
#

INSERT INTO `atraque_diario_valores` (`fecha_desde`, `dias_desde`, `dias_hasta`, `monto`) VALUES 
  ('2010-01-01',1,5,1000),
  ('2010-01-01',5,10,2000),
  ('2010-01-01',10,31,3000),
  ('2010-01-01',31,NULL,4000),
  ('2010-09-01',5,10,2010),
  ('2010-10-01',5,10,2020);

COMMIT;

#
# Data for the `materiales_precios` table  (LIMIT 0,500)
#

INSERT INTO `materiales_precios` (`cod_material`, `fecha`, `valor`) VALUES 
  (100,'2010-09-17',200),
  (100,'2010-09-22',250),
  (100,'2010-10-01',300),
  (101,'2010-09-17',50),
  (101,'2010-09-22',60),
  (101,'2010-10-01',70),
  (200,'2010-09-22',90),
  (300,'2010-09-22',45),
  (300,'2010-10-01',55),
  (400,'2010-09-17',150),
  (400,'2010-09-22',200),
  (500,'2010-09-17',690),
  (600,'2010-09-17',50),
  (700,'2010-09-22',80),
  (800,'2010-09-22',90),
  (900,'2010-09-17',100),
  (900,'2010-10-01',200);

COMMIT;

#
# Data for the `servicios_materiales` table  (LIMIT 0,500)
#

INSERT INTO `servicios_materiales` (`cod_material`, `cod_servicio`) VALUES 
  (100,1),
  (100,2),
  (100,4),
  (101,1),
  (101,2),
  (101,4),
  (200,5),
  (300,1),
  (300,5),
  (400,3),
  (400,4),
  (400,6),
  (400,7),
  (500,1),
  (500,4),
  (500,6),
  (500,8),
  (600,1),
  (600,3),
  (600,5),
  (600,9),
  (700,5),
  (700,10),
  (800,1),
  (800,2),
  (800,7),
  (800,9),
  (800,10),
  (900,1),
  (900,2),
  (900,4);

COMMIT;

