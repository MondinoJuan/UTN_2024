
/* Ver los tipos de variables que almacenan las columnas */
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE 
	TABLE_NAME = 'AlumnoInscripciones';
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE 
	TABLE_NAME = 'Comisiones';
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE 
	TABLE_NAME = 'Cursos';
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE 
	TABLE_NAME = 'DocenteCursos';
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE 
	TABLE_NAME = 'Especialidades';
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE 
	TABLE_NAME = 'Materias';
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE 
	TABLE_NAME = 'Modulos';
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE 
	TABLE_NAME = 'ModuloUsuarios';
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE 
	TABLE_NAME = 'Planes';
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE 
	TABLE_NAME = 'Usuarios';

/* Ver todas las tuplas de las tablas */
select * from Comisiones;
select * from Cursos;
select * from Especialidades;
select * from Materias;
select * from Modulos;
select * from ModuloUsuarios;
select * from Planes;
select * from Usuarios;
select * from AlumnoInscripciones;
select * from DocenteCursos;

/* INSERTS de Usuarios */
INSERT INTO Usuarios (/*Id,*/ IdPlan, Nombre, Apellido, FechaNacimiento, Direccion, Tipo, Telefono, Legajo, Email, Username, Password, FechaRegistro, Habilitado)VALUES (/*1,*/ 101, 'Juan', 'Pérez', '1990-01-15', '123 Calle Falsa', 0, 5551234, 12345, 'juan.perez@example.com', 'juanp', 'password123', '2024-11-07', 1);
INSERT INTO Usuarios (/*Id,*/ IdPlan, Nombre, Apellido, FechaNacimiento, Direccion, Tipo, Telefono, Legajo, Email, Username, Password, FechaRegistro, Habilitado)VALUES (/*2,*/ 10, 'Maria', 'Gonzalez', '1985-03-22', 'Av. Siempre Viva 742', 1, '0987654321', 2002, 'maria.gonzalez@example.com', 'mariagonz', 'securePass456', '2023-08-15', 0);
INSERT INTO Usuarios (/*Id,*/ IdPlan, Nombre, Apellido, FechaNacimiento, Direccion, Tipo, Telefono, Legajo, Email, Username, Password, FechaRegistro, Habilitado)VALUES (/*2,*/ 4, 'Alumno', 'Alumno', '1985-03-22', 'Alumno 742', 0, '0987654321', 8502, 'Alumno@example.com', 'Alumno', 'Alumno', '2023-08-15', 0);
INSERT INTO Usuarios (/*Id,*/ IdPlan, Nombre, Apellido, FechaNacimiento, Direccion, Tipo, Telefono, Legajo, Email, Username, Password, FechaRegistro, Habilitado)VALUES (/*2,*/ 3, 'Docente', 'Docente', '1985-03-24', 'Docente 742', 1, '0987654321', 2451, 'Docente@example.com', 'Docente', 'Docente', '2023-08-15', 0);


/* INSERTS de AlumnoInscripciones */
INSERT INTO AlumnoInscripciones (IdAlumno, IdCurso, Condicion, Nota) VALUES (1, 3, 'Aprobado', 8);
INSERT INTO AlumnoInscripciones (IdAlumno, IdCurso, Condicion, Nota) VALUES (2, 5, 'Desaprobado', 4);
INSERT INTO AlumnoInscripciones (IdAlumno, IdCurso, Condicion, Nota) VALUES (3, 7, 'Aprobado', 7);
INSERT INTO AlumnoInscripciones (IdAlumno, IdCurso, Condicion, Nota) VALUES (4, 1, 'Aprobado', 9);
INSERT INTO AlumnoInscripciones (IdAlumno, IdCurso, Condicion, Nota) VALUES (5, 6, 'Desaprobado', 3);
INSERT INTO AlumnoInscripciones (IdAlumno, IdCurso, Condicion, Nota) VALUES (6, 4, 'Aprobado', 6);
INSERT INTO AlumnoInscripciones (IdAlumno, IdCurso, Condicion, Nota) VALUES (7, 8, 'Desaprobado', 5);
INSERT INTO AlumnoInscripciones (IdAlumno, IdCurso, Condicion, Nota) VALUES (8, 2, 'Aprobado', 10);
INSERT INTO AlumnoInscripciones (IdAlumno, IdCurso, Condicion, Nota) VALUES (9, 9, 'Aprobado', 7);
INSERT INTO AlumnoInscripciones (IdAlumno, IdCurso, Condicion, Nota) VALUES (10, 10, 'Desaprobado', 2);


