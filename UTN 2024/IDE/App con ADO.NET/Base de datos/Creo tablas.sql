use db_prueba;

CREATE TABLE Venta (
    IdVenta INT PRIMARY KEY AUTO_INCREMENT,
    NroDocumento VARCHAR(20),
    RazonSocial VARCHAR(50),
    Total DECIMAL(10,2)
);

CREATE TABLE Detalle_Venta (
    IdDetalleVenta INT PRIMARY KEY AUTO_INCREMENT,
    IdVenta int references Venta(IdVenta),
    Producto VARCHAR(50),
    Precio DECIMAL(10,2),
    Cantidad int,
    Total DECIMAL(10,2)
);