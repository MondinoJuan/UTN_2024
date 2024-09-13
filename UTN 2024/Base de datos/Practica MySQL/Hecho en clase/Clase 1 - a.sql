use agencia_personal;
select distinct emp.cuit, razon_social from empresas emp inner join solicitudes_empresas sol on emp.cuit = sol.cuit 
														 inner join contratos con on sol.cuit = con.cuit 
																	and sol.cod_cargo = con.cod_cargo 
																	and sol.fecha_solicitud = con.fecha_solicitud;
                                                                    
	