use academia_net;

create table Entidad_Negocio (
	Id int primary key auto_increment,
    State int 							
    -- Refleja la enumerlación en .NET, de esta forma es más flexible que "State ENUM(Guardar, Crear, Modificar, Borrar)"
);

create table Especialidad (
	IdEspecialidad int primary key,
    Foreign key (IdEspecialidad) references Entidad_Negocio(Id),
	Descripcion varchar(150)
);

create table Modulo (
	IdModulo int primary key,
    Foreign key (IdModulo) references Entidad_Negocio(Id),
	Descripcion varchar(150)
);

create table Plan (
	IdPlan int primary key,
    Foreign key (IdPlan) references Entidad_Negocio(Id),
    IdEspecialidad int references Especialidad(IdEspecialidad),
    Descripcion varchar(100)
);

create table Comision (
	IdComision int primary key,
    Foreign key (IdComision) references Entidad_Negocio(Id),
    IdPlan int references Plan(IdPlan),
    AnioEspecialidad int,
    Descripcion varchar(150)
);

create table Materia (
	IdMateria int primary key,
    Foreign key (IdMateria) references Entidad_Negocio(Id),
    IdPlan int references Plan(IdPlan),
    HsSemanales int,
    HsTotales int,
    Descripcion varchar(100)
);

create table Persona (
	IdPersona int primary key,
    Foreign key (IdPersona) references Entidad_Negocio(Id),
    IdPlan int references Plan(IdPlan),
    Tipo int,
    Legajo int,
    Edad int,
    FechaNac Date,
    FechaRegistro DATETIME default CURRENT_TIMESTAMP,			-- Si no se pasa un valor se pone el de hoy.
    Nombre varchar(100),
    Apellido varchar(100),
    Correo varchar(150),
    Telefono varchar(100),
    Direccion varchar(200),
    NombreUsuario varchar(50),
    Contrasenia varchar(20),
    Habilitado boolean
);

create table Modulo_Persona (
	IdModulo_Persona int primary key,
    Foreign key (IdModulo_Persona) references Entidad_Negocio(Id),
    IdModulo int references Modulo(IdModulo),
    IdPersona int references Persona(IdPersona),
    PermiteBaja boolean,
    PermiteAlta boolean,
    PermiteConsulta boolean,
    PermiteModificacion boolean
);

create table Alumno_Inscripcion (
	IdAlumno_Inscripcion int primary key,
    Foreign key (IdAlumno_Inscripcion) references Entidad_Negocio(Id),
    IdAlumno int references Alumno(IdAlumno),
    IdCurso int references Curso(IdCurso),
    Nota int,
    Condicion varchar(150)
);

create table Curso (
	IdCurso int primary key,
    Foreign key (IdCurso) references Entidad_Negocio(Id),
    IdComision int references Comision(IdComision),
    IdMateria int references Materia(IdMateria),
    Cupo int,
    AnioCalendario int,
    Descripcion varchar(150)
);

create table Docente_Curso (
	IdDocente_Curso int primary key,
    Foreign key (IdDocente_Curso) references Entidad_Negocio(Id),
    IdCurso int references Curso(IdCurso),
    IdDocente int references Docente(IdDocente),
    TipoCargos int
);