# PRÁCTICA N12

# Ejercicio 4 y 5
start transaction;

insert into alumnos(dni, nombre, apellido, tel, email, direccion)
	value(42840150, 'juan cruz', 'mondino', 9876543, 'juancm.2000@hotmail.com', 'pellegrini 2341');

insert into instrucciones(nom_plan, nro_curso, dni, fecha_inscripcion)
	value('Maketing 3', 1, 42840150, curdate());

rollback;
