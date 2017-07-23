CREATE DATABASE  IF NOT EXISTS `hokus` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `hokus`;
-- MySQL dump 10.13  Distrib 5.5.53, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: hokus
-- ------------------------------------------------------
-- Server version	5.5.53-0+deb8u1

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
-- Table structure for table `hk_user`
--

DROP TABLE IF EXISTS `hk_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hk_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_first_name` varchar(100) NOT NULL,
  `user_last_name` varchar(100) DEFAULT NULL,
  `user_email` varchar(65) NOT NULL,
  `user_last_login` datetime DEFAULT NULL,
  `user_title` varchar(10) DEFAULT NULL,
  `user_tel` varchar(45) DEFAULT NULL,
  `user_pass` varchar(200) NOT NULL,
  PRIMARY KEY (`user_id`,`user_pass`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hk_user`
--

LOCK TABLES `hk_user` WRITE;
/*!40000 ALTER TABLE `hk_user` DISABLE KEYS */;
INSERT INTO `hk_user` VALUES (1,'Dan','Jackson','daniell33jackson@gmail.com','2016-02-09 20:37:17','Mr','01464 123456','welcom1'),(16,'Dan','J','123@123.com','2017-01-24 00:00:00','Mr',NULL,'Ne+/vUlrD++/vSPvv73vv73vv70277+977+977+9UH8=,-493905013'),(17,'Dan','J','123@123.com','2017-01-30 00:00:00','Mr',NULL,'3IXvv73vv73vv73vv73vv70qz5Dvv73vv73vv70iY++/vQ==,-2078555274'),(18,'Dan','J','123@123.com','2017-01-30 00:00:00','Mr',NULL,'77+977+9UjAB77+977+9Hu+/ve+/vXHvv70577+9Y++/vQ==,-39741050'),(19,'Dan','J','123@123.com','2017-02-16 00:00:00','Mr',NULL,'fR/vv73vv70j77+9GUgnZVnvv71+BT0=,1778844148'),(20,'Dan','J','123@123.com','2017-02-17 00:00:00','Mr',NULL,'77+977+9Mwfvv73vv71XZBwWIA7MlO+/vQ==,1003308179'),(21,'Dan','J','123@123.com','2017-02-17 00:00:00','Mr',NULL,'77+9bO+/ve+/vXvvv73vv73vv70zC0zvv73vv73vv70=,1158956434'),(22,'Dan','J','123@123.com','2017-02-17 00:00:00','Mr',NULL,'77+9Ue+/ve+/vX3cg++/vQ5U77+977+977+9bGR3,189525444'),(23,'Dan','J','admin@admin.com','2017-02-17 00:00:00','Mr',NULL,'Lu+/ve+/ve+/vXfvv73vv70N77+9OHYg77+977+9MO+/vQ==,1776414069'),(24,'Dan','J','admin@admin1.com','2017-02-17 00:00:00','Mr',NULL,'77+9H++/ve+/ve+/ve+/vTdDZABW77+977+9V01H,2018773659'),(25,'Dan','J','test@gmail.com1','2017-02-20 00:00:00','Mr',NULL,'x4xrWe+/veaVqiY7V1vvv73vv71K77+9,-169166448'),(26,'Dan','J','test@gmail.com','2017-02-20 00:00:00','Mr',NULL,'WWXvv73vv73vv73vv709EnLvv73vv70cbknvv717,1281394414'),(27,'Dan','J','test1@gmail.com','2017-02-20 00:00:00','Mr',NULL,'c++/ve+/vSJM77+977+9Fu+/vWvvv709Ru+/vTzvv70=,-1819781740'),(28,'Dan','J','test2@gmail.com','2017-02-20 00:00:00','Mr',NULL,'77+9ChNvxZUjPkzvv71X34fvv73vv71R,1304624327'),(29,'Dan','J','test5@gmail.com','2017-02-20 00:00:00','Mr',NULL,'Dxhr77+9Lxdi77+977+9cgzvv71NAT98,-1047883788'),(30,'Dan','J','test11@gmail.com','2017-02-21 00:00:00','Mr',NULL,'77+9EO+/ve+/vQrvv71S77+9Ru+/ve+/ve+/ve+/ve+/ve+/vX8=,639231852'),(31,'Dan','J','test15@gmail.com','2017-02-21 00:00:00','Mr',NULL,'BDUtGhzvv71oTe+/vXM1cFEDRg==,-164365140'),(32,'','Jackson','admin77@admin.com','2017-02-21 00:00:00','Mr',NULL,'Bu+/ve+/vW0T77+9bu+/vVApBFFdGO+/vQ==,320569479'),(33,'damien','stuyina','bob@bob.bob','2017-03-10 00:00:00','m8',NULL,'eO+/vUxrcQzvv73TmO+/vR0R77+977+9Elk=,-285223768');
/*!40000 ALTER TABLE `hk_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-23 14:25:53
