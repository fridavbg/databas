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
-- Table structure for table `speldag`
--

DROP TABLE IF EXISTS `speldag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `speldag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namn` char(15) DEFAULT NULL,
  `datum` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `speldag`
--

LOCK TABLES `speldag` WRITE;
/*!40000 ALTER TABLE `speldag` DISABLE KEYS */;
INSERT INTO `speldag` VALUES
(1,'Onsdag Prepare','2020-06-03'),
(2,'Torsdag Hardtim','2020-06-04'),
(3,'Fredag Laidback','2020-06-05'),
(4,'Lördag All-In','2020-06-06');
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
-- Dumping routines for database 'exam'
--
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-16 15:38:26
