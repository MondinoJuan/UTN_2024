use agencia_personal;
select e.cuit CUIT, e.razon_social RazonSocial, se.cod_cargo CodCargo, count(*) CantidadSolicitudes
	 from solicitudes_empresas se
     inner join empresas e on se.cuit = e.cuit
     group by CUIT, RazonSocial, CodCargo
     order by CUIT asc
;