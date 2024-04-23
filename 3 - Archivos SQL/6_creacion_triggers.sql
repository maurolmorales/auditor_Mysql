USE auditor;

DROP TRIGGER IF EXISTS trg_log_legajos_insert;
DELIMITER //
CREATE TRIGGER trg_log_legajos_insert AFTER INSERT ON auditor.legajos
FOR EACH ROW
BEGIN    
	INSERT INTO log_auditoria(id_log, accion, tabla, registro_json, usuario, fecha_ingerencia, hora_injerencia) VALUES
     (null, 'INSERT', 'legajos', JSON_OBJECT('num_cuenta', NEW.num_cuenta, 'id_empresa', NEW.id_empresa, 'num_sucursal', NEW.num_sucursal, 'id_sucursa', 
     NEW.id_sucursal, 'cod_estado', NEW.cod_estado, 'fecha_otorg', NEW.fecha_otorg, 'fecha_obs', NEW.fecha_obs), SESSION_USER(), CURDATE(), CURTIME());     
END //
DELIMITER ;
 -- CALL sp_insertarLegajo(700002, 1, 18, 25, '2024-03-19', '2024-03-20', '{"p_obs1":43, "p_obs2":42, "p_obs3":37, "p_obs4":25}', 'Ingreso de prueba desde trg_log_legajos_insert ', @p_mensaje); 
 -- SELECT * FROM legajos WHERE num_cuenta = 700001;
 -- SELECT * FROM log_auditoria;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP TRIGGER IF EXISTS trg_log_legajos_update;
DELIMITER //
CREATE TRIGGER trg_log_legajos_update AFTER UPDATE ON auditor.legajos
FOR EACH ROW
BEGIN
	INSERT INTO log_auditoria(id_log, accion, tabla, registro_json, usuario, fecha_ingerencia, hora_injerencia) VALUES
     (null, 'UPDATE_BEFORE', 'legajos', JSON_OBJECT('num_cuenta', NEW.num_cuenta, 'id_empresa', NEW.id_empresa, 'num_sucursal', NEW.num_sucursal, 
     'id_sucursa', NEW.id_sucursal, 'cod_estado', NEW.cod_estado, 'fecha_otorg', NEW.fecha_otorg, 'fecha_obs', NEW.fecha_obs), SESSION_USER(), CURDATE(), CURTIME()),
	 (null, 'UPDATE_AFTER', 'legajos', JSON_OBJECT('num_cuenta', OLD.num_cuenta, 'id_empresa', OLD.id_empresa, 'num_sucursal', OLD.num_sucursal, 
     'id_sucursa', OLD.id_sucursal, 'cod_estado', OLD.cod_estado, 'fecha_otorg', OLD.fecha_otorg, 'fecha_obs', OLD.fecha_obs), SESSION_USER(), CURDATE(), CURTIME());
END //
DELIMITER ;
-- UPDATE legajos SET cod_estado = 40 WHERE num_cuenta = 700001;
-- SELECT * FROM legajos WHERE num_cuenta = 700001;
-- SELECT * FROM log_auditoria;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP TRIGGER IF EXISTS trg_log_legajos_delete;
DELIMITER //
CREATE TRIGGER trg_log_legajos_delete AFTER DELETE ON auditor.legajos
FOR EACH ROW
BEGIN
  	INSERT INTO log_auditoria(id_log, accion, tabla, registro_json, usuario, fecha_ingerencia, hora_injerencia) VALUES
     (null, 'DELETE', 'legajos', JSON_OBJECT('num_cuenta', OLD.num_cuenta, 'id_empresa', OLD.id_empresa, 'num_sucursal', OLD.num_sucursal,
     'id_sucursa', OLD.id_sucursal, 'cod_estado', OLD.cod_estado, 'fecha_otorg', OLD.fecha_otorg, 'fecha_obs', OLD.fecha_obs), SESSION_USER(), CURDATE(), CURTIME());             
END //
DELIMITER ;
-- DELETE FROM legajos WHERE num_cuenta = 700002;
-- SELECT * FROM vw_panorama WHERE num_cuenta = 700002;
-- SELECT * FROM log_auditoria;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP TRIGGER IF EXISTS trg_log_observados_insert;
DELIMITER //
CREATE TRIGGER trg_log_observados_insert AFTER INSERT ON auditor.observados
FOR EACH ROW
BEGIN
	INSERT INTO log_auditoria(id_log, accion, tabla, registro_json, usuario, fecha_ingerencia, hora_injerencia) VALUES
     (null, 'INSERT', 'observados', JSON_OBJECT('id_observado', NEW.id_observado, 'num_cuenta', NEW.num_cuenta, 'cod_obs', NEW.cod_obs), SESSION_USER(), CURDATE(), CURTIME());
