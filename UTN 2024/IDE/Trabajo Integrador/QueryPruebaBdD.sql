

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Usuarios';

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


select * from Usuarios;


INSERT INTO Usuarios (/*Id,*/ IdPlan, Nombre, Apellido, FechaNacimiento, Direccion, Tipo, Telefono, Legajo, Email, Username, Password, FechaRegistro, Habilitado)
VALUES (/*1,*/ 101, 'Juan', 'Pérez', '1990-01-15', '123 Calle Falsa', 0, 5551234, 12345, 'juan.perez@example.com', 'juanp', 'password123', '2024-11-07', 1);

