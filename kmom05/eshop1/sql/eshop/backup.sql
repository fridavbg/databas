-- MariaDB dump 10.19  Distrib 10.6.4-MariaDB, for osx10.17 (x86_64)
--
-- Host: localhost    Database: eshop
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `faktura`
--

DROP TABLE IF EXISTS `faktura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faktura` (
  `fakturanummer` int NOT NULL,
  `kundorder` int DEFAULT NULL,
  `kund` int DEFAULT NULL,
  `fakturadatum` datetime DEFAULT CURRENT_TIMESTAMP,
  `totalpris` int DEFAULT NULL,
  `uppdaterad` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `borttagen` datetime DEFAULT NULL,
  `skickad` datetime DEFAULT NULL,
  PRIMARY KEY (`fakturanummer`),
  KEY `kundorder` (`kundorder`),
  KEY `kund` (`kund`),
  CONSTRAINT `faktura_ibfk_1` FOREIGN KEY (`kundorder`) REFERENCES `kundorder` (`ordernummer`),
  CONSTRAINT `faktura_ibfk_2` FOREIGN KEY (`kund`) REFERENCES `kund` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktura`
--

LOCK TABLES `faktura` WRITE;
/*!40000 ALTER TABLE `faktura` DISABLE KEYS */;
INSERT INTO `faktura` VALUES (123,11123,NULL,'2022-03-01 10:47:06',300,'2022-03-01 10:47:06',NULL,NULL);
/*!40000 ALTER TABLE `faktura` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER `log_insert_faktura` AFTER INSERT ON `faktura` FOR EACH ROW INSERT INTO logg (kundorder, faktura, loggdatum, kommentar)
        VALUES (NEW.kundorder, NEW.fakturanummer, NEW.fakturadatum, 'faktura skapad') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER `log_update_faktura` AFTER UPDATE ON `faktura` FOR EACH ROW INSERT INTO logg (kundorder, faktura, loggdatum, kommentar)
        VALUES (NEW.kundorder, NEW.fakturanummer, NEW.fakturadatum, 'faktura ändrad') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `faktura_rad`
--

DROP TABLE IF EXISTS `faktura_rad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faktura_rad` (
  `faktura` int NOT NULL,
  `produkt` int NOT NULL,
  `antal` int DEFAULT NULL,
  PRIMARY KEY (`faktura`,`produkt`),
  KEY `produkt` (`produkt`),
  CONSTRAINT `faktura_rad_ibfk_1` FOREIGN KEY (`produkt`) REFERENCES `produkt` (`produktkod`),
  CONSTRAINT `faktura_rad_ibfk_2` FOREIGN KEY (`faktura`) REFERENCES `faktura` (`fakturanummer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktura_rad`
--

LOCK TABLES `faktura_rad` WRITE;
/*!40000 ALTER TABLE `faktura_rad` DISABLE KEYS */;
/*!40000 ALTER TABLE `faktura_rad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategori`
--

DROP TABLE IF EXISTS `kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kategori` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firma` varchar(20) DEFAULT NULL,
  `typ` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategori`
--

LOCK TABLES `kategori` WRITE;
/*!40000 ALTER TABLE `kategori` DISABLE KEYS */;
INSERT INTO `kategori` VALUES (1,'kaffe&company','starkt'),(2,'kaffe&company','svagt'),(3,'te&company','gult'),(4,'te&company','grumligt'),(5,'te&company','rent');
/*!40000 ALTER TABLE `kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kund`
--

DROP TABLE IF EXISTS `kund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kund` (
  `id` int NOT NULL,
  `fornamn` varchar(20) DEFAULT NULL,
  `efternamn` varchar(20) DEFAULT NULL,
  `adress` varchar(20) DEFAULT NULL,
  `mail` varchar(20) DEFAULT NULL,
  `kreditkort` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund`
--

LOCK TABLES `kund` WRITE;
/*!40000 ALTER TABLE `kund` DISABLE KEYS */;
INSERT INTO `kund` VALUES (1,'Erik','Nästesjö','Skogen 1','eriknas@hotmail.com',2147483647),(2,'Kalle','Andersson','Skogen 2','kalle@hotmail.com',1242143123),(3,'Lena','Lunarstorm','Havet 1','lena@lunarstorm.com',54679691),(4,'Stina','Gustavsson','Berg 1','stina@hotmail.com',2147483647),(5,'Sigge','Sur','Berg 2','sigg@sigmail.com',2147483647);
/*!40000 ALTER TABLE `kund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kundorder`
--

DROP TABLE IF EXISTS `kundorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kundorder` (
  `ordernummer` int NOT NULL AUTO_INCREMENT,
  `kund` int DEFAULT NULL,
  `orderdatum` datetime DEFAULT CURRENT_TIMESTAMP,
  `uppdaterad` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `borttagen` datetime DEFAULT NULL,
  `skickad` datetime DEFAULT NULL,
  PRIMARY KEY (`ordernummer`),
  KEY `kund` (`kund`),
  CONSTRAINT `kundorder_ibfk_1` FOREIGN KEY (`kund`) REFERENCES `kund` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundorder`
--

LOCK TABLES `kundorder` WRITE;
/*!40000 ALTER TABLE `kundorder` DISABLE KEYS */;
INSERT INTO `kundorder` VALUES (11123,2,'2022-03-01 10:47:06','2022-03-01 10:47:06',NULL,NULL);
/*!40000 ALTER TABLE `kundorder` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER `log_insert_kundorder` AFTER INSERT ON `kundorder` FOR EACH ROW INSERT INTO logg (kundorder, loggdatum, kommentar)
        VALUES (NEW.ordernummer, NEW.orderdatum, 'beställning skapad') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER `log_update_kundorder` AFTER UPDATE ON `kundorder` FOR EACH ROW INSERT INTO logg (kundorder, loggdatum, kommentar)
        VALUES (NEW.ordernummer, NEW.uppdaterad, 'beställning ändrad') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kundorder_rad`
--

DROP TABLE IF EXISTS `kundorder_rad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kundorder_rad` (
  `kundorder` int NOT NULL,
  `produkt` int NOT NULL,
  `antal` int DEFAULT NULL,
  PRIMARY KEY (`kundorder`,`produkt`),
  KEY `produkt` (`produkt`),
  CONSTRAINT `kundorder_rad_ibfk_1` FOREIGN KEY (`kundorder`) REFERENCES `kundorder` (`ordernummer`),
  CONSTRAINT `kundorder_rad_ibfk_2` FOREIGN KEY (`produkt`) REFERENCES `produkt` (`produktkod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundorder_rad`
--

LOCK TABLES `kundorder_rad` WRITE;
/*!40000 ALTER TABLE `kundorder_rad` DISABLE KEYS */;
/*!40000 ALTER TABLE `kundorder_rad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lagerhylla`
--

DROP TABLE IF EXISTS `lagerhylla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lagerhylla` (
  `hylla` int NOT NULL,
  `beskrivning` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hylla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lagerhylla`
--

LOCK TABLES `lagerhylla` WRITE;
/*!40000 ALTER TABLE `lagerhylla` DISABLE KEYS */;
INSERT INTO `lagerhylla` VALUES (1,'101'),(2,'102'),(3,'103'),(4,'104'),(5,'105');
/*!40000 ALTER TABLE `lagerhylla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logg`
--

DROP TABLE IF EXISTS `logg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logg` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kundorder` int DEFAULT NULL,
  `faktura` int DEFAULT NULL,
  `loggdatum` datetime DEFAULT NULL,
  `kommentar` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kundorder` (`kundorder`),
  KEY `faktura` (`faktura`),
  CONSTRAINT `logg_ibfk_1` FOREIGN KEY (`kundorder`) REFERENCES `kundorder` (`ordernummer`),
  CONSTRAINT `logg_ibfk_2` FOREIGN KEY (`faktura`) REFERENCES `faktura` (`fakturanummer`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logg`
--

LOCK TABLES `logg` WRITE;
/*!40000 ALTER TABLE `logg` DISABLE KEYS */;
INSERT INTO `logg` VALUES (1,NULL,NULL,'2022-03-01 10:47:06','produkt med kod 1 tillagd'),(2,NULL,NULL,'2022-03-01 10:47:06','produkt med kod 2 tillagd'),(3,NULL,NULL,'2022-03-01 10:47:06','produkt med kod 3 tillagd'),(4,NULL,NULL,'2022-03-01 10:47:06','produkt med kod 4 tillagd'),(5,NULL,NULL,'2022-03-01 10:47:06','produkt med kod 5 tillagd'),(6,11123,NULL,'2022-03-01 10:47:06','beställning skapad'),(7,11123,NULL,'2022-03-01 10:47:06','beställning ändrad'),(8,11123,123,'2022-03-01 10:47:06','faktura skapad'),(9,11123,123,'2022-03-01 10:47:06','faktura ändrad');
/*!40000 ALTER TABLE `logg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `plocklista`
--

DROP TABLE IF EXISTS `plocklista`;
/*!50001 DROP VIEW IF EXISTS `plocklista`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `plocklista` (
  `ordernummer` tinyint NOT NULL,
  `kund` tinyint NOT NULL,
  `kundorder` tinyint NOT NULL,
  `produkt` tinyint NOT NULL,
  `antal` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `produkt`
--

DROP TABLE IF EXISTS `produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt` (
  `produktkod` int NOT NULL AUTO_INCREMENT,
  `produktnamn` varchar(20) DEFAULT NULL,
  `produktbeskrivning` varchar(50) DEFAULT NULL,
  `produktpris` int DEFAULT NULL,
  PRIMARY KEY (`produktkod`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt`
--

LOCK TABLES `produkt` WRITE;
/*!40000 ALTER TABLE `produkt` DISABLE KEYS */;
INSERT INTO `produkt` VALUES (1,'Kaffeprod','Ganska tr�kigt kaffe',50),(2,'Kaffeprod2','Lite roligare',70),(3,'Teprod1','Bubbblande roligt',100),(4,'Teprod2','Kommer r�k ur n�san',80),(5,'Teprod3','Det sticker i foten',30);
/*!40000 ALTER TABLE `produkt` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER `log_insert_produkt` AFTER INSERT ON `produkt` FOR EACH ROW INSERT INTO logg (loggdatum, kommentar)
        VALUES (NOW(), CONCAT('produkt med kod ', NEW.produktkod, ' tillagd')) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER `log_update_produkt` AFTER UPDATE ON `produkt` FOR EACH ROW INSERT INTO logg (loggdatum, kommentar)
        VALUES (NOW(), CONCAT('detaljer om produkt med kod ', NEW.produktkod, ' ändrade')) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER `log_delete_produkt` AFTER DELETE ON `produkt` FOR EACH ROW INSERT INTO logg (loggdatum, kommentar)
        VALUES (NOW(), CONCAT('produkt med kod ', OLD.produktkod, ' raderad')) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `produkt_kategori`
--

DROP TABLE IF EXISTS `produkt_kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt_kategori` (
  `produkt` int NOT NULL,
  `kategori` int NOT NULL,
  PRIMARY KEY (`produkt`,`kategori`),
  KEY `kategori` (`kategori`),
  CONSTRAINT `produkt_kategori_ibfk_1` FOREIGN KEY (`produkt`) REFERENCES `produkt` (`produktkod`) ON DELETE CASCADE,
  CONSTRAINT `produkt_kategori_ibfk_2` FOREIGN KEY (`kategori`) REFERENCES `kategori` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt_kategori`
--

LOCK TABLES `produkt_kategori` WRITE;
/*!40000 ALTER TABLE `produkt_kategori` DISABLE KEYS */;
INSERT INTO `produkt_kategori` VALUES (1,1),(2,1),(1,2),(3,3),(4,3),(5,4),(3,5);
/*!40000 ALTER TABLE `produkt_kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock` (
  `produkt` int NOT NULL,
  `lagerhylla` int NOT NULL,
  `antal` int DEFAULT NULL,
  PRIMARY KEY (`produkt`,`lagerhylla`),
  KEY `lagerhylla` (`lagerhylla`),
  CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`produkt`) REFERENCES `produkt` (`produktkod`) ON DELETE CASCADE,
  CONSTRAINT `stock_ibfk_2` FOREIGN KEY (`lagerhylla`) REFERENCES `lagerhylla` (`hylla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,1,500),(2,2,500),(3,3,500),(4,4,500),(5,5,500);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'eshop'
--
/*!50003 DROP PROCEDURE IF EXISTS `delete_produkt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `delete_produkt`(
    a_id CHAR(4)
)
BEGIN
    DELETE FROM produkt
    WHERE
        `produktkod` = a_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_produkt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `edit_produkt`(
    a_produktkod INT,
    a_produktnamn VARCHAR(20),
    a_produktbeskrivning VARCHAR(50),
    a_produktpris INT
)
BEGIN
    UPDATE produkt SET
        `produktnamn` = a_produktnamn,
        `produktbeskrivning` = a_produktbeskrivning,
        `produktpris` = a_produktpris
    WHERE
        `produktkod` = a_produktkod
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_produkt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `insert_produkt`(
    a_produktnamn VARCHAR(20),
    a_produktbeskrivning VARCHAR(50),
    a_produktpris INT
)
BEGIN
    INSERT INTO
        produkt(produktnamn, produktbeskrivning, produktpris)
    VALUES
        (a_produktnamn, a_produktbeskrivning, a_produktpris)
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `insert_stock`(
    a_produktkod INT,
    a_lagerhylla INT,
    a_antal INT
)
BEGIN
    INSERT INTO
        stock(produkt, lagerhylla, antal)
    VALUES
        (a_produktkod, a_lagerhylla, a_antal)
    ON DUPLICATE KEY UPDATE
        antal = antal + a_antal
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_from_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `remove_from_stock`(
    a_produktkod INT,
    a_lagerhylla INT,
    a_antal INT
)
BEGIN
    UPDATE
        stock
    SET
        antal = antal - a_antal
    WHERE
        produkt = a_produktkod AND
        lagerhylla = a_lagerhylla
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `search_stock`(
    a_search VARCHAR(20)
)
BEGIN
    SELECT
        s.produkt,
        p.produktnamn,
        s.lagerhylla,
        s.antal
    FROM stock as s
        JOIN produkt AS p
            on s.produkt = p.produktkod
    WHERE
        s.produkt = a_search OR
        p.produktnamn LIKE CONCAT('%', a_search, '%') OR
        s.lagerhylla = a_search OR
        s.antal = a_search
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_category` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_category`()
BEGIN
    SELECT * FROM produkt_kategori;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_lagerhylla` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_lagerhylla`()
BEGIN
    SELECT * FROM lagerhylla;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_logg` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_logg`(
    a_limit INT
)
BEGIN
    SELECT * FROM logg
    LIMIT a_limit
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_product`()
BEGIN
    SELECT
    p.produktkod,
    p.produktnamn,
    p.produktbeskrivning,
    p.produktpris,
    s.antal,
    GROUP_CONCAT(k.kategori) as "kategori"
    FROM produkt as p
        LEFT OUTER JOIN stock as s
            ON p.produktkod = s.produkt
        LEFT OUTER JOIN produkt_kategori as k
            ON p.produktkod = k.produkt
    GROUP BY p.produktkod
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_productkod` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_productkod`(
    a_id INT
)
BEGIN
    SELECT
    *
    FROM produkt
    WHERE produktkod = a_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_stock`()
BEGIN
    SELECT
        s.produkt,
        p.produktnamn,
        s.lagerhylla,
        s.antal
    FROM stock as s
        JOIN produkt AS p
            on s.produkt = p.produktkod
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `plocklista`
--

/*!50001 DROP TABLE IF EXISTS `plocklista`*/;
/*!50001 DROP VIEW IF EXISTS `plocklista`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbadm`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `plocklista` AS select `ko`.`ordernummer` AS `ordernummer`,`ko`.`kund` AS `kund`,`kor`.`kundorder` AS `kundorder`,`kor`.`produkt` AS `produkt`,`kor`.`antal` AS `antal` from (`kundorder` `ko` join `kundorder_rad` `kor` on((`ko`.`ordernummer` = `kor`.`kundorder`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-01 11:03:01
