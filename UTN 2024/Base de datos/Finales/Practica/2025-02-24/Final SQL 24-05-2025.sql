Final SQL 24-02-2025

#1 Cargar la fecha de ingreso y categoría de los miembros.            
La cooperativa decidió empezar a llevar registro de ingresos de cada miembro a la misma y 
asignarles una categoría (texto descriptivo). Para ello se deberá: 
	1. Modificar la estructura de la tabla “miembros” para reflejar esta nueva información. 
	2. Cargar la fecha de ingreso de cada miembro, como no se tiene registro se utilizará 
la primera fecha en que cada miembro participó de la elaboración de un lote. 
	3. Asignarle la categoría según esta regla, si ha trabajado más de 300 hs asignarle 
la categoría “miembro”, si ha realizado menos de esa cantidad asignarle “candidato” 

#2 Entregas excedidas.  
Listar aquellas entregas donde se hayan entregado más productos de los solicitados. 
Indicar el nombre y apellido del cliente, el número de pedido, nombre del producto, 
la cantidad pedida, la cantidad entregada y cuánto se entregó de más. Ordenar por cantidad excedente descendente. 

#3 Productos para realizar descuentos.  
Listar los productos cuya cantidad producida no entregada(*) total(**) de 2021 supere 
el promedio de todos los productos(***). Indicar código y nombre del producto, última 
fecha de producción, cantidad producida no entregada total. Notas: (*) Para cada lote 
producido la cantidad producida no entregada es la diferencia entre la cantidad producida 
del lote durante 2021 menos la cantidad total entregada de dicho lote. (**) La cantidad 
producida no entregada total es la sumatoria de la cantidad producida no entregada de todos 
los lotes de un producto. (***) El promedio sólo debe calcularse con los lotes cuya cantidad 
producida no entregada sea mayor a cero. 

#4 Sugerir productos. 
Suele suceder a la cooperativa que algunos de los productos de sus lotes no llegan a ser vendidos 
a tiempo, por lo tanto necesitan un listado que,  dada una fecha sugiera los productos  para evitar 
la situación. Para esto se debe crear un procedimiento almacenado (stored procedure-SP) que reciba 
una fecha y devuelva la lista de productos y lotes que hayan sido producidos antes de dicha fecha, 
pero no hayan vencido para esa fecha y no hayan sido aún entregados en su totalidad. Indicar código 
y nombre del producto, número de lote, fecha de vencimiento y cantidad no entregada aún. Ordenar 
por fecha de vencimiento ascendente y cantidad no entregada descendente.

#5 Actualización de precios. 
De materiales: Aumentó el costo del hierro así que se debe ingresar un nuevo precio para los clavos 
y tornillos un 30% mayor al actual con la fecha de hoy. De productos: También se debe actualizar 
el precio sugerido de los productos que utilicen clavos o tornillos en el importe correspondiente. 
Registrar los nuevos precios de materiales y la actualización del precio sugerido de manera 
atómica, consistente, aislada y durable. Calcular el costo del material que cada uno utiliza 
basado en su composición: 
NUEVO PRECIO SUGERIDO =  PRECIO SUGERIDO + SUMA ( VALOR ACTUAL TORNILLO o CLAVO * 1.3 * CANTIDAD DE COMPOSICION)  

##varios estan repetidos de otros finales