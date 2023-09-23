CREATE DATABASE  IF NOT EXISTS `hospital` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hospital`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hospital
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `acessos`
--

DROP TABLE IF EXISTS `acessos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acessos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `instituicoes_cnpj` char(18) COLLATE utf8mb3_unicode_ci NOT NULL,
  `pacientes_cpf` char(14) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `instituicoes_cnpj` (`instituicoes_cnpj`),
  KEY `pacientes_cpf` (`pacientes_cpf`),
  CONSTRAINT `fk_instituicoes_cnpj` FOREIGN KEY (`instituicoes_cnpj`) REFERENCES `instituicoes` (`cnpj`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pacientes_cpf` FOREIGN KEY (`pacientes_cpf`) REFERENCES `pacientes` (`cpf`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acessos`
--

LOCK TABLES `acessos` WRITE;
/*!40000 ALTER TABLE `acessos` DISABLE KEYS */;
/*!40000 ALTER TABLE `acessos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cirurgias`
--

DROP TABLE IF EXISTS `cirurgias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cirurgias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `id_paciente` char(14) COLLATE utf8mb3_unicode_ci NOT NULL,
  `id_medico` char(9) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cirurgia_pacientes_cpf_pacientes` (`id_paciente`),
  KEY `fk_madicos_cirurgia_id_medicos_cirurgia` (`id_medico`),
  CONSTRAINT `fk_cirurgia_pacientes_cpf_pacientes` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`cpf`),
  CONSTRAINT `fk_madicos_cirurgia_id_medicos_cirurgia` FOREIGN KEY (`id_medico`) REFERENCES `medicos` (`crm`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cirurgias`
--

LOCK TABLES `cirurgias` WRITE;
/*!40000 ALTER TABLE `cirurgias` DISABLE KEYS */;
INSERT INTO `cirurgias` VALUES (1,'2023-05-01','111.111.111-11','111111111');
/*!40000 ALTER TABLE `cirurgias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultas`
--

DROP TABLE IF EXISTS `consultas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `id_paciente` char(14) COLLATE utf8mb3_unicode_ci NOT NULL,
  `id_medico` char(9) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_consultas_pacientes_cpf_pacientes` (`id_paciente`),
  KEY `fk_madicos_consultas_id_medicos_consultas` (`id_medico`),
  CONSTRAINT `fk_consultas_pacientes_cpf_pacientes` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`cpf`),
  CONSTRAINT `fk_madicos_consultas_id_medicos_consultas` FOREIGN KEY (`id_medico`) REFERENCES `medicos` (`crm`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
INSERT INTO `consultas` VALUES (1,'2023-09-01','111.111.111-11','111111111');
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico`
--

DROP TABLE IF EXISTS `historico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico` (
  `id` int NOT NULL AUTO_INCREMENT,
  `api` int NOT NULL,
  `cpf` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `cnpj` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `instituicao` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `horario` datetime NOT NULL,
  `rota` varchar(40) COLLATE utf8mb3_unicode_ci NOT NULL,
  `resposta` varchar(1500) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico`
--

LOCK TABLES `historico` WRITE;
/*!40000 ALTER TABLE `historico` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instituicoes`
--

DROP TABLE IF EXISTS `instituicoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instituicoes` (
  `cnpj` varchar(18) COLLATE utf8mb3_unicode_ci NOT NULL,
  `nome` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instituicoes`
--

LOCK TABLES `instituicoes` WRITE;
/*!40000 ALTER TABLE `instituicoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `instituicoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicos`
--

DROP TABLE IF EXISTS `medicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicos` (
  `crm` char(9) COLLATE utf8mb3_unicode_ci NOT NULL,
  `nome` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `especializacao` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`crm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicos`
--

LOCK TABLES `medicos` WRITE;
/*!40000 ALTER TABLE `medicos` DISABLE KEYS */;
INSERT INTO `medicos` VALUES ('111111111','Doutora Zerbielli','Estética'),('123890','Cristian Solutchak ','Neurologista'),('131232','dsadsadsa','dsadas'),('23819739','aquiii','aquii2');
/*!40000 ALTER TABLE `medicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pacientes`
--

DROP TABLE IF EXISTS `pacientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pacientes` (
  `cpf` char(14) COLLATE utf8mb3_unicode_ci NOT NULL,
  `nome` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `rg` char(9) COLLATE utf8mb3_unicode_ci NOT NULL,
  `data_nasc` date NOT NULL,
  `sexo` char(1) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `mae` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `pai` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb3_unicode_ci NOT NULL,
  `cep` char(9) COLLATE utf8mb3_unicode_ci NOT NULL,
  `endereço` varchar(150) COLLATE utf8mb3_unicode_ci NOT NULL,
  `numero` int NOT NULL,
  `bairro` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `cidade` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `estado` char(2) COLLATE utf8mb3_unicode_ci NOT NULL,
  `telefone_fixo` char(12) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `celular` char(12) COLLATE utf8mb3_unicode_ci NOT NULL,
  `altura` char(4) COLLATE utf8mb3_unicode_ci NOT NULL,
  `peso` varchar(3) COLLATE utf8mb3_unicode_ci NOT NULL,
  `tipo_sanguineo` varchar(3) COLLATE utf8mb3_unicode_ci NOT NULL,
  `medico_responsavel` char(9) COLLATE utf8mb3_unicode_ci NOT NULL,
  `data_cadastro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cpf`),
  KEY `fk_medico_pacientes_crm_medico` (`medico_responsavel`),
  CONSTRAINT `fk_medico_pacientes_crm_medico` FOREIGN KEY (`medico_responsavel`) REFERENCES `medicos` (`crm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pacientes`
--

LOCK TABLES `pacientes` WRITE;
/*!40000 ALTER TABLE `pacientes` DISABLE KEYS */;
INSERT INTO `pacientes` VALUES ('111.111.111-11','Bob','1.111.111','1970-01-01','M','Joana','Jonas','bob@bobmail.com','11111-000','Rua do Bob',111,'Bairro do Bob','Bob City','AC','11 111111111','11 111111111','170','65','A+','111111111','2023-03-30 12:06:19'),('123.321.123-32','mazza','s','2023-01-04','F','s','dsçiaohdosah','c ','s','90',200,'Centro','Santa Rosa','SC','12','eqw','19','19','A+','123890','2023-03-28 17:15:29'),('s','s','s','2023-02-28','M','s','s','s','s','s',23,'s','s','AC','s','s','s','w','A-','123890','2023-03-28 17:04:04');
/*!40000 ALTER TABLE `pacientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planos`
--

DROP TABLE IF EXISTS `planos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pacote_do_plano` varchar(30) COLLATE utf8mb3_unicode_ci NOT NULL,
  `regiao` char(2) COLLATE utf8mb3_unicode_ci NOT NULL,
  `id_cliente` char(14) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_planos_pacientes_id_pacientes` (`id_cliente`),
  CONSTRAINT `fk_planos_pacientes_id_pacientes` FOREIGN KEY (`id_cliente`) REFERENCES `pacientes` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planos`
--

LOCK TABLES `planos` WRITE;
/*!40000 ALTER TABLE `planos` DISABLE KEYS */;
INSERT INTO `planos` VALUES (1,'Especial','AC','111.111.111-11'),(2,'entrada','AC','s');
/*!40000 ALTER TABLE `planos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hospital'
--

--
-- Dumping routines for database 'hospital'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-23 12:56:23