END //
DELIMITER ;
-- INSERT INTO observados (id_observado, num_cuenta, cod_obs) VALUES( NULL, 4024210, 18); 
-- SELECT * FROM observados where num_cuenta = 4108910;
-- SELECT * FROM log_auditoria;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP TRIGGER IF EXISTS trg_log_observados_update;
DELIMITER //
CREATE TRIGGER trg_log_observados_update AFTER UPDATE ON auditor.observados
FOR EACH ROW
BEGIN
	INSERT INTO log_auditoria(id_log, accion, tabla, registro_json, usuario, fecha_ingerencia, hora_injerencia) VALUES
     (null, 'UPDATE_BEFORE', 'observados', JSON_OBJECT('id_observado', OLD.id_observado, 'num_cuenta', OLD.num_cuenta, 'cod_obs', OLD.cod_obs), SESSION_USER(), CURDATE(), CURTIME()),
	 (null, 'UPDATE_AFTER', 'observados', JSON_OBJECT('id_observado', NEW.id_observado, 'num_cuenta', NEW.num_cuenta, 'cod_obs', NEW.cod_obs), SESSION_USER(), CURDATE(), CURTIME());
END //
DELIMITER ;
-- UPDATE observados SET cod_obs = 25 WHERE num_cuenta = 4024210 AND cod_obs = 18;
-- SELECT * FROM observados where num_cuenta = 4024210;
-- SELECT * FROM log_auditoria;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP TRIGGER IF EXISTS trg_log_observados_delete;
DELIMITER //
CREATE TRIGGER trg_log_observados_delete BEFORE DELETE ON auditor.observados
FOR EACH ROW
BEGIN
	INSERT INTO log_auditoria(id_log, accion, tabla, registro_json, usuario, fecha_ingerencia, hora_injerencia) VALUES
     (null, 'DELETE', 'observados', JSON_OBJECT('id_observado', OLD.id_observado, 'num_cuenta', OLD.num_cuenta, 'cod_obs', OLD.cod_obs), SESSION_USER(), CURDATE(), CURTIME());
END //
DELIMITER ;
-- DELETE FROM observados WHERE cod_obs = 45 AND num_cuenta = 4024210 ;
-- SELECT * FROM vw_panorama WHERE num_cuenta = 4024210 ;
-- SELECT * FROM log_auditoria;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP TRIGGER IF EXISTS trg_log_comentarios_insert;
DELIMITER //
CREATE TRIGGER trg_log_comentarios_insert AFTER INSERT ON auditor.comentarios
FOR EACH ROW
BEGIN
	INSERT INTO log_auditoria(id_log, accion, tabla, registro_json, usuario, fecha_ingerencia, hora_injerencia) VALUES
	  (	null, 'INSERT', 'comentarios', JSON_OBJECT('id_comentario', NEW.id_comentario, 'num_cuenta', NEW.num_cuenta, 'comentario', NEW.comentario, 
      'fecha_coment', NEW.fecha_coment), SESSION_USER(), CURDATE(), CURTIME());
END //
DELIMITER ;

-- INSERT INTO comentarios (id_comentario, num_cuenta, comentario, fecha_coment) VALUES (NULL, 4024210, 'Este es un comentario de prueba de trigger trg_log_comentarios_insert', CURDATE());
-- SELECT * FROM comentarios WHERE num_cuenta = 4024210;
-- select * from log_auditoria;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

	DROP TRIGGER IF EXISTS trg_log_comentarios_update;
    DELIMITER //
    CREATE TRIGGER trg_log_comentarios_update AFTER UPDATE ON auditor.comentarios
    FOR EACH ROW
    BEGIN
		INSERT INTO log_auditoria(id_log, accion, tabla, registro_json, usuario, fecha_ingerencia, hora_injerencia) VALUES
		  (null, 'UPDATE_BEFORE', 'comentarios', JSON_OBJECT('id_comentario', OLD.id_comentario, 'num_cuenta', OLD.num_cuenta, 'comentario', OLD.comentario,
          'fecha_coment', OLD.fecha_coment), SESSION_USER(), CURDATE(), CURTIME()),
		  (null, 'UPDATE_AFTER', 'comentarios', JSON_OBJECT('id_comentario', NEW.id_comentario, 'num_cuenta', NEW.num_cuenta, 'comentario', NEW.comentario,
          'fecha_coment', NEW.fecha_coment), SESSION_USER(), CURDATE(), CURTIME());
    END //
    DELIMITER ;
    
-- UPDATE comentarios SET comentario = 'Este es un comentario MODIFICADO de prueba de trigger' WHERE id_comentario = 4972;
-- SELECT * FROM comentarios WHERE num_cuenta = 653298;
-- SELECT * FROM log_auditoria;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

DROP TRIGGER IF EXISTS trg_log_comentarios_delete;
DELIMITER //
CREATE TRIGGER trg_log_comentarios_delete BEFORE DELETE ON auditor.comentarios
FOR EACH ROW
BEGIN
	INSERT INTO log_auditoria(id_log, accion, tabla, registro_json, usuario, fecha_ingerencia, hora_injerencia) VALUES
     (null, 'DELETE', 'comentarios', JSON_OBJECT('id_comentario', OLD.id_comentario, 'num_cuenta', OLD.num_cuenta, 'comentario', OLD.comentario,
     'fecha_coment', OLD.fecha_coment), SESSION_USER(), CURDATE(), CURTIME());
END //
DELIMITER ;

-- DELETE FROM comentarios WHERE id_comentario = 4970;
-- SELECT * FROM comentarios WHERE num_cuenta = 4024210;
-- SELECT * FROM log_auditoria;