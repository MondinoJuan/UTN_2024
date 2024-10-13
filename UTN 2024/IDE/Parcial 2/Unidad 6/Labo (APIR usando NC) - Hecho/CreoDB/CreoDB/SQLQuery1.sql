

create table [dbo].[Alumnos](
	[DNI] varchar(20) not null,
	[ApellidoNombre] varchar(50) not null,
	[Email] varchar(50) default(null) null,
	[FechaNacimiento] datetime not null,
	[NotaPromedio] decimal(4, 2) null,
	constraint [PK_Alumnos] primary key clustered([DNI] asc)
);