/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bridge_ports` (
  `id` int(11) NOT NULL,
  `bridge_id` int(11) DEFAULT NULL,
  `port_name` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bridges` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `host_count` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `client_port_services` (
  `serv_id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `type_s` tinyint NOT NULL,
  `city` tinyint NOT NULL,
  `addr` tinyint NOT NULL,
  `speed` tinyint NOT NULL,
  `vlan` tinyint NOT NULL,
  `ipaddr` tinyint NOT NULL,
  `cl_port` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `cacti_url` tinyint NOT NULL,
  `cl_id` tinyint NOT NULL,
  `port_id` tinyint NOT NULL,
  `device_ip` tinyint NOT NULL,
  `device_nic` tinyint NOT NULL,
  `device_port` tinyint NOT NULL,
  `port_label` tinyint NOT NULL,
  `flag` tinyint NOT NULL,
  `dhcp_update` tinyint NOT NULL,
  `contact` tinyint NOT NULL,
  `contact_tech` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `email_tech` tinyint NOT NULL,
  `inn` tinyint NOT NULL,
  `manager` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body` mediumtext COLLATE utf8_unicode_ci,
  `cl_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `remind` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2183 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `cl_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(1024) CHARACTER SET utf8 DEFAULT NULL,
  `contact` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remark` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `manager` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `date_add` date DEFAULT NULL,
  `cl_src` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `income` int(11) DEFAULT NULL,
  `payment` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `flag2` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `flag` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'DD',
  `time_work` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `connect_type` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `registr_addr` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_close` date DEFAULT NULL,
  `inn` bigint(20) DEFAULT NULL,
  `notificate_phone` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notificate_date` date DEFAULT NULL,
  `notificate_result` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_tech` varchar(1024) CHARACTER SET utf8 DEFAULT ' ',
  `contact_tech` varchar(1024) COLLATE utf8_unicode_ci DEFAULT ' ',
  `notificate_sms` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`cl_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6110 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `clients_ppo` (
  `cl_id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `address` tinyint NOT NULL,
  `manager` tinyint NOT NULL,
  `dogovor_num` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `idcomment` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `groupid` int(11) DEFAULT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `text` varchar(2048) DEFAULT NULL,
  `idtask` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcomment`),
  KEY `idtask` (`idtask`)
) ENGINE=MyISAM AUTO_INCREMENT=11540 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nic` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `perc` int(11) DEFAULT NULL,
  `delay` int(11) DEFAULT NULL,
  `last_ch` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `locat` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uptime` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bootstrap` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hw_ver` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mac` varchar(17) COLLATE utf8_unicode_ci DEFAULT NULL,
  `upgrade_date` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ring` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=595 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
ALTER DATABASE `crm` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `crm`.`ins_ups`
AFTER INSERT ON `crm`.`device`
FOR EACH ROW
BEGIN
    IF NEW.nic LIKE 'ups%' THEN
        Insert into ups (nic,input,outload,capacity,remaining) VALUE(NEW.nic,0,0,0,0);
    END IF;
    Insert into map (node_id) VALUE(NEW.id);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `crm` CHARACTER SET utf8 COLLATE utf8_general_ci ;
ALTER DATABASE `crm` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `crm`.`set_ch_time`
AFTER UPDATE ON `crm`.`device`
FOR EACH ROW
BEGIN
    IF NEW.perc!=OLD.perc THEN
        Insert into logs (nic,log,time) VALUE(OLD.nic,CONCAT(OLD.nic,' loss ',NEW.perc),NOW());
    END IF;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `crm` CHARACTER SET utf8 COLLATE utf8_general_ci ;
ALTER DATABASE `crm` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `crm`.`deleet`
AFTER DELETE ON `crm`.`device`
FOR EACH ROW
BEGIN
    DELETE FROM ports WHERE nic=OLD.nic;
    DELETE FROM ups WHERE nic=OLD.nic;
   INSERT INTO mng_logs (text) values (concat_ws('delete id=', OLD.id,' nic=',OLD.nic));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `crm` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `idfile` int(11) NOT NULL AUTO_INCREMENT,
  `idtask` int(11) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT 'new',
  `groupid` int(11) DEFAULT NULL,
  PRIMARY KEY (`idfile`)
) ENGINE=MyISAM AUTO_INCREMENT=12203 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `genrep` (
  `cl_id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `address` tinyint NOT NULL,
  `mng` tinyint NOT NULL,
  `flag` tinyint NOT NULL,
  `speed` tinyint NOT NULL,
  `type_s` tinyint NOT NULL,
  `time_create` tinyint NOT NULL,
  `time_change` tinyint NOT NULL,
  `result` tinyint NOT NULL,
  `type_t` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `idtask` tinyint NOT NULL,
  `task_close` tinyint NOT NULL,
  `tflag` tinyint NOT NULL,
  `dogovor_num` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `helper_for_profitlist` (
  `cl_id` tinyint NOT NULL,
  `type_s` tinyint NOT NULL,
  `speed` tinyint NOT NULL,
  `vlan` tinyint NOT NULL,
  `flag` tinyint NOT NULL,
  `dogovor_date` tinyint NOT NULL,
  `dogovor_num` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `install_report` (
  `idtask` tinyint NOT NULL,
  `cl_id` tinyint NOT NULL,
  `cl_name` tinyint NOT NULL,
  `t_name` tinyint NOT NULL,
  `manager` tinyint NOT NULL,
  `flag` tinyint NOT NULL,
  `target` tinyint NOT NULL,
  `income` tinyint NOT NULL,
  `t1s` tinyint NOT NULL,
  `t1r` tinyint NOT NULL,
  `t2s` tinyint NOT NULL,
  `t2r` tinyint NOT NULL,
  `t2d` tinyint NOT NULL,
  `t2flag` tinyint NOT NULL,
  `t3s` tinyint NOT NULL,
  `t3r` tinyint NOT NULL,
  `t3type` tinyint NOT NULL,
  `t3d` tinyint NOT NULL,
  `t4s` tinyint NOT NULL,
  `t4r` tinyint NOT NULL,
  `t4id` tinyint NOT NULL,
  `t4res1date` tinyint NOT NULL,
  `t4res2date` tinyint NOT NULL,
  `t4date_ch` tinyint NOT NULL,
  `t5s` tinyint NOT NULL,
  `t5r` tinyint NOT NULL,
  `t5id` tinyint NOT NULL,
  `t5res1date` tinyint NOT NULL,
  `t5date_ch` tinyint NOT NULL,
  `t6s` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `idlogs` int(11) NOT NULL AUTO_INCREMENT,
  `nic` varchar(45) NOT NULL,
  `log` varchar(45) DEFAULT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlogs`),
  KEY `nic_key` (`nic`)
) ENGINE=MyISAM AUTO_INCREMENT=903853 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map` (
  `idmap` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) DEFAULT NULL,
  `coord_x` int(11) DEFAULT '0',
  `coord_y` int(11) DEFAULT '0',
  PRIMARY KEY (`idmap`),
  KEY `node_id` (`node_id`)
) ENGINE=MyISAM AUTO_INCREMENT=613 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
ALTER DATABASE `crm` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `crm`.`ins_map`
BEFORE INSERT ON `crm`.`map`
FOR EACH ROW
BEGIN
    SELECT MAX(idmap) INTO @mid FROM `crm`.`map`;
    IF (NEW.coord_x=NULL and NEW.coord_y=NULL) or (NEW.coord_x=0 and NEW.coord_y=0)THEN
        if @mid>400 THEN
            SET NEW.coord_x=0;
            SET NEW.coord_y=0;
        ELSE
            SET NEW.coord_x=@mid*2;
            SET NEW.coord_y=@mid*2;
        END IF;
    END IF;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `crm` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mng_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cr_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `who` varchar(1024) DEFAULT NULL,
  `text` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95561 DEFAULT CHARSET=koi8r;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mpls_vlans` (
  `id` int(11) NOT NULL,
  `port_id` int(11) DEFAULT NULL,
  `vlan_name` varchar(45) DEFAULT NULL,
  `vlan_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ports` (
  `nic` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `port` int(11) DEFAULT NULL,
  `time_ch` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '0',
  `idport` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trap` char(1) COLLATE utf8_unicode_ci DEFAULT 'n',
  `cacti_url` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iddev` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idport`),
  KEY `nic` (`nic`),
  KEY `nic_key` (`nic`)
) ENGINE=MyISAM AUTO_INCREMENT=3719 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
ALTER DATABASE `crm` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_port` before delete ON `ports`
FOR EACH ROW BEGIN
   INSERT INTO mng_logs (text) values (concat_ws('delete idport=', OLD.idport,' nic=',OLD.nic,' port=',OLD.port,' labal=',OLD.label));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `crm` CHARACTER SET utf8 COLLATE utf8_general_ci ;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppo_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cl_id` int(11) DEFAULT NULL,
  `zapros_id` int(11) DEFAULT NULL,
  `cl_name` varchar(256) DEFAULT NULL,
  `t_name` varchar(256) DEFAULT NULL,
  `point_group` int(11) DEFAULT NULL,
  `manager` varchar(256) DEFAULT NULL,
  `flag` varchar(45) DEFAULT NULL,
  `type_t` varchar(45) DEFAULT NULL,
  `type_s` varchar(45) DEFAULT NULL,
  `target` varchar(45) DEFAULT NULL,
  `income` int(11) DEFAULT NULL,
  `t1cr` timestamp NULL DEFAULT NULL,
  `t1ch` timestamp NULL DEFAULT NULL,
  `t1s` varchar(45) DEFAULT NULL,
  `t1r` varchar(45) DEFAULT NULL,
  `t2cr` timestamp NULL DEFAULT NULL,
  `t2ch` timestamp NULL DEFAULT NULL,
  `t2s` varchar(45) DEFAULT NULL,
  `t2r` varchar(45) DEFAULT NULL,
  `t3cr` timestamp NULL DEFAULT NULL,
  `t3ch` timestamp NULL DEFAULT NULL,
  `t3s` varchar(45) DEFAULT NULL,
  `t3r` varchar(45) DEFAULT NULL,
  `t4cr` timestamp NULL DEFAULT NULL,
  `t4ch` timestamp NULL DEFAULT NULL,
  `t4s` varchar(45) DEFAULT NULL,
  `t4r` varchar(45) DEFAULT NULL,
  `t4dog_date` date DEFAULT NULL,
  `t4dog_num` varchar(45) DEFAULT NULL,
  `t4_i_pay` int(11) DEFAULT NULL,
  `t4_e_pay` int(11) DEFAULT NULL,
  `t5cr` timestamp NULL DEFAULT NULL,
  `t5ch` timestamp NULL DEFAULT NULL,
  `t5s` varchar(45) DEFAULT NULL,
  `t5r` varchar(45) DEFAULT NULL,
  `t6cr` timestamp NULL DEFAULT NULL,
  `t6ch` timestamp NULL DEFAULT NULL,
  `t6s` varchar(45) DEFAULT NULL,
  `t6r` varchar(45) DEFAULT NULL,
  `t7cr` timestamp NULL DEFAULT NULL,
  `t7ch` timestamp NULL DEFAULT NULL,
  `t7s` varchar(45) DEFAULT NULL,
  `t7r` varchar(45) DEFAULT NULL,
  `t7res1date` date DEFAULT NULL,
  `t7res2date` date DEFAULT NULL,
  `t8cr` timestamp NULL DEFAULT NULL,
  `t8ch` timestamp NULL DEFAULT NULL,
  `t8s` varchar(45) DEFAULT NULL,
  `t8r` varchar(45) DEFAULT NULL,
  `t8res1date` date DEFAULT NULL,
  `t9cr` timestamp NULL DEFAULT NULL,
  `t9ch` timestamp NULL DEFAULT NULL,
  `t9s` varchar(45) DEFAULT NULL,
  `t9r` varchar(45) DEFAULT NULL,
  `flag1` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3137 DEFAULT CHARSET=koi8r;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `ppo_report` (
  `idtask` tinyint NOT NULL,
  `cl_id` tinyint NOT NULL,
  `cl_name` tinyint NOT NULL,
  `t_name` tinyint NOT NULL,
  `manager` tinyint NOT NULL,
  `flag` tinyint NOT NULL,
  `type_t` tinyint NOT NULL,
  `type_s` tinyint NOT NULL,
  `target` tinyint NOT NULL,
  `income` tinyint NOT NULL,
  `dogim` tinyint NOT NULL,
  `t1cr` tinyint NOT NULL,
  `t1ch` tinyint NOT NULL,
  `t1s` tinyint NOT NULL,
  `t1r` tinyint NOT NULL,
  `t2cr` tinyint NOT NULL,
  `t2ch` tinyint NOT NULL,
  `t2s` tinyint NOT NULL,
  `t2r` tinyint NOT NULL,
  `t3cr` tinyint NOT NULL,
  `t3ch` tinyint NOT NULL,
  `t3s` tinyint NOT NULL,
  `t3r` tinyint NOT NULL,
  `t4cr` tinyint NOT NULL,
  `t4ch` tinyint NOT NULL,
  `t4s` tinyint NOT NULL,
  `t4r` tinyint NOT NULL,
  `t4dog_date` tinyint NOT NULL,
  `t4dog_num` tinyint NOT NULL,
  `t4_i_pay` tinyint NOT NULL,
  `t4_e_pay` tinyint NOT NULL,
  `t5cr` tinyint NOT NULL,
  `t5ch` tinyint NOT NULL,
  `t5s` tinyint NOT NULL,
  `t5r` tinyint NOT NULL,
  `t5cl` tinyint NOT NULL,
  `t6cr` tinyint NOT NULL,
  `t6ch` tinyint NOT NULL,
  `t6s` tinyint NOT NULL,
  `t6r` tinyint NOT NULL,
  `t7cr` tinyint NOT NULL,
  `t7ch` tinyint NOT NULL,
  `t7s` tinyint NOT NULL,
  `t7r` tinyint NOT NULL,
  `t7res1date` tinyint NOT NULL,
  `t7res2date` tinyint NOT NULL,
  `t8cr` tinyint NOT NULL,
  `t8ch` tinyint NOT NULL,
  `t8s` tinyint NOT NULL,
  `t8r` tinyint NOT NULL,
  `t8res1date` tinyint NOT NULL,
  `t9cr` tinyint NOT NULL,
  `t9ch` tinyint NOT NULL,
  `t9s` tinyint NOT NULL,
  `t9r` tinyint NOT NULL,
  `flag1` tinyint NOT NULL,
  `point_group` tinyint NOT NULL,
  `zapros_gid` tinyint NOT NULL,
  `latitude` tinyint NOT NULL,
  `longitude` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `profitlist_report` (
  `cl_id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `pay` tinyint NOT NULL,
  `speed` tinyint NOT NULL,
  `flag` tinyint NOT NULL,
  `dogovor_date` tinyint NOT NULL,
  `dogovor_num` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ring_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ring_name_id` int(11) DEFAULT NULL,
  `device_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ring_members_on_ringname_id` (`ring_name_id`),
  KEY `index_ring_members_on_device_id` (`device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=836 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ring_names` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ipnet` varchar(45) DEFAULT NULL,
  `agg_sw_id` int(11) DEFAULT NULL,
  `ports` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `serv_id` int(11) NOT NULL AUTO_INCREMENT,
  `cl_id` int(11) NOT NULL,
  `type_s` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'inet',
  `addr` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `speed` int(11) NOT NULL,
  `vlan` int(11) DEFAULT NULL,
  `ipaddr` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `port_id` int(11) DEFAULT NULL,
  `status` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'start',
  `pool` varchar(128) COLLATE utf8_unicode_ci DEFAULT 'null',
  `dhcp_update` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`serv_id`),
  KEY `fkey_cl` (`cl_id`),
  KEY `fkey_port` (`port_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3590 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_log` (
  `id_log` int(11) NOT NULL AUTO_INCREMENT,
  `who` varchar(45) NOT NULL,
  `action` varchar(45) NOT NULL,
  `cl_id` int(11) DEFAULT NULL,
  `serv_id` int(11) DEFAULT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `old_serv` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id_log`),
  KEY `key_cl_id` (`cl_id`),
  KEY `key_serv_id` (`serv_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3086 DEFAULT CHARSET=koi8r;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `otdel` varchar(45) DEFAULT NULL,
  `week` date DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `s1` int(11) DEFAULT NULL,
  `s2` int(11) DEFAULT NULL,
  `s3` int(11) DEFAULT NULL,
  `s4` int(11) DEFAULT NULL,
  `s5` int(11) DEFAULT NULL,
  `s6` int(11) DEFAULT NULL,
  `s7` int(11) DEFAULT NULL,
  `s8` int(11) DEFAULT NULL,
  `s9` int(11) DEFAULT NULL,
  `s10` int(11) DEFAULT NULL,
  `s11` int(11) DEFAULT NULL,
  `s12` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`otdel`)
) ENGINE=MyISAM AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `idtask` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) CHARACTER SET koi8r DEFAULT NULL,
  `target` varchar(256) CHARACTER SET koi8r DEFAULT NULL,
  `status` varchar(10) CHARACTER SET koi8r DEFAULT 'new',
  `time_create` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `autor` int(11) DEFAULT NULL,
  `zapros_gid` int(11) DEFAULT NULL,
  `from_userid` int(11) DEFAULT NULL,
  `time_from` timestamp NULL DEFAULT NULL,
  `to_gid` int(11) DEFAULT '0',
  `to_userid` int(11) DEFAULT '0',
  `time_to` timestamp NULL DEFAULT NULL,
  `type_t` varchar(20) CHARACTER SET koi8r DEFAULT 'single',
  `dead_line` date DEFAULT NULL,
  `cl_id` int(11) DEFAULT NULL,
  `result` varchar(256) CHARACTER SET koi8r DEFAULT NULL,
  `time_change` timestamp NULL DEFAULT NULL,
  `point_group` int(11) DEFAULT NULL,
  `flag` varchar(100) DEFAULT NULL,
  `type_s` varchar(45) DEFAULT NULL,
  `dogovor_num` varchar(45) DEFAULT NULL,
  `dogovor_date` date DEFAULT NULL,
  `res1_date` date DEFAULT NULL,
  `res2_date` date DEFAULT NULL,
  `dogim` varchar(10) DEFAULT 'no',
  `ppo_income` int(11) DEFAULT NULL,
  `task_close` timestamp NULL DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  PRIMARY KEY (`idtask`),
  KEY `cl_id` (`cl_id`),
  KEY `point_group` (`point_group`)
) ENGINE=MyISAM AUTO_INCREMENT=19666 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttms` (
  `idttms` int(11) NOT NULL AUTO_INCREMENT,
  `dsc` varchar(1024) DEFAULT NULL,
  `status` varchar(10) DEFAULT 'new',
  `time_create` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_change` timestamp NULL DEFAULT NULL,
  `autor` int(11) DEFAULT NULL,
  `cl_id` int(11) NOT NULL,
  `source` varchar(10) DEFAULT NULL,
  `cause` varchar(1024) DEFAULT NULL,
  `recap` varchar(1024) DEFAULT NULL,
  `comp_group` varchar(2) DEFAULT 'DD',
  `root` varchar(255) DEFAULT NULL,
  `head` int(11) DEFAULT NULL,
  PRIMARY KEY (`idttms`)
) ENGINE=MyISAM AUTO_INCREMENT=6172 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `ttms_clients` (
  `cl_id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `address` tinyint NOT NULL,
  `idttms` tinyint NOT NULL,
  `source` tinyint NOT NULL,
  `d1` tinyint NOT NULL,
  `d2` tinyint NOT NULL,
  `dsc` tinyint NOT NULL,
  `cause` tinyint NOT NULL,
  `recap` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `time_create` tinyint NOT NULL,
  `time_change` tinyint NOT NULL,
  `timeout` tinyint NOT NULL,
  `minutes` tinyint NOT NULL,
  `comp_group` tinyint NOT NULL,
  `autor` tinyint NOT NULL,
  `root` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttmscomment` (
  `idcomment` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `groupid` int(11) DEFAULT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `text` varchar(2048) DEFAULT NULL,
  `idttms` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcomment`),
  KEY `idtt` (`idttms`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttmsfiles` (
  `idfile` int(11) NOT NULL AUTO_INCREMENT,
  `idttms` int(11) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT 'new',
  `groupid` int(11) DEFAULT NULL,
  PRIMARY KEY (`idfile`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_phone_numbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(12) DEFAULT NULL,
  `type_p` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=koi8r;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ups` (
  `nic` varchar(45) NOT NULL,
  `input` int(11) DEFAULT NULL,
  `outload` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `remaining` int(11) DEFAULT NULL,
  PRIMARY KEY (`nic`),
  UNIQUE KEY `nic_UNIQUE` (`nic`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
ALTER DATABASE `crm` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `crm`.`set_ups`
AFTER UPDATE ON `crm`.`ups`
FOR EACH ROW
BEGIN
    IF ABS(NEW.input-OLD.input)>70 THEN
        Insert into logs (nic,log,time) VALUE(OLD.nic,CONCAT(OLD.nic,' input=',NEW.input),NOW());
    END IF;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `crm` CHARACTER SET utf8 COLLATE utf8_general_ci ;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_vlan_services_count` (
  `ipaddr` tinyint NOT NULL,
  `vlan` tinyint NOT NULL,
  `vlan_count` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vpls` (
  `id` int(11) NOT NULL,
  `rem_peer_ip` varchar(45) DEFAULT NULL,
  `rem_peer_id` int(11) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `wifi_ppo_report` (
  `idtask` tinyint NOT NULL,
  `cl_id` tinyint NOT NULL,
  `cl_name` tinyint NOT NULL,
  `t_name` tinyint NOT NULL,
  `manager` tinyint NOT NULL,
  `flag` tinyint NOT NULL,
  `type_t` tinyint NOT NULL,
  `type_s` tinyint NOT NULL,
  `target` tinyint NOT NULL,
  `income` tinyint NOT NULL,
  `t1cr` tinyint NOT NULL,
  `t1ch` tinyint NOT NULL,
  `t1s` tinyint NOT NULL,
  `t1r` tinyint NOT NULL,
  `t2cr` tinyint NOT NULL,
  `t2ch` tinyint NOT NULL,
  `t2s` tinyint NOT NULL,
  `t2r` tinyint NOT NULL,
  `t3cr` tinyint NOT NULL,
  `t3ch` tinyint NOT NULL,
  `t3s` tinyint NOT NULL,
  `t3r` tinyint NOT NULL,
  `t4cr` tinyint NOT NULL,
  `t4ch` tinyint NOT NULL,
  `t4s` tinyint NOT NULL,
  `t4r` tinyint NOT NULL,
  `t4dog_date` tinyint NOT NULL,
  `t4dog_num` tinyint NOT NULL,
  `t4_i_pay` tinyint NOT NULL,
  `t4_e_pay` tinyint NOT NULL,
  `t5cr` tinyint NOT NULL,
  `t5ch` tinyint NOT NULL,
  `t5s` tinyint NOT NULL,
  `t5r` tinyint NOT NULL,
  `t6cr` tinyint NOT NULL,
  `t6ch` tinyint NOT NULL,
  `t6s` tinyint NOT NULL,
  `t6r` tinyint NOT NULL,
  `t7cr` tinyint NOT NULL,
  `t7ch` tinyint NOT NULL,
  `t7s` tinyint NOT NULL,
  `t7r` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zakazi` (
  `idzakaz` int(11) NOT NULL AUTO_INCREMENT,
  `cl_id` int(10) DEFAULT NULL,
  `znum` int(10) DEFAULT NULL,
  `zdate` date DEFAULT NULL,
  `fname` varchar(256) DEFAULT NULL,
  `type_pril` varchar(5) DEFAULT 'z',
  `status` varchar(5) DEFAULT 'a',
  `service_t` varchar(10) DEFAULT 'inet',
  PRIMARY KEY (`idzakaz`),
  KEY `cl_id_key` (`cl_id`),
  KEY `idzakaz` (`idzakaz`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=koi8r;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50001 DROP TABLE IF EXISTS `client_port_services`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `client_port_services` AS select `services`.`serv_id` AS `serv_id`,`clients`.`name` AS `name`,`services`.`type_s` AS `type_s`,`services`.`city` AS `city`,`services`.`addr` AS `addr`,`services`.`speed` AS `speed`,`services`.`vlan` AS `vlan`,`services`.`ipaddr` AS `ipaddr`,concat(`device`.`nic`,', p-',`ports`.`port`,'(',`ports`.`label`,')') AS `cl_port`,`services`.`status` AS `status`,`ports`.`cacti_url` AS `cacti_url`,`clients`.`cl_id` AS `cl_id`,`services`.`port_id` AS `port_id`,`device`.`ip` AS `device_ip`,`device`.`nic` AS `device_nic`,`ports`.`port` AS `device_port`,concat('p-',`ports`.`port`,'(',`ports`.`label`,')') AS `port_label`,`clients`.`flag` AS `flag`,`services`.`dhcp_update` AS `dhcp_update`,`clients`.`contact` AS `contact`,`clients`.`contact_tech` AS `contact_tech`,`clients`.`email` AS `email`,`clients`.`email_tech` AS `email_tech`,`clients`.`inn` AS `inn`,`clients`.`manager` AS `manager` from (((`services` left join `ports` on((`services`.`port_id` = `ports`.`idport`))) left join `device` on((`ports`.`iddev` = `device`.`id`))) left join `clients` on((`services`.`cl_id` = `clients`.`cl_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `clients_ppo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `clients_ppo` AS select `clients`.`cl_id` AS `cl_id`,`clients`.`name` AS `name`,`clients`.`address` AS `address`,`clients`.`manager` AS `manager`,NULL AS `dogovor_num` from `clients` union select `genrep`.`cl_id` AS `cl_id`,`genrep`.`name` AS `name`,`genrep`.`address` AS `address`,`genrep`.`mng` AS `manager`,`genrep`.`dogovor_num` AS `dogovor_num` from `genrep` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `genrep`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `genrep` AS select `clients`.`cl_id` AS `cl_id`,`clients`.`name` AS `name`,`task`.`name` AS `address`,`clients`.`manager` AS `mng`,`clients`.`flag` AS `flag`,`task`.`target` AS `speed`,`task`.`type_s` AS `type_s`,`task`.`time_create` AS `time_create`,`task`.`time_change` AS `time_change`,`task`.`result` AS `result`,`task`.`type_t` AS `type_t`,`task`.`status` AS `status`,`task`.`idtask` AS `idtask`,`task`.`task_close` AS `task_close`,`task`.`flag` AS `tflag`,`task`.`dogovor_num` AS `dogovor_num` from (`task` left join `clients` on((`clients`.`cl_id` = `task`.`cl_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `helper_for_profitlist`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `helper_for_profitlist` AS select `task`.`cl_id` AS `cl_id`,`services`.`type_s` AS `type_s`,`services`.`speed` AS `speed`,`services`.`vlan` AS `vlan`,cast(replace(`task`.`flag`,' ','') as unsigned) AS `flag`,`task`.`dogovor_date` AS `dogovor_date`,`task`.`dogovor_num` AS `dogovor_num` from (`task` left join `services` on((`services`.`cl_id` = `task`.`cl_id`))) where (`task`.`type_t` like '%zakaz') group by `services`.`vlan` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `install_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `install_report` AS select `t1`.`idtask` AS `idtask`,`t1`.`cl_id` AS `cl_id`,`cl`.`name` AS `cl_name`,`t1`.`name` AS `t_name`,`cl`.`manager` AS `manager`,`cl`.`flag` AS `flag`,`t1`.`target` AS `target`,`cl`.`income` AS `income`,`t1`.`status` AS `t1s`,`t1`.`result` AS `t1r`,`t2`.`status` AS `t2s`,`t2`.`result` AS `t2r`,`t2`.`dogovor_date` AS `t2d`,`t2`.`flag` AS `t2flag`,`t3`.`status` AS `t3s`,`t3`.`result` AS `t3r`,`t3`.`type_t` AS `t3type`,cast(`t3`.`time_create` as date) AS `t3d`,`t4`.`status` AS `t4s`,`t4`.`result` AS `t4r`,`t4`.`idtask` AS `t4id`,`t4`.`res1_date` AS `t4res1date`,`t4`.`res2_date` AS `t4res2date`,cast(`t4`.`time_change` as date) AS `t4date_ch`,`t5`.`status` AS `t5s`,`t5`.`result` AS `t5r`,`t5`.`idtask` AS `t5id`,`t5`.`res1_date` AS `t5res1date`,cast(`t5`.`time_change` as date) AS `t5date_ch`,`t6`.`status` AS `t6s` from ((((((`task` `t1` left join `task` `t2` on(((`t1`.`point_group` = `t2`.`point_group`) and (`t1`.`type_t` = 'ppoobj') and (`t2`.`type_t` = 'zakaz')))) left join `task` `t3` on(((`t1`.`point_group` = `t3`.`point_group`) and ((`t3`.`type_t` = 'pay') or (`t3`.`type_t` = 'nopay'))))) left join `task` `t4` on(((`t1`.`point_group` = `t4`.`point_group`) and (`t4`.`type_t` = 'install')))) left join `task` `t5` on(((`t1`.`point_group` = `t5`.`point_group`) and (`t5`.`type_t` = 'install1')))) left join `clients` `cl` on((`t1`.`cl_id` = `cl`.`cl_id`))) left join `task` `t6` on(((`t1`.`point_group` = `t6`.`point_group`) and (`t6`.`type_t` = 'akt')))) where ((`t1`.`type_t` = 'ppoobj') and ((`t2`.`status` = 'end') or (`t3`.`status` = 'end')) and (isnull(`t6`.`status`) or (`t6`.`status` = 'new') or (`t6`.`status` = 'run'))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `ppo_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ppo_report` AS select `t1`.`idtask` AS `idtask`,`t1`.`cl_id` AS `cl_id`,`cl`.`name` AS `cl_name`,`t1`.`name` AS `t_name`,`cl`.`manager` AS `manager`,`cl`.`flag` AS `flag`,`t1`.`type_t` AS `type_t`,`t1`.`type_s` AS `type_s`,`t1`.`target` AS `target`,`t1`.`ppo_income` AS `income`,`t1`.`dogim` AS `dogim`,`t1`.`time_create` AS `t1cr`,date_format(`t1`.`time_change`,'%Y-%m-%d') AS `t1ch`,`t1`.`status` AS `t1s`,`t1`.`result` AS `t1r`,`t2`.`time_create` AS `t2cr`,date_format(`t2`.`time_change`,'%Y-%m-%d') AS `t2ch`,`t2`.`status` AS `t2s`,`t2`.`result` AS `t2r`,`t3`.`time_create` AS `t3cr`,date_format(`t3`.`time_change`,'%Y-%m-%d') AS `t3ch`,`t3`.`status` AS `t3s`,`t3`.`result` AS `t3r`,`t4`.`time_create` AS `t4cr`,date_format(`t4`.`time_change`,'%Y-%m-%d') AS `t4ch`,`t4`.`status` AS `t4s`,`t4`.`result` AS `t4r`,`t4`.`dogovor_date` AS `t4dog_date`,`t4`.`dogovor_num` AS `t4dog_num`,`t4`.`result` AS `t4_i_pay`,`t4`.`flag` AS `t4_e_pay`,`t5`.`time_create` AS `t5cr`,date_format(`t5`.`time_change`,'%Y-%m-%d') AS `t5ch`,`t5`.`status` AS `t5s`,`t5`.`result` AS `t5r`,`t5`.`task_close` AS `t5cl`,`t6`.`time_create` AS `t6cr`,date_format(`t6`.`time_change`,'%Y-%m-%d') AS `t6ch`,`t6`.`status` AS `t6s`,`t6`.`result` AS `t6r`,`t7`.`time_create` AS `t7cr`,date_format(`t7`.`time_change`,'%Y-%m-%d') AS `t7ch`,`t7`.`status` AS `t7s`,`t7`.`result` AS `t7r`,`t7`.`res1_date` AS `t7res1date`,`t7`.`res2_date` AS `t7res2date`,`t8`.`time_create` AS `t8cr`,date_format(`t8`.`time_change`,'%Y-%m-%d') AS `t8ch`,`t8`.`status` AS `t8s`,`t8`.`result` AS `t8r`,`t8`.`res1_date` AS `t8res1date`,`t9`.`time_create` AS `t9cr`,date_format(`t9`.`time_change`,'%Y-%m-%d') AS `t9ch`,`t9`.`status` AS `t9s`,`t9`.`result` AS `t9r`,`t4`.`flag` AS `flag1`,`t1`.`point_group` AS `point_group`,`t1`.`zapros_gid` AS `zapros_gid`,`t1`.`latitude` AS `latitude`,`t1`.`longitude` AS `longitude` from (((((((((`task` `t1` left join `task` `t2` on(((`t1`.`cl_id` = `t2`.`cl_id`) and (`t1`.`point_group` = `t2`.`point_group`) and ((`t1`.`type_t` = 'ppomap') or (`t1`.`type_t` = 'voice')) and ((`t2`.`type_t` = 'ppoobj') or (`t2`.`type_t` = NULL))))) left join `task` `t3` on(((`t1`.`cl_id` = `t3`.`cl_id`) and (`t1`.`point_group` = `t3`.`point_group`) and ((`t3`.`type_t` = 'sogl') or (`t3`.`type_t` = NULL))))) left join `task` `t4` on(((`t1`.`cl_id` = `t4`.`cl_id`) and (`t1`.`point_group` = `t4`.`point_group`) and ((`t4`.`type_t` = 'zakaz') or (`t4`.`type_t` = NULL))))) left join `task` `t5` on(((`t1`.`cl_id` = `t5`.`cl_id`) and (`t1`.`point_group` = `t5`.`point_group`) and ((`t5`.`type_t` = 'pay') or (`t5`.`type_t` = 'nopay') or (`t5`.`type_t` = NULL))))) left join `task` `t6` on(((`t1`.`cl_id` = `t6`.`cl_id`) and (`t1`.`point_group` = `t6`.`point_group`) and ((`t6`.`type_t` = 'shem') or (`t6`.`type_t` = NULL))))) left join `task` `t7` on(((`t1`.`cl_id` = `t7`.`cl_id`) and (`t1`.`point_group` = `t7`.`point_group`) and ((`t7`.`type_t` = 'install') or (`t7`.`type_t` = NULL))))) left join `task` `t8` on(((`t1`.`cl_id` = `t8`.`cl_id`) and (`t1`.`point_group` = `t8`.`point_group`) and ((`t8`.`type_t` = 'install1') or (`t8`.`type_t` = NULL))))) left join `task` `t9` on(((`t1`.`cl_id` = `t9`.`cl_id`) and (`t1`.`point_group` = `t9`.`point_group`) and ((`t9`.`type_t` = 'akt') or (`t9`.`type_t` = NULL))))) left join `clients` `cl` on((`t1`.`cl_id` = `cl`.`cl_id`))) where ((`t1`.`type_t` = 'ppomap') or (`t1`.`type_t` = 'wifippomap') or (`t1`.`type_t` = 'voice')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `profitlist_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `profitlist_report` AS select `cl`.`cl_id` AS `cl_id`,`cl`.`name` AS `name`,sum(`hh`.`flag`) AS `pay`,sum(`hh`.`speed`) AS `speed`,`cl`.`flag` AS `flag`,`hh`.`dogovor_date` AS `dogovor_date`,`hh`.`dogovor_num` AS `dogovor_num` from (`helper_for_profitlist` `hh` left join `clients` `cl` on((`cl`.`cl_id` = `hh`.`cl_id`))) group by `cl`.`cl_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `ttms_clients`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ttms_clients` AS select `ttms`.`cl_id` AS `cl_id`,`clients`.`name` AS `name`,`clients`.`address` AS `address`,`ttms`.`idttms` AS `idttms`,`ttms`.`source` AS `source`,date_format(`ttms`.`time_create`,'%Y-%m-%d') AS `d1`,date_format(`ttms`.`time_change`,'%Y-%m-%d') AS `d2`,`ttms`.`dsc` AS `dsc`,`ttms`.`cause` AS `cause`,`ttms`.`recap` AS `recap`,`ttms`.`status` AS `status`,`ttms`.`time_create` AS `time_create`,`ttms`.`time_change` AS `time_change`,round(((greatest(unix_timestamp(`ttms`.`time_change`),unix_timestamp(`ttms`.`time_create`)) - unix_timestamp(`ttms`.`time_create`)) / 3600),0) AS `timeout`,((unix_timestamp(`ttms`.`time_change`) - unix_timestamp(`ttms`.`time_create`)) / 60) AS `minutes`,`ttms`.`comp_group` AS `comp_group`,`ttms`.`autor` AS `autor`,`ttms`.`root` AS `root` from (`ttms` left join `clients` on((`ttms`.`cl_id` = `clients`.`cl_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `view_vlan_services_count`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.61.0.%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_vlan_services_count` AS select `services`.`ipaddr` AS `ipaddr`,`services`.`vlan` AS `vlan`,count(0) AS `vlan_count` from `services` where (`services`.`type_s` in ('inet','inet6','nat','one-ip','pool','voip','ipunnam')) group by `services`.`vlan` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `wifi_ppo_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `wifi_ppo_report` AS select `t1`.`idtask` AS `idtask`,`t1`.`cl_id` AS `cl_id`,`cl`.`name` AS `cl_name`,`t1`.`name` AS `t_name`,`cl`.`manager` AS `manager`,`cl`.`flag` AS `flag`,`t1`.`type_t` AS `type_t`,`t1`.`type_s` AS `type_s`,`t1`.`target` AS `target`,`cl`.`income` AS `income`,`t1`.`time_create` AS `t1cr`,date_format(`t1`.`time_change`,'%Y-%m-%d') AS `t1ch`,`t1`.`status` AS `t1s`,`t1`.`result` AS `t1r`,`t2`.`time_create` AS `t2cr`,date_format(`t2`.`time_change`,'%Y-%m-%d') AS `t2ch`,`t2`.`status` AS `t2s`,`t2`.`result` AS `t2r`,`t3`.`time_create` AS `t3cr`,date_format(`t3`.`time_change`,'%Y-%m-%d') AS `t3ch`,`t3`.`status` AS `t3s`,`t3`.`result` AS `t3r`,`t4`.`time_create` AS `t4cr`,date_format(`t4`.`time_change`,'%Y-%m-%d') AS `t4ch`,`t4`.`status` AS `t4s`,`t4`.`result` AS `t4r`,`t4`.`dogovor_date` AS `t4dog_date`,`t4`.`dogovor_num` AS `t4dog_num`,`t4`.`result` AS `t4_i_pay`,`t4`.`flag` AS `t4_e_pay`,`t5`.`time_create` AS `t5cr`,date_format(`t5`.`time_change`,'%Y-%m-%d') AS `t5ch`,`t5`.`status` AS `t5s`,`t5`.`result` AS `t5r`,`t6`.`time_create` AS `t6cr`,date_format(`t6`.`time_change`,'%Y-%m-%d') AS `t6ch`,`t6`.`status` AS `t6s`,`t6`.`result` AS `t6r`,`t7`.`time_create` AS `t7cr`,date_format(`t7`.`time_change`,'%Y-%m-%d') AS `t7ch`,`t7`.`status` AS `t7s`,`t7`.`result` AS `t7r` from (((((((`task` `t1` left join `task` `t2` on(((`t1`.`cl_id` = `t2`.`cl_id`) and (`t1`.`point_group` = `t2`.`point_group`) and (`t1`.`type_t` = 'wifippomap') and ((`t2`.`type_t` = 'wifippoobj') or (`t2`.`type_t` = NULL))))) left join `task` `t3` on(((`t1`.`cl_id` = `t3`.`cl_id`) and (`t1`.`point_group` = `t3`.`point_group`) and ((`t3`.`type_t` = 'wifisogl') or (`t3`.`type_t` = NULL))))) left join `task` `t4` on(((`t1`.`cl_id` = `t4`.`cl_id`) and (`t1`.`point_group` = `t4`.`point_group`) and ((`t4`.`type_t` = 'wifizakaz') or (`t4`.`type_t` = NULL))))) left join `task` `t5` on(((`t1`.`cl_id` = `t5`.`cl_id`) and (`t1`.`point_group` = `t5`.`point_group`) and ((`t5`.`type_t` = 'wifipay') or (`t5`.`type_t` = 'wifinopay') or (`t5`.`type_t` = NULL))))) left join `task` `t6` on(((`t1`.`cl_id` = `t6`.`cl_id`) and (`t1`.`point_group` = `t6`.`point_group`) and ((`t6`.`type_t` = 'wifiinstall') or (`t6`.`type_t` = NULL))))) left join `task` `t7` on(((`t1`.`cl_id` = `t7`.`cl_id`) and (`t1`.`point_group` = `t7`.`point_group`) and ((`t7`.`type_t` = 'akt') or (`t7`.`type_t` = NULL))))) left join `clients` `cl` on((`t1`.`cl_id` = `cl`.`cl_id`))) where (`t1`.`type_t` = 'wifippomap') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
