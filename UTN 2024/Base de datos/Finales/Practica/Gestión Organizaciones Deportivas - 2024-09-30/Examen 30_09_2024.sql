#BASE DE DATOS: ALQUILERES
/*Se requiere codificar las ubicaciones de las instalaciones.

Para ello desarrollar las sentencias SQL que se solicitan:

1) Crear la tabla ubicaciones con código (numérico) y descripción

2) Registrar las diferentes ubicaciones  de la tabla instalaciones (descripción no debe repetirse) en la tabla creada en el item 1. 
El código de la ubicación debe ser secuencial.

3) Actualizar las tablas correspondientes para cumplir con el requerimiento,  ya sea en su estructura (atributos, claves foraneas) 
como los datos que deben poseer.
*/

/*AUDITORIA DE EVENTOS
Se requiere un informe que muestre todos los eventos organizados y los servicios que se contrataron para esos eventos. 
Si para los eventos no se han contratado servicios se debe indicar esta situación. Se deberá incluir en el informe: 

Del Evento:  número del evento, razón social del organizador, descripción del tipo de evento

De los Servicios contratados: Descripción o "NO CONTRATA SERVICIOS" 
*/

/*CANTIDAD DE EVENTOS POR ORGANIZADOR POR TIPO.


De aquellos organizadores que no hayan realizado ningún evento  del Tipo “Conferencia”, listar la cantidad de tipos de eventos que 
hayan realizado. 

El listado deberá indicar: Nombre del Organizador, Descripción del tipo de Evento, 
Cantidad de eventos del tipo de evento del organizador.
*/

/*Evaluación del uso de instalaciones y valores pactados:

Con el fin de evaluar el crecimiento del uso de instalaciones y valores pactados del 2do semestre del 2021 con respecto al 
primer semestre se necesita un listado que indique por organizador, razon social,   codigo de instalación,  
la diferencia entre la sumatoria de la cantidad de personas del primer semestre respecto al segundo semestre y diferencia entre 
el total de los valores pactados del  primer semestre y el total de los valores pactados del segundo semestre.
Aquellos organizadores e instalaciones que hayan sido utilizadas en el segundo semestre y no en el primero indicar “Sin utilizacion”
*/


/*Fecha de última actualización valor de servicio a una fecha

Realizar una función que dado  un  código de servicio devuelva la fecha de la última actualización a una fecha dada.

La función debe recibir como parámetros código de servicio y fecha.

Utilizar la función para el listado: Servicios contratados para las instalaciones de un evento.

El listado debe contener:

Número de evento, código de instalación, ubicación y tipo de instalación, fecha desde la que se utilizará el servicio en la instalación 
(fecha desde del contrato), código de servicio y descripción del servicio, fecha vigencia valor de servicio 
(para el cual se deberá utilizar la función realizada y utilizando como parámetros el código de servicio y la fecha desde la que se 
utilizará) y valor del servicio a la fecha que devuelve la función.
*/
