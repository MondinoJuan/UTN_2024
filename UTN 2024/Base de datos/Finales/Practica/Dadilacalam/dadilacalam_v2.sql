# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : dadilacalam


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `dadilacalam`;

CREATE DATABASE `dadilacalam`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `dadilacalam`;

#
# Structure for the `clientes` table : 
#

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `cod_cliente` int(11) NOT NULL,
  `nombre_cliente` varchar(50) NOT NULL,
  `codigo_postal` varchar(10) NOT NULL,
  `localidad` varchar(50) NOT NULL,
  `telefono` varchar(20) default NULL,
  `direccion` varchar(50) default NULL,
  `pais` varchar(50) NOT NULL,
  `id_nacional` varchar(20) NOT NULL,
  PRIMARY KEY  (`cod_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `productos` table : 
#

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `nro_serie` int(11) NOT NULL,
  `nombre_producto` varchar(20) NOT NULL,
  `fecha_fabricacion` date NOT NULL,
  `fecha_compra` date default NULL,
  `fecha_baja` date default NULL,
  `motivo_baja` varchar(50) default NULL,
  `cod_cliente` int(11) default NULL,
  PRIMARY KEY  (`nro_serie`),
  KEY `productos_clientes_fk` (`cod_cliente`),
  CONSTRAINT `productos_clientes_fk` FOREIGN KEY (`cod_cliente`) REFERENCES `clientes` (`cod_cliente`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `componentes` table : 
#

DROP TABLE IF EXISTS `componentes`;

CREATE TABLE `componentes` (
  `nro_serie_principal` int(11) NOT NULL,
  `nro_serie_componente` int(11) NOT NULL,
  `fecha_ensamble` date NOT NULL,
  `fecha_remocion` date default NULL,
  `observacion` varchar(200) default NULL,
  PRIMARY KEY  (`nro_serie_principal`,`nro_serie_componente`,`fecha_ensamble`),
  KEY `componentes_producto_componente_fk` (`nro_serie_componente`),
  CONSTRAINT `componentes_producto_componente_fk` FOREIGN KEY (`nro_serie_componente`) REFERENCES `productos` (`nro_serie`) ON UPDATE CASCADE,
  CONSTRAINT `componentes_producto_principal_fk` FOREIGN KEY (`nro_serie_principal`) REFERENCES `productos` (`nro_serie`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `contratos` table : 
#

DROP TABLE IF EXISTS `contratos`;

CREATE TABLE `contratos` (
  `nro_contrato` int(11) NOT NULL,
  `fecha_contrato` date NOT NULL,
  `fecha_ini_soporte` date NOT NULL,
  `fecha_fin_soporte` date NOT NULL,
  `fecha_rescindido` date default NULL,
  `valor_pactado` float(9,3) NOT NULL,
  `forma_pago` varchar(200) default NULL,
  PRIMARY KEY  (`nro_contrato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `contratos_productos` table : 
#

DROP TABLE IF EXISTS `contratos_productos`;

CREATE TABLE `contratos_productos` (
  `nro_contrato` int(11) NOT NULL,
  `nro_serie` int(11) NOT NULL,
  PRIMARY KEY  (`nro_contrato`,`nro_serie`),
  KEY `contratos_productos_productos_fk` (`nro_serie`),
  CONSTRAINT `contratos_productos_contratos_fk` FOREIGN KEY (`nro_contrato`) REFERENCES `contratos` (`nro_contrato`) ON UPDATE CASCADE,
  CONSTRAINT `contratos_productos_productos_fk` FOREIGN KEY (`nro_serie`) REFERENCES `productos` (`nro_serie`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `personal_soporte` table : 
#

DROP TABLE IF EXISTS `personal_soporte`;

CREATE TABLE `personal_soporte` (
  `legajo` int(11) NOT NULL,
  `nom_ape` varchar(50) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `dni` varchar(20) NOT NULL,
  PRIMARY KEY  (`legajo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `problemas` table : 
#

DROP TABLE IF EXISTS `problemas`;

CREATE TABLE `problemas` (
  `cod_problema` int(11) NOT NULL,
  `desc_problema` varchar(200) NOT NULL,
  `causas_probables` varchar(200) NOT NULL,
  `procedimiento_diagnostico` varchar(200) NOT NULL,
  `requiere_recupero` tinyint(1) NOT NULL,
  `posible_solucion` varchar(200) NOT NULL,
  PRIMARY KEY  (`cod_problema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tickets` table : 
#

DROP TABLE IF EXISTS `tickets`;

CREATE TABLE `tickets` (
  `nro_ticket` int(11) NOT NULL,
  `fecha_hora_ingreso` datetime NOT NULL,
  `descripcion_problema` varchar(200) default NULL,
  `fecha_hora_resolucion` datetime default NULL,
  `informe_solucion` varchar(200) default NULL,
  `nro_serie` int(11) NOT NULL,
  `legajo` int(11) NOT NULL,
  PRIMARY KEY  (`nro_ticket`),
  KEY `tickets_productos_fk` (`nro_serie`),
  KEY `tickets_personal_soporte_fk` (`legajo`),
  CONSTRAINT `tickets_personal_soporte_fk` FOREIGN KEY (`legajo`) REFERENCES `personal_soporte` (`legajo`) ON UPDATE CASCADE,
  CONSTRAINT `tickets_productos_fk` FOREIGN KEY (`nro_serie`) REFERENCES `productos` (`nro_serie`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `problemas_tickets` table : 
#

DROP TABLE IF EXISTS `problemas_tickets`;

CREATE TABLE `problemas_tickets` (
  `nro_ticket` int(11) NOT NULL,
  `fecha_hora_registro` datetime NOT NULL,
  `cod_problema` int(11) NOT NULL,
  `cancelado` tinyint(1) default NULL,
  `cubierto_contrato` tinyint(1) default NULL,
  `valor_pactado` float(9,3) default NULL,
  `aceptado` tinyint(1) default NULL,
  PRIMARY KEY  (`nro_ticket`,`fecha_hora_registro`),
  KEY `problemas_tickets_problemas_fk` (`cod_problema`),
  CONSTRAINT `problemas_tickets_problemas_fk` FOREIGN KEY (`cod_problema`) REFERENCES `problemas` (`cod_problema`) ON UPDATE CASCADE,
  CONSTRAINT `problemas_tickets_tickets_fk` FOREIGN KEY (`nro_ticket`) REFERENCES `tickets` (`nro_ticket`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `procedimientos_reparaciones` table : 
#

DROP TABLE IF EXISTS `procedimientos_reparaciones`;

CREATE TABLE `procedimientos_reparaciones` (
  `cod_procedimiento` int(11) NOT NULL,
  `desc_procedimiento` varchar(20) NOT NULL,
  `pasos` varchar(200) NOT NULL,
  PRIMARY KEY  (`cod_procedimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `reparaciones` table : 
#

DROP TABLE IF EXISTS `reparaciones`;

CREATE TABLE `reparaciones` (
  `nro_ticket` int(11) NOT NULL,
  `fecha_hora_registro` datetime NOT NULL,
  `cod_procedimiento` int(11) NOT NULL,
  `legajo` int(11) NOT NULL,
  `fecha_hora_asigna` datetime NOT NULL,
  `fecha_hora_ini` datetime default NULL,
  `fecha_hora_fin` datetime default NULL,
  `resultado` varchar(50) default NULL,
  `observaciones` varchar(200) default NULL,
  PRIMARY KEY  (`nro_ticket`,`fecha_hora_registro`,`cod_procedimiento`,`legajo`,`fecha_hora_asigna`),
  KEY `reparaciones_procedimientos_reparaciones_fk` (`cod_procedimiento`),
  KEY `reparaciones_personal_soporte_fk` (`legajo`),
  CONSTRAINT `reparaciones_personal_soporte_fk` FOREIGN KEY (`legajo`) REFERENCES `personal_soporte` (`legajo`) ON UPDATE CASCADE,
  CONSTRAINT `reparaciones_problemas_tickets_fk` FOREIGN KEY (`nro_ticket`, `fecha_hora_registro`) REFERENCES `problemas_tickets` (`nro_ticket`, `fecha_hora_registro`) ON UPDATE CASCADE,
  CONSTRAINT `reparaciones_procedimientos_reparaciones_fk` FOREIGN KEY (`cod_procedimiento`) REFERENCES `procedimientos_reparaciones` (`cod_procedimiento`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tipos_soporte` table : 
#

DROP TABLE IF EXISTS `tipos_soporte`;

CREATE TABLE `tipos_soporte` (
  `cod_tipo_soporte` int(11) NOT NULL,
  `nom_tipo_soporte` varchar(50) NOT NULL,
  `detalle_tipo_soporte` varchar(200) NOT NULL,
  PRIMARY KEY  (`cod_tipo_soporte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tipos_soporte_contratos` table : 
#

DROP TABLE IF EXISTS `tipos_soporte_contratos`;

CREATE TABLE `tipos_soporte_contratos` (
  `cod_tipo_soporte` int(11) NOT NULL,
  `nro_contrato` int(11) NOT NULL,
  PRIMARY KEY  (`cod_tipo_soporte`,`nro_contrato`),
  KEY `tipos_soporte_contratos_contratos_fk` (`nro_contrato`),
  CONSTRAINT `tipos_soporte_contratos_contratos_fk` FOREIGN KEY (`nro_contrato`) REFERENCES `contratos` (`nro_contrato`) ON UPDATE CASCADE,
  CONSTRAINT `tipos_soporte_contratos_tipos_soporte_fk` FOREIGN KEY (`cod_tipo_soporte`) REFERENCES `tipos_soporte` (`cod_tipo_soporte`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_problemas` table : 
#

DROP TABLE IF EXISTS `valores_problemas`;

CREATE TABLE `valores_problemas` (
  `cod_problema` int(11) NOT NULL,
  `fecha_valor` date NOT NULL,
  `valor_problema` float(9,3) NOT NULL,
  PRIMARY KEY  (`cod_problema`,`fecha_valor`),
  CONSTRAINT `valores_problemas_problemas_fk` FOREIGN KEY (`cod_problema`) REFERENCES `problemas` (`cod_problema`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `valores_tipos_soporte` table : 
#

DROP TABLE IF EXISTS `valores_tipos_soporte`;

CREATE TABLE `valores_tipos_soporte` (
  `cod_tipo_soporte` int(11) NOT NULL,
  `fecha_valor` date NOT NULL,
  `valor_soporte` float(9,3) NOT NULL,
  PRIMARY KEY  (`cod_tipo_soporte`,`fecha_valor`),
  CONSTRAINT `valores_tipos_soporte_tipos_soporte_fk` FOREIGN KEY (`cod_tipo_soporte`) REFERENCES `tipos_soporte` (`cod_tipo_soporte`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `clientes` table  (LIMIT 0,500)
#

INSERT INTO `clientes` (`cod_cliente`, `nombre_cliente`, `codigo_postal`, `localidad`, `telefono`, `direccion`, `pais`, `id_nacional`) VALUES 
  (1,'Afatse','1111','Rosario','11 111 111-1111','Maipu 1111','Argentina','11111111111'),
  (2,'Caluter','2222','Miami','02 222 22222','2222 2nd Street','USA','22B22222222'),
  (3,'Viejos Amigos','3333','Rosario','33 333 333-3333','Sarmiento 333','Argentina','33333333333'),
  (4,'Alquileres Cutrosh','4444','Rio de Janeiro','44 44 444444','Palmas 444','Brasil','44444444444');

COMMIT;

#
# Data for the `productos` table  (LIMIT 0,500)
#

INSERT INTO `productos` (`nro_serie`, `nombre_producto`, `fecha_fabricacion`, `fecha_compra`, `fecha_baja`, `motivo_baja`, `cod_cliente`) VALUES 
  (1,'Placa Video Trident','2001-01-01',NULL,NULL,NULL,NULL),
  (2,'Memoria DDR3 1066','2009-12-02','2010-06-01',NULL,NULL,3),
  (3,'SDD 1 TB','2010-01-03',NULL,NULL,NULL,NULL),
  (4,'SDD 2 TB','2010-04-04',NULL,NULL,NULL,NULL),
  (5,'Placa Sonido Intel','2009-12-05',NULL,NULL,NULL,NULL),
  (6,'Intel i3 2.8GHz','2009-04-06',NULL,'2010-07-07','se quemó',NULL),
  (7,'Placa WIFI Cisco','2009-08-07',NULL,NULL,NULL,NULL),
  (8,'Intel i3 2.8GHz','2009-04-08',NULL,NULL,NULL,NULL),
  (9,'Memoria DDR3 1066','2010-01-09',NULL,NULL,NULL,NULL),
  (10,'Mouse G5','2010-01-10','2010-01-11',NULL,NULL,1),
  (11,'Notebook D','2010-01-11','2010-01-15',NULL,NULL,1),
  (12,'Notebook D','2010-03-12','2010-08-01',NULL,NULL,NULL),
  (13,'PC Desktop 333','2010-03-13','2010-05-01',NULL,NULL,2),
  (14,'Monitor X4','2010-04-14','2010-06-16','2010-07-17','se rompio',4),
  (15,'SDD 2 TB','2010-06-03',NULL,NULL,NULL,NULL);

COMMIT;

#
# Data for the `componentes` table  (LIMIT 0,500)
#

INSERT INTO `componentes` (`nro_serie_principal`, `nro_serie_componente`, `fecha_ensamble`, `fecha_remocion`, `observacion`) VALUES 
  (11,3,'2010-03-12',NULL,NULL),
  (11,4,'2010-01-11','2010-03-12','disco incompatible con el touch pad'),
  (12,4,'2010-03-12',NULL,NULL),
  (12,5,'2010-03-12',NULL,NULL),
  (13,1,'2010-03-13',NULL,NULL),
  (13,2,'2010-03-13','2010-05-15','esta memoria está defectuosa, traten de venderla pronto'),
  (13,6,'2010-03-13','2010-07-07','se recalienta el micro pero es porque la placa de video se burla de él. Sirve para otra pc'),
  (13,7,'2010-03-13',NULL,NULL),
  (13,8,'2010-07-07',NULL,NULL),
  (13,9,'2010-05-15',NULL,NULL);

COMMIT;

#
# Data for the `contratos` table  (LIMIT 0,500)
#

INSERT INTO `contratos` (`nro_contrato`, `fecha_contrato`, `fecha_ini_soporte`, `fecha_fin_soporte`, `fecha_rescindido`, `valor_pactado`, `forma_pago`) VALUES 
  (1,'2010-01-11','2011-01-11','2011-04-11','2010-01-16',2330,'efectivo 330 y cheque 2000'),
  (2,'2010-01-15','2010-01-16','2011-01-16',NULL,15000,'3 pagos de 5000 30, 60 y 90'),
  (3,'2010-05-01','2010-05-03','2010-12-03',NULL,1700,'170 cuotas mensuales de $10'),
  (4,'2010-05-26','2010-06-01','2010-12-01',NULL,5400,'contado efectivo'),
  (5,'2010-06-01','2010-06-03','2010-07-03',NULL,270,'cheque a 120 días'),
  (6,'2010-06-16','2010-06-18','2010-07-18',NULL,6230,'3230 en cheque corriente y 3 cheques de 1000 a 30, 60 y 120'),
  (7,'2010-06-01','2010-07-03','2010-08-03',NULL,280,'debito automático'),
  (8,'2010-06-30','2010-08-03','2010-09-03',NULL,3500,'7 cuotas de 500 con tarjeta de crédito');

COMMIT;

#
# Data for the `contratos_productos` table  (LIMIT 0,500)
#

INSERT INTO `contratos_productos` (`nro_contrato`, `nro_serie`) VALUES 
  (5,2),
  (7,2),
  (8,2),
  (1,10),
  (2,10),
  (2,11),
  (3,13),
  (4,13),
  (6,14);

COMMIT;

#
# Data for the `personal_soporte` table  (LIMIT 0,500)
#

INSERT INTO `personal_soporte` (`legajo`, `nom_ape`, `fecha_nacimiento`, `fecha_ingreso`, `dni`) VALUES 
  (10,'Albert Camus','1913-10-10','2009-10-10','10101010'),
  (11,'Miguel de Unamuno','1864-01-01','2009-11-11','11111111'),
  (12,'Ernest Hemingway','1899-02-02','2009-12-12','12121212'),
  (13,'José de Sousa Saramago','1922-11-16','2010-06-18','13131313');

COMMIT;

#
# Data for the `problemas` table  (LIMIT 0,500)
#

INSERT INTO `problemas` (`cod_problema`, `desc_problema`, `causas_probables`, `procedimiento_diagnostico`, `requiere_recupero`, `posible_solucion`) VALUES 
  (1,'Se recalienta el micro','mala placa de video','ponga un video de álta calidad a reproducir y mida la temperatura del micro en el proceso',1,'Cambiar el micro o cambiar placa de video'),
  (2,'Tiene fallas aleatorias y está sucio el producto','falta de limpieza','pasar el dedo, por el producto y soplar por alguna avertura del mismo, si el dedo se vuelve gris o la tierra deja ciego al que sopló es un problema de limpieza',1,'Limpiarlo'),
  (3,'El windows se cuelga','problemas de configuración del windows','prenda la pc y si dice windows al arranque es un problema de configuración',1,'Reinstalar windows u algun sistema operativo de verdad'),
  (4,'Software que no tiene todas las funciones o falla','Falta un dll o algún virus desconfiguró la aplicación','ejecutar la aplicación, si tira un cartel que falta una dll o no realiza lo especificado según el manual (si lo tiene y lo encuentran)',0,'Reinstalar producto o sistema (puede hacerse en forma remota)'),
  (5,'Anda mal la placa de video o sonido','mal instalado el driver o actualización defectuosa','ejecutar un video con sonido y se escuchará o verá mal',0,'Reinstalar driver de la/las placas que no funcionen (puede hacerse en forma remota)'),
  (6,'Equipo anda lento','windows','prenda la pc dirá windows al inicio',1,'Reinstalar el sistema operativo'),
  (7,'Producto no arranca','mala calidad del producto','probar que esté enchufado y tratar de encenderlo',1,'Enviarlo a alguien que sepa arreglarlo'),
  (8,'PC no reconoce el producto','drivers mal instalados','verificar los drivers que se encuentran en la pc, que sean compatibles con el producto',0,'Reinstalar driver del producto'),
  (9,'PC no reconoce el producto','PC y producto incompatibles','verificar en las especificaciones que el producto sea compatible con las características de la pc',1,'Enviarlo a alguien que sepa arreglarlo');

COMMIT;

#
# Data for the `tickets` table  (LIMIT 0,500)
#

INSERT INTO `tickets` (`nro_ticket`, `fecha_hora_ingreso`, `descripcion_problema`, `fecha_hora_resolucion`, `informe_solucion`, `nro_serie`, `legajo`) VALUES 
  (1,'2010-06-05 00:19:50','se tilda la pc','2010-06-05 01:59:50','Se devolvió sin arreglar',2,11),
  (3,'2010-01-19 00:07:04','anda lento','2010-01-19 01:45:07','arreglado',11,11),
  (6,'2010-06-17 17:12:49','se tilda la pc','2010-06-17 18:18:51','arreglado',14,11),
  (7,'2010-06-12 03:41:33','anda lento','2010-06-12 04:50:38','arreglado',2,11),
  (8,'2010-01-23 20:15:45','anda lento','2010-01-23 21:32:48','Se devolvió sin arreglar',10,11),
  (10,'2010-05-07 15:24:25','se tilda la pc','2010-05-07 16:41:25','atado con alambre',13,11),
  (11,'2010-06-25 02:45:11','anda lento','2010-06-25 04:00:16','arreglado',14,11),
  (12,'2010-06-14 09:17:23','no enciende','2010-06-14 10:18:24','atado con alambre',2,11),
  (13,'2010-01-25 08:18:35','se tilda la pc','2010-01-25 09:45:36','Se devolvió sin arreglar',10,10),
  (14,'2010-01-27 11:14:46','no enciende','2010-01-27 12:31:49','arreglado',11,11),
  (15,'2010-05-15 18:12:38','no enciende','2010-05-15 19:18:38','arreglado',13,10),
  (16,'2010-06-30 00:31:42','no enciende','2010-06-30 01:21:45','no sabemos como se arregló',14,11),
  (17,'2010-07-04 09:42:49','se tilda la pc','2010-07-04 10:51:53','arreglado',2,11),
  (18,'2010-02-14 09:48:35','no enciende','2010-02-14 10:51:35','no sabemos como se arregló',10,11),
  (20,'2010-07-07 13:36:47','anda lento','2010-07-07 14:47:49','Se devolvió sin arreglar',13,11),
  (22,'2010-07-27 08:30:45','se tilda la pc',NULL,'Se devolvió sin arreglar',2,12),
  (24,'2010-03-12 15:45:27','no enciende','2010-03-12 17:12:27','no sabemos como se arregló',11,10),
  (32,'2010-05-18 01:31:49','no enciende','2010-05-18 02:20:54','arreglado',11,12),
  (34,'2010-06-09 22:48:44','anda lento','2010-06-10 00:11:49','arreglado',10,11),
  (35,'2010-06-22 12:44:46','se tilda la pc','2010-06-22 14:16:48',NULL,11,12),
  (36,'2010-07-09 02:22:16','anda lento','2010-07-09 03:28:17',NULL,10,11),
  (37,'2010-07-26 11:17:18','no enciende',NULL,NULL,11,11);

COMMIT;

#
# Data for the `problemas_tickets` table  (LIMIT 0,500)
#

INSERT INTO `problemas_tickets` (`nro_ticket`, `fecha_hora_registro`, `cod_problema`, `cancelado`, `cubierto_contrato`, `valor_pactado`, `aceptado`) VALUES 
  (1,'2010-06-05 00:20:54',5,NULL,1,NULL,NULL),
  (1,'2010-06-05 00:21:50',5,NULL,1,NULL,NULL),
  (3,'2010-01-19 00:08:07',1,1,1,NULL,NULL),
  (3,'2010-01-19 00:09:07',6,NULL,1,NULL,NULL),
  (6,'2010-06-17 17:13:51',7,NULL,1,NULL,NULL),
  (6,'2010-06-17 17:14:50',3,NULL,0,282.424,1),
  (7,'2010-06-12 03:45:33',8,NULL,1,NULL,NULL),
  (7,'2010-06-12 03:46:38',2,NULL,1,NULL,NULL),
  (8,'2010-01-23 20:17:48',1,NULL,1,NULL,NULL),
  (8,'2010-01-23 20:19:49',6,NULL,1,NULL,NULL),
  (10,'2010-05-07 15:25:25',2,1,0,12.413,0),
  (10,'2010-05-07 15:28:27',7,NULL,1,NULL,NULL),
  (11,'2010-06-25 02:45:12',7,NULL,1,NULL,NULL),
  (11,'2010-06-25 02:48:16',6,NULL,1,NULL,NULL),
  (12,'2010-06-14 09:18:26',7,NULL,1,NULL,NULL),
  (12,'2010-06-14 09:22:24',6,NULL,1,NULL,NULL),
  (13,'2010-01-25 08:19:36',2,NULL,1,NULL,NULL),
  (13,'2010-01-25 08:19:39',7,1,0,285.763,1),
  (14,'2010-01-27 11:15:49',1,NULL,0,387.044,0),
  (14,'2010-01-27 11:17:47',6,1,0,110.834,1),
  (15,'2010-05-15 18:12:42',2,NULL,1,NULL,NULL),
  (15,'2010-05-15 18:13:38',3,NULL,1,NULL,NULL),
  (15,'2010-05-15 18:16:43',7,NULL,0,188.479,1),
  (16,'2010-06-30 00:32:45',7,NULL,1,NULL,NULL),
  (16,'2010-06-30 00:34:42',5,NULL,1,NULL,NULL),
  (17,'2010-07-04 09:43:53',2,NULL,1,NULL,NULL),
  (17,'2010-07-04 09:44:53',2,NULL,1,NULL,NULL),
  (18,'2010-02-14 09:49:39',6,NULL,0,287.03,1),
  (18,'2010-02-14 09:52:35',6,NULL,1,NULL,NULL),
  (20,'2010-07-07 13:38:49',2,NULL,1,NULL,NULL),
  (20,'2010-07-07 13:40:50',7,NULL,1,NULL,NULL),
  (22,'2010-07-27 08:31:47',1,NULL,1,NULL,NULL),
  (22,'2010-07-27 08:33:50',6,NULL,1,NULL,NULL),
  (24,'2010-03-12 15:45:27',1,NULL,1,NULL,NULL),
  (24,'2010-03-12 15:47:29',7,NULL,1,NULL,NULL),
  (32,'2010-05-18 01:35:52',2,NULL,1,NULL,NULL),
  (32,'2010-05-18 01:36:54',9,NULL,1,NULL,NULL),
  (34,'2010-06-09 22:49:49',6,NULL,1,NULL,NULL),
  (34,'2010-06-09 22:53:48',3,NULL,1,NULL,NULL),
  (35,'2010-06-22 12:46:51',6,NULL,0,310.92,0),
  (35,'2010-06-22 12:48:48',1,NULL,0,547.103,0),
  (36,'2010-07-09 02:23:20',5,NULL,1,NULL,NULL),
  (36,'2010-07-09 02:25:17',1,NULL,1,NULL,NULL),
  (36,'2010-07-09 02:27:17',5,NULL,0,258.592,1),
  (37,'2010-07-26 11:19:18',3,NULL,1,NULL,NULL),
  (37,'2010-07-26 11:22:21',8,NULL,1,NULL,NULL);

COMMIT;

#
# Data for the `procedimientos_reparaciones` table  (LIMIT 0,500)
#

INSERT INTO `procedimientos_reparaciones` (`cod_procedimiento`, `desc_procedimiento`, `pasos`) VALUES 
  (1,'Soplar','Inhalar aire, exhalar fuertemente hasta que no quede tierra. Pasar un trapo húmedo con un  limpiador multiuso'),
  (2,'Reinstalar','Registrar elementos instalados en la PC, chequear instaladores, formatear, instalar so y todo el software previamente instalado'),
  (3,'Cambiar componente','Retirar componente defectuoso, relevar características del componente, buscar reemplazo, controlar con las características del producto que sea compatible y colocar el nuevo componente'),
  (4,'Enviar a reparación','Pedir presupuesto a personal externo a la empresa que si sepa reparar los productos, hacer aprobar el presupuesto y llevar el producto a que lo reparen'),
  (5,'Instalar drivers','Ingresar a la pc vía acceso remoto, descargar driver, instalarlo'),
  (6,'Reconfigurar','Ingresar a la pc vía acceso remoto, modificar la configuración');

COMMIT;

#
# Data for the `reparaciones` table  (LIMIT 0,500)
#

INSERT INTO `reparaciones` (`nro_ticket`, `fecha_hora_registro`, `cod_procedimiento`, `legajo`, `fecha_hora_asigna`, `fecha_hora_ini`, `fecha_hora_fin`, `resultado`, `observaciones`) VALUES 
  (1,'2010-06-05 00:20:54',1,11,'2010-06-05 00:34:54','2010-06-05 01:16:54','2010-06-05 01:39:54','resuelto',NULL),
  (1,'2010-06-05 00:20:54',2,11,'2010-06-05 00:32:54','2010-06-05 00:54:54','2010-06-05 01:26:54','no resuelto',NULL),
  (1,'2010-06-05 00:21:50',1,11,'2010-06-05 00:45:50','2010-06-05 01:08:50','2010-06-05 02:02:50','resuelto',NULL),
  (1,'2010-06-05 00:21:50',2,10,'2010-06-05 01:04:50','2010-06-05 01:59:50','2010-06-05 02:30:50','resuelto',NULL),
  (3,'2010-01-19 00:08:07',1,11,'2010-01-19 00:52:07','2010-01-19 01:34:07','2010-01-19 01:59:07','resuelto',NULL),
  (3,'2010-01-19 00:08:07',2,11,'2010-01-19 00:30:07','2010-01-19 01:03:07','2010-01-19 01:36:07','resuelto',NULL),
  (3,'2010-01-19 00:09:07',1,10,'2010-01-19 00:39:07','2010-01-19 01:31:07','2010-01-19 02:12:07','resuelto',NULL),
  (3,'2010-01-19 00:09:07',2,10,'2010-01-19 01:01:07','2010-01-19 01:45:07','2010-01-19 02:28:07','resuelto','en una semana vuelve'),
  (6,'2010-06-17 17:13:51',1,11,'2010-06-17 17:27:51','2010-06-17 18:12:51','2010-06-17 19:04:51','resuelto',NULL),
  (6,'2010-06-17 17:13:51',2,11,'2010-06-17 17:24:51','2010-06-17 18:18:51','2010-06-17 18:50:51','resuelto',NULL),
  (6,'2010-06-17 17:14:50',1,11,'2010-06-17 17:27:50','2010-06-17 18:00:50','2010-06-17 18:22:50','resuelto',NULL),
  (6,'2010-06-17 17:14:50',2,12,'2010-06-17 17:45:50','2010-06-17 18:09:50','2010-06-17 18:20:50','resuelto',NULL),
  (7,'2010-06-12 03:45:33',1,12,'2010-06-12 04:29:33','2010-06-12 04:34:33','2010-06-12 05:08:33','resuelto',NULL),
  (7,'2010-06-12 03:45:33',2,11,'2010-06-12 04:28:33','2010-06-12 04:48:33','2010-06-12 05:19:33','resuelto',NULL),
  (7,'2010-06-12 03:46:38',1,10,'2010-06-12 03:49:38','2010-06-12 04:12:38','2010-06-12 04:45:38','resuelto',NULL),
  (7,'2010-06-12 03:46:38',2,11,'2010-06-12 04:27:38','2010-06-12 04:50:38','2010-06-12 05:12:38','resuelto',NULL),
  (8,'2010-01-23 20:17:48',1,11,'2010-01-23 20:31:48','2010-01-23 20:33:48','2010-01-23 20:53:48','no resuelto',NULL),
  (8,'2010-01-23 20:17:48',2,12,'2010-01-23 20:59:48','2010-01-23 21:32:48','2010-01-23 21:37:48','resuelto',NULL),
  (8,'2010-01-23 20:19:49',1,10,'2010-01-23 21:02:49','2010-01-23 21:25:49','2010-01-23 21:57:49','resuelto',NULL),
  (8,'2010-01-23 20:19:49',2,11,'2010-01-23 20:33:49','2010-01-23 20:57:49','2010-01-23 21:39:49','resuelto',NULL),
  (10,'2010-05-07 15:25:25',1,11,'2010-05-07 15:48:25','2010-05-07 16:11:25','2010-05-07 16:25:25','resuelto',NULL),
  (10,'2010-05-07 15:25:25',2,11,'2010-05-07 15:57:25','2010-05-07 16:41:25','2010-05-07 17:14:25','resuelto',NULL),
  (10,'2010-05-07 15:28:27',1,10,'2010-05-07 16:02:27','2010-05-07 16:13:27','2010-05-07 16:15:27','resuelto',NULL),
  (10,'2010-05-07 15:28:27',2,11,'2010-05-07 15:42:27','2010-05-07 16:25:27','2010-05-07 17:08:27','resuelto',NULL),
  (11,'2010-06-25 02:45:12',1,11,'2010-06-25 03:16:12','2010-06-25 03:36:12','2010-06-25 03:59:12','resuelto',NULL),
  (11,'2010-06-25 02:45:12',2,11,'2010-06-25 03:16:12','2010-06-25 03:18:12','2010-06-25 03:38:12','resuelto',NULL),
  (11,'2010-06-25 02:48:16',1,11,'2010-06-25 03:13:16','2010-06-25 03:36:16','2010-06-25 03:58:16','resuelto',NULL),
  (11,'2010-06-25 02:48:16',2,11,'2010-06-25 03:38:16','2010-06-25 04:00:16','2010-06-25 04:10:16','resuelto',NULL),
  (12,'2010-06-14 09:18:26',1,11,'2010-06-14 09:53:26','2010-06-14 10:08:26','2010-06-14 10:31:26','resuelto',NULL),
  (12,'2010-06-14 09:18:26',2,10,'2010-06-14 09:59:26','2010-06-14 10:01:26','2010-06-14 10:51:26','resuelto',NULL),
  (12,'2010-06-14 09:22:24',1,11,'2010-06-14 09:23:24','2010-06-14 09:44:24','2010-06-14 10:08:24','resuelto',NULL),
  (12,'2010-06-14 09:22:24',2,11,'2010-06-14 09:45:24','2010-06-14 10:18:24','2010-06-14 10:59:24','resuelto',NULL),
  (13,'2010-01-25 08:19:36',1,11,'2010-01-25 09:02:36','2010-01-25 09:45:36','2010-01-25 10:36:36','resuelto',NULL),
  (13,'2010-01-25 08:19:36',2,12,'2010-01-25 09:04:36','2010-01-25 09:44:36','2010-01-25 10:29:36','resuelto',NULL),
  (13,'2010-01-25 08:19:39',1,10,'2010-01-25 08:22:39','2010-01-25 09:05:39','2010-01-25 09:19:39','no resuelto',NULL),
  (13,'2010-01-25 08:19:39',2,12,'2010-01-25 08:34:39','2010-01-25 09:15:39','2010-01-25 09:30:39','resuelto',NULL),
  (14,'2010-01-27 11:15:49',1,12,'2010-01-27 11:46:49','2010-01-27 12:31:49','2010-01-27 12:41:49','resuelto',NULL),
  (14,'2010-01-27 11:15:49',2,12,'2010-01-27 11:26:49','2010-01-27 12:10:49','2010-01-27 12:40:49','resuelto',NULL),
  (14,'2010-01-27 11:17:47',1,11,'2010-01-27 11:32:47','2010-01-27 12:17:47','2010-01-27 12:42:47','resuelto',NULL),
  (14,'2010-01-27 11:17:47',2,11,'2010-01-27 11:48:47','2010-01-27 11:49:47','2010-01-27 12:23:47','resuelto',NULL),
  (15,'2010-05-15 18:12:42',1,11,'2010-05-15 18:15:42','2010-05-15 18:39:42','2010-05-15 19:01:42','resuelto',NULL),
  (15,'2010-05-15 18:12:42',2,10,'2010-05-15 18:36:42','2010-05-15 18:41:42','2010-05-15 19:13:42','resuelto',NULL),
  (15,'2010-05-15 18:13:38',1,12,'2010-05-15 18:55:38','2010-05-15 19:18:38','2010-05-15 20:10:38','resuelto',NULL),
  (15,'2010-05-15 18:13:38',2,12,'2010-05-15 18:37:38','2010-05-15 18:49:38','2010-05-15 19:43:38','resuelto',NULL),
  (15,'2010-05-15 18:16:43',1,11,'2010-05-15 18:27:43','2010-05-15 19:00:43','2010-05-15 19:15:43','resuelto',NULL),
  (15,'2010-05-15 18:16:43',2,11,'2010-05-15 18:48:43','2010-05-15 19:00:43','2010-05-15 19:54:43','resuelto',NULL),
  (16,'2010-06-30 00:32:45',1,10,'2010-06-30 00:52:45','2010-06-30 01:16:45','2010-06-30 01:56:45','resuelto',NULL),
  (16,'2010-06-30 00:32:45',2,12,'2010-06-30 01:06:45','2010-06-30 01:21:45','2010-06-30 01:54:45','resuelto',NULL),
  (16,'2010-06-30 00:34:42',1,11,'2010-06-30 00:36:42','2010-06-30 00:48:42','2010-06-30 01:20:42','resuelto',NULL),
  (16,'2010-06-30 00:34:42',2,10,'2010-06-30 00:47:42','2010-06-30 00:59:42','2010-06-30 01:34:42','resuelto',NULL),
  (17,'2010-07-04 09:43:53',1,11,'2010-07-04 10:24:53','2010-07-04 10:35:53','2010-07-04 11:29:53','resuelto',NULL),
  (17,'2010-07-04 09:43:53',2,11,'2010-07-04 10:17:53','2010-07-04 10:51:53','2010-07-04 11:13:53','resuelto',NULL),
  (17,'2010-07-04 09:44:53',1,11,'2010-07-04 09:58:53','2010-07-04 10:40:53','2010-07-04 11:02:53','resuelto',NULL),
  (17,'2010-07-04 09:44:53',2,11,'2010-07-04 09:56:53','2010-07-04 10:39:53','2010-07-04 11:12:53','resuelto',NULL),
  (18,'2010-02-14 09:49:39',1,12,'2010-02-14 10:00:39','2010-02-14 10:31:39','2010-02-14 10:44:39','resuelto',NULL),
  (18,'2010-02-14 09:49:39',2,11,'2010-02-14 10:14:39','2010-02-14 10:45:39','2010-02-14 11:27:39','resuelto',NULL),
  (18,'2010-02-14 09:52:35',1,12,'2010-02-14 10:07:35','2010-02-14 10:51:35','2010-02-14 11:32:35','resuelto',NULL),
  (18,'2010-02-14 09:52:35',2,11,'2010-02-14 10:26:35','2010-02-14 10:49:35','2010-02-14 11:40:35','resuelto',NULL),
  (20,'2010-07-07 13:38:49',1,10,'2010-07-07 13:51:49','2010-07-07 14:02:49','2010-07-07 14:07:49','resuelto',NULL),
  (20,'2010-07-07 13:38:49',2,11,'2010-07-07 14:02:49','2010-07-07 14:47:49','2010-07-07 15:11:49','resuelto',NULL),
  (20,'2010-07-07 13:40:50',1,10,'2010-07-07 14:32:50','2010-07-07 14:42:50','2010-07-07 14:53:50','resuelto',NULL),
  (20,'2010-07-07 13:40:50',2,12,'2010-07-07 13:45:50','2010-07-07 14:28:50','2010-07-07 14:58:50','no resuelto',NULL),
  (24,'2010-03-12 15:45:27',1,11,'2010-03-12 16:39:27','2010-03-12 17:12:27','2010-03-12 17:54:27','resuelto',NULL),
  (24,'2010-03-12 15:45:27',2,11,'2010-03-12 16:26:27','2010-03-12 16:58:27','2010-03-12 17:09:27','resuelto',NULL),
  (24,'2010-03-12 15:47:29',1,11,'2010-03-12 16:32:29','2010-03-12 17:05:29','2010-03-12 17:29:29','resuelto',NULL),
  (24,'2010-03-12 15:47:29',2,11,'2010-03-12 16:10:29','2010-03-12 16:31:29','2010-03-12 17:04:29','resuelto',NULL),
  (32,'2010-05-18 01:35:52',1,10,'2010-05-18 01:48:52','2010-05-18 01:58:52','2010-05-18 02:32:52','resuelto',NULL),
  (32,'2010-05-18 01:35:52',2,12,'2010-05-18 01:57:52','2010-05-18 02:09:52','2010-05-18 02:31:52','resuelto',NULL),
  (32,'2010-05-18 01:36:54',1,11,'2010-05-18 01:49:54','2010-05-18 01:50:54','2010-05-18 02:32:54','resuelto',NULL),
  (32,'2010-05-18 01:36:54',2,11,'2010-05-18 01:37:54','2010-05-18 02:20:54','2010-05-18 02:33:54','resuelto',NULL),
  (34,'2010-06-09 22:49:49',1,12,'2010-06-09 23:30:49','2010-06-10 00:11:49','2010-06-10 00:43:49','resuelto',NULL),
  (34,'2010-06-09 22:49:49',2,10,'2010-06-09 23:13:49','2010-06-09 23:57:49','2010-06-10 00:27:49','resuelto',NULL),
  (34,'2010-06-09 22:53:48',1,11,'2010-06-09 23:04:48','2010-06-09 23:15:48','2010-06-09 23:47:48','resuelto',NULL),
  (34,'2010-06-09 22:53:48',2,11,'2010-06-09 23:25:48','2010-06-09 23:47:48','2010-06-10 00:21:48','resuelto',NULL),
  (35,'2010-06-22 12:46:51',1,11,'2010-06-22 13:21:51','2010-06-22 14:05:51','2010-06-22 14:19:51','resuelto',NULL),
  (35,'2010-06-22 12:46:51',2,12,'2010-06-22 13:17:51','2010-06-22 13:42:51','2010-06-22 14:13:51','no resuelto',NULL),
  (35,'2010-06-22 12:48:48',1,10,'2010-06-22 13:20:48','2010-06-22 13:41:48','2010-06-22 14:01:48','resuelto',NULL),
  (35,'2010-06-22 12:48:48',2,10,'2010-06-22 13:42:48','2010-06-22 14:16:48','2010-06-22 14:30:48','no resuelto',NULL),
  (36,'2010-07-09 02:23:20',1,10,'2010-07-09 02:55:20','2010-07-09 03:17:20','2010-07-09 03:17:20','resuelto',NULL),
  (36,'2010-07-09 02:23:20',2,11,'2010-07-09 02:27:20','2010-07-09 03:01:20','2010-07-09 03:23:20','no resuelto',NULL),
  (36,'2010-07-09 02:25:17',1,12,'2010-07-09 02:36:17','2010-07-09 03:28:17','2010-07-09 04:20:17','resuelto',NULL),
  (36,'2010-07-09 02:25:17',2,11,'2010-07-09 02:59:17','2010-07-09 03:13:17','2010-07-09 03:46:17','no resuelto',NULL),
  (36,'2010-07-09 02:27:17',1,11,'2010-07-09 02:50:17','2010-07-09 02:55:17','2010-07-09 03:07:17','resuelto',NULL),
  (36,'2010-07-09 02:27:17',2,10,'2010-07-09 02:38:17','2010-07-09 03:09:17','2010-07-09 03:19:17','resuelto',NULL);

COMMIT;

#
# Data for the `tipos_soporte` table  (LIMIT 0,500)
#

INSERT INTO `tipos_soporte` (`cod_tipo_soporte`, `nom_tipo_soporte`, `detalle_tipo_soporte`) VALUES 
  (1,'Limpieza','limpiar la tierra con un multiuso'),
  (2,'Reemplazo de componentes barato','reemplazo de un componente por otro siempre y cuando el componente reemplazado funcione bien y sea barato'),
  (3,'Reinstalación y configuración de software','reinstalar cualquier software o driver que sea d fábrica'),
  (4,'Seguro contra todo riesgo y granizo','lo que sea que necesite');

COMMIT;

#
# Data for the `tipos_soporte_contratos` table  (LIMIT 0,500)
#

INSERT INTO `tipos_soporte_contratos` (`cod_tipo_soporte`, `nro_contrato`) VALUES 
  (3,1),
  (1,2),
  (2,2),
  (3,2),
  (2,3),
  (1,4),
  (2,4),
  (1,5),
  (4,6),
  (1,7),
  (1,8);

COMMIT;

#
# Data for the `valores_problemas` table  (LIMIT 0,500)
#

INSERT INTO `valores_problemas` (`cod_problema`, `fecha_valor`, `valor_problema`) VALUES 
  (1,'2009-04-01',400),
  (1,'2009-05-01',560),
  (1,'2009-06-12',580),
  (1,'2009-07-15',868),
  (1,'2009-08-02',588),
  (1,'2009-09-15',795.2),
  (1,'2009-10-15',1084.6),
  (1,'2009-11-24',1423.52),
  (1,'2009-12-02',616),
  (1,'2010-01-07',817.6),
  (1,'2010-02-13',1131),
  (1,'2010-03-23',1727.32),
  (1,'2010-04-05',693.84),
  (1,'2010-05-17',1168.944),
  (1,'2010-06-26',1420.826),
  (1,'2010-07-28',2448.454),
  (1,'2010-08-05',520),
  (1,'2010-09-08',952),
  (2,'2009-04-01',120),
  (2,'2009-05-13',133.2),
  (2,'2009-06-12',154.8),
  (2,'2009-07-14',215.784),
  (2,'2009-08-04',156),
  (2,'2009-09-24',250.416),
  (2,'2009-10-13',159.444),
  (2,'2009-11-24',338.781),
  (2,'2009-12-10',230.4),
  (2,'2010-01-23',251.748),
  (2,'2010-02-15',249.228),
  (2,'2010-03-18',345.254),
  (2,'2010-04-05',285.48),
  (2,'2010-06-04',333.053),
  (2,'2010-06-18',294.971),
  (2,'2010-07-26',406.537),
  (2,'2010-08-14',211.2),
  (2,'2010-09-13',241.092),
  (3,'2009-04-01',300),
  (3,'2009-05-15',441),
  (3,'2009-06-12',336),
  (3,'2009-07-18',740.88),
  (3,'2009-08-11',504),
  (3,'2009-09-20',784.98),
  (3,'2009-10-23',551.04),
  (3,'2009-11-30',881.647),
  (3,'2009-12-09',345),
  (3,'2010-01-16',485.1),
  (3,'2010-02-14',524.16),
  (3,'2010-03-22',1274.314),
  (3,'2010-04-22',851.76),
  (3,'2010-05-22',1303.067),
  (3,'2010-07-05',688.8),
  (3,'2010-08-04',363),
  (3,'2010-08-09',1648.68),
  (3,'2010-09-20',471.87),
  (4,'2009-04-01',300),
  (4,'2009-05-08',579),
  (4,'2009-06-12',576),
  (4,'2009-07-11',746.91),
  (4,'2009-08-07',528),
  (4,'2009-09-14',1007.46),
  (4,'2009-10-19',714.24),
  (4,'2009-11-22',1478.882),
  (4,'2009-12-03',405),
  (4,'2010-01-10',1001.67),
  (4,'2010-02-15',1048.32),
  (4,'2010-03-18',1456.474),
  (4,'2010-04-11',844.8),
  (4,'2010-05-16',1914.174),
  (4,'2010-06-20',1228.493),
  (4,'2010-07-27',2410.578),
  (4,'2010-08-13',474),
  (4,'2010-09-12',1013.25),
  (5,'2009-04-01',180),
  (5,'2009-05-04',271.8),
  (5,'2009-06-13',234),
  (5,'2009-07-04',307.134),
  (5,'2009-08-11',271.8),
  (5,'2009-09-10',489.24),
  (5,'2009-10-22',388.44),
  (5,'2009-11-10',393.132),
  (5,'2009-12-01',250.2),
  (5,'2010-01-15',494.676),
  (5,'2010-02-23',241.02),
  (5,'2010-03-04',350.133),
  (5,'2010-04-19',369.648),
  (5,'2010-05-12',812.138),
  (5,'2010-07-05',524.394),
  (5,'2010-07-12',687.981),
  (5,'2010-08-07',304.2),
  (5,'2010-09-06',491.958),
  (6,'2009-04-01',250),
  (6,'2009-05-12',327.5),
  (6,'2009-06-10',425),
  (6,'2009-07-21',393),
  (6,'2009-08-01',360),
  (6,'2009-09-12',615.7),
  (6,'2009-10-13',718.25),
  (6,'2009-11-30',483.39),
  (6,'2009-12-04',257.5),
  (6,'2010-01-17',596.05),
  (6,'2010-02-24',552.5),
  (6,'2010-03-30',503.04),
  (6,'2010-04-08',583.2),
  (6,'2010-05-21',812.724),
  (6,'2010-06-23',1055.827),
  (6,'2010-08-01',395),
  (6,'2010-08-03',541.397),
  (6,'2010-09-24',412.65),
  (7,'2009-04-01',800),
  (7,'2009-05-04',1088),
  (7,'2009-06-01',1200),
  (7,'2009-07-10',1904),
  (7,'2009-08-03',864),
  (7,'2009-09-18',1664.64),
  (7,'2009-10-12',1512),
  (7,'2009-11-10',2380),
  (7,'2009-12-11',848),
  (7,'2010-01-07',1098.88),
  (7,'2010-02-06',2100),
  (7,'2010-03-20',2284.8),
  (7,'2010-04-16',907.2),
  (7,'2010-05-24',1864.397),
  (7,'2010-06-15',2676.24),
  (7,'2010-07-12',3617.6),
  (7,'2010-08-07',888),
  (7,'2010-09-07',1925.76),
  (8,'2009-04-01',150),
  (8,'2009-05-01',292.5),
  (8,'2009-06-07',268.5),
  (8,'2009-07-11',353.925),
  (8,'2009-08-04',210),
  (8,'2009-09-05',380.25),
  (8,'2009-10-16',300.72),
  (8,'2009-11-23',583.976),
  (8,'2009-12-02',286.5),
  (8,'2010-01-05',479.7),
  (8,'2010-02-12',534.315),
  (8,'2010-03-23',371.621),
  (8,'2010-04-16',214.2),
  (8,'2010-05-14',391.658),
  (8,'2010-06-20',387.929),
  (8,'2010-08-01',753.329),
  (8,'2010-08-08',193.5),
  (8,'2010-09-14',476.775),
  (9,'2009-04-01',800),
  (9,'2009-05-11',1432),
  (9,'2009-06-14',1560),
  (9,'2009-07-25',1546.56),
  (9,'2009-08-13',928),
  (9,'2009-09-15',1675.44),
  (9,'2009-10-26',2745.6),
  (9,'2009-11-28',3046.723),
  (9,'2009-12-09',1560),
  (9,'2010-01-12',2148),
  (9,'2010-02-18',2979.6),
  (9,'2010-04-04',2892.067),
  (9,'2010-04-15',1280.64),
  (9,'2010-05-19',2178.072),
  (9,'2010-07-05',3651.648),
  (9,'2010-08-07',4631.019),
  (9,'2010-08-15',936),
  (9,'2010-09-24',2735.12);

COMMIT;

#
# Data for the `valores_tipos_soporte` table  (LIMIT 0,500)
#

INSERT INTO `valores_tipos_soporte` (`cod_tipo_soporte`, `fecha_valor`, `valor_soporte`) VALUES 
  (1,'2009-07-01',100),
  (1,'2009-08-10',105),
  (1,'2009-09-01',164),
  (1,'2009-10-12',196.35),
  (1,'2009-11-14',109),
  (1,'2010-01-09',244.36),
  (1,'2010-02-22',198.314),
  (1,'2010-03-02',167),
  (1,'2010-05-11',270.6),
  (1,'2010-06-14',339.685),
  (1,'2010-07-18',125.35),
  (1,'2010-09-10',459.397),
  (1,'2010-10-24',245.909),
  (2,'2009-07-01',180),
  (2,'2009-09-14',322.2),
  (2,'2009-10-11',222.156),
  (2,'2009-12-12',222.156),
  (2,'2010-01-28',412.416),
  (2,'2010-02-17',315.461),
  (2,'2010-03-10',288),
  (2,'2010-04-07',246.024),
  (2,'2010-05-22',634.734),
  (2,'2010-07-28',418.5),
  (2,'2010-08-20',433.204),
  (2,'2010-10-21',429.028),
  (3,'2009-07-01',300),
  (3,'2009-08-12',546),
  (3,'2009-10-23',737.1),
  (3,'2009-11-12',462),
  (3,'2009-12-18',786.24),
  (3,'2010-01-16',858.6),
  (3,'2010-03-09',869.778),
  (3,'2010-03-14',384),
  (3,'2010-04-23',616.98),
  (3,'2010-05-05',1036.8),
  (3,'2010-07-26',887.04),
  (3,'2010-08-29',794.102),
  (3,'2010-09-27',1596.996),
  (3,'2010-11-23',1052.431),
  (4,'2009-07-01',5000),
  (4,'2009-08-12',7400),
  (4,'2009-09-08',7250),
  (4,'2009-10-23',10582),
  (4,'2009-11-15',5950),
  (4,'2009-12-13',7548),
  (4,'2010-01-19',11962.5),
  (4,'2010-02-23',13121.68),
  (4,'2010-03-03',6350);

COMMIT;

