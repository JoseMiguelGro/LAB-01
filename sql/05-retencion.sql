-- Identificar registros con antigüedad mayor a 5 años
SELECT * 
FROM clientes 
WHERE fecha_alta < CURRENT_DATE - INTERVAL '5 years';

--Área de soporte debe poder consultar:
SELECT * FROM v_clientes_soporte;
--pero no acceder directamente a:
SELECT * FROM clientes;
--Área de analítica debe poder consultar:
SELECT * FROM analitica.clientes;
--pero no:
SELECT * FROM pii.mapa_cliente;
--ni:
SELECT * FROM public.clientes;
