CREATE SCHEMA pii;

CREATE SCHEMA analitica;

CREATE TABLE pii.mapa_cliente ( token UUID PRIMARY KEY, cliente_id BIGINT UNIQUE
REFERENCES public.clientes(id));

CREATE EXTENSION IF NOT EXISTS pgcrypto;

--Generar un token para cada cliente:
INSERT INTO pii.mapa_cliente (token, cliente_id)
SELECT gen_random_uuid(), id FROM clientes;

SELECT * FROM pii.mapa_cliente;

-- 10. Crear conjunto de datos analíticos
CREATE TABLE analitica.clientes AS 
SELECT 
    m.token AS cliente_token,
    c.edad,
    c.ciudad,
    c.codigo_postal,
    c.fecha_alta
FROM pii.mapa_cliente m
JOIN clientes c ON c.id = m.cliente_id;

SELECT * FROM analitica.clientes;

--Crear el rol:
CREATE ROLE analista NOLOGIN;
--Conceder acceso al conjunto de datos analítico:
GRANT USAGE ON SCHEMA analitica TO analista;
GRANT SELECT ON analitica.clientes TO analista;

--No conceder acceso a: pii.mapa_cliente
REVOKE ALL ON pii.mapa_cliente FROM analista;

--ni a: public.clientes
REVOKE ALL ON public.clientes FROM analista;

--El acceso al conjunto analítico debe estar permitido:
SELECT * FROM analitica.clientes;

--El acceso al mapa de correspondencia debe estar restringido:
SELECT * FROM pii.mapa_cliente;

--También debe estar restringido el acceso directo a los datos originales:
SELECT * FROM public.clientes;