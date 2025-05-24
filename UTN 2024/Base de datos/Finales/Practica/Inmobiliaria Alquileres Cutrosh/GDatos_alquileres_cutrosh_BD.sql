# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : alquileres_cutrosh


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `alquileres_cutrosh`;

CREATE DATABASE `alquileres_cutrosh`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `alquileres_cutrosh`;

#
# Structure for the `personas` table : 
#

DROP TABLE IF EXISTS `personas`;

CREATE TABLE `personas` (
  `dni` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(30) NOT NULL,
  `fecha_nac` date NOT NULL,
  `telefono` varchar(20) default NULL,
  `domicilio` varchar(50) default NULL,
  `email` varchar(50) default NULL,
  `usuario` varchar(60) default NULL,
  `contrasenia` varchar(20) default NULL,
  `cuil` varchar(20) default NULL,
  `cbu` varchar(30) default NULL,
  `fecha_verifica` date default NULL,
  `pendiente_validacion` tinyint(1) default NULL,
  PRIMARY KEY  (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `centro_turistico` table : 
#

DROP TABLE IF EXISTS `centro_turistico`;

CREATE TABLE `centro_turistico` (
  `cod_centro` int(11) NOT NULL,
  `nom_centro` varchar(30) NOT NULL,
  `dni_encargado` int(11) NOT NULL,
  PRIMARY KEY  (`cod_centro`),
  KEY `centro_turistico_fk` (`dni_encargado`),
  CONSTRAINT `centro_turistico_fk` FOREIGN KEY (`dni_encargado`) REFERENCES `personas` (`dni`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `propiedades` table : 
#

DROP TABLE IF EXISTS `propiedades`;

CREATE TABLE `propiedades` (
  `cod_propiedad` int(11) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `caracteristicas` varchar(200) NOT NULL,
  `capacidad` int(11) NOT NULL,
  `fecha_revision` date default NULL,
  `publica` tinyint(1) default NULL,
  `dni_propietario` int(11) NOT NULL,
  `cod_centro` int(11) NOT NULL,
  PRIMARY KEY  (`cod_propiedad`),
  KEY `propiedades_propietarios_fk` (`dni_propietario`),
  KEY `propiedades_centros_fk` (`cod_centro`),
  CONSTRAINT `propiedades_centros_fk` FOREIGN KEY (`cod_centro`) REFERENCES `centro_turistico` (`cod_centro`) ON UPDATE CASCADE,
  CONSTRAINT `propiedades_propietarios_fk` FOREIGN KEY (`dni_propietario`) REFERENCES `personas` (`dni`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `alquileres` table : 
#

DROP TABLE IF EXISTS `alquileres`;

CREATE TABLE `alquileres` (
  `cod_propiedad` int(11) NOT NULL,
  `nro_alquiler` int(11) NOT NULL,
  `fecha_alquiler` date NOT NULL,
  `fecha_reserva` date default NULL,
  `fecha_desde` date NOT NULL,
  `fecha_hasta` date NOT NULL,
  `importe_convenido` float(9,3) NOT NULL,
  `fecha_cancela` date default NULL,
  `motivo_cancela` varchar(100) default NULL,
  `dni_cliente` int(11) NOT NULL,
  PRIMARY KEY  (`cod_propiedad`,`nro_alquiler`),
  KEY `alquileres_fk1` (`dni_cliente`),
  CONSTRAINT `alquileres_fk` FOREIGN KEY (`cod_propiedad`) REFERENCES `propiedades` (`cod_propiedad`) ON UPDATE CASCADE,
  CONSTRAINT `alquileres_fk1` FOREIGN KEY (`dni_cliente`) REFERENCES `personas` (`dni`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `servicios` table : 
#

DROP TABLE IF EXISTS `servicios`;

CREATE TABLE `servicios` (
  `cod_servicio` int(11) NOT NULL,
  `nom_servicio` varchar(30) NOT NULL,
  PRIMARY KEY  (`cod_servicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `propiedades_servicios` table : 
#

DROP TABLE IF EXISTS `propiedades_servicios`;

CREATE TABLE `propiedades_servicios` (
  `cod_propiedad` int(11) NOT NULL,
  `cod_servicio` int(11) NOT NULL,
  PRIMARY KEY  (`cod_propiedad`,`cod_servicio`),
  KEY `propiedades_servicios_fk` (`cod_servicio`),
  CONSTRAINT `propiedades_servicios_fk` FOREIGN KEY (`cod_servicio`) REFERENCES `servicios` (`cod_servicio`) ON UPDATE CASCADE,
  CONSTRAINT `propiedades_servicios_propiedades_fk` FOREIGN KEY (`cod_propiedad`) REFERENCES `propiedades` (`cod_propiedad`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `alquileres_servicios` table : 
#

DROP TABLE IF EXISTS `alquileres_servicios`;

CREATE TABLE `alquileres_servicios` (
  `cod_propiedad` int(11) NOT NULL,
  `nro_alquiler` int(11) NOT NULL,
  `cod_servicio` int(11) NOT NULL,
  `importe_convenido` float(9,3) NOT NULL,
  PRIMARY KEY  (`cod_propiedad`,`nro_alquiler`,`cod_servicio`),
  KEY `alquileres_servicios_servicios_fk` (`cod_propiedad`,`cod_servicio`),
  CONSTRAINT `alquileres_servicios_alquileres_fk` FOREIGN KEY (`cod_propiedad`, `nro_alquiler`) REFERENCES `alquileres` (`cod_propiedad`, `nro_alquiler`) ON UPDATE CASCADE,
  CONSTRAINT `alquileres_servicios_servicios_fk` FOREIGN KEY (`cod_propiedad`, `cod_servicio`) REFERENCES `propiedades_servicios` (`cod_propiedad`, `cod_servicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `pagos` table : 
#

DROP TABLE IF EXISTS `pagos`;

CREATE TABLE `pagos` (
  `cod_propiedad` int(11) NOT NULL,
  `nro_alquiler` int(11) NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `fecha_pago` date default NULL,
  `importe_pago` float(9,3) NOT NULL,
  `recargo` float(9,3) default NULL,
  PRIMARY KEY  (`cod_propiedad`,`nro_alquiler`,`fecha_vencimiento`),
  CONSTRAINT `pagos_alquileres_fk` FOREIGN KEY (`cod_propiedad`, `nro_alquiler`) REFERENCES `alquileres` (`cod_propiedad`, `nro_alquiler`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_propiedades` table : 
#

DROP TABLE IF EXISTS `valores_propiedades`;

CREATE TABLE `valores_propiedades` (
  `cod_propiedad` int(11) NOT NULL,
  `fecha_valor` date NOT NULL,
  `cant_dias_min` int(11) NOT NULL,
  `valor_propiedad` float(9,3) NOT NULL,
  PRIMARY KEY  (`cod_propiedad`,`fecha_valor`,`cant_dias_min`),
  CONSTRAINT `valores_propiedades_propiedades_fk` FOREIGN KEY (`cod_propiedad`) REFERENCES `propiedades` (`cod_propiedad`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_servicios` table : 
#

DROP TABLE IF EXISTS `valores_servicios`;

CREATE TABLE `valores_servicios` (
  `cod_propiedad` int(11) NOT NULL,
  `cod_servicio` int(11) NOT NULL,
  `fecha_valor` date NOT NULL,
  `valor_servicio` float(9,3) NOT NULL,
  PRIMARY KEY  (`cod_propiedad`,`cod_servicio`,`fecha_valor`),
  CONSTRAINT `valores_servicios_fk` FOREIGN KEY (`cod_propiedad`, `cod_servicio`) REFERENCES `propiedades_servicios` (`cod_propiedad`, `cod_servicio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `personas` table  (LIMIT 0,500)
#

INSERT INTO `personas` (`dni`, `nombre`, `apellido`, `fecha_nac`, `telefono`, `domicilio`, `email`, `usuario`, `contrasenia`, `cuil`, `cbu`, `fecha_verifica`, `pendiente_validacion`) VALUES 
  (11111111,'Marya Saloméa ','Sktodowska Boguska','1911-11-11','111-1111','Rioja 1111','marya11@cutrosh.com.ar','maryas','radio','11-11111111-1',NULL,NULL,NULL),
  (12121212,'Helen','Keller','1912-12-12','121-2121','Arijon 1212','hekel@cutrosh.com.ar','hekel','voluntad','12-12121212-1',NULL,NULL,NULL),
  (13131313,'Edmund','Hillary','1913-03-13','131-3131','Valparaiso 1313','edih@cutrosh.com.ar','ehillary','everest','13-13131313-1',NULL,NULL,NULL),
  (21212121,'Tenzing','Norgay','1921-02-21','212-1212','Alvarez Tomas 212','tennor@gmail.com','tenzing','everest',NULL,'21212121212121','2008-02-21',0),
  (22222222,'Mohandas Karamchand ','Gandhi','1922-02-22','222-2222','Paraguay 222','mohan@gmail.com','mahatma','paz',NULL,'22222222222222','2008-02-22',0),
  (23232323,'James','Dewar','1923-03-23','232-3232','Lima 232','dewarj@gmail.com','dewar','fisica',NULL,'23232323232323','2008-03-23',0),
  (24242424,'Michael','Faraday','1924-04-24','242-4242','Richeri 2424','mickyfara@gmail.com',NULL,NULL,NULL,'24242424242424',NULL,1),
  (25252525,'Nikola','Tesla','1925-05-25','252-5252','Buenos Aires 252','nokola@teslacorp.com.ar',NULL,NULL,NULL,'25252525252525',NULL,1),
  (51515151,'Mary','Quant','1951-05-15','515-1515','San Martín 5151','maryquant@gmail.com',NULL,NULL,NULL,'51515151515151',NULL,NULL),
  (52525252,'King Camp','Gillette','1952-05-25','525-2525','Cordoba 525','kcgillete@gmail.com',NULL,NULL,NULL,'52525252525252',NULL,NULL),
  (53535353,'Alexis','Duchateau','1953-05-03','535-3535','Laines 53','alduc@gmail.com',NULL,NULL,NULL,'53535353535353',NULL,NULL),
  (54545454,'John Logie','Baird','1954-05-04','545-4545','Uriburu 5454','jlbaird@gmail.com',NULL,NULL,NULL,'54545454545454',NULL,NULL);

COMMIT;

#
# Data for the `centro_turistico` table  (LIMIT 0,500)
#

INSERT INTO `centro_turistico` (`cod_centro`, `nom_centro`, `dni_encargado`) VALUES 
  (1,'Bariloche',11111111),
  (2,'Mar del Plata',12121212),
  (3,'Mendoza',13131313);

COMMIT;

#
# Data for the `propiedades` table  (LIMIT 0,500)
#

INSERT INTO `propiedades` (`cod_propiedad`, `direccion`, `caracteristicas`, `capacidad`, `fecha_revision`, `publica`, `dni_propietario`, `cod_centro`) VALUES 
  (1,'Pasaje Iriondo 1111','Cabaña, 2 dormitorios, 1 baño, estufa, termotanque, wifi',5,'2008-03-11',1,21212121,1),
  (2,'J.M. de Rosas 2222','Cabaña, 3 dormitorios 2 baños, calefaccion central, calefon garage, 2 plantas, wifi, cable',8,'2008-03-12',1,21212121,1),
  (3,'Belgrano 3333','Departamento, 2 dormitorios, 1 baño, estacionamiento',4,'2008-04-13',0,21212121,2),
  (4,'Rasero 4444','Monoambiente',2,'2008-04-19',1,22222222,2),
  (5,'Alvear 5555','Casa frente a playa, 3 dormitorios, 2 baños, garage 2 autos, calefon, 2 camas cuchetas 1 dos plazas',7,'2008-04-21',1,23232323,2),
  (6,'Salta 666','Casa en las afueras, 2 dormitorios 1 baño, estacionamiento, termotanque, aire acondicionado',4,NULL,NULL,23232323,3),
  (7,'Alvarez Tomas 77 bis','Departamento 3 ambientes, 1 dormitorio, 1 baño',2,NULL,NULL,22222222,2),
  (8,'Itaupe 888','Casa 2 plantas 4 dormitorios, 2 baños, garage pasante, patio, parrillero y quincho',10,NULL,NULL,23232323,3);

COMMIT;

#
# Data for the `alquileres` table  (LIMIT 0,500)
#

INSERT INTO `alquileres` (`cod_propiedad`, `nro_alquiler`, `fecha_alquiler`, `fecha_reserva`, `fecha_desde`, `fecha_hasta`, `importe_convenido`, `fecha_cancela`, `motivo_cancela`, `dni_cliente`) VALUES 
  (1,1,'2008-03-20','2008-03-27','2008-06-10','2008-06-25',140,NULL,NULL,51515151),
  (1,2,'2008-07-11','2008-07-29','2008-12-01','2009-01-11',179,'2008-10-03','Cliente no pagó',52525252),
  (1,3,'2008-08-12','2008-08-24','2008-12-08','2009-01-12',164,NULL,NULL,51515151),
  (1,4,'2008-08-20','2008-08-29','2009-01-19','2009-02-12',240,NULL,NULL,52525252),
  (1,5,'2008-02-01','2008-02-20','2009-07-12','2009-08-12',245,NULL,NULL,51515151),
  (2,1,'2008-03-31','2008-04-09','2008-04-01','2008-04-15',463,NULL,NULL,52525252),
  (2,2,'2008-09-25','2008-10-11','2008-12-01','2009-01-11',640,NULL,NULL,53535353),
  (2,3,'2008-12-03','2008-12-11','2009-01-13','2009-01-31',684,NULL,NULL,51515151),
  (3,1,'2008-07-01','2008-07-07','2009-01-01','2009-01-15',244,NULL,NULL,53535353),
  (4,1,'2008-05-23','2008-05-27','2008-07-01','2008-07-07',145,NULL,NULL,21212121),
  (4,2,'2009-03-03','2009-03-05','2009-06-01','2009-06-12',320,NULL,NULL,53535353);

COMMIT;

#
# Data for the `servicios` table  (LIMIT 0,500)
#

INSERT INTO `servicios` (`cod_servicio`, `nom_servicio`) VALUES 
  (1,'Limpieza'),
  (2,'Media pension'),
  (3,'Clases de Snowboard'),
  (4,'Lavanderia'),
  (5,'Guia turistica'),
  (6,'Alquiler vehículo');

COMMIT;

#
# Data for the `propiedades_servicios` table  (LIMIT 0,500)
#

INSERT INTO `propiedades_servicios` (`cod_propiedad`, `cod_servicio`) VALUES 
  (1,1),
  (2,1),
  (4,1),
  (5,1),
  (1,2),
  (2,2),
  (3,2),
  (5,2),
  (1,3),
  (1,4),
  (3,4),
  (4,4),
  (1,5),
  (2,5),
  (4,5);

COMMIT;

#
# Data for the `alquileres_servicios` table  (LIMIT 0,500)
#

INSERT INTO `alquileres_servicios` (`cod_propiedad`, `nro_alquiler`, `cod_servicio`, `importe_convenido`) VALUES 
  (1,1,4,30),
  (1,1,5,150),
  (1,2,4,30),
  (1,3,1,40),
  (1,3,4,30),
  (1,3,5,150),
  (1,4,1,40),
  (1,4,5,150),
  (2,1,2,100),
  (2,3,1,40),
  (2,3,5,150),
  (3,1,4,30),
  (4,1,5,120),
  (4,2,1,40),
  (4,2,4,30),
  (4,2,5,150);

COMMIT;

#
# Data for the `pagos` table  (LIMIT 0,500)
#

INSERT INTO `pagos` (`cod_propiedad`, `nro_alquiler`, `fecha_vencimiento`, `fecha_pago`, `importe_pago`, `recargo`) VALUES 
  (1,1,'2008-03-27','2008-03-26',1058.5,105.85),
  (1,1,'2008-04-27','2008-05-04',255,25.5),
  (1,1,'2008-05-27','2008-05-29',255,25.5),
  (1,1,'2008-06-27','2008-06-28',255,25.5),
  (1,1,'2008-07-27','2008-07-29',255,25.5),
  (1,1,'2008-08-27','2008-08-27',255,25.5),
  (1,1,'2008-09-27','2008-09-26',216.5,25.5),
  (1,2,'2008-07-31',NULL,3675,367.5),
  (1,2,'2008-08-31',NULL,856.9,85.69),
  (1,2,'2008-09-30',NULL,856.9,85.69),
  (1,2,'2008-10-30',NULL,856.9,85.69),
  (1,2,'2008-11-30',NULL,856.9,85.69),
  (1,2,'2008-12-30',NULL,856.9,85.69),
  (1,2,'2009-01-30',NULL,609.5,85.69),
  (1,3,'2008-08-29','2008-08-27',2871,287.1),
  (1,3,'2008-09-29','2008-10-03',714,71.4),
  (1,3,'2008-10-29','2008-10-30',714,71.4),
  (1,3,'2008-11-29','2008-12-06',714,71.4),
  (1,3,'2008-12-29','2009-01-01',714,71.4),
  (1,3,'2009-01-29','2009-01-26',714,71.4),
  (1,3,'2009-02-28','2009-02-28',699,71.4),
  (1,4,'2008-09-01','2008-09-04',2903.5,290.35),
  (1,4,'2008-10-01','2008-10-07',672,67.2),
  (1,4,'2008-11-01','2008-11-04',672,67.2),
  (1,4,'2008-12-01','2008-12-03',672,67.2),
  (1,4,'2009-01-01','2009-01-05',672,67.2),
  (1,4,'2009-02-01','2009-01-30',672,67.2),
  (1,4,'2009-03-01','2009-03-01',456.5,67.2),
  (1,5,'2008-02-16','2008-02-14',3835,383.5),
  (1,5,'2008-03-16','2008-03-19',1500,150),
  (1,5,'2008-04-16','2008-04-19',1500,150),
  (1,5,'2008-05-16','2008-05-18',760,76),
  (2,1,'2008-04-07','2008-04-09',3243,324.3),
  (2,1,'2008-05-07','2008-05-05',788.2,78.82),
  (2,1,'2008-06-07','2008-06-14',788.2,78.82),
  (2,1,'2008-07-07','2008-07-10',788.2,78.82),
  (2,1,'2008-08-07','2008-08-13',788.2,78.82),
  (2,1,'2008-09-07','2008-09-13',788.2,78.82),
  (2,1,'2008-10-07','2008-10-10',698,78.82),
  (2,2,'2008-10-15','2008-10-16',13164.5,1316.45),
  (2,2,'2008-11-15','2008-11-13',5000,500),
  (2,2,'2008-12-15','2008-12-17',5000,500),
  (2,2,'2009-01-15','2009-01-21',3075.5,300),
  (2,3,'2008-12-12','2008-12-11',6156.5,615.65),
  (2,3,'2009-01-12','2009-01-13',1303.2,130.32),
  (2,3,'2009-02-12','2009-02-12',1303.2,130.32),
  (2,3,'2009-03-12','2009-03-12',1303.2,130.32),
  (2,3,'2009-04-12','2009-04-16',1303.2,130.32),
  (2,3,'2009-05-12','2009-05-15',1303.2,130.32),
  (2,3,'2009-06-12','2009-06-10',359.5,130.32),
  (3,1,'2008-07-08','2008-07-09',1709,170.9),
  (3,1,'2008-08-08','2008-08-11',383.6,38.36),
  (3,1,'2008-09-08','2008-09-06',383.6,38.36),
  (3,1,'2008-10-08','2008-10-09',383.6,38.36),
  (3,1,'2008-11-08','2008-11-12',383.6,38.36),
  (3,1,'2008-12-08','2008-12-10',383.6,38.36),
  (3,1,'2009-01-08','2009-01-10',209,38.36),
  (4,1,'2008-01-26','2008-01-23',37.5,3.75),
  (4,1,'2008-05-26','2008-05-25',439.5,43.95),
  (4,1,'2008-06-26','2008-06-25',159,15.9),
  (4,1,'2008-07-26','2008-07-22',159,15.9),
  (4,1,'2008-08-26','2008-08-12',159,15.9),
  (4,1,'2008-09-26','2008-09-23',159,15.9),
  (4,1,'2008-10-26','2008-10-24',159,15.9),
  (4,1,'2008-11-26','2008-11-12',159,15.9),
  (4,1,'2008-12-26','2008-12-02',159,15.9),
  (4,2,'2009-03-08','2009-03-14',1773.5,177.35),
  (4,2,'2009-04-08','2009-04-10',396,39.6),
  (4,2,'2009-05-08','2009-05-06',396,39.6),
  (4,2,'2009-06-08','2009-06-05',396,39.6),
  (4,2,'2009-07-08',NULL,396,39.6),
  (4,2,'2009-08-08',NULL,396,39.6),
  (4,2,'2009-09-08',NULL,206.5,39.6);

COMMIT;

#
# Data for the `valores_propiedades` table  (LIMIT 0,500)
#

INSERT INTO `valores_propiedades` (`cod_propiedad`, `fecha_valor`, `cant_dias_min`, `valor_propiedad`) VALUES 
  (1,'2008-03-18',0,150),
  (1,'2008-03-18',30,130),
  (1,'2008-06-18',0,180),
  (1,'2008-06-18',30,156),
  (1,'2008-09-18',0,210),
  (1,'2008-09-18',30,182),
  (1,'2009-03-18',0,270),
  (1,'2009-03-18',30,234),
  (1,'2009-09-18',0,330),
  (1,'2009-09-18',30,286),
  (2,'2008-03-20',0,450),
  (2,'2008-03-20',15,410),
  (2,'2008-03-20',30,390),
  (2,'2008-03-20',45,375),
  (2,'2008-06-20',0,540),
  (2,'2008-06-20',15,492),
  (2,'2008-06-20',30,468),
  (2,'2008-06-20',45,450),
  (2,'2008-09-20',0,630),
  (2,'2008-09-20',15,574),
  (2,'2008-09-20',30,546),
  (2,'2008-09-20',45,525),
  (2,'2009-03-20',0,810),
  (2,'2009-03-20',15,738),
  (2,'2009-03-20',30,702),
  (2,'2009-03-20',45,675),
  (2,'2009-09-20',0,990),
  (2,'2009-09-20',15,902),
  (2,'2009-09-20',30,858),
  (2,'2009-09-20',45,825),
  (3,'2008-04-15',0,250),
  (3,'2008-04-15',7,230),
  (3,'2008-04-15',14,210),
  (3,'2008-04-15',21,200),
  (3,'2008-07-15',0,300),
  (3,'2008-07-15',7,276),
  (3,'2008-07-15',14,252),
  (3,'2008-07-15',21,240),
  (3,'2008-10-15',0,350),
  (3,'2008-10-15',7,322),
  (3,'2008-10-15',14,294),
  (3,'2008-10-15',21,280),
  (3,'2009-04-15',0,450),
  (3,'2009-04-15',7,414),
  (3,'2009-04-15',14,378),
  (3,'2009-04-15',21,360),
  (3,'2009-10-15',0,550),
  (3,'2009-10-15',7,506),
  (3,'2009-10-15',14,462),
  (3,'2009-10-15',21,440),
  (4,'2008-05-01',0,150),
  (4,'2008-08-01',0,180),
  (4,'2008-11-01',0,210),
  (4,'2009-05-01',0,270),
  (4,'2009-11-01',0,330),
  (5,'2008-05-01',0,600),
  (5,'2008-05-01',15,500),
  (5,'2008-05-01',30,350),
  (5,'2008-08-01',0,720),
  (5,'2008-08-01',15,600),
  (5,'2008-08-01',30,420),
  (5,'2008-11-01',0,840),
  (5,'2008-11-01',15,700),
  (5,'2008-11-01',30,490),
  (5,'2009-05-01',0,1080),
  (5,'2009-05-01',15,900),
  (5,'2009-05-01',30,630),
  (5,'2009-11-01',0,1320),
  (5,'2009-11-01',15,1100),
  (5,'2009-11-01',30,770);

COMMIT;

#
# Data for the `valores_servicios` table  (LIMIT 0,500)
#

INSERT INTO `valores_servicios` (`cod_propiedad`, `cod_servicio`, `fecha_valor`, `valor_servicio`) VALUES 
  (1,1,'2008-03-18',20),
  (1,1,'2008-06-18',23),
  (1,1,'2008-09-18',30),
  (1,1,'2009-03-18',38),
  (1,1,'2009-09-18',45),
  (1,2,'2008-03-18',70),
  (1,2,'2008-06-18',75),
  (1,2,'2008-09-18',85),
  (1,2,'2009-03-18',70),
  (1,2,'2009-09-18',68),
  (1,3,'2008-03-18',50),
  (1,3,'2008-06-18',45),
  (1,3,'2008-09-18',55),
  (1,3,'2009-03-18',60),
  (1,3,'2009-09-18',70),
  (2,2,'2008-03-20',100),
  (2,2,'2008-06-20',120),
  (2,2,'2008-09-20',130),
  (2,2,'2009-03-20',145),
  (2,2,'2009-09-20',160),
  (2,5,'2008-03-20',150),
  (2,5,'2008-06-20',155),
  (2,5,'2008-09-20',150),
  (2,5,'2009-03-20',160),
  (2,5,'2009-09-20',170),
  (3,2,'2008-04-15',90),
  (3,2,'2008-07-15',100),
  (3,2,'2008-10-15',125),
  (3,2,'2009-04-15',140),
  (3,2,'2009-10-15',150),
  (3,4,'2008-04-15',20),
  (3,4,'2008-07-15',25),
  (3,4,'2008-10-15',35),
  (3,4,'2009-04-15',45),
  (3,4,'2009-10-15',55),
  (4,1,'2008-05-01',40),
  (4,1,'2008-08-01',30),
  (4,1,'2008-11-01',45),
  (4,1,'2009-05-01',50),
  (4,1,'2009-11-01',60),
  (4,4,'2008-05-01',30),
  (4,4,'2008-08-01',45),
  (4,4,'2008-11-01',60),
  (4,4,'2009-05-01',65),
  (4,4,'2009-11-01',70),
  (4,5,'2008-05-01',150),
  (4,5,'2008-08-01',140),
  (4,5,'2008-11-01',155),
  (4,5,'2009-05-01',170),
  (4,5,'2009-11-01',210);

COMMIT;