/* INSERTS de Comisiones */
INSERT INTO Comisiones (IdPlan, Descripcion, AnioEspecialidad) VALUES (1, 'Comisión A', 1);
INSERT INTO Comisiones (IdPlan, Descripcion, AnioEspecialidad) VALUES (2, 'Comisión B', 2);
INSERT INTO Comisiones (IdPlan, Descripcion, AnioEspecialidad) VALUES (3, 'Comisión C', 3);
INSERT INTO Comisiones (IdPlan, Descripcion, AnioEspecialidad) VALUES (4, 'Comisión D', 4);
INSERT INTO Comisiones (IdPlan, Descripcion, AnioEspecialidad) VALUES (5, 'Comisión E', 5);
INSERT INTO Comisiones (IdPlan, Descripcion, AnioEspecialidad) VALUES (6, 'Comisión F', 2);
INSERT INTO Comisiones (IdPlan, Descripcion, AnioEspecialidad) VALUES (7, 'Comisión G', 3);
INSERT INTO Comisiones (IdPlan, Descripcion, AnioEspecialidad) VALUES (8, 'Comisión H', 1);
INSERT INTO Comisiones (IdPlan, Descripcion, AnioEspecialidad) VALUES (9, 'Comisión I', 4);
INSERT INTO Comisiones (IdPlan, Descripcion, AnioEspecialidad) VALUES (10, 'Comisión J', 5);


/* INSERTS de Cursos */
INSERT INTO Cursos (IdComision, IdMateria, Cupo, AnioCalendario, Descripcion) VALUES (1, 3, 25, 2023, 'Curso de Matemática');
INSERT INTO Cursos (IdComision, IdMateria, Cupo, AnioCalendario, Descripcion) VALUES (2, 5, 30, 2023, 'Curso de Física');
INSERT INTO Cursos (IdComision, IdMateria, Cupo, AnioCalendario, Descripcion) VALUES (3, 7, 20, 2024, 'Curso de Química');
INSERT INTO Cursos (IdComision, IdMateria, Cupo, AnioCalendario, Descripcion) VALUES (4, 2, 40, 2024, 'Curso de Historia');
INSERT INTO Cursos (IdComision, IdMateria, Cupo, AnioCalendario, Descripcion) VALUES (5, 8, 35, 2023, 'Curso de Biología');
INSERT INTO Cursos (IdComision, IdMateria, Cupo, AnioCalendario, Descripcion) VALUES (6, 4, 15, 2024, 'Curso de Lengua');
INSERT INTO Cursos (IdComision, IdMateria, Cupo, AnioCalendario, Descripcion) VALUES (7, 1, 50, 2023, 'Curso de Geografía');
INSERT INTO Cursos (IdComision, IdMateria, Cupo, AnioCalendario, Descripcion) VALUES (8, 6, 45, 2024, 'Curso de Computación');
INSERT INTO Cursos (IdComision, IdMateria, Cupo, AnioCalendario, Descripcion) VALUES (9, 9, 20, 2023, 'Curso de Filosofía');
INSERT INTO Cursos (IdComision, IdMateria, Cupo, AnioCalendario, Descripcion) VALUES (10, 10, 30, 2024, 'Curso de Música');


