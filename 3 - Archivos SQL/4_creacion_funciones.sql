USE auditor;

DROP FUNCTION IF EXISTS fn_obtenerIdSucursal;
DELIMITER //
CREATE FUNCTION fn_obtenerIdSucursal(p_idEmpresa INT, p_numSucursal INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE resultado INT;
    SELECT id_sucursal INTO resultado FROM sucursales WHERE id_empresa = p_idEmpresa AND num_sucursal = p_numSucursal;
    RETURN resultado;
END // 
DELIMITER ;
-- SELECT fn_obtenerIdSucursal(2,2);

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP FUNCTION IF EXISTS fn_updateCategoria;
DELIMITER //
CREATE FUNCTION fn_updateCategoria(p_cantidad INT)
RETURNS CHAR(1)
DETERMINISTIC
BEGIN
	DECLARE calificacion CHAR(1);    
    SET calificacion = CASE
		WHEN p_cantidad = 0 THEN "A"
        WHEN  p_cantidad >0 AND p_cantidad <= 20 THEN "B"
        WHEN p_cantidad >20 AND p_cantidad <= 50 THEN "C"
		WHEN p_cantidad > 50 THEN "D"
        ELSE "-"    
    END ;     
    RETURN calificacion;
END //
DELIMITER ;
-- SELECT fn_updateCategoria(56) AS Resultado;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP FUNCTION IF EXISTS fn_verifica_num_cuenta;
DELIMITER //
CREATE FUNCTION fn_verifica_num_cuenta(p_num_cuenta INT)
RETURNS INTEGER
DETERMINISTIC
BEGIN
	DECLARE respuesta INTEGER;
    IF EXISTS (SELECT num_cuenta FROM legajos WHERE num_cuenta = p_num_cuenta) IS TRUE THEN 
		SET respuesta = 1;
    ELSE 
		SET respuesta = 0;
	END IF;		
    RETURN respuesta;
END //
DELIMITER ;

-- SELECT fn_verifica_num_cuenta(000001);
-- SELECT fn_verifica_num_cuenta(4136776);