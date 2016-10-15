-- MySQL dump 10.13  Distrib 5.5.35, for FreeBSD9.2 (i386)
--
-- Host: localhost    Database: auth
-- ------------------------------------------------------
-- Server version       5.5.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `gid2member`
--

DROP TABLE IF EXISTS `gid2member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gid2member` (
  `gid` int(11) NOT NULL,
  `member` int(11) NOT NULL,
  `permit` varchar(5) COLLATE koi8r_bin DEFAULT 'vcs',
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gid2name`
--

DROP TABLE IF EXISTS `gid2name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gid2name` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE koi8r_bin NOT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!50001 DROP VIEW IF EXISTS `user_group`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `user_group` (
  `user` tinyint NOT NULL,
  `firstname` tinyint NOT NULL,
  `surname` tinyint NOT NULL,
  `gid` tinyint NOT NULL,
  `member` tinyint NOT NULL,
  `gr_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_aliases`
--

DROP TABLE IF EXISTS `view_aliases`;
/*!50001 DROP VIEW IF EXISTS `view_aliases`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_aliases` (
  `email` tinyint NOT NULL,
  `destination` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_users`
--

DROP TABLE IF EXISTS `view_users`;
/*!50001 DROP VIEW IF EXISTS `view_users`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_users` (
  `id` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `password` tinyint NOT NULL,
  `path` tinyint NOT NULL,
  `quota` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `virtual_aliases`
--

DROP TABLE IF EXISTS `virtual_aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtual_aliases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `source` varchar(40) NOT NULL,
  `destination` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  CONSTRAINT `virtual_aliases_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `virtual_domains` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `virtual_domains`
--

DROP TABLE IF EXISTS `virtual_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtual_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `virtual_users`
--

DROP TABLE IF EXISTS `virtual_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtual_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `user` varchar(40) CHARACTER SET latin1 NOT NULL,
  `password` varchar(32) CHARACTER SET latin1 NOT NULL,
  `firstname` varchar(100) COLLATE koi8r_bin DEFAULT '',
  `tel_w1` varchar(100) COLLATE koi8r_bin DEFAULT NULL,
  `surname` varchar(50) COLLATE koi8r_bin DEFAULT NULL,
  `quota` bigint(20) NOT NULL DEFAULT '31457280',
  `job` varchar(100) COLLATE koi8r_bin DEFAULT '',
  `tel_m` varchar(45) COLLATE koi8r_bin DEFAULT NULL,
  `born` varchar(10) COLLATE koi8r_bin DEFAULT '',
  `tel_w2` varchar(45) COLLATE koi8r_bin DEFAULT NULL,
  `notice` varchar(15) COLLATE koi8r_bin DEFAULT NULL,
  `pass_change` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE_EMAIL` (`domain_id`,`user`),
  CONSTRAINT `virtual_users_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `virtual_domains` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=koi8r COLLATE=koi8r_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `user_group`
--

/*!50001 DROP TABLE IF EXISTS `user_group`*/;
/*!50001 DROP VIEW IF EXISTS `user_group`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_group` AS select `virtual_users`.`user` AS `user`,`virtual_users`.`firstname` AS `firstname`,`virtual_users`.`surname` AS `surname`,`gid2member`.`gid` AS `gid`,`gid2member`.`member` AS `member`,`gid2name`.`name` AS `gr_name` from ((`gid2member` left join `virtual_users` on((`gid2member`.`member` = `virtual_users`.`id`))) left join `gid2name` on((`gid2member`.`gid` = `gid2name`.`gid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_aliases`
--

/*!50001 DROP TABLE IF EXISTS `view_aliases`*/;
/*!50001 DROP VIEW IF EXISTS `view_aliases`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_aliases` AS select concat(`virtual_aliases`.`source`,'@',`virtual_domains`.`name`) AS `email`,`virtual_aliases`.`destination` AS `destination` from (`virtual_aliases` left join `virtual_domains` on((`virtual_aliases`.`domain_id` = `virtual_domains`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_users`
--

/*!50001 DROP TABLE IF EXISTS `view_users`*/;
/*!50001 DROP VIEW IF EXISTS `view_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_users` AS select `virtual_users`.`id` AS `id`,concat(`virtual_users`.`user`,'@',`virtual_domains`.`name`) AS `email`,`virtual_users`.`password` AS `password`,concat('/home/vmail/',`virtual_users`.`user`,'@',`virtual_domains`.`name`) AS `path`,`virtual_users`.`quota` AS `quota` from (`virtual_users` left join `virtual_domains` on((`virtual_users`.`domain_id` = `virtual_domains`.`id`))) */;
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

-- Dump completed on 2016-10-13 20:12:15


