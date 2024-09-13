use agencia_personal;
select nro_contrato as Nro_Contrato, dni as DNI, sueldo as Salario, cuit as CUIL from contratos 
where sueldo > 2000 and (cuit = '30-10504876-5' or cuit = '30-21098732-4') order by nro_contrato;