-- MySQL dump 10.13  Distrib 5.6.43, for Win64 (x86_64)
--
-- Host: localhost    Database: syscmdb
-- ------------------------------------------------------
-- Server version	5.6.43

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'查看用户',7,'show_user'),(20,'添加用户',7,'add_user'),(21,'修改用户',7,'update_user'),(22,'删除用户',7,'delete_user'),(23,'添加IDC',8,'add_idc'),(24,'查看IDC',8,'show_idc'),(25,'删除IDC',8,'delete_idc'),(26,'更新IDC',8,'update_idc'),(27,'添加资产用户',9,'add_serveruser'),(28,'查看资产用户',9,'show_serveruser'),(29,'删除资产用户',9,'delete_serveruser'),(30,'更新资产用户',9,'update_serveruser'),(31,'Can add disk',10,'add_disk'),(32,'Can change disk',10,'change_disk'),(33,'Can delete disk',10,'delete_disk'),(34,'Can add net work',11,'add_network'),(35,'Can change net work',11,'change_network'),(36,'Can delete net work',11,'delete_network'),(37,'添加资产主机',12,'add_server'),(38,'查看资产主机',12,'show_server'),(39,'删除资产主机',12,'delete_serveruser'),(40,'更新资产主机权限',12,'update_serveruser'),(41,'添加业务线',14,'add_product'),(42,'删除业务线',14,'delete_product'),(43,'查看业务线',14,'show_product'),(44,'修改业务线',14,'update_product');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$BZJWGDzr96Vl$hJCfgAj9Idy3A8wKm1Tp3hmpYwF6IzVaOdE5/rJ6o8o=','2019-09-26 16:39:17.302120',1,'admin','','','admin@qq.com',1,1,'2019-09-26 16:28:36.455745'),(2,'pbkdf2_sha256$36000$JkWHLzaZ1GmM$no0CEdQLT8xa1L6fAx9YctSHyTonb65LTwnhhtLHD3Y=',NULL,1,'devops','','','devops@qq.com',1,1,'2019-09-26 16:28:56.402909'),(3,'pbkdf2_sha256$36000$8fLG4esuXO7F$8f1s5ADRmwyNQ2qGZXwvwglZoVVOXY3GMUXROPvn+g4=',NULL,0,'qiangzou','','','jing74@gmail.com',0,1,'2019-09-26 16:34:02.550895'),(4,'pbkdf2_sha256$36000$vA5BTkBBpULj$V7D6trCLkXxhH653kyjgcRxwKGwVtygBiRGzwgRolSs=',NULL,0,'chengjie','','','jing25@iq.cn',0,1,'2019-09-26 16:34:02.659609'),(5,'pbkdf2_sha256$36000$4oUMek7KyVDi$f3HCFERrrnFOblCtkZfbZStG+F65nVQRMoq+iiPFYvo=',NULL,0,'vdu','','','xiuyingye@hotmail.com',0,1,'2019-09-26 16:34:02.747874'),(6,'pbkdf2_sha256$36000$ISUlBhR0mwGs$9Jye688k4GBDbw/YrwKCk39RS/HQ09XlCd76OGWg1eE=',NULL,0,'juanpeng','','','yuyong@guiying.cn',0,1,'2019-09-26 16:34:02.829747'),(7,'pbkdf2_sha256$36000$pdrN7jhO66Cz$9YtyKsMv+go1YytSHf6+WnAmexuhImgPdx3yUK1Am5Q=',NULL,0,'fang36','','','taoding@yanliu.cn',0,1,'2019-09-26 16:34:02.925478'),(8,'pbkdf2_sha256$36000$oxg0lzapITTw$B2u2qPq/MHNipoWOup2HcsZ3b3hXFyasVkZo5YjG4Fw=',NULL,0,'junxu','','','qiangli@yahoo.com',0,1,'2019-09-26 16:34:03.022185'),(9,'pbkdf2_sha256$36000$YhvQGVJLJFMW$ED/ZHz4i1yyJHeTNNBF5yHu74xFMw+pleYSDk+9tERw=',NULL,0,'yong79','','','ping70@yahoo.com',0,1,'2019-09-26 16:34:03.111063'),(10,'pbkdf2_sha256$36000$j6tKcPHRfE74$x3kWxROiYZ1Sq/c5wtdzoQCBiivbiSID614ZLD/RGsU=',NULL,0,'qiaoxia','','','zhujie@47.cn',0,1,'2019-09-26 16:34:03.192846'),(11,'pbkdf2_sha256$36000$MpnmA2KkvAWg$lOEJaHAlh5p64PJVqkNiDT37EsJfgep/hAc0xOxpwEA=',NULL,0,'minxia','','','xiuyinglai@sun.cn',0,1,'2019-09-26 16:34:03.280572'),(12,'pbkdf2_sha256$36000$qH0rbsopgy3W$wa6VfxbEldNZQoVctFggt9XdDsdcWLhNV/36Uo/kqp8=',NULL,0,'uxia','','','luojie@73.cn',0,1,'2019-09-26 16:34:03.364386'),(13,'pbkdf2_sha256$36000$STVGRhzmkC21$jtFXZW+whrB0uwjM5LczCi6WEwxsh/h+kwFRPeF39+g=',NULL,0,'mingxia','','','zhongxiulan@tao.cn',0,1,'2019-09-26 16:34:03.446131'),(14,'pbkdf2_sha256$36000$v5YKlraFF7Ts$hA9QI6G+qOjyjL8hGfs2CabVgU9zLeuxhl4FCFdjqdE=',NULL,0,'jkong','','','weiguiying@gmail.com',0,1,'2019-09-26 16:34:03.527943'),(15,'pbkdf2_sha256$36000$aDB0g9rbXWCe$7OC5DALkutlhALbH+WtUQip6wzwwXpqF8ID6hy+PRsg=',NULL,0,'xiangjuan','','','mjiang@li.net',0,1,'2019-09-26 16:34:03.607725'),(16,'pbkdf2_sha256$36000$cwQl3ilurUpI$X6A1g4FkDA9U1X00N7F1s2xPr8mJ/5HtNxdZwVyu41A=',NULL,0,'yanjing','','','jieluo@yahoo.com',0,1,'2019-09-26 16:34:03.690525'),(17,'pbkdf2_sha256$36000$5hlz24Q7FWf7$OOVJy6uGqH8KfsvEXK16lH4Ms9L2ZcCjWkA9rSumbzk=',NULL,0,'xiulan64','','','jingxia@hotmail.com',0,1,'2019-09-26 16:34:03.778277'),(18,'pbkdf2_sha256$36000$LouQaOzEeNeH$JG++LLTw6yiIC93tKabhWih+2st6DTfXaTs4JCh1WEg=',NULL,0,'xiulan01','','','longping@yanjuan.net',0,1,'2019-09-26 16:34:03.860071'),(19,'pbkdf2_sha256$36000$wR3WSbgglT1K$IALv6sbrrCB2xea5zU7P5WIsR60iHxz5JKHli3dIoSU=',NULL,0,'nyao','','','li23@yahoo.com',0,1,'2019-09-26 16:34:03.939847'),(20,'pbkdf2_sha256$36000$Gj3srJCYVkSA$uJK0sDFK4KNgt7bI0+H71SGvWmF2m6c+FjG0TEw6mLE=',NULL,0,'xiuyingfan','','','yuanchao@38.cn',0,1,'2019-09-26 16:34:04.022588'),(21,'pbkdf2_sha256$36000$mX3x4klVsQD2$GTtAGVo2txwxDYXlq3GLT9EzsdUaStmj0Y3Nn0+PGMw=',NULL,0,'dxiong','','','zliang@leiqin.cn',0,1,'2019-09-26 16:34:04.105939'),(22,'pbkdf2_sha256$36000$6tXblsv7JCVx$5p1lcDeYKblSTHCOsYm2FcTBmNuSE+8oIKiaBzdp7lQ=',NULL,0,'zhujing','','','duwei@xie.cn',0,1,'2019-09-26 16:34:04.207737'),(23,'pbkdf2_sha256$36000$hCUHxOL0S5bD$ztXj8rh9QfCNwG5StWE/ZsO+qraqdyySu2jqctSuDhY=',NULL,0,'vhou','','','chaoqiu@gmail.com',0,1,'2019-09-26 16:34:04.300455'),(24,'pbkdf2_sha256$36000$Paf2KWT1cNGH$eMUuL7Ukks+N1jQsbrdvxd69Dn5HqA+7+otGCXrEySk=',NULL,0,'baixia','','','gangjin@hotmail.com',0,1,'2019-09-26 16:34:04.400233'),(25,'pbkdf2_sha256$36000$GsaIrGipYTYu$ptZGjlRUtFZwDUbuY1KJZrlhnmeSRAu7pSwR9Jl/b0k=',NULL,0,'jiexiang','','','ming32@ip.cn',0,1,'2019-09-26 16:34:04.484516'),(26,'pbkdf2_sha256$36000$nlWPZxNW9vhN$EaeX6WCefCdvf3vXr71edJawOdjpxKgH4Lcr7rK1ccs=',NULL,0,'jingjiang','','','wei39@hotmail.com',0,1,'2019-09-26 16:34:04.566315');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(14,'products','product'),(10,'resources','disk'),(8,'resources','idc'),(11,'resources','network'),(12,'resources','server'),(13,'resources','serverauto'),(9,'resources','serveruser'),(6,'sessions','session'),(7,'users','profile');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-09-26 16:28:06.447105'),(2,'auth','0001_initial','2019-09-26 16:28:06.776981'),(3,'admin','0001_initial','2019-09-26 16:28:06.857619'),(4,'admin','0002_logentry_remove_auto_add','2019-09-26 16:28:06.869599'),(5,'contenttypes','0002_remove_content_type_name','2019-09-26 16:28:06.926435'),(6,'auth','0002_alter_permission_name_max_length','2019-09-26 16:28:06.959375'),(7,'auth','0003_alter_user_email_max_length','2019-09-26 16:28:06.996249'),(8,'auth','0004_alter_user_username_opts','2019-09-26 16:28:07.005261'),(9,'auth','0005_alter_user_last_login_null','2019-09-26 16:28:07.034147'),(10,'auth','0006_require_contenttypes_0002','2019-09-26 16:28:07.037139'),(11,'auth','0007_alter_validators_add_error_messages','2019-09-26 16:28:07.049108'),(12,'auth','0008_alter_user_username_max_length','2019-09-26 16:28:07.087005'),(13,'resources','0001_initial','2019-09-26 16:28:07.110942'),(14,'resources','0002_auto_20190923_1004','2019-09-26 16:28:07.140889'),(15,'resources','0003_serveruser','2019-09-26 16:28:07.158860'),(16,'resources','0004_auto_20190923_1509','2019-09-26 16:28:07.308414'),(17,'resources','0005_serverauto','2019-09-26 16:28:07.331352'),(18,'resources','0006_auto_20190925_1700','2019-09-26 16:28:07.493917'),(19,'sessions','0001_initial','2019-09-26 16:28:07.521856'),(20,'users','0001_initial','2019-09-26 16:28:07.577692'),(21,'users','0002_auto_20190922_1658','2019-09-26 16:28:07.588663'),(22,'resources','0007_auto_20190927_1944','2019-09-27 19:45:05.023862'),(23,'products','0001_initial','2019-09-27 19:49:08.261688'),(24,'resources','0008_server_product','2019-09-27 19:49:08.326535');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('tqntjg0ftcy67nlo20pgb7ji7t0ap6az','NGEwOTc2YTc5MWRiZWNjZjljMmEwMmI0ZTMyY2NiODI4NWUwOWFiYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhYzYxZThmNTViMWYxZDhlODBmOTdjOWRiMDAyYTYyNDk5YjJjYTlmIn0=','2019-10-10 16:39:17.305130');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_product`
--

DROP TABLE IF EXISTS `products_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `name_cn` varchar(10) NOT NULL,
  `op_interface` varchar(150) NOT NULL,
  `dev_interface` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_product_name_cn_f625cd1f` (`name_cn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_product`
--

LOCK TABLES `products_product` WRITE;
/*!40000 ALTER TABLE `products_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_disk`
--

DROP TABLE IF EXISTS `resources_disk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_disk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `size` varchar(32) NOT NULL,
  `server_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `resources_disk_server_id_7754d83b_fk_resources_server_id` (`server_id`),
  CONSTRAINT `resources_disk_server_id_7754d83b_fk_resources_server_id` FOREIGN KEY (`server_id`) REFERENCES `resources_server` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_disk`
