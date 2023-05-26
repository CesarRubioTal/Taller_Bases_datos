DELIMITER //

-- Crear la tabla CONSECUTIVOS y agregar un registro con un valor inicial de 1000
CREATE TABLE CONSECUTIVOS (
  CONSECUTIVO INT
);

INSERT INTO CONSECUTIVOS (CONSECUTIVO) VALUES (1000);

-- Crear la función para generar el NSS
CREATE FUNCTION generar_NSS(paciente_fecha_nacimiento DATE) RETURNS TEXT
BEGIN
  DECLARE nss_office INT;
  DECLARE nss_year INT;
  DECLARE nss_birth_year INT;
  DECLARE nss_imss INT;
  DECLARE nss_checksum INT;
  DECLARE nss TEXT;
  
  -- Generar el número de oficina aleatorio entre 0 y 100
  SET nss_office = FLOOR(RAND() * 101);
  
  -- Generar el año de inscripción aleatorio entre 15 años después del año de nacimiento y el año actual
  SET nss_year = YEAR(CURRENT_DATE) - YEAR(paciente_fecha_nacimiento) + 15;
  
  -- Generar el año de nacimiento
  SET nss_birth_year = YEAR(paciente_fecha_nacimiento) % 100;
  
  -- Obtener el último valor de la tabla CONSECUTIVOS y sumarle 1 para el número IMSS
  SELECT CONSECUTIVO INTO nss_imss FROM CONSECUTIVOS ORDER BY CONSECUTIVO DESC LIMIT 1;
  SET nss_imss = nss_imss + 1;
  
  -- Actualizar el valor de la tabla CONSECUTIVOS con el nuevo número IMSS
  INSERT INTO CONSECUTIVOS (CONSECUTIVO) VALUES (nss_imss);
  
  -- Calcular el dígito verificador
  SET nss_checksum = (
    (FLOOR(nss_office / 10) + (nss_office % 10)) +
    (FLOOR(nss_year / 10) + (nss_year % 10)) +
    (FLOOR(nss_birth_year / 10) + (nss_birth_year % 10)) +
    (FLOOR(nss_imss / 1000) + FLOOR((nss_imss % 1000) / 100) + FLOOR((nss_imss % 100) / 10) + (nss_imss % 10))
  ) % 10;
  
  -- Construir el NSS completo
  SET nss = CONCAT(
    LPAD(nss_office, 2, '0'), '-', 
    LPAD(nss_year, 2, '0'), '-', 
    LPAD(nss_birth_year, 2, '0'), '-', 
    LPAD(nss_imss, 4, '0'), '-', 
    nss_checksum
  );
  
  RETURN nss;
END //

DELIMITER ;
