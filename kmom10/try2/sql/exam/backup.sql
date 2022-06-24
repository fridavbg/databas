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
-- Table structure for table `aktier`
--

DROP TABLE IF EXISTS `aktier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aktier` (
  `id` varchar(10) NOT NULL,
  `varde` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aktier`
--

LOCK TABLES `aktier` WRITE;
/*!40000 ALTER TABLE `aktier` DISABLE KEYS */;
INSERT INTO `aktier` VALUES
('AMAZON',3),
('META',7),
('MICROSOFT',6),
('SPACEX',5),
('TESLA',4);
/*!40000 ALTER TABLE `aktier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fastighet`
--

DROP TABLE IF EXISTS `fastighet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fastighet` (
  `person_id` varchar(4) DEFAULT NULL,
  `fastighet_id` varchar(15) NOT NULL,
  `vardering` int(11) DEFAULT NULL,
  PRIMARY KEY (`fastighet_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `fastighet_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fastighet`
--

LOCK TABLES `fastighet` WRITE;
/*!40000 ALTER TABLE `fastighet` DISABLE KEYS */;
INSERT INTO `fastighet` VALUES
('elon','EIFFELTORNET',12),
('mark','NEW-YORK-C',16),
('bill','Ö-I-SÖDERHAVET',14),
('jeff','STOCKHOLM-C',10),
('mark','STUDENTRUM-A',18);
/*!40000 ALTER TABLE `fastighet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `id` varchar(4) NOT NULL,
  `fornamn` varchar(20) DEFAULT NULL,
  `efternamn` varchar(25) DEFAULT NULL,
  `foretag` varchar(25) DEFAULT NULL,
  `formogenhet` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES
('bill','Bill','Gates','Microsoft',124),
('elon','Elon','Musk','Tesla',151),
('jeff','Jeff','Bezos','Amazon',177),
('mark','Mark','Zuckerberg','Meta',97),
('mos','Mikael','Roos','BTH',0);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `personreport`
--

DROP TABLE IF EXISTS `personreport`;
/*!50001 DROP VIEW IF EXISTS `personreport`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `personreport` (
  `id` tinyint NOT NULL,
  `fornamn` tinyint NOT NULL,
  `efternamn` tinyint NOT NULL,
  `foretag` tinyint NOT NULL,
  `formogenhet` tinyint NOT NULL,
  `aktie_id` tinyint NOT NULL,
  `antal` tinyint NOT NULL,
  `inkop` tinyint NOT NULL,
  `varde` tinyint NOT NULL,
  `fastighet_id` tinyint NOT NULL,
  `vardering` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `portfolj`
--

DROP TABLE IF EXISTS `portfolj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portfolj` (
  `person_id` varchar(4) DEFAULT NULL,
  `aktie_id` varchar(10) DEFAULT NULL,
  `antal` int(11) DEFAULT NULL,
  `inkop` int(11) DEFAULT NULL,
  KEY `person_id` (`person_id`),
  KEY `aktie_id` (`aktie_id`),
  CONSTRAINT `portfolj_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `portfolj_ibfk_2` FOREIGN KEY (`aktie_id`) REFERENCES `aktier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portfolj`
--

LOCK TABLES `portfolj` WRITE;
/*!40000 ALTER TABLE `portfolj` DISABLE KEYS */;
INSERT INTO `portfolj` VALUES
('jeff','AMAZON',1,11),
('elon','TESLA',1,12),
('elon','SPACEX',1,13),
('bill','MICROSOFT',1,14),
('mark','META',1,15),
('mark','SPACEX',1,16);
/*!40000 ALTER TABLE `portfolj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'exam'
--
/*!50003 DROP PROCEDURE IF EXISTS `search_personReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `search_personReport`(
    a_search VARCHAR(20)
)
BEGIN 
    SELECT
    *
    FROM 
    personReport
WHERE 
    id LIKE CONCAT('%', a_search, '%') OR
    fornamn LIKE CONCAT('%', a_search, '%') OR
    efternamn LIKE CONCAT('%', a_search, '%') OR
    foretag LIKE CONCAT('%', a_search, '%') OR
    formogenhet LIKE CONCAT('%', a_search, '%') OR
    aktie_id LIKE CONCAT('%', a_search, '%') OR
    antal LIKE CONCAT('%', a_search, '%') OR
    inkop LIKE CONCAT('%', a_search, '%') OR
    varde LIKE CONCAT('%', a_search, '%') OR
    fastighet_id LIKE CONCAT('%', a_search, '%') OR
    vardering LIKE CONCAT('%', a_search, '%')
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_personReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `show_personReport`()
BEGIN 
    SELECT
    *
    FROM 
    personReport;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `specialReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`localhost` PROCEDURE `specialReport`()
BEGIN 
    SELECT
    *
    FROM 
    personReport;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `personreport`
--

/*!50001 DROP TABLE IF EXISTS `personreport`*/;
/*!50001 DROP VIEW IF EXISTS `personreport`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbadm`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `personreport` AS select `p`.`id` AS `id`,`p`.`fornamn` AS `fornamn`,`p`.`efternamn` AS `efternamn`,`p`.`foretag` AS `foretag`,`p`.`formogenhet` AS `formogenhet`,`pf`.`aktie_id` AS `aktie_id`,`pf`.`antal` AS `antal`,`pf`.`inkop` AS `inkop`,`a`.`varde` AS `varde`,`f`.`fastighet_id` AS `fastighet_id`,`f`.`vardering` AS `vardering` from (((`person` `p` left join `portfolj` `pf` on(`p`.`id` = `pf`.`person_id`)) left join `aktier` `a` on(`pf`.`aktie_id` = `a`.`id`)) left join `fastighet` `f` on(`p`.`id` = `f`.`person_id`)) */;
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

-- Dump completed on 2022-05-27 12:54:54
