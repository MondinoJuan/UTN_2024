# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : riesgos


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `riesgos`;

CREATE DATABASE `riesgos`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `riesgos`;

#
# Structure for the `estados` table : 
#

CREATE TABLE `estados` (
  `cod_estado` int(3) NOT NULL auto_increment,
  `descripcion` char(30) default NULL,
  PRIMARY KEY  (`cod_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `niveles_riesgo` table : 
#

CREATE TABLE `niveles_riesgo` (
  `nivel_riesgo` char(1) NOT NULL,
  `descripcion` char(30) default NULL,
  PRIMARY KEY  (`nivel_riesgo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tipo_eventos` table : 
#

CREATE TABLE `tipo_eventos` (
  `tipo_evento` int(2) NOT NULL auto_increment,
  `descripcion` char(30) default NULL,
  PRIMARY KEY  (`tipo_evento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `eventos` table : 
#

CREATE TABLE `eventos` (
  `nro_evento` int(11) NOT NULL,
  `fecha_evento` date default NULL,
  `nivel_riesgo` char(1) default NULL,
  `tipo_evento` int(2) NOT NULL,
  PRIMARY KEY  (`nro_evento`),
  KEY `nivel_riesgo` (`nivel_riesgo`),
  KEY `tipo_evento` (`tipo_evento`),
  CONSTRAINT `eventos_fk` FOREIGN KEY (`nivel_riesgo`) REFERENCES `niveles_riesgo` (`nivel_riesgo`),
  CONSTRAINT `eventos_fk1` FOREIGN KEY (`tipo_evento`) REFERENCES `tipo_eventos` (`tipo_evento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `recomendaciones` table : 
#

CREATE TABLE `recomendaciones` (
  `cod_recomendacion` int(3) NOT NULL,
  `descripcion` char(30) default NULL,
  `tipo_evento` int(2) NOT NULL,
  PRIMARY KEY  (`cod_recomendacion`),
  KEY `tipo_evento` (`tipo_evento`),
  CONSTRAINT `recomendaciones_fk` FOREIGN KEY (`tipo_evento`) REFERENCES `tipo_eventos` (`tipo_evento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `motivos` table : 
#

CREATE TABLE `motivos` (
  `cod_motivo` int(3) NOT NULL,
  `descripcion` char(30) default NULL,
  PRIMARY KEY  (`cod_motivo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `soluciones` table : 
#

CREATE TABLE `soluciones` (
  `cod_solucion` int(2) NOT NULL auto_increment,
  `descripcion` char(30) default NULL,
  PRIMARY KEY  (`cod_solucion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `eventos_recomendaciones` table : 
#

CREATE TABLE `eventos_recomendaciones` (
  `nro_evento` int(11) NOT NULL,
  `fecha_recomendacion` date NOT NULL,
  `cod_recomendacion` int(3) NOT NULL,
  `cod_motivo` int(3) NOT NULL,
  `cod_solucion` int(2) NOT NULL,
  PRIMARY KEY  (`nro_evento`,`fecha_recomendacion`),
  KEY `nro_evento` (`nro_evento`),
  KEY `cod_recomendacion` (`cod_recomendacion`),
  KEY `cod_motivo` (`cod_motivo`),
  KEY `cod_solucion` (`cod_solucion`),
  CONSTRAINT `eventos_recomendaciones_fk` FOREIGN KEY (`nro_evento`) REFERENCES `eventos` (`nro_evento`),
  CONSTRAINT `eventos_recomendaciones_fk1` FOREIGN KEY (`cod_recomendacion`) REFERENCES `recomendaciones` (`cod_recomendacion`),
  CONSTRAINT `eventos_recomendaciones_fk2` FOREIGN KEY (`cod_motivo`) REFERENCES `motivos` (`cod_motivo`),
  CONSTRAINT `eventos_recomendaciones_fk3` FOREIGN KEY (`cod_solucion`) REFERENCES `soluciones` (`cod_solucion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `resultados` table : 
#

CREATE TABLE `resultados` (
  `cod_resultado` int(3) NOT NULL auto_increment,
  `descripcion` char(30) default NULL,
  PRIMARY KEY  (`cod_resultado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tipo_trabajo` table : 
#

CREATE TABLE `tipo_trabajo` (
  `cod_tipo_trabajo` int(3) NOT NULL,
  `descripcion` char(30) default NULL,
  PRIMARY KEY  (`cod_tipo_trabajo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `programas_trabajo` table : 
#

CREATE TABLE `programas_trabajo` (
  `nro_evento` int(11) NOT NULL,
  `fecha_comienzo` date NOT NULL,
  `fecha_fin` date default NULL,
  `descripcion` char(30) default NULL,
  `cod_resultado` int(3) default NULL,
  `cod_tipo_trabajo` int(3) NOT NULL,
  PRIMARY KEY  (`nro_evento`,`fecha_comienzo`),
  KEY `nro_evento` (`nro_evento`),
  KEY `cod_resultado` (`cod_resultado`),
  KEY `cod_tipo_trabajo` (`cod_tipo_trabajo`),
  CONSTRAINT `programas_trabajo_fk` FOREIGN KEY (`nro_evento`) REFERENCES `eventos` (`nro_evento`),
  CONSTRAINT `programas_trabajo_fk1` FOREIGN KEY (`cod_resultado`) REFERENCES `resultados` (`cod_resultado`),
  CONSTRAINT `programas_trabajo_fk2` FOREIGN KEY (`cod_tipo_trabajo`) REFERENCES `tipo_trabajo` (`cod_tipo_trabajo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `programas_estados` table : 
#

CREATE TABLE `programas_estados` (
  `nro_evento` int(11) NOT NULL,
  `fecha_comienzo` date NOT NULL,
  `fecha_estado` date NOT NULL,
  `cod_estado` int(2) default NULL,
  PRIMARY KEY  (`nro_evento`,`fecha_comienzo`,`fecha_estado`),
  KEY `nro_evento` (`nro_evento`,`fecha_comienzo`),
  KEY `cod_estado` (`cod_estado`),
  CONSTRAINT `programas_estados_fk` FOREIGN KEY (`nro_evento`, `fecha_comienzo`) REFERENCES `programas_trabajo` (`nro_evento`, `fecha_comienzo`),
  CONSTRAINT `programas_estados_fk1` FOREIGN KEY (`cod_estado`) REFERENCES `estados` (`cod_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `estados` table  (LIMIT 0,500)
#

INSERT INTO `estados` (`cod_estado`, `descripcion`) VALUES 
  (1,'FINALIZADO'),
  (2,'EN CURSO'),
  (3,'SUSPENDIDO'),
  (4,'EN ESPERA'),
  (5,'CANCELADO');

COMMIT;

#
# Data for the `niveles_riesgo` table  (LIMIT 0,500)
#

INSERT INTO `niveles_riesgo` (`nivel_riesgo`, `descripcion`) VALUES 
  ('A','DERRUMBE'),
  ('B','INCENDIO'),
  ('C','SHOCK ELECTRICO'),
  ('D','ALTO RIESGO VARIOS'),
  ('E','CAIDA'),
  ('F','MEDIO RIESGO VARIOS'),
  ('G','BAJO RIESGO VARIOS');

COMMIT;

#
# Data for the `tipo_eventos` table  (LIMIT 0,500)
#

INSERT INTO `tipo_eventos` (`tipo_evento`, `descripcion`) VALUES 
  (1,'REPORTE DE ACCIDENTE'),
  (2,'INFORME DE RIESGO'),
  (3,'INSPECCION');

COMMIT;

#
# Data for the `eventos` table  (LIMIT 0,500)
#

INSERT INTO `eventos` (`nro_evento`, `fecha_evento`, `nivel_riesgo`, `tipo_evento`) VALUES 
  (100,'2010-12-12','D',1),
  (101,'2010-12-15','A',1),
  (200,'2011-01-05','B',3),
  (201,'2011-01-25','C',2),
  (300,'2011-03-03','G',3),
  (301,'2010-09-09','F',1),
  (400,'2010-09-19','A',2),
  (401,'2011-04-25','D',3),
  (500,'2011-05-13','E',2),
  (501,'2011-03-12','A',2),
  (600,'2011-02-23','D',1),
  (601,'2011-05-12','B',1),
  (700,'2010-12-08','E',1),
  (701,'2011-03-28','D',1),
  (800,'2011-05-15','C',1),
  (801,'2011-03-30','D',1),
  (900,'2011-02-09','F',3);

COMMIT;

#
# Data for the `recomendaciones` table  (LIMIT 0,500)
#

INSERT INTO `recomendaciones` (`cod_recomendacion`, `descripcion`, `tipo_evento`) VALUES 
  (1,'usar vallado perimetral',1),
  (2,'usar casco',2),
  (3,'usar cinturones de seguridad',3),
  (4,'usar guantes',3),
  (5,'usar borcegos',3),
  (6,'primeros auxilios',1),
  (7,'delimitar la zona afectada',2),
  (8,'detener construccion',2),
  (9,'desalojar la zona',1);

COMMIT;

#
# Data for the `motivos` table  (LIMIT 0,500)
#

INSERT INTO `motivos` (`cod_motivo`, `descripcion`) VALUES 
  (1,'INCUMPLIMIENTO'),
  (2,'DAÑO A INSTALACIONES'),
  (3,'MEJORES PRACTICAS'),
  (4,'ACTIVIDAD RIESGOSA');

COMMIT;

#
# Data for the `soluciones` table  (LIMIT 0,500)
#

INSERT INTO `soluciones` (`cod_solucion`, `descripcion`) VALUES 
  (1,'COMPRA ELEMENTOS SEGURIDAD'),
  (2,'PROVISION ELEMENTOS SEGURIDAD'),
  (3,'CONSTRUCCION VALLADO SEGURIDAD'),
  (4,'CAPACITACION PRACTICAS SEGURAS'),
  (5,'INSTALACION RED CONTENCION'),
  (6,'CONSTRUCCION PROTECCION');

COMMIT;

#
# Data for the `eventos_recomendaciones` table  (LIMIT 0,500)
#

INSERT INTO `eventos_recomendaciones` (`nro_evento`, `fecha_recomendacion`, `cod_recomendacion`, `cod_motivo`, `cod_solucion`) VALUES 
  (100,'2010-12-30',1,1,1),
  (100,'2011-02-01',6,3,4),
  (100,'2011-04-30',8,1,1),
  (100,'2011-05-15',9,4,6),
  (101,'2010-12-30',6,4,4),
  (200,'2010-09-15',5,1,1),
  (200,'2011-01-15',3,1,1),
  (201,'2011-02-05',7,4,3),
  (201,'2011-04-18',2,1,1),
  (300,'2011-03-13',3,3,2),
  (300,'2011-05-19',5,1,1),
  (301,'2010-09-19',8,2,4),
  (301,'2011-03-19',6,3,4),
  (400,'2010-09-29',2,1,1),
  (401,'2011-05-05',4,1,1),
  (401,'2011-05-10',5,1,1),
  (401,'2011-05-17',3,1,1),
  (500,'2011-05-23',7,2,3),
  (501,'2011-12-23',7,4,5),
  (600,'2011-03-03',8,4,4),
  (601,'2011-05-22',8,1,1),
  (700,'2010-12-18',8,1,4),
  (701,'2011-04-04',9,4,6),
  (800,'2011-05-11',6,3,1),
  (801,'2011-04-10',8,4,4),
  (900,'2011-02-19',4,1,1),
  (900,'2011-04-30',5,1,1);

COMMIT;

#
# Data for the `resultados` table  (LIMIT 0,500)
#

INSERT INTO `resultados` (`cod_resultado`, `descripcion`) VALUES 
  (1,'EXITOSO'),
  (2,'INCONCLUSO'),
  (3,'INDETERMINADO'),
  (4,'FALLIDO'),
  (5,'ANULADO'),
  (6,'CORRECTO');

COMMIT;

#
# Data for the `tipo_trabajo` table  (LIMIT 0,500)
#

INSERT INTO `tipo_trabajo` (`cod_tipo_trabajo`, `descripcion`) VALUES 
  (1,'NUEVA INSTALACION'),
  (2,'REPARACION'),
  (3,'ADECUACION'),
  (4,'PROTECCION ADICIONAL'),
  (5,'VALLADO DE SEGURIDAD'),
  (6,'CAPACITACION EN OBRA'),
  (7,'CAPACITACION EN OFICINA');

COMMIT;

#
# Data for the `programas_trabajo` table  (LIMIT 0,500)
#

INSERT INTO `programas_trabajo` (`nro_evento`, `fecha_comienzo`, `fecha_fin`, `descripcion`, `cod_resultado`, `cod_tipo_trabajo`) VALUES 
  (100,'2010-12-15','2011-05-01','obra axitosa privada',1,1),
  (101,'2010-12-15',NULL,'capacitacion personal',NULL,2),
  (200,'2011-01-08',NULL,'sin observaciones',2,2),
  (201,'2011-01-25',NULL,'compra de cascos',NULL,1),
  (201,'2011-01-30',NULL,'capacitar en uso de cascos',2,3),
  (300,'2011-03-06','2011-05-16','establecido por el ministerio',5,2),
  (400,'2010-09-22','2011-04-17','con capitales extranjeros',1,1);

COMMIT;

#
# Data for the `programas_estados` table  (LIMIT 0,500)
#

INSERT INTO `programas_estados` (`nro_evento`, `fecha_comienzo`, `fecha_estado`, `cod_estado`) VALUES 
  (100,'2010-12-15','2011-05-01',1),
  (400,'2010-09-22','2011-04-17',1),
  (100,'2010-12-15','2011-03-08',2),
  (101,'2010-12-15','2010-12-15',2),
  (201,'2011-01-30','2011-02-01',2),
  (300,'2011-03-06','2011-03-08',2),
  (200,'2011-01-08','2011-05-05',4),
  (201,'2011-01-25','2011-01-25',4),
  (400,'2010-09-22','2010-09-23',4),
  (300,'2011-03-06','2011-04-15',5);

COMMIT;

