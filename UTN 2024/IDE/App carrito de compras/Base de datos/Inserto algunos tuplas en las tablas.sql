use db_carrito;

select * from usuario;
insert into usuario (Nombres, Apellidos, Correo, Clave) values 
	('test nombre', 'test apellido', 'test@example.com', 'test123') -- Para encriptar la clave usa SHA256
;

select * from categoria;
insert into categoria (Descripcion) values 
	('Tecnologia'),
    ('Muebles'),
    ('Dormitorio'),
    ('Deportes')
;

select * from marca;
insert into marca (Descripcion) values 
	('SONYTE'),
    ('HPTE'),
    ('LGTE'),
    ('CANONTE'),
    ('ROBERTA ALLENTE'),
    ('HYUNDAITE')
;

select * from departamento;
insert into departamento (IdDepartamento, Descripcion) values 
	('01', 'Arequipa'),
    ('02', 'Ica'),
    ('03', 'Lima')
;

select * from provincia;
insert into provincia (IdProvincia, Descripcion, IdDepartamento) values 
	('0101', 'Arequipa', '01'),
    ('0102', 'Camaná', '01'),
    ('0201', 'Ica', '02'),
    ('0202', 'Chincha', '02'),
    ('0301', 'Lima', '03'),
    ('0302', 'Barranca', '03')
;

select * from distrito;
insert into distrito (IdDistrito, Descripcion, IdProvincia, IdDepartamento) values 
	('010101', 'Nieva', '0101', '01'),
    ('010102', 'El Cenepa', '0101', '01'),
    ('010201', 'Camaná', '0102', '01'),
    ('010202', 'José María Quimper', '0102', '01'),
    ('020101', 'Ica', '0201', '02'),
    ('020102', 'La Tinguiña', '0201', '02'),
    ('020201', 'Chincha Alta', '0202', '02'),
    ('020202', 'Alto Laran', '0202', '02'),
    ('030101', 'Lima', '0301', '03'),
    ('030102', 'Ancón', '0301', '03'),
    ('030201', 'Paramonga', '0302', '03'),
    ('030202', 'Barranca', '0302', '03')
;