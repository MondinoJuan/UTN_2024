USE agencia_personal;
select concat(nombre, ' ', apellido) as nombre_completo, fecha_nacimiento, Telefono, direccion from personas 
where dni = 27890765 or dni = 29345777 or dni = 31345778 ORDER BY fecha_nacimiento;