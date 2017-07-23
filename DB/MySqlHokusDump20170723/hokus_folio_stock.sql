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
-- Table structure for table `folio_stock`
--

DROP TABLE IF EXISTS `folio_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folio_stock` (
  `folio_id` int(11) NOT NULL,
  `stock_id` varchar(20) NOT NULL,
  `stock_added_date` datetime DEFAULT NULL,
  `stock_qty` decimal(18,3) DEFAULT NULL,
  `stock_purchase_price` decimal(18,3) DEFAULT NULL,
  `stock_currency` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folio_stock`
--

LOCK TABLES `folio_stock` WRITE;
/*!40000 ALTER TABLE `folio_stock` DISABLE KEYS */;
INSERT INTO `folio_stock` VALUES (1,'BARC.L','2017-01-15 18:52:14',1000.000,10.200,'GBP'),(1,'BARC.L','2017-02-23 00:00:00',10.000,100.000,'GBP'),(1,'BARC.L','2017-02-23 00:00:00',1.000,1.000,'GBP'),(1,'ANII.L','2017-02-23 00:00:00',2332.000,400.000,'GBP'),(1,'ANW.L','2017-02-23 00:00:00',1704.000,455.000,'GBP'),(1,'GB0031412744.L','2017-02-24 00:00:00',5170.000,999.000,'GBP'),(1,'','2017-02-25 00:00:00',NULL,NULL,'GBP');
/*!40000 ALTER TABLE `folio_stock` ENABLE KEYS */;
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
