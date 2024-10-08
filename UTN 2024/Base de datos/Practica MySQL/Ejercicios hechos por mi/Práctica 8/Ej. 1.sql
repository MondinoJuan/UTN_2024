use afatse; 

start transaction;

insert into instructores /*(cuil, nombre, apellido, tel, email, direccion, cuil_supervisor)*/
	values ("44-44444444-4", "Daniel", "Tapia", "444-444444", "dotapia@gmail.com", "Ayacucho 4444", NULL)
;

-- commit;

select * from instructores;