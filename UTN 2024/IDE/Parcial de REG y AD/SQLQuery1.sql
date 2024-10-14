
BEGIN TRANSACTION;

-- Insertar en TiposPropiedades
INSERT INTO [dbo].[TiposPropiedades] ([Descripcion])
VALUES ('Departamento');

-- Obtener el ID generado
DECLARE @TipoPropiedadId BIGINT;
SET @TipoPropiedadId = SCOPE_IDENTITY();

-- Insertar en Propiedades
INSERT INTO [dbo].[Propiedades] (
    [IdTipoPropiedad], 
    [Titulo], 
    [Descripcion], 
    [CantidadHabitaciones], 
    [M2], 
    [Precio], 
    [FechaAlta])
VALUES (
    @TipoPropiedadId, 
    'Propiedad 1', 
    'Una bonita propiedad', 
    3, 
    120, 
    200000.00, 
    GETDATE());

COMMIT;
