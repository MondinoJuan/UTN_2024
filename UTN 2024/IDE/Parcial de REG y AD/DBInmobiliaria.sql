CREATE TABLE [dbo].[TiposPropiedades] (
    [Id]          BIGINT       IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_TiposPropiedades] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[Propiedades] (
    [Id]                   BIGINT          IDENTITY (1, 1) NOT NULL,
    [IdTipoPropiedad]      BIGINT          NOT NULL,
    [Titulo]               VARCHAR (50)    NOT NULL,
    [Descripcion]          VARCHAR (100)   NOT NULL,
    [CantidadHabitaciones] INT             NOT NULL,
    [M2]                   INT             NOT NULL,
    [Precio]               DECIMAL (18, 2) NOT NULL,
    [FechaAlta]            DATETIME        NOT NULL,
    CONSTRAINT [PK_Propiedades] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Propiedades_TiposPropiedades] FOREIGN KEY ([IdTipoPropiedad]) REFERENCES [dbo].[TiposPropiedades] ([Id])
);

select * from Propiedades;
select * from TiposPropiedades;



