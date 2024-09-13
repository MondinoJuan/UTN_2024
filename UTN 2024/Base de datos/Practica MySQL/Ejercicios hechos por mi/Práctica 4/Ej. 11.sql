use agencia_personal;
select e.cuit CUIT, e.razon_social RazonSocial, count(*) CantidadSolicitudes
	 from solicitudes_empresas se
     inner join empresas e on se.cuit = e.cuit
     group by CUIT, RazonSocial
;     