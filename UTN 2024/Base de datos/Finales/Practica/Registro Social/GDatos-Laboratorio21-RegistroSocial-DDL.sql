# SQL Manager 2005 Lite for MySQL 3.7.0.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : registro_social


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `registro_social`;

CREATE DATABASE `registro_social`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `registro_social`;

#
# Structure for the `calles` table : 
#

DROP TABLE IF EXISTS `calles`;

CREATE TABLE `calles` (
  `id_calle` int(10) NOT NULL,
  `nombre_calle` varchar(60) NOT NULL,
  PRIMARY KEY  (`id_calle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='\r\n';

#
# Structure for the `empleados` table : 
#

DROP TABLE IF EXISTS `empleados`;

CREATE TABLE `empleados` (
  `nro_legajo` int(5) NOT NULL,
  `tipo_doc` char(3) default NULL,
  `nro_doc` int(9) default NULL,
  `nombre` char(20) default NULL,
  `apellido` char(20) default NULL,
  PRIMARY KEY  (`nro_legajo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tematica` table : 
#

DROP TABLE IF EXISTS `tematica`;

CREATE TABLE `tematica` (
  `cod_tematica` int(3) NOT NULL,
  `desc_tematica` varchar(60) default NULL,
  PRIMARY KEY  (`cod_tematica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `grupo_familiar` table : 
#

DROP TABLE IF EXISTS `grupo_familiar`;

CREATE TABLE `grupo_familiar` (
  `id_grupo` int(10) NOT NULL,
  `descripcion` char(20) NOT NULL,
  `id_calle` int(10) NOT NULL,
  `nro` int(5) NOT NULL,
  `letra` char(1) default NULL,
  `piso` int(2) default NULL,
  `depto` int(3) default NULL,
  `monoblock` int(1) default NULL,
  `fecha_baja` date default NULL,
  PRIMARY KEY  (`id_grupo`),
  KEY `id_calle` (`id_calle`),
  CONSTRAINT `grupo_familiar_fk` FOREIGN KEY (`id_calle`) REFERENCES `calles` (`id_calle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `instituciones` table : 
#

DROP TABLE IF EXISTS `instituciones`;

CREATE TABLE `instituciones` (
  `cuit` char(14) NOT NULL,
  `nombre` char(20) NOT NULL,
  `telefono` char(15) default NULL,
  `id_calle` int(10) NOT NULL,
  `nro` int(5) NOT NULL,
  `letra` char(1) default NULL,
  `piso` int(2) default NULL,
  `depto` int(3) default NULL,
  `monoblock` int(1) default NULL,
  `fecha_baja` date default NULL,
  PRIMARY KEY  (`cuit`),
  KEY `instituciones_fk` (`id_calle`),
  CONSTRAINT `instituciones_fk` FOREIGN KEY (`id_calle`) REFERENCES `calles` (`id_calle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `intervenciones` table : 
#

DROP TABLE IF EXISTS `intervenciones`;

CREATE TABLE `intervenciones` (
  `nro_intervencion` int(11) NOT NULL,
  `fecha` date default NULL,
  `hora` time default NULL,
  `desc_interv` varchar(60) default NULL,
  `fecha_baja` date default NULL,
  `cod_tematica` int(3) default NULL,
  `nro_legajo` int(5) default NULL,
  `id_grupo` int(10) default NULL,
  `cuit` char(14) default NULL,
  `tipo_intervencion` char(1) default NULL,
  PRIMARY KEY  (`nro_intervencion`),
  KEY `cod_tematica` (`cod_tematica`),
  KEY `nro_legajo` (`nro_legajo`),
  KEY `id_grupo` (`id_grupo`),
  KEY `cuit` (`cuit`),
  CONSTRAINT `intervenciones_fk` FOREIGN KEY (`cod_tematica`) REFERENCES `tematica` (`cod_tematica`),
  CONSTRAINT `intervenciones_fk1` FOREIGN KEY (`nro_legajo`) REFERENCES `empleados` (`nro_legajo`),
  CONSTRAINT `intervenciones_fk2` FOREIGN KEY (`id_grupo`) REFERENCES `grupo_familiar` (`id_grupo`),
  CONSTRAINT `intervenciones_fk3` FOREIGN KEY (`cuit`) REFERENCES `instituciones` (`cuit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `entrevistas` table : 
#

DROP TABLE IF EXISTS `entrevistas`;

CREATE TABLE `entrevistas` (
  `nro_entrevista` int(11) NOT NULL,
  `fecha` date default NULL,
  `hora` time default NULL,
  `obs_entrevista` varchar(40) default NULL,
  `nro_intervencion` int(11) default NULL,
  `nro_legajo` int(5) default NULL,
  PRIMARY KEY  (`nro_entrevista`),
  KEY `nro_intervención` (`nro_intervencion`),
  KEY `nro_legajo` (`nro_legajo`),
  CONSTRAINT `entrevistas_fk` FOREIGN KEY (`nro_intervencion`) REFERENCES `intervenciones` (`nro_intervencion`),
  CONSTRAINT `entrevistas_fk1` FOREIGN KEY (`nro_legajo`) REFERENCES `empleados` (`nro_legajo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `personas` table : 
#

DROP TABLE IF EXISTS `personas`;

CREATE TABLE `personas` (
  `tipo_doc` char(3) NOT NULL,
  `nro_doc` int(9) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `telefono` char(15) default NULL,
  `sexo` char(1) default NULL,
  PRIMARY KEY  (`tipo_doc`,`nro_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `grupo_personas` table : 
#

DROP TABLE IF EXISTS `grupo_personas`;

CREATE TABLE `grupo_personas` (
  `id_grupo` int(10) NOT NULL,
  `tipo_doc` char(3) NOT NULL,
  `nro_doc` int(9) NOT NULL,
  `fecha_desde` date NOT NULL,
  `fecha_hasta` date default NULL,
  PRIMARY KEY  (`id_grupo`,`tipo_doc`,`nro_doc`,`fecha_desde`),
  KEY `id_grupo` (`id_grupo`),
  KEY `tipo_doc` (`tipo_doc`,`nro_doc`),
  CONSTRAINT `grupo_personas_fk` FOREIGN KEY (`id_grupo`) REFERENCES `grupo_familiar` (`id_grupo`),
  CONSTRAINT `grupo_personas_fk1` FOREIGN KEY (`tipo_doc`, `nro_doc`) REFERENCES `personas` (`tipo_doc`, `nro_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `rubros` table : 
#

DROP TABLE IF EXISTS `rubros`;

CREATE TABLE `rubros` (
  `cod_rubro` char(3) NOT NULL,
  `desc_rubro` varchar(60) default NULL,
  PRIMARY KEY  (`cod_rubro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `inst_rubros` table : 
#

DROP TABLE IF EXISTS `inst_rubros`;

CREATE TABLE `inst_rubros` (
  `cuit` char(14) NOT NULL,
  `cod_rubro` char(3) NOT NULL,
  PRIMARY KEY  (`cuit`,`cod_rubro`),
  KEY `cuit` (`cuit`),
  KEY `cod_rubro` (`cod_rubro`),
  CONSTRAINT `inst_rubros_fk` FOREIGN KEY (`cod_rubro`) REFERENCES `rubros` (`cod_rubro`),
  CONSTRAINT `inst_rubros_fk1` FOREIGN KEY (`cuit`) REFERENCES `instituciones` (`cuit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `soluciones` table : 
#

DROP TABLE IF EXISTS `soluciones`;

CREATE TABLE `soluciones` (
  `cod_solucion` int(3) NOT NULL,
  `descr_solucion` varchar(60) default NULL,
  PRIMARY KEY  (`cod_solucion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `intervenciones-soluciones` table : 
#

DROP TABLE IF EXISTS `intervenciones-soluciones`;

CREATE TABLE `intervenciones-soluciones` (
  `nro_intervencion` int(11) NOT NULL,
  `cod_solucion` int(3) NOT NULL,
  `fecha_compromiso` date NOT NULL,
  `cantidad_importe` int(11) default NULL,
  `fecha_baja` date default NULL,
  `nro_legajo` int(11) default NULL,
  PRIMARY KEY  (`nro_intervencion`,`cod_solucion`,`fecha_compromiso`),
  KEY `nro_intervención` (`nro_intervencion`),
  KEY `cod_solución` (`cod_solucion`),
  KEY `nro_legajo` (`nro_legajo`),
  CONSTRAINT `intervenciones-soluciones_fk` FOREIGN KEY (`nro_intervencion`) REFERENCES `intervenciones` (`nro_intervencion`),
  CONSTRAINT `intervenciones-soluciones_fk1` FOREIGN KEY (`cod_solucion`) REFERENCES `soluciones` (`cod_solucion`),
  CONSTRAINT `intervenciones-soluciones_fk2` FOREIGN KEY (`nro_legajo`) REFERENCES `empleados` (`nro_legajo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `intervenciones_microemprendimientos` table : 
#

DROP TABLE IF EXISTS `intervenciones_microemprendimientos`;

CREATE TABLE `intervenciones_microemprendimientos` (
  `nro_intervencion` int(11) NOT NULL,
  `tipo_doc` char(3) NOT NULL,
  `nro_doc` int(9) NOT NULL,
  PRIMARY KEY  (`nro_intervencion`,`tipo_doc`,`nro_doc`),
  KEY `nro_intervencion` (`nro_intervencion`),
  KEY `tipo_doc` (`tipo_doc`,`nro_doc`),
  CONSTRAINT `intervenciones_microemprendimientos_fk` FOREIGN KEY (`nro_intervencion`) REFERENCES `intervenciones` (`nro_intervencion`),
  CONSTRAINT `intervenciones_microemprendimientos_fk1` FOREIGN KEY (`tipo_doc`, `nro_doc`) REFERENCES `personas` (`tipo_doc`, `nro_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `seguimiento` table : 
#

DROP TABLE IF EXISTS `seguimiento`;

CREATE TABLE `seguimiento` (
  `nro_intervencion` int(11) NOT NULL,
  `cod_solucion` int(3) NOT NULL,
  `fecha_compromiso` date NOT NULL,
  `fecha_entrega` date NOT NULL,
  `cantidad_importe` int(11) default NULL,
  `observacion` varchar(60) default NULL,
  `nro_legajo` int(11) NOT NULL,
  PRIMARY KEY  (`nro_intervencion`,`cod_solucion`,`fecha_compromiso`,`fecha_entrega`),
  KEY `nro_legajo` (`nro_legajo`),
  KEY `nro_intervencion_2` (`nro_intervencion`,`cod_solucion`,`fecha_compromiso`),
  CONSTRAINT `seguimiento_fk` FOREIGN KEY (`nro_intervencion`, `cod_solucion`, `fecha_compromiso`) REFERENCES `intervenciones-soluciones` (`nro_intervencion`, `cod_solucion`, `fecha_compromiso`),
  CONSTRAINT `seguimiento_fk1` FOREIGN KEY (`nro_legajo`) REFERENCES `empleados` (`nro_legajo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for the `calles` table  (LIMIT 0,500)
#

INSERT INTO `calles` (`id_calle`, `nombre_calle`) VALUES 
  (23200,'AMEGHINO FLORENTINO'),
  (23300,' AMENABAR JOSE DE'),
  (29150,'BELGRANO GRAL. MANUEL'),
  (32200,'BROWN ALMTE. GUILLERMO'),
  (37200,'CASAS CASIANO'),
  (44450,'CURA JORGE C'),
  (53950,' GODOY FRANCISCO'),
  (58650,'IRIGOYEN HIPOLITO'),
  (71900,'NUESTRA SRA DEL ROSARIO'),
  (76650,' PELLEGRINI CARLOS');

COMMIT;

#
# Data for the `empleados` table  (LIMIT 0,500)
#

INSERT INTO `empleados` (`nro_legajo`, `tipo_doc`, `nro_doc`, `nombre`, `apellido`) VALUES 
  (1,'DNI',18002546,'AGUSTINA','PEREZ'),
  (2,'DNI',20154365,'PABLO GUSTAVO','LEONARDI'),
  (3,'DNI',32214254,'NATALIA','DARIN'),
  (4,'DNI',20225651,'MIA ABRIL','XIOMARA');

COMMIT;

#
# Data for the `tematica` table  (LIMIT 0,500)
#

INSERT INTO `tematica` (`cod_tematica`, `desc_tematica`) VALUES 
  (1,'CATASTROFE'),
  (2,'SITUACION DE CALLE'),
  (3,'CAPACITACION/SENSIBILIDACIÒN'),
  (4,'TRABAJO'),
  (5,'VIOLENCIA'),
  (6,'SALUD'),
  (7,'ADULTOS MAYORES'),
  (8,'VIVIENDA'),
  (9,'EDUCACION');

COMMIT;

#
# Data for the `grupo_familiar` table  (LIMIT 0,500)
#

INSERT INTO `grupo_familiar` (`id_grupo`, `descripcion`, `id_calle`, `nro`, `letra`, `piso`, `depto`, `monoblock`, `fecha_baja`) VALUES 
  (1,'familia numerosa',23200,200,NULL,NULL,NULL,NULL,NULL),
  (2,'estudiantes',29150,1500,NULL,1,NULL,NULL,NULL),
  (3,'abuelos',76650,6500,NULL,1,NULL,NULL,NULL);

COMMIT;

#
# Data for the `instituciones` table  (LIMIT 0,500)
#

INSERT INTO `instituciones` (`cuit`, `nombre`, `telefono`, `id_calle`, `nro`, `letra`, `piso`, `depto`, `monoblock`, `fecha_baja`) VALUES 
  ('30-54724233-1','MASTELLONE HNOS SA','236584',32200,1500,NULL,NULL,NULL,NULL,NULL),
  ('30-59628776-6','ETNADE',NULL,37200,365,NULL,NULL,NULL,NULL,NULL),
  ('30-70794537-7','ARGENFLEX S.R.L',NULL,44450,2000,NULL,NULL,NULL,NULL,NULL);

COMMIT;

#
# Data for the `intervenciones` table  (LIMIT 0,500)
#

INSERT INTO `intervenciones` (`nro_intervencion`, `fecha`, `hora`, `desc_interv`, `fecha_baja`, `cod_tematica`, `nro_legajo`, `id_grupo`, `cuit`, `tipo_intervencion`) VALUES 
  (1,'2011-01-01','08:00:00','Necesita alojamiento temporario','2011-04-05',9,1,2,NULL,'G'),
  (2,'2011-02-10','10:00:00','Necesita alimentos',NULL,2,1,1,NULL,'G'),
  (3,'2010-01-15','07:00:00','Necesita alojamiento por inundación',NULL,1,3,1,NULL,'G'),
  (5,'2010-02-10','08:00:00','alojamiento',NULL,7,3,2,NULL,'G'),
  (6,'2010-02-15','10:00:00','becas para estudio',NULL,9,2,NULL,NULL,'P'),
  (7,'2011-01-01','15:00:00','Asistencia alimentaria',NULL,2,2,2,NULL,'G'),
  (8,'2010-05-16','08:00:00','Huerta Solidaria - Capacitación',NULL,3,3,NULL,'30-59628776-6','I'),
  (9,'2010-12-20','15:00:00','Microemprendimiento',NULL,4,3,NULL,NULL,'P'),
  (10,'2011-05-15','08:00:00','Becas para estudio',NULL,9,3,NULL,NULL,'P'),
  (11,'2011-06-15','11:00:00','Necesita trabajo',NULL,4,4,NULL,'30-70794537-7','I');

COMMIT;

#
# Data for the `entrevistas` table  (LIMIT 0,500)
#

INSERT INTO `entrevistas` (`nro_entrevista`, `fecha`, `hora`, `obs_entrevista`, `nro_intervencion`, `nro_legajo`) VALUES 
  (1,'2011-02-01','08:00:00','Se verifica la necesidad del alojamiento',1,3),
  (2,'2011-02-10','09:00:00','Se verifica estado del alojamiento',1,2),
  (3,'2011-02-15','09:00:00','Verifica alimentos otorgados en el aloj',1,2),
  (4,'2011-03-20','09:00:00','Verifica rendicion de cheques',2,2),
  (5,'2011-04-20','09:00:00','Verifica rendicion de cheques',2,2),
  (6,'2011-05-20','09:00:00','Verifica rendicion de cheques',2,2);

COMMIT;

#
# Data for the `personas` table  (LIMIT 0,500)
#

INSERT INTO `personas` (`tipo_doc`, `nro_doc`, `nombre`, `apellido`, `telefono`, `sexo`) VALUES 
  ('DNI',1532636,'KIARA','PORTILLO',NULL,'F'),
  ('DNI',2025436,'JUAN EUSEBIO','FARIAS','289865','M'),
  ('DNI',2365985,'WALTER RODRIGO','FERNANDEZ','252542','M'),
  ('DNI',3266598,'NATAEL NICOLAS','BLANCO',NULL,'M'),
  ('DNI',10326326,'ALEXIS','SORAIRE','236569','M'),
  ('DNI',10365325,'ALEXANDRA DIAMELA','PELOSO',NULL,'F'),
  ('DNI',18220365,'LOURDES JAZMIN','RUIZ',NULL,'F'),
  ('DNI',18365985,'LAUREANO','CARDOZO',NULL,'M'),
  ('DNI',18369852,'CRISTIAN RAFAEL','IGLESIAS',NULL,'M'),
  ('DNI',19365698,'TIAGO ISMAEL','ALDERETE',NULL,'M'),
  ('DNI',22365365,'FABIAN HECTOR','TORRES','326598','M'),
  ('DNI',22365987,'JESUS MARIANO','NUÑEZ','259996','M'),
  ('DNI',30336364,'FELIPE PABLO','GOMEZ','236596','M'),
  ('DNI',36665698,'ROCIO','ALMUA',NULL,'F'),
  ('LC',5365698,'CECILIA','ARRIOLA','365843','F'),
  ('LC',33656365,'CRISTIAN','ARCE','362565','M');

COMMIT;

#
# Data for the `grupo_personas` table  (LIMIT 0,500)
#

INSERT INTO `grupo_personas` (`id_grupo`, `tipo_doc`, `nro_doc`, `fecha_desde`, `fecha_hasta`) VALUES 
  (1,'DNI',1532636,'2010-01-01',NULL),
  (1,'DNI',2365985,'2010-01-01',NULL),
  (1,'DNI',10365325,'2000-10-10','2009-08-28');

COMMIT;

#
# Data for the `rubros` table  (LIMIT 0,500)
#

INSERT INTO `rubros` (`cod_rubro`, `desc_rubro`) VALUES 
  ('1','FABRICACION DE QUESOS Y MANTECA'),
  ('2','FABRICA DE HELADOS ARTESANALES'),
  ('3','ELABORACION Y ENVASADO DE FRUTAS Y LEGUMBRES.'),
  ('4','ELABORACION Y ENVASADO DE FRUTAS Y LEGUMBRES SECAS'),
  ('5','ELABORACION Y ENVASADO DE DULCES MERMELADAS Y JALEAS'),
  ('6','FABRICACION DE PAN (PANADERIAS).'),
  ('7','FABRICACION DE GALLETITAS Y BIZCOCHOSY OTROS PRODUCTOS '),
  ('8','HUERTA'),
  ('9','HUERTA - GANADERIA');

COMMIT;

#
# Data for the `inst_rubros` table  (LIMIT 0,500)
#

INSERT INTO `inst_rubros` (`cuit`, `cod_rubro`) VALUES 
  ('30-59628776-6','8'),
  ('30-70794537-7','8'),
  ('30-70794537-7','9');

COMMIT;

#
# Data for the `soluciones` table  (LIMIT 0,500)
#

INSERT INTO `soluciones` (`cod_solucion`, `descr_solucion`) VALUES 
  (1,'CAPACITACION'),
  (2,'ASESORAMIENTO'),
  (4,'ENTREGA DE ELEMENTOS MATERIALES'),
  (5,'ENTREGA DE ELEMENTOS PERSONALES'),
  (6,'ALOJAMIENTO EN INSTITUCION'),
  (7,'ENTREGA DE BOLSONES DE COMIDA'),
  (8,'ENTREGA DE COLCHONES'),
  (9,'ENTREGA DE CHEQUES'),
  (10,'ENTREA DE CHEQUES PARA MATERIALES');

COMMIT;

#
# Data for the `intervenciones-soluciones` table  (LIMIT 0,500)
#

INSERT INTO `intervenciones-soluciones` (`nro_intervencion`, `cod_solucion`, `fecha_compromiso`, `cantidad_importe`, `fecha_baja`, `nro_legajo`) VALUES 
  (1,6,'2011-01-10',1,NULL,2),
  (2,7,'2011-03-07',1,NULL,2),
  (2,8,'2011-03-06',3,NULL,2),
  (2,10,'2011-03-15',1500,NULL,2),
  (3,4,'2011-07-04',1000,NULL,3),
  (3,6,'2010-02-08',NULL,NULL,2),
  (3,9,'2011-07-05',1000,NULL,1),
  (3,9,'2011-08-05',1000,NULL,3),
  (8,1,'2010-05-20',NULL,NULL,1),
  (8,2,'2010-05-19',1,NULL,1),
  (9,1,'2010-12-30',12,NULL,1),
  (11,1,'2011-06-15',1,NULL,2);

COMMIT;

#
# Data for the `intervenciones_microemprendimientos` table  (LIMIT 0,500)
#

INSERT INTO `intervenciones_microemprendimientos` (`nro_intervencion`, `tipo_doc`, `nro_doc`) VALUES 
  (9,'DNI',2025436),
  (9,'DNI',2365985);

COMMIT;

#
# Data for the `seguimiento` table  (LIMIT 0,500)
#

INSERT INTO `seguimiento` (`nro_intervencion`, `cod_solucion`, `fecha_compromiso`, `fecha_entrega`, `cantidad_importe`, `observacion`, `nro_legajo`) VALUES 
  (1,6,'2011-01-10','2011-01-15',1,'Alojamiento en insti',2),
  (2,10,'2011-03-15','2011-03-17',200,'Pesos en cheques',3),
  (2,10,'2011-03-15','2011-04-17',300,'Pesos en cheques',3),
  (2,10,'2011-03-15','2011-05-18',100,'Pesos en cheques',3),
  (3,4,'2011-07-04','2011-07-15',5,'Chapas',2),
  (3,6,'2010-02-08','2010-02-15',1,'Alojamiento en Inst',3),
  (3,6,'2010-02-08','2010-04-15',NULL,'Rev. alojam. en inst',3),
  (3,6,'2010-02-08','2010-06-15',NULL,'Rev. alojam. en inst',2),
  (3,6,'2010-02-08','2010-08-15',NULL,'Rev. aloam. en inst',2),
  (3,6,'2010-02-08','2010-10-15',NULL,'Rev. alojam en inst',2),
  (3,6,'2010-02-08','2010-12-15',NULL,'Rev. alojam eninst',3),
  (3,6,'2010-02-08','2011-02-15',NULL,'Rev. alojam',2),
  (3,6,'2010-02-08','2011-04-15',NULL,'Rev. alojam en inst',2),
  (3,6,'2010-02-08','2011-06-15',NULL,'Rev. alojam eninst',2),
  (3,9,'2011-07-05','2011-07-07',500,'Pesos en cheques',2),
  (3,9,'2011-07-05','2011-08-01',300,'Pesos en cheques',2),
  (3,9,'2011-08-05','2011-08-06',400,'Pesos en cheques',3),
  (8,1,'2010-05-20','2010-05-25',1,'Cap.  a 20 pers huerta organica',2),
  (8,1,'2010-05-20','2010-05-30',1,'Cap a 15 pers. h org. zanahoria',2),
  (9,1,'2010-12-30','2011-01-15',1,'Tercer curso huerta',1),
  (9,1,'2010-12-30','2011-02-15',1,'Seg. curso Huerta',2),
  (9,1,'2010-12-30','2011-03-15',1,'Terc curso huerta',2),
  (9,1,'2010-12-30','2011-04-15',1,'Cuarto curso Huerta',2),
  (9,1,'2010-12-30','2011-05-15',1,'Quinto Curso Huerta',2),
  (9,1,'2010-12-30','2011-06-15',1,'Sexto curso Huerta',2),
  (9,1,'2010-12-30','2011-07-15',1,'Sept. curso Huerta',2),
  (11,1,'2011-06-15','2011-06-20',1,'Asesoramiento',2);

COMMIT;

