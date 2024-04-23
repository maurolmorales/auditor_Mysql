USE auditor;

DROP PROCEDURE IF EXISTS sp_insertarLegajo;
DELIMITER //
CREATE PROCEDURE sp_insertarLegajo( IN p_num_cuenta INT, IN p_id_empresa INT, IN p_num_sucursal INT, IN p_cod_estado INT, 
									IN p_fecha_otorg DATE, IN p_fecha_obs DATE, IN p_observaciones JSON, 
                                    IN p_comentario VARCHAR(250), OUT p_mensaje VARCHAR(200) )
BEGIN
	DECLARE idSucursal INT;    
    DECLARE admission INT;
    DECLARE cod_obs1 INT;  
	DECLARE cod_obs2 INT;  
	DECLARE cod_obs3 INT;  
	DECLARE cod_obs4 INT;  
	SET cod_obs1 = JSON_EXTRACT(p_observaciones, '$.p_obs1');
	SET cod_obs2 = JSON_EXTRACT(p_observaciones, '$.p_obs2');
	SET cod_obs3 = JSON_EXTRACT(p_observaciones, '$.p_obs3');
	SET cod_obs4 = JSON_EXTRACT(p_observaciones, '$.p_obs4');    
	SET admission = fn_verifica_num_cuenta(p_num_cuenta);    
    -- Se obtiene el id_sucursal previo a obtener el id de la empresa y el número de la sucursal: 
    IF admission = 0 THEN SET idSucursal = fn_obtenerIdSucursal(p_id_empresa, p_num_sucursal); 
    -- se ingresa primero a la tabla legajos: 
		INSERT INTO legajos (num_cuenta, id_empresa, num_sucursal, cod_estado, id_sucursal, fecha_otorg, fecha_obs)
			VALUES (p_num_cuenta, p_id_empresa, p_num_sucursal, p_cod_estado, idSucursal, p_fecha_otorg, p_fecha_obs);
	 -- se ingresa seguidamente a la tabla observados: 
		IF cod_obs1 IS NOT NULL THEN INSERT INTO observados(id_observado, num_cuenta, cod_obs) VALUES (null, p_num_cuenta, cod_obs1);
		END IF;
		IF cod_obs2 IS NOT NULL THEN INSERT INTO observados(id_observado, num_cuenta, cod_obs) VALUES (null, p_num_cuenta, cod_obs2);
		END IF;
		IF cod_obs3 IS NOT NULL THEN INSERT INTO observados(id_observado, num_cuenta, cod_obs) VALUES (null, p_num_cuenta, cod_obs3);
		END IF;
		IF cod_obs4 IS NOT NULL THEN INSERT INTO observados(id_observado, num_cuenta, cod_obs) VALUES (null, p_num_cuenta, cod_obs4);  
		END IF;  
        -- Por último se ingresa a la tabla comentarios:   
        IF p_comentario IS NOT NULL THEN
			INSERT INTO comentarios(id_comentario, num_cuenta, comentario, fecha_coment )
				VALUES(null, p_num_cuenta, p_comentario, CURDATE());    
        END IF;        
        SET p_mensaje = 'inserción exitosa';
        SELECT p_mensaje AS Mensaje;
    ELSE  
		SET p_mensaje = 'El número de cuenta ya existe en la base';	
		SELECT p_mensaje AS Mensaje;
	END IF;    
END //
DELIMITER ;
-- CALL sp_insertarLegajo(753291, 1, 69, 25, '2024-03-19', '2024-03-20', '{"p_obs1":25, "p_obs2":2, "p_obs3":15}', 'Este es un comentario de prueba', @p_mensaje);
-- SELECT * FROM vw_panorama WHERE num_cuenta = 753291;
-- SELECT * FROM legajos WHERE num_cuenta = 753291;
-- SELECT * FROM observados WHERE num_cuenta = 753291;
-- SELECT * FROM comentarios WHERE num_cuenta = 753291;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP PROCEDURE IF EXISTS sp_consultaProgreso;
DELIMITER //
CREATE PROCEDURE sp_consultaProgreso(IN p_primerLapso VARCHAR(20), IN p_codEstado INT, IN p_fechaDesde DATE,
									 IN p_fechaHasta DATE, IN p_segundoLapso VARCHAR(20),
									 IN p_fechaDesde2 DATE, IN p_fechaHasta2 DATE )
