DELIMITER //

CREATE PROCEDURE ACTUALIZAR_PAGOS(IN paciente_id INT)
BEGIN
  SELECT 'EFECTIVO' AS TIPO_PAGO, FORMAT(SUM(costo_total), 2) AS MONTO
  FROM cuentas_pacientes_detalles
  WHERE cuentas_pacientes_id = paciente_id AND detalle = 'EFECTIVO'
  UNION ALL
  SELECT 'CHEQUE' AS TIPO_PAGO, FORMAT(SUM(costo_total), 2) AS MONTO
  FROM cuentas_pacientes_detalles
  WHERE cuentas_pacientes_id = paciente_id AND detalle = 'CHEQUE'
  UNION ALL
  SELECT 'TARJETA CRÉDITO' AS TIPO_PAGO, FORMAT(SUM(costo_total), 2) AS MONTO
  FROM cuentas_pacientes_detalles
  WHERE cuentas_pacientes_id = paciente_id AND detalle = 'TARJETA CRÉDITO'
  UNION ALL
  SELECT 'TARJETA DÉBITO' AS TIPO_PAGO, FORMAT(SUM(costo_total), 2) AS MONTO
  FROM cuentas_pacientes_detalles
  WHERE cuentas_pacientes_id = paciente_id AND detalle = 'TARJETA DÉBITO'
  UNION ALL
  SELECT 'SIN PAGO' AS TIPO_PAGO, FORMAT(SUM(costo_total), 2) AS MONTO
  FROM cuentas_pacientes_detalles
  WHERE cuentas_pacientes_id = paciente_id AND detalle IS NULL;
END//

DELIMITER ;

