-- MariaDB dump 10.19  Distrib 10.6.5-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: eshop
-- ------------------------------------------------------
-- Server version	10.6.5-MariaDB

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
  `fakturanummer` int(11) NOT NULL,
  `kundorder` int(11) DEFAULT NULL,
  `kund` int(11) DEFAULT NULL,
  `fakturadatum` datetime DEFAULT current_timestamp(),
  `totalpris` int(11) DEFAULT NULL,
  `uppdaterad` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `borttagen` datetime DEFAULT NULL,
  `skickad` datetime DEFAULT NULL,
  PRIMARY KEY (`fakturanummer`),
  KEY `kundorder` (`kundorder`),
  KEY `kund` (`kund`),
  CONSTRAINT `faktura_ibfk_1` FOREIGN KEY (`kundorder`) REFERENCES `kundorder` (`ordernummer`),
  CONSTRAINT `faktura_ibfk_2` FOREIGN KEY (`kund`) REFERENCES `kund` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktura`
--

LOCK TABLES `faktura` WRITE;
/*!40000 ALTER TABLE `faktura` DISABLE KEYS */;
/*!40000 ALTER TABLE `faktura` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER log_insert_faktura
AFTER INSERT
ON faktura FOR EACH ROW
    INSERT INTO logg (kundorder, faktura, loggdatum, kommentar)
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER log_update_faktura
AFTER UPDATE
ON faktura FOR EACH ROW
    INSERT INTO logg (kundorder, faktura, loggdatum, kommentar)
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
  `faktura` int(11) NOT NULL,
  `produkt` int(11) NOT NULL,
  `antal` int(11) DEFAULT NULL,
  PRIMARY KEY (`faktura`,`produkt`),
  KEY `produkt` (`produkt`),
  CONSTRAINT `faktura_rad_ibfk_1` FOREIGN KEY (`produkt`) REFERENCES `produkt` (`produktkod`),
  CONSTRAINT `faktura_rad_ibfk_2` FOREIGN KEY (`faktura`) REFERENCES `faktura` (`fakturanummer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firma` varchar(20) DEFAULT NULL,
  `typ` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
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
  `id` int(11) NOT NULL,
  `fornamn` varchar(20) DEFAULT NULL,
  `efternamn` varchar(20) DEFAULT NULL,
  `adress` varchar(20) DEFAULT NULL,
  `telefonnummer` int(11) DEFAULT NULL,
  `mail` varchar(20) DEFAULT NULL,
  `kreditkort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund`
--

LOCK TABLES `kund` WRITE;
/*!40000 ALTER TABLE `kund` DISABLE KEYS */;
INSERT INTO `kund` VALUES (1,'Grimar','Haraldsson',' Åsbotorpsvägen 13',467054354,'grimar@dodgit.com',2147483647),(2,'Hafr','Steingrimsson','Östmovägen 2',467311032,'haffstein@spamherelo',1242143123),(3,'Gæierlaug','Hosvirdottir','Hägran 53A',467055560,'gaehos@spamherelots.',54679691),(4,'Thorunn','Dvegrheimr','Prästbolet 1',467233482,'stina@mailinator.com',2147483647),(5,'Yngvild','Háskifold','Buskan 22',467348311,'yngen@mailmetrash.co',2147483647);
/*!40000 ALTER TABLE `kund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kundorder`
--

DROP TABLE IF EXISTS `kundorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kundorder` (
  `ordernummer` int(11) NOT NULL AUTO_INCREMENT,
  `kund` int(11) DEFAULT NULL,
  `skapad` datetime DEFAULT current_timestamp(),
  `orderdatum` datetime DEFAULT NULL,
  `uppdaterad` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `skickad` datetime DEFAULT NULL,
  `borttagen` datetime DEFAULT NULL,
  PRIMARY KEY (`ordernummer`),
  KEY `kund` (`kund`),
  CONSTRAINT `kundorder_ibfk_1` FOREIGN KEY (`kund`) REFERENCES `kund` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundorder`
--

