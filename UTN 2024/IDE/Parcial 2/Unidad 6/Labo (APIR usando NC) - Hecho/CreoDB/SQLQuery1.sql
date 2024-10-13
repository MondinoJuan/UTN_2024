

select * from Alumnos;

BEGIN TRANSACTION;

-- Insertar el primer alumno
INSERT INTO [dbo].[Alumnos] (DNI, ApellidoNombre, Email, FechaNacimiento, NotaPromedio)
VALUES ('12345678', 'Juan Perez', 'juan.perez@email.com', '1995-05-15', 8.75);

-- Insertar el segundo alumno
INSERT INTO [dbo].[Alumnos] (DNI, ApellidoNombre, Email, FechaNacimiento, NotaPromedio)
VALUES ('87654321', 'Ana Garcia', 'ana.garcia@email.com', '1997-11-22', 9.50);

-- Insertar el tercer alumno
INSERT INTO [dbo].[Alumnos] (DNI, ApellidoNombre, Email, FechaNacimiento, NotaPromedio)
VALUES ('11223344', 'Carlos Lopez', NULL, '1996-02-10', 7.30);

-- Confirmar la transacción
COMMIT;
