# PRÁCTICA N13

# Ejercicio 1
CREATE USER userName@localhost identified by 'password';

# Ejercicio 5
REVOKE ALL PRIVILEGES, 
GRANT OPTION FROM 'userName'@'localhost';

# Ejercicio 6
GRANT SELECT, INSERT, UPDATE ON AGENCIA_PERSONAL.contratos TO 'userName'@'localhost';

SHOW GRANTS FOR 'userName'@'localhost';