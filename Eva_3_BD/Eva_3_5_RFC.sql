DELIMITER $$
CREATE FUNCTION generar_rfc(apellido_pat VARCHAR(50), apellido_mat VARCHAR(50), nombre VARCHAR(50), fecha_nac DATE)
RETURNS VARCHAR(13) deterministic
BEGIN
  DECLARE rfc VARCHAR(13);
  SET rfc = CONCAT(LEFT(apellido_paterno, 2), LEFT(apellido_materno, 1), LEFT(nombre, 1));
  SET rfc = CONCAT(rfc, DATE_FORMAT(fecha_nacimiento, '%y%m%d'));
  RETURN rfc;
END $$
DELIMITER ;