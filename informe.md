# Informe de Laboratorio 01: Protección y Privacidad de Datos

## 1. Clasificación
Se identificaron como datos con necesidad de protección directa a `nombre`, `correo`, `telefono` y `rfc` por ser identificadores directos del titular. Datos como `edad`, `ciudad` y `codigo_postal` se clasificaron como cuasi-identificadores, ya que su combinación incrementa sustancialmente la posibilidad de reidentificación.

## 2. Enmascaramiento
Se creó una vista (`v_clientes_soporte`) que enmascara parcialmente el correo, teléfono y RFC. Esta vista se asignó al rol `soporte`, al cual se le revocaron los permisos directos sobre la tabla original `clientes` para mitigar la exposición innecesaria de información.

## 3. Seudonimización
Se generaron identificadores aleatorios únicos (UUID) almacenados en la tabla `pii.mapa_cliente`. Se construyó la tabla `analitica.clientes` utilizando únicamente el token y variables sociodemográficas. Se aplicó separación de funciones al restringir completamente al rol `analista` el acceso a la tabla de mapa de correspondencia y a la tabla original.

## 4. Anonimización
Se transformaron las variables continuas o detalladas en rangos (ej. rangos de edad y regiones de código postal) y se agruparon registros. Se aplicó la cláusula `HAVING COUNT(*) >= 5` para suprimir grupos con pocos elementos. Se concluyó que el riesgo residual de reidentificación persiste si los datos se combinan con fuentes externas.

## 5. Retención
Se diseñó la consulta para seleccionar registros cuya `fecha_alta` supere los 5 años de antigüedad. Se estableció un protocolo que exige respaldos cifrados previos, aprobaciones por compliance y almacenamiento de logs de auditoría sin ejecutar borrados directos no autorizados.

## 6. Conclusiones
* **Área de Soporte:** Enmascaramiento mediante vistas.
* **Área de Analítica:** Seudonimización con separación estricta de funciones.
* **Publicación Estadística / Dirección:** Anonimización (agregación y generalización).
* **Control de Acceso:** Ninguna técnica de transformación técnica sustituye al control de acceso; el control de acceso determina *quién* entra, mientras que la transformación determina *qué* ve cada usuario de acuerdo con la finalidad.