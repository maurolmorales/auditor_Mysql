USE mysql;
SELECT * FROM user;

CREATE USER IF NOT EXISTS 'juanperez'@'localhost' IDENTIFIED BY 'qwe9qwe';
CREATE USER IF NOT EXISTS 'mariagarcia'@'localhost' IDENTIFIED BY 'asd6asd';
CREATE USER IF NOT EXISTS 'carlosmartinez'@'localhost' IDENTIFIED BY 'zxc3zxc';

GRANT SELECT ON auditor.* TO 'juanperez'@'localhost';
GRANT SELECT ON auditor.* TO 'mariagarcia'@'localhost';
GRANT SELECT, INSERT, UPDATE, EXECUTE ON auditor.* TO 'carlosmartinez'@'localhost';
