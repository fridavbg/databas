-- MariaDB dump 10.19  Distrib 10.7.3-MariaDB, for osx10.17 (x86_64)
--
-- Host: localhost    Database: exam
-- ------------------------------------------------------
-- Server version	10.7.3-MariaDB

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
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist` (
  `id` char(3) DEFAULT NULL,
  `namn` varchar(20) DEFAULT NULL,
  `ort` char(15) DEFAULT NULL,
  `landskod` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES
('dbh','Death By Horse','Skåne','SE'),
('mw','Mass Worship','Stockholm','SE'),
('bc','Browsing Collection','Skövde','SE'),
('hb','Honeburst','Halmstad','SE'),
('el','Elden','Karlstad','SE');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `concertinfo`
--

DROP TABLE IF EXISTS `concertinfo`;
/*!50001 DROP VIEW IF EXISTS `concertinfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `concertinfo` (
  `id` tinyint NOT NULL,
  `namn` tinyint NOT NULL,
  `ort` tinyint NOT NULL,
  `landskod` tinyint NOT NULL,
  `land` tinyint NOT NULL,
  `klockslag` tinyint NOT NULL,
  `datum` tinyint NOT NULL,
  `dag` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `hund`
--

DROP TABLE IF EXISTS `hund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hund` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namn` varchar(20) DEFAULT NULL,
  `url` varchar(1500) DEFAULT NULL,
  `ras_id` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ras_id` (`ras_id`),
  CONSTRAINT `hund_ibfk_1` FOREIGN KEY (`ras_id`) REFERENCES `ras` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hund`
--

LOCK TABLES `hund` WRITE;
/*!40000 ALTER TABLE `hund` DISABLE KEYS */;
INSERT INTO `hund` VALUES
(1,'Båtsman','https://sv.wikipedia.org/wiki/Vi_p%C3%A5_Saltkr%C3%A5kan','sb'),
(2,'Bo','https://sv.wikipedia.org/wiki/Bo_(hund)','pv'),
(3,'Arleekin','https://sv.wikipedia.org/wiki/Pavlovs_hundar','br'),
(4,'Laska','https://sv.wikipedia.org/wiki/Pavlovs_hundar','br'),
(5,'Zloday','https://sv.wikipedia.org/wiki/Pavlovs_hundar','br'),
(6,'Sunny','https://sv.wikipedia.org/wiki/Bo_(hund)','pv'),
(7,'Lajka','https://sv.wikipedia.org/wiki/Lajka','br'),
(8,'Skeppshunden Bamse','https://sv.wikipedia.org/wiki/Skeppshunden_Bamse','sb');
/*!40000 ALTER TABLE `hund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kund`
--

DROP TABLE IF EXISTS `kund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kund` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fornamn` char(15) DEFAULT NULL,
  `efternamn` char(25) DEFAULT NULL,
  `ort` char(20) DEFAULT NULL,
  `medlem` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund`
--

LOCK TABLES `kund` WRITE;
/*!40000 ALTER TABLE `kund` DISABLE KEYS */;
INSERT INTO `kund` VALUES
(1,'Vladimir','Putin','Moskva','1999-12-31 00:00:00'),
(2,'Boris','Johnson','London','2019-07-24 00:00:00'),
(3,'Cyril','Ramaphosa','Johannisburg','2018-02-15 00:00:00'),
(4,'Joe','Biden','Washington','2021-01-20 00:00:00'),
(5,'Xi','Jinping','Peking','2013-03-14 00:00:00');
/*!40000 ALTER TABLE `kund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kund2vaccin`
--

DROP TABLE IF EXISTS `kund2vaccin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kund2vaccin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kund_id` int(11) DEFAULT NULL,
  `vaccin_id` char(2) DEFAULT NULL,
  `datum` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kund_id` (`kund_id`),
  KEY `vaccin_id` (`vaccin_id`),
  CONSTRAINT `kund2vaccin_ibfk_1` FOREIGN KEY (`kund_id`) REFERENCES `kund` (`id`),
  CONSTRAINT `kund2vaccin_ibfk_2` FOREIGN KEY (`vaccin_id`) REFERENCES `vaccin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund2vaccin`
--

LOCK TABLES `kund2vaccin` WRITE;
/*!40000 ALTER TABLE `kund2vaccin` DISABLE KEYS */;
INSERT INTO `kund2vaccin` VALUES
(1,1,'mt','2001-06-07 00:00:00'),
(2,1,'ss','2008-08-12 00:00:00'),
(3,1,'as','2021-05-28 00:00:00'),
(4,2,'mt','2002-06-08 00:00:00'),
(5,3,'as','2021-02-23 00:00:00'),
(6,4,'ss','2008-08-14 00:00:00'),
(7,4,'ss','2021-05-01 00:00:00');
/*!40000 ALTER TABLE `kund2vaccin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `kundinfo`
--

DROP TABLE IF EXISTS `kundinfo`;
/*!50001 DROP VIEW IF EXISTS `kundinfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `kundinfo` (
  `kund_id` tinyint NOT NULL,
  `fornamn` tinyint NOT NULL,
  `efternamn` tinyint NOT NULL,
  `ort` tinyint NOT NULL,
  `medlem` tinyint NOT NULL,
  `sjukdom_id` tinyint NOT NULL,
  `sjukdom` tinyint NOT NULL,
  `beskrivning` tinyint NOT NULL,
  `vaccin_id` tinyint NOT NULL,
  `vaccin` tinyint NOT NULL,
  `typ` tinyint NOT NULL,
  `datum` tinyint NOT NULL,
  `sannolikhet` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `landskod`
--

DROP TABLE IF EXISTS `landskod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `landskod` (
  `kod` char(2) NOT NULL,
  `namn` char(15) DEFAULT NULL,
  PRIMARY KEY (`kod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landskod`
--

LOCK TABLES `landskod` WRITE;
/*!40000 ALTER TABLE `landskod` DISABLE KEYS */;
INSERT INTO `landskod` VALUES
('DE','Danmark'),
('SE','Sverige'),
('US','USA');
/*!40000 ALTER TABLE `landskod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medlem`
--

DROP TABLE IF EXISTS `medlem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medlem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fornamn` varchar(20) DEFAULT NULL,
  `alias` varchar(20) DEFAULT NULL,
  `efternamn` varchar(25) DEFAULT NULL,
  `ort` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medlem`
--

LOCK TABLES `medlem` WRITE;
/*!40000 ALTER TABLE `medlem` DISABLE KEYS */;
INSERT INTO `medlem` VALUES
(1,'Barrack','\"the president\"','Obama','Washington'),
(2,'Ivan','\"the scientist\"','Pavlov','Sankt Petersburg'),
(3,'Millan','\"the whisperer\"','Cesar','Santa Clarita'),
(4,'Hafto','\"the captain\"','Erling','Honningsvåg'),
(5,'Tjorven','\"tjorven\"','Grankvist','Saltkråkan');
/*!40000 ALTER TABLE `medlem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medlem2hund`
--

DROP TABLE IF EXISTS `medlem2hund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medlem2hund` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medlem_id` int(11) DEFAULT NULL,
  `hund_id` int(11) DEFAULT NULL,
  `registrerad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medlem_id` (`medlem_id`),
  KEY `hund_id` (`hund_id`),
  CONSTRAINT `medlem2hund_ibfk_1` FOREIGN KEY (`medlem_id`) REFERENCES `medlem` (`id`),
  CONSTRAINT `medlem2hund_ibfk_2` FOREIGN KEY (`hund_id`) REFERENCES `hund` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medlem2hund`
--

LOCK TABLES `medlem2hund` WRITE;
/*!40000 ALTER TABLE `medlem2hund` DISABLE KEYS */;
INSERT INTO `medlem2hund` VALUES
(1,1,2,2008),
(2,1,6,2013),
(3,2,3,1922),
(4,2,4,1922),
(5,2,5,1923),
(6,4,8,1937),
(7,5,1,1964);
/*!40000 ALTER TABLE `medlem2hund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `memberinfo`
--

DROP TABLE IF EXISTS `memberinfo`;
/*!50001 DROP VIEW IF EXISTS `memberinfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `memberinfo` (
  `fornamn` tinyint NOT NULL,
  `efternamn` tinyint NOT NULL,
  `alias` tinyint NOT NULL,
  `ort` tinyint NOT NULL,
  `namn` tinyint NOT NULL,
  `url` tinyint NOT NULL,
  `ras` tinyint NOT NULL,
  `godkänd` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ras`
--

DROP TABLE IF EXISTS `ras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ras` (
  `id` varchar(2) NOT NULL,
  `namn` varchar(20) DEFAULT NULL,
  `godkänd` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ras`
--

LOCK TABLES `ras` WRITE;
/*!40000 ALTER TABLE `ras` DISABLE KEYS */;
INSERT INTO `ras` VALUES
('br','Blandras','nej'),
('pv','Portugisisk vattenhu','ja'),
('sb','Sankt bernhardshund','ja'),
('sc','Schäfer','ja');
/*!40000 ALTER TABLE `ras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sjukdom`
--

DROP TABLE IF EXISTS `sjukdom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sjukdom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namn` char(15) DEFAULT NULL,
  `beskrivning` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sjukdom`
--

LOCK TABLES `sjukdom` WRITE;
/*!40000 ALTER TABLE `sjukdom` DISABLE KEYS */;
INSERT INTO `sjukdom` VALUES
(1,'Agorafobi','Torgskräck'),
(2,'Atopiska vinter','Vanligast hos barn mellan 4 och 12 års ålder'),
(3,'Anemi','Järnbrist'),
(4,'Anafylaxi','Allergisk chock'),
(5,'Ankyloserande s','Ont i ryggen'),
(6,'Alopecia areata','Håravfall');
/*!40000 ALTER TABLE `sjukdom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `speldag`
--

DROP TABLE IF EXISTS `speldag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `speldag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namn` char(15) DEFAULT NULL,
  `datum` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `speldag`
--

LOCK TABLES `speldag` WRITE;
/*!40000 ALTER TABLE `speldag` DISABLE KEYS */;
INSERT INTO `speldag` VALUES
(1,'Onsdag Prepare','2020-06-03 00:00:00'),
(2,'Torsdag Hardtim','2020-06-04 00:00:00'),
(3,'Fredag Laidback','2020-06-05 00:00:00'),
(4,'Lördag All-In','2020-06-06 00:00:00');
/*!40000 ALTER TABLE `speldag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spelning`
--

DROP TABLE IF EXISTS `spelning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spelning` (
  `artist_id` char(3) DEFAULT NULL,
  `speldag_id` int(11) DEFAULT NULL,
  `klockslag` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spelning`
--

LOCK TABLES `spelning` WRITE;
/*!40000 ALTER TABLE `spelning` DISABLE KEYS */;
INSERT INTO `spelning` VALUES
('dbh',1,'15:00:00'),
('dbh',2,'15:00:00'),
('dbh',3,'15:00:00'),
('bc',2,'19:00:00'),
('bc',3,'19:00:00'),
('mw',1,'21:00:00'),
('mw',2,'21:00:00'),
('el',3,'21:00:00');
/*!40000 ALTER TABLE `spelning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccin`
--

DROP TABLE IF EXISTS `vaccin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vaccin` (
  `id` char(2) NOT NULL,
  `namn` char(25) DEFAULT NULL,
  `typ` char(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccin`
--

LOCK TABLES `vaccin` WRITE;
/*!40000 ALTER TABLE `vaccin` DISABLE KEYS */;
INSERT INTO `vaccin` VALUES
('as','Allverkande svamp','Svamp'),
('mt','Den magiska tabletten','Tablett'),
('rr','Rysk roulette','Slumpen'),
('ss','Stor spruta','Spruta');
/*!40000 ALTER TABLE `vaccin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccin2sjukdom`
--

DROP TABLE IF EXISTS `vaccin2sjukdom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vaccin2sjukdom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vaccin_id` char(2) DEFAULT NULL,
  `sjukdom_id` int(11) DEFAULT NULL,
  `sannolikhet` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vaccin_id` (`vaccin_id`),
  KEY `sjukdom_id` (`sjukdom_id`),
  CONSTRAINT `vaccin2sjukdom_ibfk_1` FOREIGN KEY (`vaccin_id`) REFERENCES `vaccin` (`id`),
  CONSTRAINT `vaccin2sjukdom_ibfk_2` FOREIGN KEY (`sjukdom_id`) REFERENCES `sjukdom` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccin2sjukdom`
--

LOCK TABLES `vaccin2sjukdom` WRITE;
/*!40000 ALTER TABLE `vaccin2sjukdom` DISABLE KEYS */;
INSERT INTO `vaccin2sjukdom` VALUES
(1,'mt',1,7),
(2,'ss',1,11),
(3,'mt',3,2),
(4,'as',3,9),
(5,'mt',4,13),
(6,'rr',4,50),
(7,'rr',5,50);
/*!40000 ALTER TABLE `vaccin2sjukdom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vaccinereport`
--

DROP TABLE IF EXISTS `vaccinereport`;
/*!50001 DROP VIEW IF EXISTS `vaccinereport`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vaccinereport` (
  `kund_id` tinyint NOT NULL,
  `fornamn` tinyint NOT NULL,
  `efternamn` tinyint NOT NULL,
  `ort` tinyint NOT NULL,
  `registrerades` tinyint NOT NULL,
  `sjukdom_id` tinyint NOT NULL,
  `sjukdom` tinyint NOT NULL,
  `beskrivning` tinyint NOT NULL,
  `vaccin_id` tinyint NOT NULL,
  `vaccin` tinyint NOT NULL,
  `typ` tinyint NOT NULL,
  `vaccinerades` tinyint NOT NULL,
  `sannolikhet` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'exam'
--
/*!50003 DROP PROCEDURE IF EXISTS `search_concertinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `search_concertinfo`(
    a_search VARCHAR(20)
)
BEGIN
    SELECT
        a.id,
        a.namn,
        a.ort,
        a.landskod,
        lk.namn AS land, 
        s.klockslag,
        sd.datum,
        sd.namn AS dag
    FROM artist AS a
        JOIN landskod AS lk
        ON a.landskod = lk.kod
        JOIN spelning AS s
        ON a.id = s.artist_id
        JOIN speldag AS sd
        ON sd.id = s.speldag_id
    WHERE 
        a.id = a_search OR
        a.namn LIKE CONCAT('%', a_search, '%') OR
        a.ort LIKE CONCAT('%', a_search, '%') OR
        a.landskod = a_search OR
        lk.namn LIKE CONCAT('%', a_search, '%') OR
        s.klockslag LIKE CONCAT('%', a_search, '%') OR
        sd.datum LIKE CONCAT('%', a_search, '%') OR
        sd.namn LIKE CONCAT('%', a_search, '%')
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_memberinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `search_memberinfo`(
    a_search VARCHAR(20)
)
BEGIN
    SELECT *
    FROM memberInfo AS mI
WHERE 
    mI.fornamn LIKE CONCAT('%', a_search, '%') OR
    mI.efternamn LIKE CONCAT('%', a_search, '%') OR
    mI.alias LIKE CONCAT('%', a_search, '%') OR
    mI.ort LIKE CONCAT('%', a_search, '%') OR
    mI.namn LIKE CONCAT('%', a_search, '%') OR
    mI.ras LIKE CONCAT('%', a_search, '%') OR
    mI.godkänd LIKE CONCAT('%', a_search, '%')
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_concertinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_concertinfo`()
BEGIN
    SELECT
        a.id,
        a.namn,
        a.ort,
        a.landskod,
        lk.namn AS land, 
        s.klockslag,
        sd.datum,
        sd.namn AS dag
    FROM artist AS a
        JOIN landskod AS lk
        ON a.landskod = lk.kod
        JOIN spelning AS s
        ON a.id = s.artist_id
        JOIN speldag AS sd
        ON sd.id = s.speldag_id
    ORDER BY sd.datum
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_memberinfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_memberinfo`()
BEGIN 
    SELECT * FROM memberInfo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_vaccinereport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_vaccinereport`()
BEGIN
    SELECT
    *
    FROM 
    vaccineReport
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `concertinfo`
--

/*!50001 DROP TABLE IF EXISTS `concertinfo`*/;
/*!50001 DROP VIEW IF EXISTS `concertinfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbadm`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `concertinfo` AS select `a`.`id` AS `id`,`a`.`namn` AS `namn`,`a`.`ort` AS `ort`,`a`.`landskod` AS `landskod`,`lk`.`namn` AS `land`,`s`.`klockslag` AS `klockslag`,`sd`.`datum` AS `datum`,`sd`.`namn` AS `dag` from (((`artist` `a` join `landskod` `lk` on(`a`.`landskod` = `lk`.`kod`)) join `spelning` `s` on(`a`.`id` = `s`.`artist_id`)) join `speldag` `sd` on(`sd`.`id` = `s`.`speldag_id`)) order by `sd`.`datum` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `kundinfo`
--

/*!50001 DROP TABLE IF EXISTS `kundinfo`*/;
/*!50001 DROP VIEW IF EXISTS `kundinfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbadm`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `kundinfo` AS select `k`.`id` AS `kund_id`,`k`.`fornamn` AS `fornamn`,`k`.`efternamn` AS `efternamn`,`k`.`ort` AS `ort`,`k`.`medlem` AS `medlem`,`s`.`id` AS `sjukdom_id`,`s`.`namn` AS `sjukdom`,`s`.`beskrivning` AS `beskrivning`,`v`.`id` AS `vaccin_id`,`v`.`namn` AS `vaccin`,`v`.`typ` AS `typ`,`kv`.`datum` AS `datum`,`vs`.`sannolikhet` AS `sannolikhet` from ((((`kund` `k` join `kund2vaccin` `kv` on(`k`.`id` = `kv`.`kund_id`)) join `vaccin` `v` on(`v`.`id` = `kv`.`vaccin_id`)) join `vaccin2sjukdom` `vs` on(`v`.`id` = `vs`.`vaccin_id`)) join `sjukdom` `s` on(`vs`.`sjukdom_id` = `s`.`id`)) order by `k`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `memberinfo`
--

/*!50001 DROP TABLE IF EXISTS `memberinfo`*/;
/*!50001 DROP VIEW IF EXISTS `memberinfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbadm`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `memberinfo` AS select `m`.`fornamn` AS `fornamn`,`m`.`efternamn` AS `efternamn`,`m`.`alias` AS `alias`,`m`.`ort` AS `ort`,`h`.`namn` AS `namn`,`h`.`url` AS `url`,`r`.`namn` AS `ras`,`r`.`godkänd` AS `godkänd` from (((`medlem` `m` join `medlem2hund` `mh` on(`m`.`id` = `mh`.`medlem_id`)) join `hund` `h` on(`h`.`id` = `mh`.`hund_id`)) join `ras` `r` on(`r`.`id` = `h`.`ras_id`)) order by `m`.`fornamn` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vaccinereport`
--

/*!50001 DROP TABLE IF EXISTS `vaccinereport`*/;
/*!50001 DROP VIEW IF EXISTS `vaccinereport`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbadm`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vaccinereport` AS select `k`.`id` AS `kund_id`,`k`.`fornamn` AS `fornamn`,`k`.`efternamn` AS `efternamn`,`k`.`ort` AS `ort`,date_format(`k`.`medlem`,'%d-%m-%Y') AS `registrerades`,`s`.`id` AS `sjukdom_id`,`s`.`namn` AS `sjukdom`,`s`.`beskrivning` AS `beskrivning`,`v`.`id` AS `vaccin_id`,`v`.`namn` AS `vaccin`,`v`.`typ` AS `typ`,date_format(`kv`.`datum`,'%d-%m-%Y') AS `vaccinerades`,`vs`.`sannolikhet` AS `sannolikhet` from ((((`kund` `k` join `kund2vaccin` `kv` on(`k`.`id` = `kv`.`kund_id`)) join `vaccin` `v` on(`v`.`id` = `kv`.`vaccin_id`)) join `vaccin2sjukdom` `vs` on(`v`.`id` = `vs`.`vaccin_id`)) join `sjukdom` `s` on(`vs`.`sjukdom_id` = `s`.`id`)) order by `kv`.`datum` desc */;
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

-- Dump completed on 2022-05-24 17:34:30
