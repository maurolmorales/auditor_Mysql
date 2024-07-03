DROP SCHEMA IF EXISTS AUDITOR;
CREATE SCHEMA IF NOT EXISTS AUDITOR;
USE AUDITOR;

CREATE TABLE EMPRESAS (
  id_empresa  INT UNSIGNED NOT NULL auto_increment,
  nom_empresa  VARCHAR(20) NOT NULL,
  CONSTRAINT PK_EMPRESAS PRIMARY KEY (id_empresa)
);

CREATE TABLE LOCALIDADES (
  id_localidad  INT UNSIGNED NOT NULL AUTO_INCREMENT,
  ref_localidad  VARCHAR(25) NOT NULL,
  sector VARCHAR(10) NOT NULL,
  CONSTRAINT PK_LOCALIDAD PRIMARY KEY (id_localidad)
);

CREATE TABLE REGIONALES (
  id_regional  INT UNSIGNED NOT NULL auto_increment,
  nombre  VARCHAR(12) NOT NULL,
  apellido  VARCHAR(15) NOT NULL,
  email  VARCHAR(50) NOT NULL,
  telefono  VARCHAR(20) NOT NULL,
  CONSTRAINT PK_REGIONALES PRIMARY KEY (id_regional)
);

CREATE TABLE REFERENCIA (
  cod_referencia  INT UNSIGNED NOT NULL,
  ref_referencia  VARCHAR(45) NOT NULL,   
  CONSTRAINT PK_REFERENCIA PRIMARY KEY (cod_referencia)
);

CREATE TABLE CODIGOS (
  cod_obs  INT UNSIGNED NOT NULL,
  cod_referencia  INT UNSIGNED NOT NULL, 
  ref_codigo  VARCHAR(45) NOT NULL,   
  CONSTRAINT PK_CODIGOS PRIMARY KEY (cod_obs)
);

CREATE TABLE OBSERVADOS(
  id_observado  INT UNSIGNED NOT NULL auto_increment,
  num_cuenta  INT UNSIGNED NOT NULL, 
  cod_obs  INT UNSIGNED NOT NULL, 
  CONSTRAINT PK_OBSERVADOS PRIMARY KEY (id_observado)
);

CREATE TABLE COMENTARIOS(
  id_comentario  INT UNSIGNED NOT NULL auto_increment,
  num_cuenta  INT UNSIGNED NOT NULL, 
  comentario  VARCHAR(250) NOT NULL, 
  fecha_coment  DATE NOT NULL,
  CONSTRAINT PK_COMENTARIOS PRIMARY KEY (id_comentario)
);

CREATE TABLE ESTADOS (
  cod_estado  INT UNSIGNED NOT NULL,
  ref_estado  VARCHAR(40) NOT NULL, 
  CONSTRAINT PK_ESTADOS PRIMARY KEY (cod_estado)
);

CREATE TABLE SUCURSALES (
  id_sucursal  INT UNSIGNED NOT NULL auto_increment,
  num_sucursal  INT UNSIGNED NOT NULL,
  id_localidad  INT UNSIGNED NOT NULL,   
  id_empresa  INT UNSIGNED NOT NULL, 
  id_regional  INT UNSIGNED NOT NULL,  
  latitud DECIMAL(20,15) NOT NULL,
  longitud DECIMAL(20,15) NOT NULL,
  nom_sucursal  VARCHAR(30) NOT NULL, 
  categoria  CHAR(1) DEFAULT NULL,
  email  VARCHAR(50) DEFAULT NULL,
  telefono  VARCHAR(20) DEFAULT NULL,   
  CONSTRAINT PK_SUCURSALES PRIMARY KEY (id_sucursal)
);

CREATE TABLE LEGAJOS (  
  num_cuenta  INT UNSIGNED NOT NULL,  
  id_empresa  INT UNSIGNED NOT NULL, 
  num_sucursal  INT UNSIGNED NOT NULL, 
  id_sucursal INT UNSIGNED NOT NULL, 
  cod_estado  INT UNSIGNED NOT NULL, 
  fecha_otorg  DATE NOT NULL, 
  fecha_obs  DATE NOT NULL, 
  CONSTRAINT PK_LEGAJOS PRIMARY KEY (num_cuenta)
);

CREATE TABLE log_auditoria(
	id_log INT AUTO_INCREMENT,
    accion VARCHAR(50),
    tabla VARCHAR(50),        
    usuario VARCHAR(100),
    registro_json json,
    fecha_ingerencia DATE,
    hora_injerencia TIME,
	PRIMARY KEY (id_log)
);

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    
ALTER TABLE codigos ADD CONSTRAINT fk_cod_codReferencia
	FOREIGN KEY fk_cod_codReferencia(cod_referencia)
    REFERENCES referencia(cod_referencia) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE observados ADD CONSTRAINT fk_obs_idCodigos
	FOREIGN KEY fk_obs_idCodigos(cod_obs)
    REFERENCES codigos(cod_obs) ON DELETE RESTRICT ON UPDATE CASCADE;  
    
ALTER TABLE observados ADD CONSTRAINT fk_obs_numCuenta
	FOREIGN KEY fk_obs_numCuenta(num_cuenta)
    REFERENCES legajos(num_cuenta) ON DELETE CASCADE ON UPDATE CASCADE;        
    
ALTER TABLE comentarios ADD CONSTRAINT fk_coment_numCuenta
	FOREIGN KEY fk_coment_numCuenta(num_cuenta)
    REFERENCES legajos(num_cuenta) ON DELETE CASCADE ON UPDATE CASCADE;     
    
ALTER TABLE legajos ADD CONSTRAINT fk_leg_codEstado
	FOREIGN KEY fk_leg_codEstado(cod_estado)
    REFERENCES estados(cod_estado) ON DELETE CASCADE ON UPDATE CASCADE;   
    
ALTER TABLE sucursales ADD CONSTRAINT fk_suc_idLocalidad
	FOREIGN KEY fk_suc_idLocalidad(id_localidad)
    REFERENCES localidades(id_localidad) ON DELETE RESTRICT ON UPDATE CASCADE; 
    
ALTER TABLE sucursales ADD CONSTRAINT fk_suc_idEmpresa
	FOREIGN KEY fk_suc_idEmpresa(id_empresa)
    REFERENCES empresas(id_empresa) ON DELETE RESTRICT ON UPDATE CASCADE;
    
ALTER TABLE sucursales ADD CONSTRAINT fk_suc_idRegional
	FOREIGN KEY fk_suc_idRegional(id_regional)
    REFERENCES regionales(id_regional) ON DELETE RESTRICT ON UPDATE CASCADE;
   
ALTER TABLE legajos ADD CONSTRAINT fk_leg_idSucursal
	FOREIGN KEY fk_leg_idSucursal(id_sucursal)
    REFERENCES sucursales(id_sucursal) ON DELETE RESTRICT ON UPDATE CASCADE;     