/*
Seleccionar las comisiones pagadas que tengan un importe menor al promedio de todas las
comisiones(pagas y no pagas), mostrando razón social de la empresa contratante, mes
contrato, año contrato , nro. contrato, nombre y apellido del empleado
*/

use agencia_personal;

select avg(com.importe_comision) into @prome
	from comisiones com
;

SELECT 
    *
FROM
    empresas em
        INNER JOIN
    contratos con ON em.cuit = con.cuit
        INNER JOIN
    comisiones com ON con.nro_contrato = com.nro_contrato
        INNER JOIN
    personas per ON con.dni = per.dni
WHERE
    fecha_pago IS NOT NULL
        AND importe_comision < @prome
;