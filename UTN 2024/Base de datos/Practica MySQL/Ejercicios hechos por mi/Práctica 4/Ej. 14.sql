use agencia_personal;
select car.cod_cargo CodCargo, car.desc_cargo DescCargo, count(se.cod_cargo) CantidadSolicitudes
	from cargos car
    left join solicitudes_empresas se on car.cod_cargo = se.cod_cargo
    group by CodCargo, DescCargo
    order by CantidadSolicitudes desc
;