/* INSERTS de DocenteCursos */
INSERT INTO DocenteCursos (IdCurso, IdDocente, Cargo) VALUES (1, 3, 2);
INSERT INTO DocenteCursos (IdCurso, IdDocente, Cargo) VALUES (2, 5, 3);
INSERT INTO DocenteCursos (IdCurso, IdDocente, Cargo) VALUES (3, 2, 1);
INSERT INTO DocenteCursos (IdCurso, IdDocente, Cargo) VALUES (4, 6, 2);
INSERT INTO DocenteCursos (IdCurso, IdDocente, Cargo) VALUES (5, 8, 3);
INSERT INTO DocenteCursos (IdCurso, IdDocente, Cargo) VALUES (6, 4, 1);
INSERT INTO DocenteCursos (IdCurso, IdDocente, Cargo) VALUES (7, 9, 2);
INSERT INTO DocenteCursos (IdCurso, IdDocente, Cargo) VALUES (8, 10, 3);
INSERT INTO DocenteCursos (IdCurso, IdDocente, Cargo) VALUES (9, 7, 1);
INSERT INTO DocenteCursos (IdCurso, IdDocente, Cargo) VALUES (10, 1, 2);

/* INSERTS de Especialidades */
INSERT INTO Especialidades (Descripcion) VALUES ('Especialidad en Ingeniería de Software');
INSERT INTO Especialidades (Descripcion) VALUES ('Especialidad en Ciencia de Datos');
INSERT INTO Especialidades (Descripcion) VALUES ('Especialidad en Redes y Seguridad');
INSERT INTO Especialidades (Descripcion) VALUES ('Especialidad en Desarrollo Web');
INSERT INTO Especialidades (Descripcion) VALUES ('Especialidad en Inteligencia Artificial');
INSERT INTO Especialidades (Descripcion) VALUES ('Especialidad en Bases de Datos');
INSERT INTO Especialidades (Descripcion) VALUES ('Especialidad en Administración de Sistemas');
INSERT INTO Especialidades (Descripcion) VALUES ('Especialidad en Robótica');
INSERT INTO Especialidades (Descripcion) VALUES ('Especialidad en Internet de las Cosas');
INSERT INTO Especialidades (Descripcion) VALUES ('Especialidad en Análisis de Sistemas');

/* INSERTS de Materias */
INSERT INTO Materias (Descripcion, IdPlan, HsSemanales, HsTotales) VALUES ('Matemáticas', 1, 4, 60);
INSERT INTO Materias (Descripcion, IdPlan, HsSemanales, HsTotales) VALUES ('Física', 2, 3, 45);
INSERT INTO Materias (Descripcion, IdPlan, HsSemanales, HsTotales) VALUES ('Química', 3, 3, 50);
INSERT INTO Materias (Descripcion, IdPlan, HsSemanales, HsTotales) VALUES ('Biología', 4, 2, 40);
INSERT INTO Materias (Descripcion, IdPlan, HsSemanales, HsTotales) VALUES ('Historia', 5, 2, 35);
INSERT INTO Materias (Descripcion, IdPlan, HsSemanales, HsTotales) VALUES ('Geografía', 6, 2, 30);
INSERT INTO Materias (Descripcion, IdPlan, HsSemanales, HsTotales) VALUES ('Literatura', 7, 3, 50);
INSERT INTO Materias (Descripcion, IdPlan, HsSemanales, HsTotales) VALUES ('Inglés', 8, 4, 60);
INSERT INTO Materias (Descripcion, IdPlan, HsSemanales, HsTotales) VALUES ('Educación Física', 9, 1, 20);
INSERT INTO Materias (Descripcion, IdPlan, HsSemanales, HsTotales) VALUES ('Arte', 10, 2, 25);

/* INSERTS de Modulos */
INSERT INTO Modulos (Descripcion) VALUES ('Descripcion 1');
INSERT INTO Modulos (Descripcion) VALUES ('Descripcion 2');
INSERT INTO Modulos (Descripcion) VALUES ('Descripcion 3');
INSERT INTO Modulos (Descripcion) VALUES ('Descripcion 4');
INSERT INTO Modulos (Descripcion) VALUES ('Descripcion 5');
INSERT INTO Modulos (Descripcion) VALUES ('Descripcion 6');
INSERT INTO Modulos (Descripcion) VALUES ('Descripcion 7');
INSERT INTO Modulos (Descripcion) VALUES ('Descripcion 8');
INSERT INTO Modulos (Descripcion) VALUES ('Descripcion 9');
INSERT INTO Modulos (Descripcion) VALUES ('Descripcion 10');

