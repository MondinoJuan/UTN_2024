# PRÁCTICA 1

# Ejercicio 1
use agencia_personal;
select * from empresas;

# Ejercicio 2
use agencia_personal;
select apellido, nombre, fecha_registro_agencia, fecha_nacimiento from personas;

# Ejercicio 3
use agencia_personal;
select cod_titulo, desc_titulo, tipo_titulo from titulos
order by desc_titulo asc;

# Ejercicio 4
use agencia_personal;
select nombre, apellido, fecha_nacimiento, telefono, direccion from personas as p
where p.dni = 28675888;

# Ejercicio 5
use agencia_personal;
select nombre, apellido, fecha_nacimiento, telefono, direccion from personas as p
where p.dni = 27890765 or p.dni = 29345777 or p.dni = 31345778
order by fecha_nacimiento;

# Ejercicio 6
use agencia_personal;
select nombre, apellido, fecha_nacimiento, telefono, direccion from personas as p
where p.apellido LIKE 'G%';

# Ejercicio 7
use agencia_personal;
select nombre, apellido, fecha_nacimiento, telefono, direccion from personas as p
where p.fecha_nacimiento > '1980-12-31' and p.fecha_nacimiento < '2000-01-01';

# Ejercicio 8
use agencia_personal;
select * from solicitudes_empresas
order by fecha_solicitud ASC
;

# Ejercicio 9
use agencia_personal;
select * from antecedentes
where fecha_hasta is null
order by fecha_desde ASC
;

# Ejercicio 10
use agencia_personal;
select * from antecedentes
where fecha_hasta < '2013-06-01' or fecha_hasta > '2013-12-31'
;

# Ejercicio 11
use agencia_personal;
select * from contratos
where sueldo > 2000 and (cuit = '30-10504876-5' or cuit = '30-21098732-4')
;

# Ejercicio 12
use agencia_personal;
select * from titulos
where desc_titulo like 'Tecnico%'
;

# Ejercicio 13
use agencia_personal;
select * from solicitudes_empresas
where (fecha_solicitud > '2013-09-21' and cod_cargo = 6) or sexo = 'Femenino'
;

# Ejercicio 14
use agencia_personal;
select * from contratos
where sueldo > 2000 and fecha_caducidad is null
;