LOCK TABLES `kundorder` WRITE;
/*!40000 ALTER TABLE `kundorder` DISABLE KEYS */;
INSERT INTO `kundorder` VALUES (1,1,'2022-03-12 15:50:59','2022-03-12 15:50:59','2022-03-12 16:07:31','2022-03-12 16:07:31',NULL),(2,2,'2022-03-12 15:50:59','2022-03-12 15:50:59',NULL,NULL,NULL),(3,3,'2022-03-12 15:50:59','2022-03-12 15:50:59','2022-03-12 15:50:59',NULL,NULL),(4,4,'2022-03-12 15:50:59','2022-03-12 15:50:59',NULL,'2022-03-12 15:50:59',NULL),(5,2,'2022-03-12 16:06:35','2022-03-12 16:06:45',NULL,NULL,NULL);
/*!40000 ALTER TABLE `kundorder` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER log_insert_kundorder
AFTER INSERT
ON kundorder FOR EACH ROW
    INSERT INTO logg (kundorder, loggdatum, kommentar)
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER log_update_kundorder
AFTER UPDATE
ON kundorder FOR EACH ROW
    INSERT INTO logg (kundorder, loggdatum, kommentar)
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
  `kundorder` int(11) NOT NULL,
  `produkt` int(11) NOT NULL,
  `antal` int(11) DEFAULT NULL,
  PRIMARY KEY (`kundorder`,`produkt`),
  KEY `produkt` (`produkt`),
  CONSTRAINT `kundorder_rad_ibfk_1` FOREIGN KEY (`kundorder`) REFERENCES `kundorder` (`ordernummer`),
  CONSTRAINT `kundorder_rad_ibfk_2` FOREIGN KEY (`produkt`) REFERENCES `produkt` (`produktkod`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundorder_rad`
--

LOCK TABLES `kundorder_rad` WRITE;
/*!40000 ALTER TABLE `kundorder_rad` DISABLE KEYS */;
INSERT INTO `kundorder_rad` VALUES (1,1,3),(1,3,4),(2,1,3),(2,5,2),(3,4,2),(4,5,1),(5,1,4);
/*!40000 ALTER TABLE `kundorder_rad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lagerhylla`
--

DROP TABLE IF EXISTS `lagerhylla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lagerhylla` (
  `hylla` int(11) NOT NULL,
  `beskrivning` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hylla`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kundorder` int(11) DEFAULT NULL,
  `faktura` int(11) DEFAULT NULL,
  `loggdatum` datetime DEFAULT NULL,
  `kommentar` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kundorder` (`kundorder`),
  KEY `faktura` (`faktura`),
  CONSTRAINT `logg_ibfk_1` FOREIGN KEY (`kundorder`) REFERENCES `kundorder` (`ordernummer`),
  CONSTRAINT `logg_ibfk_2` FOREIGN KEY (`faktura`) REFERENCES `faktura` (`fakturanummer`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logg`
--

LOCK TABLES `logg` WRITE;
/*!40000 ALTER TABLE `logg` DISABLE KEYS */;
INSERT INTO `logg` VALUES (1,NULL,NULL,'2022-03-12 15:50:59','produkt med kod 1 tillagd'),(2,NULL,NULL,'2022-03-12 15:50:59','produkt med kod 2 tillagd'),(3,NULL,NULL,'2022-03-12 15:50:59','produkt med kod 3 tillagd'),(4,NULL,NULL,'2022-03-12 15:50:59','produkt med kod 4 tillagd'),(5,NULL,NULL,'2022-03-12 15:50:59','produkt med kod 5 tillagd'),(6,1,NULL,'2022-03-12 15:50:59','beställning skapad'),(7,2,NULL,'2022-03-12 15:50:59','beställning skapad'),(8,3,NULL,'2022-03-12 15:50:59','beställning skapad'),(9,4,NULL,'2022-03-12 15:50:59','beställning skapad'),(10,5,NULL,NULL,'beställning skapad'),(11,5,NULL,NULL,'beställning ändrad'),(12,1,NULL,'2022-03-12 16:07:31','beställning ändrad');
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
  `produkt` tinyint NOT NULL,
  `antal_bestallt` tinyint NOT NULL,
  `lagerhylla` tinyint NOT NULL,
  `antal_i_lager` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `produkt`
--

