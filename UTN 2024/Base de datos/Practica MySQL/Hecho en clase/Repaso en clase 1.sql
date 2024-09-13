/*Realizamos ejercitacion suponiendo el uso de la base de datos de ferretería.*/

/*Mostrar los productos con categoría 123 y 124.*/
	select * from Productos prod where prod.idCat = 123 or prod.idCat = 124;

/*Mostrar datos personales de las personas que hicieron algún pedido.*/
	/*Hecho por mi: MAL*/
	select * from Personas per left join Pedidos ped where ped.nroPed is not null;

	/*Bien.*/     
	/*Aclaración: no uso el distinct porque los atributos utilizados son primaryKey y no estarán duplicados. Si lo utilizaría si es que 
	muestro solamente el atributo del cuil (no todos, *), porque puede que una persona haya hecho mas de un pedido entonces aparecería varias 
	veces*/
	select * from Personas per inner join Pedidos ped on per.cuit = ped.cuit;

/*Detalle de los productos solicitados por "La Ferre SA"*/
	/*Hecho por profe*/ /*Aclaración: estaría mal utilizar el distinct acá.*/
    select deta.id_producto, prod.descripcion, deta.cantidad from personas per 
		inner join pedidos ped on per.cuit = ped.cuit 
        inner join detalle_pedidos deta on ped.ir_pedido = deta.id_pedido 
		inner join prod_prov on prod_prov.idprod = deta.idprod
        inner join productos prod on prod_prov.idprod = prod.idprod 
        where per.razon_social = 'La Ferre SA';
        
/*Listado de todas las personas: su cuit, razon social direccion y ,si realizaron pedido, mostrar la fecha del pedido.*/
	/*Hecho profe.*/
    select per.cuit, per.razon_social, per.direccion, ifnull(ped.fecha_ped, 'Sin pedidos.') FechaPedidos 
		from personas per 
        left join pedidos ped on per.cuit = ped.cuit;