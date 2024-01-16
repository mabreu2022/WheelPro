-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: fulanorodas
-- ------------------------------------------------------
-- Server version	5.7.44-log

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
-- Table structure for table `posicionamento`
--

DROP TABLE IF EXISTS `posicionamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posicionamento` (
  `idposicionamento` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idproduto` int(11) DEFAULT NULL,
  `idveiculo` int(11) DEFAULT NULL,
  `top` int(11) DEFAULT NULL,
  `left` int(11) DEFAULT NULL,
  `Align` varchar(45) DEFAULT 'alNone',
  `BevelOuter` varchar(45) DEFAULT 'bvNone',
  `BorderStyle` varchar(45) DEFAULT 'bsSingle',
  `Caption` varchar(45) DEFAULT '',
  `Color` varchar(45) DEFAULT 'clNone',
  `DockSite` varchar(4) DEFAULT 'True',
  `DoubleBuffered` varchar(4) DEFAULT 'true',
  `DragKind` varchar(45) DEFAULT 'dkDock',
  `DragMode` varchar(45) DEFAULT 'dmAutomatic',
  `Enabled` varchar(4) DEFAULT 'True',
  `Height` int(11) DEFAULT NULL,
  `Movable` varchar(4) DEFAULT 'True',
  `Name` varchar(45) DEFAULT 'JvPanel_',
  `Transparent` varchar(4) DEFAULT 'True',
  `Width` int(11) DEFAULT NULL,
  PRIMARY KEY (`idposicionamento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posicionamento`
--

LOCK TABLES `posicionamento` WRITE;
/*!40000 ALTER TABLE `posicionamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `posicionamento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-08 17:32:05