DROP TABLE IF EXISTS `produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt` (
  `produktkod` int(11) NOT NULL AUTO_INCREMENT,
  `produktnamn` varchar(20) DEFAULT NULL,
  `produktbeskrivning` varchar(50) DEFAULT NULL,
  `produktpris` int(11) DEFAULT NULL,
  PRIMARY KEY (`produktkod`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt`
--

LOCK TABLES `produkt` WRITE;
/*!40000 ALTER TABLE `produkt` DISABLE KEYS */;
INSERT INTO `produkt` VALUES (1,'Löfbergs Melodi','Ett mjukt välbalanserat och fylligt kaffe.',50),(2,'Löfbergs Aria','Ett mörkrostat kaffe med intensiv kaffearom.',70),(3,'Maharadja Chai','Ett mycket fylligt och kraftigt helblads-te.',100),(4,'Anhui Maofeng',' Kinesiskt storbladigt te.',80),(5,'Scottish Breakfast','Frukostte enligt skottsk tradition.',30);
/*!40000 ALTER TABLE `produkt` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER log_insert_produkt
AFTER INSERT
ON produkt FOR EACH ROW
    INSERT INTO logg (loggdatum, kommentar)
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER log_update_produkt
AFTER UPDATE
ON produkt FOR EACH ROW
    INSERT INTO logg (loggdatum, kommentar)
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`localhost`*/ /*!50003 TRIGGER log_delete_produkt
AFTER DELETE
ON produkt FOR EACH ROW
    INSERT INTO logg (loggdatum, kommentar)
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
  `produkt` int(11) NOT NULL,
  `kategori` int(11) NOT NULL,
  PRIMARY KEY (`produkt`,`kategori`),
  KEY `kategori` (`kategori`),
  CONSTRAINT `produkt_kategori_ibfk_1` FOREIGN KEY (`produkt`) REFERENCES `produkt` (`produktkod`) ON DELETE CASCADE,
  CONSTRAINT `produkt_kategori_ibfk_2` FOREIGN KEY (`kategori`) REFERENCES `kategori` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt_kategori`
--

LOCK TABLES `produkt_kategori` WRITE;
/*!40000 ALTER TABLE `produkt_kategori` DISABLE KEYS */;
INSERT INTO `produkt_kategori` VALUES (1,1),(1,2),(2,1),(3,3),(3,5),(4,3),(5,4);
/*!40000 ALTER TABLE `produkt_kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock` (
  `produkt` int(11) NOT NULL,
  `lagerhylla` int(11) NOT NULL,
  `antal` int(11) DEFAULT NULL,
  PRIMARY KEY (`produkt`,`lagerhylla`),
  KEY `lagerhylla` (`lagerhylla`),
  CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`produkt`) REFERENCES `produkt` (`produktkod`) ON DELETE CASCADE,
  CONSTRAINT `stock_ibfk_2` FOREIGN KEY (`lagerhylla`) REFERENCES `lagerhylla` (`hylla`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,1,0),(2,2,500),(3,3,256),(4,4,21),(5,5,40);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'eshop'
--
/*!50003 DROP FUNCTION IF EXISTS `loggdatum` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` FUNCTION `loggdatum`(a_skapad TIMESTAMP,
    a_beställd TIMESTAMP,
    a_uppdaterad TIMESTAMP,
    a_skickad TIMESTAMP,
    a_raderad TIMESTAMP
) RETURNS date
    DETERMINISTIC
BEGIN
    IF a_raderad IS NOT NULL THEN
        RETURN DATE_FORMAT(a_raderad, '%Y-%m-%d');
    ELSEIF a_skickad IS NOT NULL THEN
        RETURN DATE_FORMAT(a_skickad, '%Y-%m-%d');
    ELSEIF a_uppdaterad IS NOT NULL THEN
        RETURN DATE_FORMAT(a_uppdaterad, '%Y-%m-%d');
    ELSEIF a_beställd IS NOT NULL THEN
        RETURN DATE_FORMAT(a_beställd, '%Y-%m-%d');
    END IF;
    RETURN DATE_FORMAT(a_skapad, '%Y-%m-%d');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `orderstatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` FUNCTION `orderstatus`(a_skapad TIMESTAMP,
    a_beställd TIMESTAMP,
    a_uppdaterad TIMESTAMP,
    a_skickad TIMESTAMP,
    a_raderad TIMESTAMP
) RETURNS char(10) CHARSET latin1
    DETERMINISTIC
BEGIN
    IF a_raderad IS NOT NULL THEN
        RETURN 'Raderad';
    ELSEIF a_skickad IS NOT NULL THEN
        RETURN 'Skickad';
    ELSEIF a_uppdaterad IS NOT NULL THEN
        RETURN 'Uppdaterad';
    ELSEIF a_beställd IS NOT NULL THEN
        RETURN 'Beställd';
    ELSEIF a_skapad IS NOT NULL THEN
        RETURN 'Skapad';
    END IF;
    RETURN 'Okänd';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `create_order`(
    a_kund INT
)
BEGIN
INSERT INTO
    kundorder(kund)
VALUES
    (a_kund)
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_produkt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `insert_order_rad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `insert_order_rad`(
    a_kundorder INT,
    a_produkt INT,
    a_antal INT
)
BEGIN
INSERT INTO
    kundorder_rad(kundorder, produkt, antal)
VALUES
    (a_kundorder, a_produkt, a_antal)
ON DUPLICATE KEY UPDATE
    antal = antal + a_antal
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `search_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `search_order`(
    a_search VARCHAR(20)
)
BEGIN
    SELECT
        k.ordernummer,
        k.kund,
        DATE_FORMAT(k.orderdatum, "%Y-%m-%d") AS orderdatum,
        COUNT(kr.kundorder) AS antal,
        orderstatus(skapad, orderdatum, uppdaterad, skickad, borttagen) AS orderstatus
    FROM kundorder AS k
    LEFT OUTER JOIN kundorder_rad AS kr
    ON k.ordernummer = kr.kundorder
    WHERE
        k.ordernummer LIKE CONCAT('%', a_search, '%') OR
        kr.kundorder LIKE CONCAT('%', a_search, '%') OR
        k.kund = a_search
    GROUP BY ordernummer
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `set_orderdatum` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `set_orderdatum`(
    a_ordernummer INT
)
BEGIN
    UPDATE kundorder SET
        orderdatum = NOW(),
        uppdaterad = NULL 
    WHERE
        ordernummer = a_ordernummer
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `show_customers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_customers`()
BEGIN
    SELECT
        id,
        CONCAT(fornamn, ' ', efternamn) AS namn,
        adress,
        telefonnummer,
        mail
    FROM kund
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_individual_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_individual_customer`(
    a_id INT
)
BEGIN
    SELECT
        id,
        CONCAT(fornamn, ' ', efternamn) AS namn,
        adress,
        telefonnummer,
        mail
    FROM kund
    WHERE id = a_id
    ;
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `show_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_orders`()
BEGIN
    SELECT
        k.ordernummer,
        k.kund,
        DATE_FORMAT(k.orderdatum, "%Y-%m-%d") AS orderdatum,
        COUNT(kr.kundorder) AS antal,
        orderstatus(skapad, orderdatum, uppdaterad, skickad, borttagen) AS orderstatus
    FROM kundorder AS k
    LEFT OUTER JOIN kundorder_rad AS kr
        ON k.ordernummer = kr.kundorder
    GROUP BY k.ordernummer;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_plocklista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_plocklista`(
    a_order_number VARCHAR(20)
)
BEGIN
    SELECT
      *
    FROM plocklista as pl
    WHERE
        pl.ordernummer LIKE CONCAT('%', a_order_number, '%') OR
        pl.ordernummer = a_order_number
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `show_specific_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_specific_order`(
    a_ordernummer INT
)
BEGIN
    SELECT
        k.ordernummer AS ordernummer,
        k.kund AS kund,
        DATE_FORMAT(k.orderdatum, "%Y-%m-%d") AS orderdatum,
        
        orderstatus(skapad, orderdatum, uppdaterad, skickad, borttagen) AS orderstatus
    FROM kundorder AS k
    
    
    WHERE k.ordernummer = a_ordernummer;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_specific_order_rows` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_specific_order_rows`(
    a_ordernummer INT
)
BEGIN
    SELECT
        p.produktkod,
        p.produktnamn,
        p.produktbeskrivning,
        p.produktpris,
        k.antal
    FROM kundorder_rad AS k
    JOIN produkt AS p
    ON k.produkt = p.produktkod
    WHERE k.kundorder = a_ordernummer;
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
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
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
/*!50003 DROP PROCEDURE IF EXISTS `update_orderstatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `update_orderstatus`(
        a_order_number INT
)
BEGIN
    UPDATE kundorder
    SET
    skickad = NOW()
    WHERE ordernummer = a_order_number
    
    AND CONCAT(skickad) IS NULL;
    SELECT *
    FROM kundorder
    WHERE ordernummer = a_order_number;
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
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbadm`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `plocklista` AS select `k`.`ordernummer` AS `ordernummer`,`k`.`kund` AS `kund`,`kr`.`produkt` AS `produkt`,`kr`.`antal` AS `antal_bestallt`,`s`.`lagerhylla` AS `lagerhylla`,`s`.`antal` AS `antal_i_lager` from ((`kundorder` `k` join `kundorder_rad` `kr` on(`k`.`ordernummer` = `kr`.`kundorder`)) join `stock` `s` on(`kr`.`produkt` = `s`.`produkt`)) order by `k`.`ordernummer` */;
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

-- Dump completed on 2022-03-12 15:11:30
