use db_carrito;

create table Categoria (
	IdCategoria int primary key auto_increment,
    Descripcion varchar(100),
    Activo tinyint(1) default 1,
    FechaRegistro datetime default now()
);

create table Marca (
	IdMarca int primary key auto_increment,
    Descripcion varchar(100),
    Activo tinyint(1) default 1,
    FechaRegistro datetime default now()
);

create table Producto (
	IdProducto int primary key auto_increment,
    Descripcion varchar(500),
    Nombre varchar(500),
    Precio decimal(10,2) default 0,
    IdMarca int references Marca(IdMarca),
    IdCategoria int references Categoria(IdCategoria),
    Stock int,
    RutaImagen varchar(100),
    NombreImagen varchar(100),
    Activo tinyint(1) default 1,
    FechaRegistro datetime default now()
);

create table Cliente (
	IdCliente int primary key auto_increment,
    Nombres varchar(100),
    Apellidos varchar(100),
    Correo varchar(100),
    Clave varchar(150),
    Reestablecer tinyint(1) default 0,			-- Para reestablecer la contraseña.
    FechaRegistro datetime default now()
);

create table Carrito (
	IdCarrito int primary key auto_increment,
    IdCliente int references Cliente(IdCliente),
    IdProducto int references Producto(IdProducto),
    Cantidad int
);

create table Venta (
	IdVenta int primary key auto_increment,
    IdCliente int references Cliente(IdCliente),
    TotalProducto int,
    MontoTotal decimal(10,2),
    Contacto varchar(50),
    IdDistrito varchar(10),
    Telefono varchar(50),
    Direccion varchar(500),
    IdTransaccion varchar(50),
    FechaVenta datetime default now()
);

create table Detalle_Venta (
	IdDetalleVenta int primary key auto_increment,
    IdVenta int references Venta(IdVenta),
    IdProducto int references Producto(IdProducto),
    Cantidad int,
    Total decimal(10,2)
);

create table Usuario (
	IdUsuario int primary key auto_increment,
    Nombres varchar(100),
    Apellidos varchar(100),
    Correo varchar(100),
    Clave varchar(150),
    Activo tinyint(1) default 1,
    Reestablecer tinyint(1) default 1,			-- Para reestablecer la contraseña.
    FechaRegistro datetime default now()
);

create table Departamento (
	IdDepartamento varchar(2) not null,
    Descripcion varchar(45) not null
);

create table Provincia (
	IdProvincia varchar(4) not null,
    Descripcion varchar(45) not null,
    IdDepartamento varchar(2) not null references Departamento(IdDepartamento)
);

create table Distrito (
	IdDistrito varchar(6) not null,
	IdDepartamento varchar(2) not null references Departamento(IdDepartamento),
    IdProvincia varchar(4) not null references Provincia(IdProvincia),
    Descripcion varchar(45) not null
);

