USE agencia_personal;
select concat(nombre, ' ', apellido) as nombre_completo, fecha_nacimiento, Telefono, direccion from personas where dni = 28675888;