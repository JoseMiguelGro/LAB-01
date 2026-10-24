-- 8.1 Crear el rol de soporte sin login directo
CREATE ROLE soporte NOLOGIN;

-- 8.2 Crear vista enmascarada
CREATE VIEW v_clientes_soporte AS 
SELECT
    id, 
    nombre,
    CONCAT(LEFT(correo, 2), '*****', SUBSTRING(correo FROM POSITION('@' IN correo))) AS correo,
    CONCAT('******', RIGHT(telefono, 4)) AS telefono,
    CONCAT('*********', RIGHT(rfc, 4)) AS rfc 
FROM clientes;

-- 8.3 Conceder permisos sobre el esquema y la vista, y revocar acceso a la tabla original
GRANT USAGE ON SCHEMA public TO soporte;
GRANT SELECT ON v_clientes_soporte TO soporte;
REVOKE ALL ON clientes FROM soporte;

SELECT * FROM v_clientes_soporte;

SELECT * FROM clientes;