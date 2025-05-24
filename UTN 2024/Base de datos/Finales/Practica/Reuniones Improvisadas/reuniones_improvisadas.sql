# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : reuniones_improvisadas


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `reuniones_improvisadas`;

CREATE DATABASE `reuniones_improvisadas`
    CHARACTER SET 'latin1'
    COLLATE 'latin1_swedish_ci';

USE `reuniones_improvisadas`;

#
# Structure for the `personas` table : 
#

DROP TABLE IF EXISTS `personas`;

CREATE TABLE `personas` (
  `idpersona` int(11) NOT NULL,
  `apellidoynombre` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `direccion` varchar(30) NOT NULL,
  `email` varchar(50) default NULL,
  `fecha_tentativa` date default NULL,
  `consultas` varchar(200) default NULL,
  `dni` int(11) default NULL,
  `empresa` varchar(20) default NULL,
  `nro_tel_laboral` varchar(20) default NULL,
  PRIMARY KEY  (`idpersona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `decorados` table : 
#

DROP TABLE IF EXISTS `decorados`;

CREATE TABLE `decorados` (
  `desc_decorado` varchar(50) NOT NULL,
  PRIMARY KEY  (`desc_decorado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `salones` table : 
#

DROP TABLE IF EXISTS `salones`;

CREATE TABLE `salones` (
  `ubicacion` varchar(50) NOT NULL,
  `dimensiones` varchar(20) NOT NULL,
  `cant_max_asistentes` int(11) NOT NULL,
  `caracteristicas` varchar(100) default NULL,
  `desc_decorado` varchar(50) NOT NULL,
  PRIMARY KEY  (`ubicacion`),
  KEY `salones_decorados_fk` (`desc_decorado`),
  CONSTRAINT `salones_decorados_fk` FOREIGN KEY (`desc_decorado`) REFERENCES `decorados` (`desc_decorado`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `empleados` table : 
#

DROP TABLE IF EXISTS `empleados`;

CREATE TABLE `empleados` (
  `dni` int(11) NOT NULL,
  `apellidoynombres` varchar(50) NOT NULL,
  PRIMARY KEY  (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `contratos_por_eventos` table : 
#

DROP TABLE IF EXISTS `contratos_por_eventos`;

CREATE TABLE `contratos_por_eventos` (
  `nro_contrato` int(11) NOT NULL,
  `fecha_evento` date default NULL,
  `cantidad_personas` int(11) default NULL,
  `fecha_inspeccion_salon` date default NULL,
  `dias_preparativos_salon` int(11) default NULL,
  `serv_personalizado` varchar(50) default NULL,
  `valor_serv_pers` float(9,3) default NULL,
  `dni_empleado` int(11) default NULL,
  `idpersona` int(11) default NULL,
  `salon_ubicacion` varchar(50) default NULL,
  PRIMARY KEY  (`nro_contrato`),
  KEY `contratos_por_eventos__empleadosfk` (`dni_empleado`),
  KEY `contratos_por_eventos_personas_fk` (`idpersona`),
  KEY `contratos_por_eventos_salones_fk` (`salon_ubicacion`),
  CONSTRAINT `contratos_por_eventos_personas_fk` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`) ON UPDATE CASCADE,
  CONSTRAINT `contratos_por_eventos_salones_fk` FOREIGN KEY (`salon_ubicacion`) REFERENCES `salones` (`ubicacion`) ON UPDATE CASCADE,
  CONSTRAINT `contratos_por_eventos__empleadosfk` FOREIGN KEY (`dni_empleado`) REFERENCES `empleados` (`dni`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `precios_salones` table : 
#

DROP TABLE IF EXISTS `precios_salones`;

CREATE TABLE `precios_salones` (
  `ubicacion` varchar(50) NOT NULL,
  `fecha_precio` date NOT NULL,
  `importe` float(9,3) NOT NULL,
  PRIMARY KEY  (`ubicacion`,`fecha_precio`),
  CONSTRAINT `precios_salones_salones_fk` FOREIGN KEY (`ubicacion`) REFERENCES `salones` (`ubicacion`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `servicios` table : 
#

DROP TABLE IF EXISTS `servicios`;

CREATE TABLE `servicios` (
  `nombre_servicios` varchar(30) NOT NULL,
  `descripcion_detallada` varchar(50) NOT NULL,
  PRIMARY KEY  (`nombre_servicios`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `precios_servicios` table : 
#

DROP TABLE IF EXISTS `precios_servicios`;

CREATE TABLE `precios_servicios` (
  `nombre_servicio` varchar(30) NOT NULL,
  `fecha_precio` date NOT NULL,
  `importe` float(9,3) NOT NULL,
  PRIMARY KEY  (`nombre_servicio`,`fecha_precio`),
  CONSTRAINT `precios_servicios_servicios_fk` FOREIGN KEY (`nombre_servicio`) REFERENCES `servicios` (`nombre_servicios`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `recibos_pago` table : 
#

DROP TABLE IF EXISTS `recibos_pago`;

CREATE TABLE `recibos_pago` (
  `nro_recibo` int(11) NOT NULL,
  `fecha_recibo` date NOT NULL,
  `valor_abonado` float(9,3) NOT NULL,
  `nro_contrato` int(11) NOT NULL,
  PRIMARY KEY  (`nro_recibo`),
  KEY `recibos_pago_contrato_fk` (`nro_contrato`),
  CONSTRAINT `recibos_pago_contrato_fk` FOREIGN KEY (`nro_contrato`) REFERENCES `contratos_por_eventos` (`nro_contrato`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `servicios_contratos` table : 
#

DROP TABLE IF EXISTS `servicios_contratos`;

CREATE TABLE `servicios_contratos` (
  `nro_contrato` int(11) NOT NULL,
  `nombre_servicio` varchar(30) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `fecha_fin` date default NULL,
  `hora_fin` time default NULL,
  PRIMARY KEY  (`nro_contrato`,`nombre_servicio`,`fecha_inicio`,`hora_inicio`),
  KEY `servicios_contratos_servicios_fk` (`nombre_servicio`),
  CONSTRAINT `servicios_contratos_contratos_fk` FOREIGN KEY (`nro_contrato`) REFERENCES `contratos_por_eventos` (`nro_contrato`) ON UPDATE CASCADE,
  CONSTRAINT `servicios_contratos_servicios_fk` FOREIGN KEY (`nombre_servicio`) REFERENCES `servicios` (`nombre_servicios`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `valores_empleados` table : 
#

DROP TABLE IF EXISTS `valores_empleados`;

CREATE TABLE `valores_empleados` (
  `dni` int(11) NOT NULL,
  `anio_valor` int(4) NOT NULL,
  `mes_valor` int(2) NOT NULL,
  `sueldo_basico` float(9,3) NOT NULL,
  `porcentaje_comision` float(9,3) NOT NULL,
  PRIMARY KEY  (`dni`,`anio_valor`,`mes_valor`),
  CONSTRAINT `valores_empleados_empleados_fk` FOREIGN KEY (`dni`) REFERENCES `empleados` (`dni`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Data for the `personas` table  (LIMIT 0,500)
#

INSERT INTO `personas` (`idpersona`, `apellidoynombre`, `telefono`, `direccion`, `email`, `fecha_tentativa`, `consultas`, `dni`, `empresa`, `nro_tel_laboral`) VALUES 
  (1,'Mohandas Karamchand Gandhi','4956321','Buenos Aires 239 4º C','paz@interior.org','2007-08-25',NULL,15964218,'Paz Interior','4253687'),
  (2,'Helen Keller','4652311','San Martín 6107','hkeller@helenkeller.org','2007-09-08','¿Tienen salones equipados para discapacitados?',5496325,'Fundación Keller','46523687'),
  (3,'Edmund Hillary','4874962','Everest',NULL,'2007-09-18',NULL,11521896,'Alpinistas Famosos','4751255'),
  (4,'Marya Saloméa Sktodowska Boguska','4552007 ','Pellegrini 7214','msktodowska@gmail.com','2007-12-03','¿En cuantas cuotas se puede pagar?',NULL,NULL,NULL),
  (5,'Tenzing Norgay','4885264','Chomolungma',NULL,'2007-08-20',NULL,NULL,NULL,NULL);

COMMIT;

#
# Data for the `decorados` table  (LIMIT 0,500)
#

INSERT INTO `decorados` (`desc_decorado`) VALUES 
  ('infantil'),
  ('marino'),
  ('minimalista'),
  ('moderno');

COMMIT;

#
# Data for the `salones` table  (LIMIT 0,500)
#

INSERT INTO `salones` (`ubicacion`, `dimensiones`, `cant_max_asistentes`, `caracteristicas`, `desc_decorado`) VALUES 
  ('Arijon 312','12 m x 30 m',180,'Incluye juegos para chicos, patio y habitación para padres','infantil'),
  ('Canal 5 Salon 2','20 m x 40 m',450,'Buena Vista. Salida al río. Estacionamiento incluido','marino'),
  ('Mendoza 8405','50 m x 20 m',500,'Aire libre. Ideal Verano','minimalista'),
  ('Moreno 1398','18 m x 35 m',250,'Aire acondicionado. Pista central elevada','moderno');

COMMIT;

#
# Data for the `empleados` table  (LIMIT 0,500)
#

INSERT INTO `empleados` (`dni`, `apellidoynombres`) VALUES 
  (27548963,'Rolihlahla Dalibhunga Mandela'),
  (28452698,'Samuel Langhorne Clemens'),
  (30541247,'Agnes Gonxha Bojaxhiu');

COMMIT;

#
# Data for the `contratos_por_eventos` table  (LIMIT 0,500)
#

INSERT INTO `contratos_por_eventos` (`nro_contrato`, `fecha_evento`, `cantidad_personas`, `fecha_inspeccion_salon`, `dias_preparativos_salon`, `serv_personalizado`, `valor_serv_pers`, `dni_empleado`, `idpersona`, `salon_ubicacion`) VALUES 
  (1,'2007-08-25',150,NULL,NULL,'Payaso cantando feliz cumple',50,30541247,1,'Arijon 312'),
  (2,'2007-09-08',400,NULL,NULL,'La novia y el novio entran en lancha del muelle',250,27548963,2,'Canal 5 Salon 2'),
  (3,'2007-09-18',NULL,'2007-09-01',15,NULL,0,28452698,3,NULL),
  (4,'2007-09-25',NULL,'2007-09-05',20,NULL,0,30541247,1,NULL),
  (5,'2007-09-25',250,NULL,NULL,NULL,0,27548963,3,'Moreno 1398');

COMMIT;

#
# Data for the `precios_salones` table  (LIMIT 0,500)
#

INSERT INTO `precios_salones` (`ubicacion`, `fecha_precio`, `importe`) VALUES 
  ('Arijon 312','2007-08-01',210),
  ('Arijon 312','2007-09-01',250),
  ('Canal 5 Salon 2','2007-08-01',600),
  ('Canal 5 Salon 2','2007-09-01',700),
  ('Mendoza 8405','2007-08-01',500),
  ('Mendoza 8405','2007-09-01',580),
  ('Moreno 1398','2007-08-01',280),
  ('Moreno 1398','2007-09-01',300);

COMMIT;

#
# Data for the `servicios` table  (LIMIT 0,500)
#

INSERT INTO `servicios` (`nombre_servicios`, `descripcion_detallada`) VALUES 
  ('acondicionamiento salon','Preparar una salon del cliente para un evento'),
  ('catering','Entrada, Plato Principal, Postre y una bebida'),
  ('cotillon','disfraces'),
  ('musica','DJ, y equipo de sonido'),
  ('musica en vivo','Banda, Intrumentos y Equipo de sonido');

COMMIT;

#
# Data for the `precios_servicios` table  (LIMIT 0,500)
#

INSERT INTO `precios_servicios` (`nombre_servicio`, `fecha_precio`, `importe`) VALUES 
  ('acondicionamiento salon','2007-08-01',250),
  ('acondicionamiento salon','2007-09-01',300),
  ('catering','2007-08-01',300),
  ('catering','2007-09-01',360),
  ('cotillon','2007-08-01',180),
  ('cotillon','2007-09-01',216),
  ('musica','2007-08-01',100),
  ('musica','2007-09-01',120),
  ('musica en vivo','2007-08-01',500),
  ('musica en vivo','2007-09-01',600);

COMMIT;

#
# Data for the `recibos_pago` table  (LIMIT 0,500)
#

INSERT INTO `recibos_pago` (`nro_recibo`, `fecha_recibo`, `valor_abonado`, `nro_contrato`) VALUES 
  (1,'2007-08-10',440,1),
  (2,'2007-08-15',400,1),
  (3,'2007-09-06',1046,2),
  (4,'2007-09-09',600,2),
  (5,'2007-09-01',780,3),
  (6,'2007-09-01',1000,4),
  (7,'2007-09-15',260,4),
  (8,'2007-09-05',1260,5);

COMMIT;

#
# Data for the `servicios_contratos` table  (LIMIT 0,500)
#

INSERT INTO `servicios_contratos` (`nro_contrato`, `nombre_servicio`, `fecha_inicio`, `hora_inicio`, `fecha_fin`, `hora_fin`) VALUES 
  (1,'catering','2007-08-25','18:04:45','2007-08-25','20:00:00'),
  (1,'cotillon','2007-08-25','19:04:45','2007-08-25','20:00:00'),
  (1,'musica','2007-08-25','18:04:45','2007-08-25','20:00:00'),
  (2,'catering','2007-09-08','18:04:45','2007-09-08','23:05:30'),
  (2,'cotillon','2007-09-08','22:00:00','2007-09-09','01:00:00'),
  (2,'musica','2007-09-08','18:04:45','2007-09-09','01:00:00'),
  (3,'acondicionamiento salon','2007-09-16','18:04:45','2007-09-17','18:05:03'),
  (3,'catering','2007-09-18','21:04:45','2007-09-18','23:05:17'),
  (3,'musica','2007-09-18','21:04:45','2007-09-18','23:05:17'),
  (4,'acondicionamiento salon','2007-09-23','21:04:45','2007-09-24','21:04:52'),
  (4,'catering','2007-09-25','21:04:45','2007-09-25','23:30:00'),
  (4,'musica en vivo','2007-09-25','19:04:45','2007-09-25','23:30:00'),
  (5,'catering','2007-09-25','20:00:00','2007-09-25','23:00:00'),
  (5,'musica en vivo','2007-09-25','20:00:00','2007-09-25','23:00:00');

COMMIT;

#
# Data for the `valores_empleados` table  (LIMIT 0,500)
#

INSERT INTO `valores_empleados` (`dni`, `anio_valor`, `mes_valor`, `sueldo_basico`, `porcentaje_comision`) VALUES 
  (27548963,2007,8,800,20),
  (27548963,2007,9,950,21),
  (27548963,2007,10,950,21),
  (28452698,2007,8,900,18),
  (28452698,2007,9,1100,19),
  (28452698,2007,10,1100,19),
  (30541247,2007,8,900,15),
  (30541247,2007,9,1200,19),
  (30541247,2007,10,1200,19);

COMMIT;