/* INSERTS de ModuloUsuarios */
INSERT INTO ModuloUsuarios (IdModulo, IdUsuario, PermiteAlta, PermiteBaja, PermiteConsulta, PermiteModificacion) VALUES (1, 2, 1, 0, 1, 0);
INSERT INTO ModuloUsuarios (IdModulo, IdUsuario, PermiteAlta, PermiteBaja, PermiteConsulta, PermiteModificacion) VALUES (2, 3, 0, 1, 0, 1);
INSERT INTO ModuloUsuarios (IdModulo, IdUsuario, PermiteAlta, PermiteBaja, PermiteConsulta, PermiteModificacion) VALUES (3, 4, 1, 1, 1, 1);
INSERT INTO ModuloUsuarios (IdModulo, IdUsuario, PermiteAlta, PermiteBaja, PermiteConsulta, PermiteModificacion) VALUES (4, 5, 0, 0, 0, 0);
INSERT INTO ModuloUsuarios (IdModulo, IdUsuario, PermiteAlta, PermiteBaja, PermiteConsulta, PermiteModificacion) VALUES (5, 6, 1, 0, 1, 1);
INSERT INTO ModuloUsuarios (IdModulo, IdUsuario, PermiteAlta, PermiteBaja, PermiteConsulta, PermiteModificacion) VALUES (6, 7, 0, 1, 1, 0);
INSERT INTO ModuloUsuarios (IdModulo, IdUsuario, PermiteAlta, PermiteBaja, PermiteConsulta, PermiteModificacion) VALUES (7, 8, 1, 1, 0, 1);
INSERT INTO ModuloUsuarios (IdModulo, IdUsuario, PermiteAlta, PermiteBaja, PermiteConsulta, PermiteModificacion) VALUES (8, 9, 0, 0, 1, 1);
INSERT INTO ModuloUsuarios (IdModulo, IdUsuario, PermiteAlta, PermiteBaja, PermiteConsulta, PermiteModificacion) VALUES (9, 10, 1, 0, 0, 0);
INSERT INTO ModuloUsuarios (IdModulo, IdUsuario, PermiteAlta, PermiteBaja, PermiteConsulta, PermiteModificacion) VALUES (10, 1, 0, 1, 1, 1);

/* INSERTS de Planes */
INSERT INTO Planes (IdEspecialidad, Descripcion) VALUES (1, 'Descripcion 1');
INSERT INTO Planes (IdEspecialidad, Descripcion) VALUES (2, 'Descripcion 2');
INSERT INTO Planes (IdEspecialidad, Descripcion) VALUES (3, 'Descripcion 3');
INSERT INTO Planes (IdEspecialidad, Descripcion) VALUES (4, 'Descripcion 4');
INSERT INTO Planes (IdEspecialidad, Descripcion) VALUES (5, 'Descripcion 5');
INSERT INTO Planes (IdEspecialidad, Descripcion) VALUES (6, 'Descripcion 6');
INSERT INTO Planes (IdEspecialidad, Descripcion) VALUES (7, 'Descripcion 7');
INSERT INTO Planes (IdEspecialidad, Descripcion) VALUES (8, 'Descripcion 8');
INSERT INTO Planes (IdEspecialidad, Descripcion) VALUES (9, 'Descripcion 9');
INSERT INTO Planes (IdEspecialidad, Descripcion) VALUES (10, 'Descripcion 10');


/* Eliminacion de todas las tablas */
DROP TABLE Comisiones;
DROP TABLE Cursos;
DROP TABLE DocenteCursos;
DROP TABLE Especialidades;
DROP TABLE Materias;
DROP TABLE Modulos;
DROP TABLE ModuloUsuarios;
DROP TABLE Planes;
DROP TABLE Usuarios;
DROP TABLE AlumnoInscripciones;