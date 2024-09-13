use agencia_personal;
SELECT concat(p.nombre, ' ', p.apellido) as 'Postulante', c.desc_cargo as 'Cargo' 
	FROM personas p
	INNER JOIN antecedentes a ON a.dni = p.dni
	INNER JOIN cargos c ON a.cod_cargo = c.cod_cargo