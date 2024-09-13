use agencia_personal;
select nombre, apellido, fecha_nacimiento from personas where fecha_nacimiento between '1980-12-31' and '2000-01-01';