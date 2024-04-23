-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: auditor
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `codigos`
--

DROP TABLE IF EXISTS `codigos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `codigos` (
  `cod_obs` int unsigned NOT NULL,
  `cod_referencia` int unsigned NOT NULL,
  `ref_codigo` varchar(45) NOT NULL,
  PRIMARY KEY (`cod_obs`),
  KEY `fk_cod_codReferencia` (`cod_referencia`),
  CONSTRAINT `fk_cod_codReferencia` FOREIGN KEY (`cod_referencia`) REFERENCES `referencia` (`cod_referencia`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentarios` (
  `id_comentario` int unsigned NOT NULL AUTO_INCREMENT,
  `num_cuenta` int unsigned NOT NULL,
  `comentario` varchar(250) NOT NULL,
  `fecha_coment` date NOT NULL,
  PRIMARY KEY (`id_comentario`),
  KEY `fk_coment_numCuenta` (`num_cuenta`),
  CONSTRAINT `fk_coment_numCuenta` FOREIGN KEY (`num_cuenta`) REFERENCES `legajos` (`num_cuenta`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4969 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresas` (
  `id_empresa` int unsigned NOT NULL AUTO_INCREMENT,
  `nom_empresa` varchar(20) NOT NULL,
  PRIMARY KEY (`id_empresa`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados` (
  `cod_estado` int unsigned NOT NULL,
  `ref_estado` varchar(40) NOT NULL,
  PRIMARY KEY (`cod_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `legajos`
--

DROP TABLE IF EXISTS `legajos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legajos` (
  `num_cuenta` int unsigned NOT NULL,
  `id_empresa` int unsigned NOT NULL,
  `num_sucursal` int unsigned NOT NULL,
  `id_sucursal` int unsigned NOT NULL,
  `cod_estado` int unsigned NOT NULL,
  `fecha_otorg` date NOT NULL,
  `fecha_obs` date NOT NULL,
  PRIMARY KEY (`num_cuenta`),
  KEY `fk_leg_codEstado` (`cod_estado`),
  KEY `fk_leg_idSucursal` (`id_sucursal`),
  CONSTRAINT `fk_leg_codEstado` FOREIGN KEY (`cod_estado`) REFERENCES `estados` (`cod_estado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_leg_idSucursal` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id_sucursal`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `localidades`
--

DROP TABLE IF EXISTS `localidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `localidades` (
  `id_localidad` int unsigned NOT NULL AUTO_INCREMENT,
  `ref_localidad` varchar(25) NOT NULL,
  `sector` varchar(10) NOT NULL,
  PRIMARY KEY (`id_localidad`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_auditoria`
--

DROP TABLE IF EXISTS `log_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_auditoria` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(50) DEFAULT NULL,
  `tabla` varchar(50) DEFAULT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `registro_json` json DEFAULT NULL,
  `fecha_ingerencia` date DEFAULT NULL,
  `hora_injerencia` time DEFAULT NULL,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `observados`
--

DROP TABLE IF EXISTS `observados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `observados` (
  `id_observado` int unsigned NOT NULL AUTO_INCREMENT,
  `num_cuenta` int unsigned NOT NULL,
  `cod_obs` int unsigned NOT NULL,
  PRIMARY KEY (`id_observado`),
  KEY `fk_obs_idCodigos` (`cod_obs`),
  KEY `fk_obs_numCuenta` (`num_cuenta`),
  CONSTRAINT `fk_obs_idCodigos` FOREIGN KEY (`cod_obs`) REFERENCES `codigos` (`cod_obs`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_obs_numCuenta` FOREIGN KEY (`num_cuenta`) REFERENCES `legajos` (`num_cuenta`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11310 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referencia`
--

DROP TABLE IF EXISTS `referencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referencia` (
  `cod_referencia` int unsigned NOT NULL,
  `ref_referencia` varchar(45) NOT NULL,
  PRIMARY KEY (`cod_referencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `regionales`
--

DROP TABLE IF EXISTS `regionales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regionales` (
  `id_regional` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(12) NOT NULL,
  `apellido` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  PRIMARY KEY (`id_regional`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sucursales`
--

DROP TABLE IF EXISTS `sucursales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sucursales` (
  `id_sucursal` int unsigned NOT NULL AUTO_INCREMENT,
  `num_sucursal` int unsigned NOT NULL,
  `id_localidad` int unsigned NOT NULL,
  `id_empresa` int unsigned NOT NULL,
  `id_regional` int unsigned NOT NULL,
  `latitud` decimal(20,15) NOT NULL,
  `longitud` decimal(20,15) NOT NULL,
  `nom_sucursal` varchar(30) NOT NULL,
  `categoria` char(1) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_sucursal`),
  KEY `fk_suc_idLocalidad` (`id_localidad`),
  KEY `fk_suc_idEmpresa` (`id_empresa`),
  KEY `fk_suc_idRegional` (`id_regional`),
  CONSTRAINT `fk_suc_idEmpresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_suc_idLocalidad` FOREIGN KEY (`id_localidad`) REFERENCES `localidades` (`id_localidad`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_suc_idRegional` FOREIGN KEY (`id_regional`) REFERENCES `regionales` (`id_regional`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-20  3:31:21
