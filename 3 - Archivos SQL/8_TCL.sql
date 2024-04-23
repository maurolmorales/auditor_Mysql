USE auditor;
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;
SELECT @@SQL_SAFE_UPDATES;
SELECT @@AUTOCOMMIT;
SELECT @@FOREIGN_KEY_CHECKS;

ROLLBACK;
START TRANSACTION;
DELETE FROM comentarios WHERE id_comentario = 3906;
DELETE FROM comentarios WHERE id_comentario = 3924;
DELETE FROM comentarios WHERE id_comentario = 3954;
SELECT * FROM comentarios WHERE id_comentario IN(3906, 3924, 3954);
-- ROLLBACK;
-- COMMIT;

START TRANSACTION;
INSERT INTO observados(id_observado, num_cuenta, cod_obs) VALUES (null, 600001, 3), (null, 600002, 18), (null, 600003, 25), (null, 600004, 42);
SAVEPOINT punto_1;
DELETE FROM observados WHERE id_observado IN(600001,600003);
SAVEPOINT punto_2;
INSERT INTO observados(id_observado, num_cuenta, cod_obs) VALUES (null, 600005, 41), (null, 600006, 46), (null, 600007, 33), (null, 600008, 26);
SAVEPOINT punto_3;
UPDATE observados SET cod_obs = 25 WHERE num_cuenta = 600007;
SELECT id_observado, num_cuenta, cod_obs FROM observados ORDER BY id_observado DESC LIMIT 8;
-- RELEASE SAVEPOINT punto_1;
-- COMMIT;