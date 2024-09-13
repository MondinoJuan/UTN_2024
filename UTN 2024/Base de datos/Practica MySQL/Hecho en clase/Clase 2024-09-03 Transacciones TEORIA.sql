/*
Una transacción son un conjunto de operaciones elementales que se realizan todas o ninguna. Esto se hace para garantizar la seguridad de los datos; por ejemplo se corta la alimentación eléctrica 
y los datos quedasen a medias, en este caso se vuelve al estado anterior. Cada operación finaliza con un commit (en caso de éxito) o con un rollback (en caso de falla), rollback vuelve al último
estado consistente previo al fallo. Soy yo el que tiene que especificar la acción.

Las operaciones elementales son Update (Actualiza valores de atributos), Delete (Elimina tuplas), Insert (Inserta tuplas) y Select (Consulta de datos), porque generan cambios 
en lo estados de la base de datos.

Cada vez que use un update o delete tengo que poner si o si where, para no afectar a todos.
*/