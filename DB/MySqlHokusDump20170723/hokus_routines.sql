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
-- Temporary table structure for view `stock_date_yearago`
--

DROP TABLE IF EXISTS `stock_date_yearago`;
/*!50001 DROP VIEW IF EXISTS `stock_date_yearago`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `stock_date_yearago` (
  `yearsago` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `stock_summary`
--

DROP TABLE IF EXISTS `stock_summary`;
/*!50001 DROP VIEW IF EXISTS `stock_summary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `stock_summary` (
  `stock_date` tinyint NOT NULL,
  `count(*)` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `stock_date_threemthsago`
--

DROP TABLE IF EXISTS `stock_date_threemthsago`;
/*!50001 DROP VIEW IF EXISTS `stock_date_threemthsago`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `stock_date_threemthsago` (
  `threemthsago` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `stock_date_yesterday`
--

DROP TABLE IF EXISTS `stock_date_yesterday`;
/*!50001 DROP VIEW IF EXISTS `stock_date_yesterday`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `stock_date_yesterday` (
  `yesterday` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `stock_memorable_dates`
--

DROP TABLE IF EXISTS `stock_memorable_dates`;
/*!50001 DROP VIEW IF EXISTS `stock_memorable_dates`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `stock_memorable_dates` (
  `yesterday` tinyint NOT NULL,
  `threemthsago` tinyint NOT NULL,
  `yearsago` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `stock_date_yearago`
--

/*!50001 DROP TABLE IF EXISTS `stock_date_yearago`*/;
/*!50001 DROP VIEW IF EXISTS `stock_date_yearago`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `stock_date_yearago` AS select min(`stock_summary`.`stock_date`) AS `yearsago` from `stock_summary` where (`stock_summary`.`stock_date` >= (now() - interval 12 month)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `stock_summary`
--

/*!50001 DROP TABLE IF EXISTS `stock_summary`*/;
/*!50001 DROP VIEW IF EXISTS `stock_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `stock_summary` AS select distinct `stock_detail`.`stock_date` AS `stock_date`,count(0) AS `count(*)` from `stock_detail` group by 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `stock_date_threemthsago`
--

/*!50001 DROP TABLE IF EXISTS `stock_date_threemthsago`*/;
/*!50001 DROP VIEW IF EXISTS `stock_date_threemthsago`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `stock_date_threemthsago` AS select min(`stock_summary`.`stock_date`) AS `threemthsago` from `stock_summary` where (`stock_summary`.`stock_date` >= (now() - interval 3 month)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `stock_date_yesterday`
--

/*!50001 DROP TABLE IF EXISTS `stock_date_yesterday`*/;
/*!50001 DROP VIEW IF EXISTS `stock_date_yesterday`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `stock_date_yesterday` AS select max(`stock_summary`.`stock_date`) AS `yesterday` from `stock_summary` where ((`stock_summary`.`stock_date` >= (now() - interval 1 month)) and (`stock_summary`.`stock_date` < (now() - interval 1 day))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `stock_memorable_dates`
--

/*!50001 DROP TABLE IF EXISTS `stock_memorable_dates`*/;
/*!50001 DROP VIEW IF EXISTS `stock_memorable_dates`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `stock_memorable_dates` AS select `stock_date_yesterday`.`yesterday` AS `yesterday`,`stock_date_threemthsago`.`threemthsago` AS `threemthsago`,`stock_date_yearago`.`yearsago` AS `yearsago` from ((`stock_date_yesterday` join `stock_date_threemthsago`) join `stock_date_yearago`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping routines for database 'hokus'
--
/*!50003 DROP PROCEDURE IF EXISTS `addStockToFolio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addStockToFolio`( folioId INT, 
stockId varchar(20), stockPrice decimal(5,2), stockQty INT  )
BEGIN

	DECLARE stock_exist BOOLEAN;
    SET stock_exist = false;
  -- Validate the StockID
  SET stock_exist = (
	SELECT true
    FROM stock
    WHERE stock_id = stockId );
  
  -- Insert the data into folio_stock
  INSERT INTO folio_stock
  (folio_id, stock_id, stock_added_date, stock_qty,
  stock_purchase_price, stock_currency)
  SELECT folioId, stockId, current_date, stockQty,
	stockPrice, 'GBP';
    
   -- Select Insert Stock Details 
   IF stock_exist = true THEN
		SELECT stockId, 'Stock Inserted' stockMessage, true stockAdded;
   ELSE 
		SELECT stockId, 'Stock Not In DB Check Symbol' stockMessage, false stockAdded;
   END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getFolio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getFolio`( userId INT )
BEGIN  

SELECT f.folio_id, f.folio_desc, f.folio_created_date, 
	s.stock_name, fs.stock_id, fs.stock_qty, fs.stock_purchase_price, fs.stock_currency, u.user_id, 
	CONCAT(u.user_first_name,' ',u.user_last_name) user_name,
    EarningsShare, BookValue, YearHigh, YearLow, ChangeFromTwoHundreddayMovingAverage,
	ChangeFromFiftydayMovingAverage, COALESCE(stock_bid,PreviousClose) stock_bid,
	COALESCE(stock_ask,PreviousClose) stock_ask
FROM hokus.folio f , hokus.user_folio uf , hokus.folio_stock fs, 
	hokus.hk_user u, hokus.stock_detail sd, hokus.stock s
WHERE u.user_id = userId 
AND u.user_id = uf.user_id 
AND uf.folio_id = f.folio_id 
AND fs.folio_id = uf.folio_id 
AND fs.stock_id = sd.stock_id
AND s.stock_id = fs.stock_id
AND sd.stock_date = current_date();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getFolioStocksByTime` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getFolioStocksByTime`(folioId INT)
BEGIN

  DECLARE stock_list TEXT;

  SELECT GROUP_CONCAT(stock_id SEPARATOR ',') as stock_id
  INTO stock_list
  FROM folio_stock
  WHERE folio_id = folioId;

  CALL getStockByTime(stock_list,'MONTH');
  

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getStockByTime` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStockByTime`(stockIdList TEXT, periodicty TEXT)
BEGIN

  IF periodicty = 'MONTH' THEN
    BEGIN
		SELECT
			stock_id, 
            coalesce(coalesce(stock_bid,Open),PreviousClose) stock_bid, 
            date_format(stock_date,'%d-%m-%y') f_stock_date
		FROM
			stock_detail
		WHERE FIND_IN_SET(stock_id, stockIdList) > 0
        AND stock_date >= (CURRENT_DATE() - INTERVAL 3 MONTH)
		ORDER BY stock_id, stock_date;
    END;
  END IF;
  
  IF periodicty = '6MONTH' THEN
    BEGIN
		SELECT
			stock_id, 
            coalesce(coalesce(stock_bid,Open),PreviousClose) stock_bid, 
            date_format(stock_date,'%d-%m-%y') f_stock_date
		FROM
			stock_detail
		WHERE
			FIND_IN_SET(stock_id, stockIdList) > 0
            
		ORDER BY stock_id, stock_date;
    END;
  END IF;
  
  IF periodicty = '1YEAR' THEN
    BEGIN
		SELECT
			stock_id, 
            coalesce(coalesce(stock_bid,Open),PreviousClose) stock_bid, 
            date_format(stock_date,'%d-%m-%y') f_stock_date
		FROM
			stock_detail
		WHERE
			FIND_IN_SET(stock_id, stockIdList) > 0
            
		ORDER BY stock_id, stock_date;
    END;
  END IF;  
  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-23 14:25:55
