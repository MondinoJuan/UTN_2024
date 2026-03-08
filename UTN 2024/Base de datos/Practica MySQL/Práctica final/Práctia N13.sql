# PRÁCTICA N13

# Ejercicio 1
CREATE USER userName@localhost identified by 'password';

# Ejercicio 2
ALTER USER 'userName'@'localhost' identified by 'entrar';

# Ejercicio 3
grant select on afatse.* to 'userName'@'localhost';

# Ejercicio 4
grant insert, update, delete on afatse.alumnos to 'userName'@'localhost';

# Ejercicio 5
REVOKE SELECT, INSERT, UPDATE, DELETE, EXECUTE
ON afatse.*
FROM 'userName'@'localhost';

# Ejercicio 6
GRANT SELECT, INSERT, UPDATE ON AGENCIA_PERSONAL.vw_contratos TO 'userName'@'localhost';

SHOW GRANTS FOR 'userName'@'localhost';

# Ejercicio 7
REVOKE ALL PRIVILEGES, 
GRANT OPTION FROM 'userName'@'localhost';
