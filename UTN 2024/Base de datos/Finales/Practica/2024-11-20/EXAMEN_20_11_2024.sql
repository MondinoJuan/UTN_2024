#--------------------------------------------------------------------------------------------------------#
# EXAMEN 20/11/2024                                                                                      #
#--------------------------------------------------------------------------------------------------------#

#Pregunta 1 --> descargar la BDD RRHH

#Pregunta 2
/*
Nuevo Requerimiento: Categorizar a los empleados
Realice la creación, inserción de registros y modificación de las tablas que se requieran con sus correspondientes 
claves primarias y foráneas, según el siguiente requerimiento:
Cada empleado corresponde a una única categoría.   De las categorías se registran, código y descripción. 
Categoría 1- Empleado gerencial
Categoría 2. Empleado técnico.
Se deberá asignar la categoría a los empleados según sus puestos de trabajo actuales:
Los que tienen puesto 1- Jefe de Producción y 14- Director de sistemas se categorizan como 1-Empleado Gerencial.
El resto serán Categoría 2- Empleado Técnico*/

#Pregunta 3
/*
EMPLEADOS NO CONTRATADOS: 
Listado de las personas que no hayan sido contratadas por la empresa en el 2016 (fecha_ini) .
El listado debe contener todos los datos registrados de la persona. */

#Pregunta 4
/*
CANTIDAD DE SOLICITUDES CANCELADAS POR ESTADO:
Indicar por estado  la cantidad de procesos de solicitudes no canceladas cuya cantidad supere 3. 
No incluir los estados  “contrato” y “rechazo”. 
Mostrar: Codigo de estado, descripción, cantidad de solicitudes. */

#Pregunta 5
/*
Ranking de competencias. 
Mostrar las competencias que más personas la han presentado en su curricum (mayor que dos). 
Indicar por cada competencia, la descripcion, cantidad de veces que se repite, nombre, apellido de las personas que
la presentaron en su curriculum. 
Para aquellas personas que fueron contratadas en estas competencias indicar su último puesto.
Aquellas personas que no fueron contratadas indicar “Competencia sin Contratar”
NOTA: una persona en su curriculum puede indicar varias competencias, luego ser contratada por una de ellas, no por todas 
las competencias que presentó. */

#Pregunta 6
/*Crear un procedimiento de nombre personas_puesto que recibiendo como parámetros la denominación de un área y 
la descripción de un puesto de trabajo, liste los datos personales de las personas que en su último curriculumn 
se presentaron para competencias en esa área y puesto de trabajo. Probar el procedimiento para área: ‘Producción’, 
puesto: ‘operario’
Copiar el script generado en la respuesta.*/