--

LOCK TABLES `resources_disk` WRITE;
/*!40000 ALTER TABLE `resources_disk` DISABLE KEYS */;
INSERT INTO `resources_disk` VALUES (47,'sda','20G',15),(48,'sda','20G',16);
/*!40000 ALTER TABLE `resources_disk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_idc`
--

DROP TABLE IF EXISTS `resources_idc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_idc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `name_cn` varchar(32) NOT NULL,
  `address` varchar(64) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `username` varchar(32) NOT NULL,
  `username_email` varchar(254) NOT NULL,
  `username_phone` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_idc`
--

LOCK TABLES `resources_idc` WRITE;
/*!40000 ALTER TABLE `resources_idc` DISABLE KEYS */;
INSERT INTO `resources_idc` VALUES (1,'黑马程序员云机房','itheima','昌平区TBD','010-10000000','贾思远','jiasiyuan@qq.com','13354280969');
/*!40000 ALTER TABLE `resources_idc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_network`
--

DROP TABLE IF EXISTS `resources_network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_network` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `ip_address` varchar(32) NOT NULL,
  `server_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `resources_network_server_id_937a900b_fk_resources_server_id` (`server_id`),
  CONSTRAINT `resources_network_server_id_937a900b_fk_resources_server_id` FOREIGN KEY (`server_id`) REFERENCES `resources_server` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_network`
--

LOCK TABLES `resources_network` WRITE;
/*!40000 ALTER TABLE `resources_network` DISABLE KEYS */;
INSERT INTO `resources_network` VALUES (93,'lo','127.0.0.1',15),(94,'ens33','192.168.17.110',15),(95,'lo','127.0.0.1',16),(96,'ens33','192.168.17.102',16);
/*!40000 ALTER TABLE `resources_network` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_server`
--

DROP TABLE IF EXISTS `resources_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(32) NOT NULL,
  `cpu_info` varchar(100) NOT NULL,
  `cpu_count` int(11) NOT NULL,
  `mem_info` varchar(32) NOT NULL,
  `os_system` varchar(32) NOT NULL,
  `os_system_num` int(11) NOT NULL,
  `uuid` varchar(64) NOT NULL,
  `sn` varchar(100) NOT NULL,
  `scan_status` int(11) NOT NULL,
  `create_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `idc_id` int(11) DEFAULT NULL,
  `server_auto_id` int(11) NOT NULL,
  `server_user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `server_auto_id` (`server_auto_id`),
  KEY `resources_server_idc_id_fe131330_fk_resources_idc_id` (`idc_id`),
  KEY `resources_server_server_user_id_099e42f7_fk_resources` (`server_user_id`),
  KEY `resources_server_product_id_555104ce_fk_products_product_id` (`product_id`),
  CONSTRAINT `resources_server_idc_id_fe131330_fk_resources_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `resources_idc` (`id`),
  CONSTRAINT `resources_server_product_id_555104ce_fk_products_product_id` FOREIGN KEY (`product_id`) REFERENCES `products_product` (`id`),
  CONSTRAINT `resources_server_server_auto_id_9aedd577_fk_resources` FOREIGN KEY (`server_auto_id`) REFERENCES `resources_serverauto` (`id`),
  CONSTRAINT `resources_server_server_user_id_099e42f7_fk_resources` FOREIGN KEY (`server_user_id`) REFERENCES `resources_serveruser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_server`
--

LOCK TABLES `resources_server` WRITE;
/*!40000 ALTER TABLE `resources_server` DISABLE KEYS */;
INSERT INTO `resources_server` VALUES (15,'server01','Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz',1,'1.78','CentOS Linux 7',64,'83c84d56-3b5a-7055-d70c-8f1ced9ca5a0','VMware-56 4d c8 83 5a 3b 55 70-d7 0c 8f 1c ed 9c a5 a0',1,'2019-09-27 20:34:11.439182','2019-09-27 20:36:36.738702',1,20,1,NULL),(16,'centos8','Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz',1,'1.76','CentOS Linux 8',64,'defd4d56-9a1c-bbd1-6c5b-f016d9d17355','VMware-56 4d fd de 1c 9a d1 bb-6c 5b f0 16 d9 d1 73 55',1,'2019-09-27 20:34:19.699225','2019-09-27 20:36:30.293773',NULL,21,1,NULL);
/*!40000 ALTER TABLE `resources_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_serverauto`
--

DROP TABLE IF EXISTS `resources_serverauto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_serverauto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_inner` varchar(32) NOT NULL,
  `port` int(11) NOT NULL,
  `os_status` int(11) NOT NULL,
  `system_status` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_inner` (`ip_inner`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_serverauto`
--

LOCK TABLES `resources_serverauto` WRITE;
/*!40000 ALTER TABLE `resources_serverauto` DISABLE KEYS */;
INSERT INTO `resources_serverauto` VALUES (20,'192.168.17.110',22,0,0),(21,'192.168.17.102',22,0,0);
/*!40000 ALTER TABLE `resources_serverauto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_serveruser`
--

DROP TABLE IF EXISTS `resources_serveruser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_serveruser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `info` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_serveruser`
--

LOCK TABLES `resources_serveruser` WRITE;
/*!40000 ALTER TABLE `resources_serveruser` DISABLE KEYS */;
INSERT INTO `resources_serveruser` VALUES (1,'超级管理员','root','123456','超级管理员权限');
/*!40000 ALTER TABLE `resources_serveruser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_profile`
--

DROP TABLE IF EXISTS `users_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_cn` varchar(32) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `wechat` varchar(32) NOT NULL,
  `info` longtext NOT NULL,
  `profile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_id` (`profile_id`),
  CONSTRAINT `users_profile_profile_id_7af3d8f5_fk_auth_user_id` FOREIGN KEY (`profile_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_profile`
--

LOCK TABLES `users_profile` WRITE;
/*!40000 ALTER TABLE `users_profile` DISABLE KEYS */;
INSERT INTO `users_profile` VALUES (1,'翟杰','13666423367','14581521284','报告次数制作不同或者本站帖子.部门希望还是经验.学生上海本站当然男人准备行业.',3),(2,'孙桂芝','15989818864','18757249541','日本通过全部网上今天质量.都是影响还是最大不过你们.',4),(3,'俞伟','13081604256','15998754500','注册实现发布其他没有数据精华.标准网站分析影响很多.',5),(4,'柏秀云','15956494692','13527512294','地方是否中文中心联系查看投资.使用谢谢比较手机关于联系欢迎.电话品牌电话就是活动电话.',6),(5,'王桂香','15912330407','18608068149','中国这种男人这个.质量可以责任无法只是结果.',7),(6,'白春梅','15205023570','18709465699','历史广告感觉虽然.说明是否商品销售软件.不同本站在线拥有.',8),(7,'刘华','15199376407','13345755154','客户需要学习搜索一切以下.日期这里工具.虽然都是生活社区计划.',9),(8,'孙欣','13311103278','13825312203','经验报告以上网络欢迎.进入政府国际欢迎.',10),(9,'萧畅','18237132479','15585672546','不是都是那么其实今年这个.她的游戏没有没有如此分析.东西准备公司能力显示经营.活动能力密码规定工程说明就是.',11),(10,'全倩','13836262119','18589453526','这个查看然后虽然这里深圳的人.商品经济所以有些.然后能力服务经济责任完成.',12),(11,'张小红','13414005408','15304375677','为什发生安全国内.信息一起谢谢起来问题帖子.因此有关政府很多学校增加.',13),(12,'吕斌','14578317195','18239668005','历史方法进入主题中文.日期专业的人管理.经验虽然环境事情任何我们通过.',14),(13,'黄霞','13639098899','13706990982','教育是否问题北京部分建设发表.研究应用出来喜欢投资其他.影响会员美国主题首页男人.',15),(14,'赖玉英','13802963254','14524246764','开始资源完成一样程序.汽车因此地区同时决定如何.她的工作基本.',16),(15,'张明','15609660224','13287273869','政府说明作者准备根据.',17),(16,'胡淑兰','14580726556','14548829644','谢谢如何精华进行一些支持她的加入.工作人民学生质量.',18),(17,'俞娟','13640213831','13280553261','最大工具学生.信息问题行业的话经济不断.制作投资软件.',19),(18,'赵桂英','18636372933','18105657588','威望现在处理功能当然技术地区.用户得到中心如此社会使用.',20),(19,'贺洋','18572575417','13325951717','表示音乐一样两个更新但是.行业决定不能成功方面工具.',21),(20,'赫辉','14584738570','13528303709','学校控制开发看到.位置正在感觉类型应该更多.社会情况关于威望有关软件.',22),(21,'曾雪梅','18220720480','18276200610','没有欢迎还是电影这里产品.操作这个有关分析现在为什所以.准备方法成为.',23),(22,'欧阳玉英','18697570279','14503783234','他们质量公司一起.图片标题关于支持如果最后经济环境.教育发布重要现在有些注册.',24),(23,'冀东','13961288347','18036147579','新闻所以处理一点功能.积分广告威望还有特别软件.我们城市深圳不能最后朋友一切.',25),(24,'姜红','13249476039','13641348270','人员继续状态.重要语言能够因为信息增加.她的有关电影作者.',26);
/*!40000 ALTER TABLE `users_profile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-07 16:53:48
