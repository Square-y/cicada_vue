-- MySQL dump 10.13  Distrib 8.0.31, for macos13.0 (x86_64)
--
-- Host: 127.0.0.1    Database: cicada
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `auth_manage`
--

DROP TABLE IF EXISTS `auth_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_manage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `icon` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单标志',
  `menuId` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单id，字符串',
  `component` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '组件名称',
  `level` int NOT NULL COMMENT '菜单级别',
  `logined` int DEFAULT NULL COMMENT '是否登录',
  `parent_id` int DEFAULT '0' COMMENT '父级菜单id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_manage_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_manage`
--

LOCK TABLES `auth_manage` WRITE;
/*!40000 ALTER TABLE `auth_manage` DISABLE KEYS */;
INSERT INTO `auth_manage` VALUES (1,'主菜单1','Operation','1','',0,0,0),(2,'子菜单1-1','','1-1','hello1',1,0,1),(3,'子菜单1-2','','1-2','index',1,0,1),(4,'子菜单1-3','','1-3','hello3',1,0,1),(5,'主菜单2','Operation','2','',0,0,0),(6,'子菜单2-1','','2-1','hello1',1,0,1),(7,'子菜单2-2','','2-2','index',1,0,1),(8,'子菜单2-3','','2-3','hello3',1,0,1),(9,'主菜单3','Grid','3','',0,0,0),(10,'子菜单3-1','','3-1','hello1',1,0,1),(11,'子菜单3-2','','3-2','index',1,0,1),(12,'子菜单3-3','','3-3','hello3',1,0,1),(13,'主菜单4','Operation','4','',0,0,0),(14,'子菜单4-1','','4-1','hello1',1,0,1),(15,'子菜单4-2','','4-2','index',1,0,1),(16,'子菜单4-3','','4-3','hello3',1,0,1),(17,'用户管理','User','5','',0,0,0),(18,'用户','','5-1','hello1',1,0,1),(19,'角色','','5-2','index',1,0,1),(20,'权限','','5-3','hello3',1,0,1);
/*!40000 ALTER TABLE `auth_manage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_role`
--

DROP TABLE IF EXISTS `auth_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_role` (
  `authId` int DEFAULT NULL COMMENT '权限id',
  `roleId` int DEFAULT NULL COMMENT '角色id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='权限-角色关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_role`
--

LOCK TABLES `auth_role` WRITE;
/*!40000 ALTER TABLE `auth_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_manage`
--

DROP TABLE IF EXISTS `role_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_manage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_manage_id_uindex` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_manage`
--

LOCK TABLES `role_manage` WRITE;
/*!40000 ALTER TABLE `role_manage` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_manage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_user` (
  `roleId` int DEFAULT NULL COMMENT '角色id',
  `userId` int DEFAULT NULL COMMENT '用户id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色-用户关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_user`
--

LOCK TABLES `role_user` WRITE;
/*!40000 ALTER TABLE `role_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_manage`
--

DROP TABLE IF EXISTS `user_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_manage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '昵称',
  `create_on` int unsigned DEFAULT '0' COMMENT '创建时间',
  `create_by` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
  `modified_on` int unsigned DEFAULT '0' COMMENT '修改时间',
  `modified_by` int unsigned DEFAULT '0' COMMENT '修改人',
  `email` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `del_on` int unsigned DEFAULT '0' COMMENT '删除时间',
  `is_del` tinyint unsigned DEFAULT '0' COMMENT '是否删除 0 为未删除、1 为已删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cicada_id_uindex` (`id`),
  UNIQUE KEY `cicada_username_uindex` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_manage`
--

LOCK TABLES `user_manage` WRITE;
/*!40000 ALTER TABLE `user_manage` DISABLE KEYS */;
INSERT INTO `user_manage` VALUES (1,'huang','e10adc3949ba59abbe56e057f20f883e',NULL,1681824913,'huang',0,0,NULL,0,0);
/*!40000 ALTER TABLE `user_manage` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-07 18:21:05