BEGIN
    DECLARE CodEstado VARCHAR(200);
    DECLARE resultado VARCHAR(200);

    IF p_codEstado IS NULL THEN SET CodEstado = '';
    ELSE SET CodEstado = CONCAT(' AND cod_estado = ',  p_codEstado);
    END IF;       
    
    SET @consulta = CONCAT(
        'SELECT nom_empresa AS Empresa, num_sucursal AS NumSuc, nom_sucursal AS NomSuc, ',
        'COUNT(CASE WHEN fecha_obs > ''', p_fechaDesde, ''' AND fecha_obs < ''', p_fechaHasta, ''' THEN cod_obs END) AS ', p_primerLapso, ',',
        'COUNT(CASE WHEN fecha_obs > ''', p_fechaDesde2, ''' AND fecha_obs < ''', p_fechaHasta2, ''' THEN cod_obs END) AS ', p_segundoLapso,
        ' FROM vw_panorama WHERE 1=1',CodEstado, ' GROUP BY Empresa, NumSuc, NomSuc ORDER BY num_sucursal'
    );
    
    PREPARE informe FROM @consulta;
    EXECUTE informe;
    DEALLOCATE PREPARE informe;
END //
DELIMITER ;

-- CALL sp_consultaProgreso('año_2022', NULL , '2022-01-01','2022-12-30','año_2023', '2023-01-01','2023-12-30');

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP PROCEDURE IF EXISTS sp_ordenarTabla;
DELIMITER //
CREATE PROCEDURE sp_ordenarTabla( IN p_nombreTabla VARCHAR(100), IN p_campoOrdenamiento VARCHAR(100), IN p_orden VARCHAR(10) )
BEGIN
    SET @query = CONCAT('SELECT * FROM ', p_nombreTabla, ' ORDER BY ', p_campoOrdenamiento, ' ', p_orden);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

-- CALL sp_ordenarTabla('legajos', 'num_sucursal', 'ASC');
-- CALL sp_ordenarTabla('comentarios', 'fecha_coment', 'DESC');

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP PROCEDURE IF EXISTS sp_informe_mensual;
DELIMITER //
CREATE PROCEDURE sp_informe_mensual (IN p_id_empresa VARCHAR(20), IN p_fechaDesde DATE, IN p_fechaHasta DATE)
BEGIN
IF p_id_empresa IS NOT NULL THEN 
	SELECT * FROM vw_panorama WHERE fecha_obs >= p_fechaDesde AND fecha_obs <= p_fechaHasta AND id_empresa = p_id_empresa;
ELSE 
    SELECT DISTINCT * FROM vw_panorama WHERE fecha_obs >= p_fechaDesde AND fecha_obs <= p_fechaHasta;
END IF ;    
END //
DELIMITER ;

-- CALL sp_informe_mensual (null, '2023-01-01', '2023-12-31');

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP PROCEDURE IF EXISTS sp_actualizarCategoria;
DELIMITER //
CREATE PROCEDURE sp_actualizarCategoria (IN p_fecha_desde DATE, IN p_fecha_hasta DATE)
BEGIN 
	UPDATE sucursales AS suc
	INNER JOIN ( SELECT id_sucursal, COUNT(num_cuenta) AS cuenta FROM legajos WHERE fecha_obs BETWEEN p_fecha_desde AND p_fecha_hasta  GROUP BY id_sucursal ) AS leg
	ON suc.id_sucursal = leg.id_sucursal
	SET suc.categoria = fn_updateCategoria(leg.cuenta);    
END //
DELIMITER ;	

-- CALL sp_actualizarCategoria ('2023-01-01', '2023-06-01')